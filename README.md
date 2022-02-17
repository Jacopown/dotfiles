# My dotfiles collection

The aim of this repository is to collect all my dotfiles to let me (and eventually everyone interested) to replicate my linux setups.  
I try to be as detailed as possible because of my bad memory.  
In all the Window Managers installation guides I'm assuming u have a clean Arch installation made by following my guide.  
I'm currently working on all this setups and some of them already need an update, see TODO.

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
- [TODO](#todo)

## AwesomeWM

### Dependencies

For my AwesomeWm build i use some specific tool (i.e. some keybindinded tools) that we'll be install right now, more general tools will have a dedicated section.  
I use Paru as AUR helper so...

```bash
mkdir ~/tmp
git -C ~/tmp clone https://aur.archlinux.org/paru.git
cd ~/tmp/paru
makepkg -si
rm -rf ~/tmp
```

...and let's install everything we need:

```bash
paru xorg xorg-xinit awesome alacritty git nitrogen wget rofi  lxappearance qt5ct brave-bin 
```

If you'd like to use another terminal emulator skip the alacritty package.

### Base Installation

First of all let's copy my AwesomeWM config directory:

```bash
mkdir ~/Downloads 
git -C ~/Downloads clone https://github.com/Jacopown/dotfiles.git
cp -r ~/Downloads/dotfiles/linux/Awesome/config/awesome ~/.config
```

### Wallpapers

By default my build reads the whole wallpapers folder and sets a random one everytime you restart the WM, you can edit nitrogen autostart command at the end of `~/.config/awesome/rc.lua` as you prefer to change this behaviour.

```bash
mkdir ~/Pictures 
cp -r ~/Downloads/dotfiles/wallpapers/ ~/Pictures/
```

### Login Manager

Now we'll install the login manager, the greeter and the login manager theme. Than we enable it:

 ```bash
paru lightdm lightdm-webkit2-greeter lightdm-webkit-theme-eather
sudo systemctl enable lightdm
 ```

And reboot.

### Terminal and Shell

In this setup I used Alacritty with zsh, feel free to install averything you prefer but keep in mind that I'm using the MesloNerdFontPatched from the zsh theme installation as system font so you'll need to change some configs if you skip it and also edit awesome terminal keybind to match the terminal you've chosen.  
[My Alacritty setup guide](#alacritty).  
[My zsh setup guide](#zsh).

### Rofi

The last step is to copy my rofi config files:

```bash
cp -r ~/Downloads/dotfiles/linux/Awesome/config/rofi ~/.config
```

## Alacritty

This terminal installation uses my zsh theme font, if you're planning to use another remember to change it in the config file.  
Copy my Alacritty config file:

```bash
cp -r ~/Downloads/dotfiles/linux/Awesome/config/alacritty ~/.config
```

and restart the terminal to see the changes.  
Now we can install our shell, in this case i'll use [my zsh guide](#zsh).

## zsh

As of now I'm using the p10k theme and oh-my-zsh on my zsh setup.
Let's install and start our shell

```bash
paru zsh
zsh
```

At this point you can configure the shell as you like, I kept everything default.  
We're going to overwrite these settings by coping my config file so remember to merge your new setting in my configs when at that point.

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

We are missing a custom font, so let's install it:

```bash
sudo mkdir -p /usr/local/share/fonts/ttf/MesloNerdFontPatched
```

```bash
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
```

```bash
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
```

```bash
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
```

```bash
sudo wget -P /usr/local/share/fonts/ttf/MesloNerdFontPatched https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
```

Copy my shell and theme configs:

```bash
cp -r ~/Downloads/dotfiles/linux/Awesome/.zshrc ~/
cp -r ~/Downloads/dotfiles/linux/Awesome/.p10k.zsh ~/
```

Let's end this by installing some plugins and tools for our cli:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
paru thefuck
```

Now restart your terminal.

## TODO

- [ ] Add description for [AwesomeWm](#awesomewm)
- [ ] Add feature list for [AwesomeWm](#awesomewm)
- [ ] Add screenshots for [AwesomeWm](#awesomewm)
