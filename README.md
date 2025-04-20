# ultragrub-theme
I wanted to make a cool theme about a game I love, and this is what happened.

## Screenshots
<img src="https://github.com/user-attachments/assets/3ccf0cc2-a5fc-467f-bb83-27543d3b0ee6" alt="Normal selection screen" width="700">
<details>
<summary>More screenshots</summary>  
<img src="https://github.com/user-attachments/assets/d2bef9db-bbd1-4f71-85fb-3e56b395d186" alt="GRUB command line" width="700">
</details>

## Installation
First, make sure GNU Make and GRUB are installed.
- **On Debian/Ubuntu/Mint-based systems:**
  `sudo apt install make grub-pc`
- **On Fedora/CentOS/RHEL-based systems:**
  `sudo dnf install make grub2`
  <!-- todo: verify that grub2 is correct -->
- **On Arch-based systems:**
  `sudo pacman -S make grub`
Then, clone the repository and run `sudo make install`:
```bash
git clone https://github.com/its-mrarsikk/ultragrub-theme.git
cd ultragrub-theme
sudo make install
```
In order to apply the theme, edit your `/etc/default/grub` and add or replace this line:
```ini
GRUB_THEME=/boot/grub/themes/ultragrub/theme.txt
```
Then, run your distro's command to update GRUB's configuration:
- **On Debian/Ubuntu/Mint-based systems:**
  `sudo update-grub`
- **On Fedora/CentOS/RHEL-based systems:**
  `sudo grub2-mkconfig -o /boot/grub2/grub.cfg`
- **On Arch-based systems:**
  `sudo grub-mkconfig -o /boot/grub/grub.cfg`
  
Finally, reboot your system.
## Uninstalling
If you still have the Makefile:
```bash
sudo make uninstall
```
Otherwise,
```bash
sudo rm -rf /boot/grub/themes/ultragrub
```
## Other `make` targets
- `make` simply copies files and converts fonts from `src` to `ultragrub`.
- `make preview` launches [`grub2-theme-preview`](https://github.com/hartwork/grub2-theme-preview) to preview the theme.
- `make clean` removes `ultragrub` from the current directory.
## Credits
- **Arsi "Hakita" Patala** and **New Blood Interactive** for **ULTRAKILL**
- **hartwork** for **grub2-theme-preview**
- **KDE** for the Breeze theme which I used as a base
