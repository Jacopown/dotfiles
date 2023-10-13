# This is the procedure I follow while installing Arch Linux on my machines

### Change keymap

Arch sets the default keyboard to US, so if you have another keyboard layout you need to change it. Run

```bash
ls /usr/share/kbd/keymaps/**/*.map.gz
```

You can obviously change the next command according to one of the results you got:

```bash
loadkeys it
```

### Network connection

If you use an ethernet cable you're probably already connected, you can check it by running

```bash
ping www.archlinux.com
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

### Mirrors
<!-- TODO move mirrors in the right place -->
Now we'll tell our package manager the best mirrors to use

```bash
pacman -Syyy
```

```bash
pacman -S reflector
```

```bash
reflector -c Italy -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

You need to change 'Italy' with your country and you can also change the -a value that represents the max number of hours from the last synchronization of the mirrors, it's better to set it $\geq 6$ so you'll surely find some mirrors.

## Partitioning

I'll try to explain every possible scenario you'll meet while installing arch, so choose the right formatting guide that fits you. The only part of the guide that changes is the one on partitioning, the rest is universal.
Let's start by checking if you are on an UEFI system, run

```bash
ls /sys/firmware/efi/efivars
```

If you don't see any relevant output choose guides for non-UEFI systems.
If you see a bunch of lines appear choose guides for UEFI systems.

### Partitioning for no dualboot Arch installation (UEFI)

You can use

```bash
sfdisk -l
```

```bash
lsblk
```

to identify the disk where you want to install Arch. For example I'll install on *sda*.
In the following commands you have to change the disk and partition codes to match yours.
Start formatting the disk with

```bash
fdisk /dev/sda
```

1. Type 'd' and press Enter for partition deleting.
1. Type 'n' and press Enter for new partition.
1. Press Enter for default primary partition.
1. Press Enter again for partition number 1.
1. Press Enter again for default first sector.
1. Type '+512M' and press Enter for partition dimension.
1. Type 't' and press Enter for changing partition type.
1. Type 'L' and press Enter for a list of available types.
1. Type the code corresponding to EFI system and press Enter.
1. Type 'n' and press Enter for new partition.
1. Keep pressing Enter until the process ends for default option in every step.
1. Type 'w' and press Enter.
Create filesystem on both partitions with

```bash
mkfs.fat -F32 /dev/sda1
```

```bash
mkfs.ext4 /dev/sda2
```

Mount root partition

```bash
mount /dev/sda2 /mnt
```

### Partitioning for separate Arch and Windows disks (UEFI)

You can use `sfdisk -l` or `lsblk` to identify the disk where you want to install Arch and the already existing EFI partition in the windows disk.
I've also another HDD where i save my documents, photos and videos and i want to be able to access it from both linux and windows.
Lets start creating the partition for linux, run:

```bash
fdisk /dev/sdd
```

1. Than type 'g' and press Enter.
2. Type 'n' and press Enter.
3. Press Enter for default option.
4. Press Enter for default option again.
5. Type the amount of space u want to allocate for the linux installation, leaving enought space for swap partition if needed and press Enter.
6. If asked type 'Y' and hit Enter to remove the existing signature.
7. Type 'n' and press Enter.
8. Type Enter for default option.
9. Type Enter for default option again.
10. Type the amount of space u want to allocate for the swap partition and press Enter.
11. If asked type 'Y' and hit Enter to remove the existing signature.
12. Type 't' to change partition type and press Enter.
13. Type '2' and hit Enter to choose the swap partition.
13. Type 'L' to list all possible types and press Enter.
14. Type the code for the 'swap' type and press Enter.
15. Type 'w' and hit Enter.

The swap partition is used as a backup memory by linux in case you'll run out of RAM memory, it is also used to hibernate the system, i chose from [here](https://itsfoss.com/swap-size/) the dimension of this partition.
Now we've created our partition for linux (you can check it running `lsblk`).
Now we will create the file system on our new partition

```bash
mkfs.btrfs /dev/sdd1
```

Same for swap partition

```bash
mkswap /dev/swap_partition
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

And last activate swap partition

```bash
swapon /dev/swap_partition
```

### Base Installation

Run

```bash
pacstrap /mnt base linux linux-firmware btrfs-progs base-devel linux-headers vim
```

You can also add `intel-ucode` or `amd-ucode` if you have intel or amd processors.

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

### Locales Let's search for our timezone 

Run

```bash
ls /usr/share/zoneinfo/ 
```
and u'll see the list of regions, into the region folder u can find the city u want.

You need to change 'Europe/Rome' according to your region and timezone, and set it with

```bash
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
```

Now sync the hardware clock with the system clock

```bash
hwclock --systohc
```

Now run

```bash
vim /etc/locale.gen
```

and uncomment the line you prefer, this will define the date format of your system, the language, the currency and other stuff. You can also choose more than one.

Run

```bash
locale-gen
```

and

```bash
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

Change "en_US.UTF-8" according to the line you uncommented in the previous step.

Than

```bash
export LANG=en_US.UTF-8
```

If you've changed keymap at the beginning, run

```bash
echo "KEYMAP=it" >> /etc/vconsole.conf
```

and change 'it' with your keymap. Now we've set our locales.

### Hostname

Run

```bash
vim /etc/hostname
```

write the hostname for your machine on the first line than save and exit.
Run

```bash
vim /etc/hosts
```

and on new line write

```bash
127.0.0.1   localhost
::1         localhost
127.0.1.1   hostname.localdomain    hostname
```

Note that in the first line you need to tab once for the spacing and continue usig tab to reproduce the same structure as in the example. Change 'hostname' according to the one you set in the first step.

## GRUB installation

Do you remember when I said that the guide is universal except for partitioning? Well I was lying.

### GRUB installation for no dualboot Arch installation (UEFI)

Let's install grub and some other useful packages

```bash
pacman -S grub efibootmgr base-devel linux-headers 
```

Create boot directory

```bash
mkdir /boot/EFI
```

and mount boot partition

```bash
mount /dev/sda1 /boot/EFI
```

Now we'll install grub on the system

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
```

and create the grub config file

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### GRUB installation for no dualboot Arch installation (non-UEFI)

Let's install grub and some other useful packages

```bash
pacman -S grub base-devel linux-headers 
```

Create boot directory

```bash
mkdir /boot/EFI
```

and mount boot partition

```bash
mount /dev/sda1 /boot/EFI
```

Now we'll install grub on the system

```bash
grub-install /dev/sda
```

and create the grub config file

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### GRUB installation for separate Arch and Windows disks (UEFI)

Let's install grub and some other useful packages

```bash
pacman -S grub efibootmgr os-prober 
```

Now we'll install grub on the system

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
```

and create the grub config file

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

If the output doesn't show that grub has found the windows partition or if it says that os-prober had some problems do the following steps

```bash
vim /etc/default/grub
```

and add or uncomment

```bash
GRUB_DISABLE_OS_PROBER=false
```

save and exit and run
```
os-prober
```
and than run

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### Enable services

Let's install some useful packages

```bash
pacman -S networkmanager network-manager-applet wireless_tools wpa_supplicant dialog pipewire pipewire-alsa pipewire-pulse pipewire-jack bluez bluez-utils cups git stow
```

When asked choose WirePlumber as session manager for pipewire.

Now enable them:

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

And now modify wheel group options uncommenting the line "%wheel ALL=(ALL:ALL)ALL"

```bash
EDITOR=vim visudo
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

### Final setup

If you want wifi connection

```bash
nmtui
```

And install graphic card drivers

```bash
sudo pacman -S xf86-video-intel
```

for intel graphic cards

```bash
sudo pacman -S xf86-video-amdgpu
```

for amd graphic cards

```bash
sudo pacman -S nvidia nvidia-utils
```

for nvidia graphic cards

```bash
sudo pacman -S xf86-video-vmware
```

for virtual machines.
