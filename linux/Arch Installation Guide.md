# This is the procedure I follow while installing Arch Linux on my machines
## Dualbooting on windows 10 UEFI machine
Let's start by checking if you really are on an UEFI system, run
```bash
ls /sys/firmware/efi/efivars
```
If you don't see any relevant output i'm sorry to tell you that this isn't the right section.
If you see a bunch of lines appear you can proceed from here.
### Change keymap
Arch sets the default keyboard to US, so if you have another keyboard layout you need to change it. Run 
```bash
localectl list-keymaps | grep it
```
You can obviously change 'it' with any country code you're interested in and change the next command according to one of the results you got:
```bash
loadkeys it
```
### Network connection 
If you use an internet cable you're probably already connected, you can check it by running
```bash
ping www.google.com
```
You can check the status of your internet interfaces with
```bash
ip a
```
If you want to use a wifi connection you can set it up with
```bash
wifi-menu
```
In my experience it's always easier to use ethernet connection or usb tethering form your phone and setup wifi connection after the installation.
### Time 
Set the system clock to update through internet
```bash
timedatectl set-ntp true
```
### Mirrors
Now we'll tell our package manager the best mirrors to use
```bash
pacman -Syyy
```
```bash
pacman -S reflector
```
```bash
reflector -c Italy -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```
You need to change 'Italy' with your country and you can also change the -a value that represents the max number of hours from the last synchronization of the mirrors, it's better to set it $\geq 6$ so you'll surely find some mirrors.
### Formatting 
In this guide i'm going to install Arch on a separate disk from windows 10. If you want to install it on the same disk in a partition the process is similar but not exactly the same.
You can use 
```bash
sfdisk -l
```
```bash
lsblk
```
to identify the disk where you want to install Arch and the already existing EFI partition in the windows disk.
In my case the EFI partition is *sdc1* and the linux disk is *sdd*. I've also another HDD where i save my documents, photos and videos and i want to be able to access it from both linux and windows, it is *sdb3* for me.
In the following commands you have to change the disk and partition codes to match yours.
Lets start creating the partition for linux, run 
```bash
fdisk /dev/sdd
```
Than type 'g' and press Enter.
Type 'n' and press Enter.
Press Enter for default option.
Press Enter for default oprion again.
Press Enter for default oprion again.
If asked type 'Y' and hit Enter to remove the existing signature.
Type 'w' and hit Enter.
Now we've created our partition for linux (you can check it running `lsblk`).
Now we will create the file system on our new partition
```bash
mkfs.ext4 /dev/sdd1
```
If asked type 'Y' to proceed anyway.
Now mount the new partition 
```bash
mount /dev/sdd1 /mnt
```
Create a new boot folder where we'll mount the already existing EFI partition 
```bash
mkdir -p /mnt/boot/EFI
```
And mount EFI partition on it
```bash
mount /dev/sdc1 /mnt/boot/EFI
```
The next 2 steps are optional if you want a shared folder between windows and linux like me
```bash
mkdir /mnt/shared_storage
```
```bash
mount /dev/sdb3 /mnt/shared_storage
```
### Create FSTAB
Create fstab file running 
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```
### Chroot
Run 
```bash
arch-chroot /mnt
```
### Swap 
The swap partition is used as a backup memory by linux in case you'll run out of RAM memory, it is also used to hibernate the system, i chose from [here](https://itsfoss.com/swap-size/) the dimension of this partition.
Now allocate the swap file
```bash
fallocate -l 20GB /swapfile
```
Change its permissions
```bash
chmod 600 /swapfile
```
Create the swap file
```bash
mkswap /swapfile
```
Activate swap file
```bash
swapon /swapfile
```
And now add it in the fstab file we created earlier
```bash
nvim /etc/fstab
```
this will open the aditor, on a new line at the bottom of the file type 
```
/swapfile none swap defaults 0 0
```
than save and exit.
### Locales
Let's search for our timezone
```bash
timedatectl list-timezones | grep Rome
```
You need to change 'Rome' according to your timezone, and set it with
```bash
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
```
Now sync the hardware clock with the system clock
```bash
hwclock --systohc
```
Now run
```bash
nvim /etc/locale.gen
```
and uncomment the line you prefere, this will define the date format of your system, the language, the currency and other stuff. You can also choose more than one.
Run
```bash
locale-gen
```
and
```bash
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```
Change "en_US.UTF-8" according to the line you uncommented in the previous step.
If you've changed keymap at the beginning, run
```bash
echo "KEYMAP=it" >> /etc/vconsole.conf
```
and change 'it' with your keymap. Now we've set our locales.
### Hostname
Run 
```bash
nvim /etc/hostname
```
write the hostname for your machine on the first line than save and exit.
Run
```bash
nvim /etc/hosts
```
and on new line write
```bash
127.0.0.1   localhost
::1         localhost
127.0.1.1   hostname.localdomain    hostname
```
Note that in the first line you need to tab once for the spacing and continue usig tab to reproduce the same structure as in the example. Change 'hostname' according to the one you set in the first step.
### GRUB
Let's install grub and some other useful packages
```bash
pacman -S grub efibootmgr os-prober mtools dosfstools base-devel linux-headers ntfs-3g
```
Now we'll install brub on the system 
```bash
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
```
and create the grub config file
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```
If the output doesn't show that grub has found the windows partitio or if it says that os-prober had some problems do the following steps
```bash
nvim /etc/default/grub
```
and add or uncomment
```bash
GRUB_DISABLE_OS_PROBER=false
```
save and exit and run
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```
### Enable services
Let's install some useful packages
```bash
pacman -S networkmanager network-manager-applet wireless_tools wpa_supplicant dialog bluez bluez-utils pulseaudio-bluetooth cups 
```
and enable them
```bash
systemctl enable NetworkManager
```
```bash
systemctl enable bluetooth
```
```bash
systemctl enable cups
```
### Setup Users
Set root password
```bash
passwd
```
Now add a normal user 
```bash
useradd -mG wheel username
```
Change 'username' with yours. Set the password for the new user.
```bash
passwd username
```
And now modify wheel group options uncommenting the line "%wheel ALL=(ALL)ALL"
```bash
EDITOR=nvim visudo
```
```bash
exit
```
```bash
umount -a
```
```bash
reboot
```