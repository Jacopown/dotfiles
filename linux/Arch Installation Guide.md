# This is the procedure i follow while installing Arch Linux on my machines
## Dualbooting on windows 10 uefi machine
Let's start by checking if you really are on an uefi system, run
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
Simply set the system clock to update via internet
```bash
timedatectl set-ntp true
```
### Mirrors
Now we will tell our packet manager the best mirrors to use
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
In my case the EFI partition is sdc1 and the linux disk is sdd. I've also another HDD where i save my documents, photos and videos and i want to be able to access it from both linux and windows, it is sdb3 for me.
In the followin command you have to change the disk and partition codes to match yours.
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
Create a new boot folder where we'll mount the already existinf EFI partition 
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
