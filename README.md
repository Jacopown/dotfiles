# My dotfiles collection

The aim of this repository is to collect all my dotfiles to let me (and eventually everyone interested) to replicate my linux setups.  
I'm trying to be as detailed as possible because of my bad memory.  
In all the Window Managers installation guides I'm assuming you have a clean Arch installation made by following [my guide](https://github.com/Jacopown/dotfiles/blob/main/docs/ArchLinux.md) and this repository cloned in your home directory.  
I'm currently working on all this setups and some of them already need an update, see [TODO](#todo).

### Index

- [AwesomeWM](#awesomewm)
  - [Dependencies](#dependencies)
  - [Base Installation](#base-installation)
  - [Wallpapers](#wallpapers)
  - [Login Manager](#login-manager)
  - [Terminal and Shell](#terminal-and-shell)
  - [Rofi](#rofi)
- DWM
- Terminals and Shell
  - [Alacritty](#alacritty)
  - st
  - [zsh](#zsh)
- [Apps and Tools](#apps-and-tools)
  - [NeoVim](#neovim)
  - [mlocate](#mlocate)
- [TODO](#todo)

## AwesomeWM

At the end of the installation process, you can jump to [Apps and Tools](#apps-and-tools) to add usefull programs and their configurations.

### Dependencies

For my AwesomeWm build i use some specific tools (i.e. some keybindinded tools) that we'll be install right now, more general tools will have a dedicated section.  
I use Paru as AUR helper so...

```bash
mkdir ~/tmp
git -C ~/tmp clone https://aur.archlinux.org/paru.git
cd ~/tmp/paru
makepkg -si
rm -rf ~/tmp
```

...and let's install everything we need:

```
paru -S xorg-server awesome-git lightdm lightdm-gtk-greeter
```
than reboot to make lightdm service available and than run
```
sudo systemctl enable lightdm.service
```
now set the greeter-session parameter in `/etc/lightdm/lightdm.conf` file as `lightdm-gtk-greeter` and rebooting again should show the display manager on boot.
```
paru -S openssh
```

```bash
paru -S xorg xorg-xinit awesome alacritty nitrogen wget rofi lxsession lxappearance qt5ct brave-bin 
```

If you'd like to use another terminal emulator skip the alacritty package.

### Base Installation

First of all let's symlink my AwesomeWM config directory:

```bash
cd ~/dofiles && stow awesome
```

### Wallpapers

By default my build reads the whole wallpapers folder and sets a random one everytime you restart the WM, you can edit nitrogen autostart command at the end of `~/.config/awesome/rc.lua` as you prefer to change this behaviour.

### Login Manager

Now we'll install the login manager, the greeter and the login manager theme. Than we enable it:

 ```bash
paru -S lightdm lightdm-webkit2-greeter lightdm-webkit-theme-aether
sudo systemctl enable lightdm
 ```

And reboot.

### Terminal and Shell

In this setup I used Alacritty with zsh, feel free to install averything you prefer but keep in mind that I'm using the MesloNerdFontPatched from the zsh theme installation as system font so you'll need to change some configs if you skip it and also edit awesome terminal keybind to match the terminal you've chosen.  
[My Alacritty setup guide](#alacritty).  
[My zsh setup guide](#zsh).

### Rofi

The last step is to symlink my rofi config files:

```bash
stow -t ~/ ~/dotfiles/rofi/
```

## Alacritty

This terminal installation uses [my zsh](#zsh) theme font, if you're planning to use another remember to change it in the config file.  

First of all let's install our font:

```bash
sudo mkdir -p /usr/local/share/fonts/ttf/MesloNerdFontPatched
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
```

Symlink my Alacritty config file:

```bash
stow ~/dotfiles/linuxAlacritty/
```

and restart the terminal to see the changes.  

## zsh

As of now I'm using the p10k theme and oh-my-zsh on my zsh setup.
Let's install our shell

```bash
paru -S zsh
```

Set zsh as your default shell...

```bash
chsh -s $(which zsh)
```

...and reboot.

Now we'll install oh-my-zsh and the shell theme

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git -C ~/.oh-my-zsh/custom/themes clone https://github.com/romkatv/powerlevel10k.git
```

Now install the patched font used by powerlevel10k (if you follow the shell
guide as a standalone guide remember to set this font as your terminal font):

```bash
sudo mkdir -p /usr/local/share/fonts/ttf/MesloNerdFontPatched
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
```

Symlink my shell configs:

```bash
stow ~/dotfiles/zsh/
```

Let's finish this up by installing some plugins and tools for our cli:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
paru -S thefuck
```

Now restart your terminal.

## Apps and Tools

In this section I'll list all the tools, programs and applications that I normally use and if needed, their configs.

### NeoVim

Simply copy my configs:

```bash
cp -r ~/Downloads/dotfiles/linux/config/nvim ~/.config
```

Than open nvim and run:

```
:PlugInstall
```

### mlocate

A simple cli command to search files or folders running `locate` seguito dal nome da cercare.

```bash
paru -S mlocate
sudo updatedb
```

## TODO

- [ ] Add description for [AwesomeWm](#awesomewm)
- [ ] Add feature list for [AwesomeWm](#awesomewm)
- [ ] Add screenshots for [AwesomeWm](#awesomewm)
- [ ] Add feature list for [zsh](#zsh)
- [ ] Add screenshots for [zsh](#zsh)
- [ ] Add screenshots for [Alacritty](#alacritty)
- [ ] Add and update st
- [ ] Add and update DWM
- [ ] Add programs and tools list
- [ ] Add picom for trasparency and rounded corners [Alacritty](#alacritty)
- [ ] Add gtk and qt themes
- [ ] Add volume control in [Alacritty](#alacritty)
- [ ] Update NeoVim section with a link to a separate .md file with my
  configuration infos and installation guide. [NeoVim](#NeoVim)
- [x] Update all guides to match new dotfiles structure optimization for stow
- [x] Add a section for tools and applications I generally use
- [x] Add nvim config
