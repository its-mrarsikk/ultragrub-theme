ifeq ($(shell command -v grub-mkfont),)
  ifeq ($(shell command -v grub2-mkfont),)
    $(error Neither grub-mkfont nor grub2-mkfont is installed or not in the PATH. Not continuing)
  else
    MKFONT := grub2-mkfont
  endif
else
  MKFONT := grub-mkfont
endif

SRC_DIR ?= ./src
TARGET_DIR ?= ./ultragrub
PREVIEW_COMMAND ?= grub2-theme-preview
PREVIEW_RESOLUTION ?= 1280x720
INSTALL_DIR ?= $(shell [ -d /boot/grub2 ] && echo /boot/grub2 || echo /boot/grub)/themes/$(notdir $(TARGET_DIR))

IMAGES := $(addprefix $(TARGET_DIR)/, $(notdir $(wildcard $(SRC_DIR)/*.png)))
TTFS := $(notdir $(wildcard $(SRC_DIR)/*.ttf))
FONTS := $(addprefix $(TARGET_DIR)/, $(TTFS:.ttf=.pf2))

.PHONY: preview install uninstall clean

$(TARGET_DIR)/theme.txt: $(IMAGES) $(FONTS)
	cp $(SRC_DIR)/theme.txt $@

$(TARGET_DIR)/%.pf2: $(SRC_DIR)/%.ttf $(TARGET_DIR)
	$(MKFONT) -o $@ -s 26 $<

$(TARGET_DIR)/%.png: $(SRC_DIR)/%.png $(TARGET_DIR)
	cp $< $@

$(TARGET_DIR):
	mkdir -p $@

preview: $(TARGET_DIR)/theme.txt
	$(PREVIEW_COMMAND) --resolution $(PREVIEW_RESOLUTION) $(TARGET_DIR)

install: $(TARGET_DIR)/theme.txt
	install -dvm 755 $(INSTALL_DIR)
	install -vm 755 $(TARGET_DIR)/* $(INSTALL_DIR)/
	$(MAKE) clean
	@echo -e "\033[0;32mYou can now use this theme at $(INSTALL_DIR)/theme.txt\033[0m"

uninstall: $(INSTALL_DIR)
	@printf "Are you sure you want to remove $(realpath $(INSTALL_DIR))? (y/N) "
	@read -r -n 1 confirm && [ "$$confirm" = "y" ]; \
	if [ $$? -eq 0 ]; then rm -rf $(INSTALL_DIR); fi
	@printf '\n'

clean: $(TARGET_DIR)
	rm -rf $(TARGET_DIR)
