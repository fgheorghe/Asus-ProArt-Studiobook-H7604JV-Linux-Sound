# Description

!!! NOTE: As of Linux Kernel 6.7 this patch is obsolete. !!!

Linux ProArt Studiobook H7604JV_H7604JV sound fix.

Works with:
```ASUSTeK COMPUTER INC. ProArt Studiobook H7604JV_H7604JV/H7604JV, BIOS H7604JV.300 04/13/2023
  Hardware Class: sound
  Model: "Intel Multimedia audio controller"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x7a50
  SubVendor: pci 0x1043 "ASUSTeK Computer Inc."
  SubDevice: pci 0x1f1f
  Revision: 0x11
  Driver: "snd_hda_intel"
  Driver Modules: "snd_hda_intel"
```

Use ONLY for this specific model and BIOS version 300 (H7604JV.300) and at your own risk!

# Synopsis

ASUS Laptops have an incorporated Cirrus CS35L41 audio amplifier. 

Their BIOSes do not properly expose ACPI properties to the kernel, thus Linux drivers won't be able to use this amplifier.

This fix adds missing properties to the kernel and is based on:

https://asus-linux.org/wiki/cirrus-amps/

https://gist.github.com/lamperez/862763881c0e1c812392b5574727f6ff

https://github.com/badgers-ua/asus_zenbook_ux5304va_sound

Firmware has been extracted from Windows 11.

# Requirements

This patch has been tested on KUbuntu 23.04 with linux kernel 6.4.11-060411-generic, however it should work on any kernel supporting ASUS UX582ZS, which appears to be compatible with H7604JV.

Support has been introduced here:

https://lore.kernel.org/lkml/20220815141953.25197-1-sbinding@opensource.cirrus.com/.

To install a specific version of the kernel use: https://learnubuntu.com/install-mainline-kernel/

Install the following dependencies:

sudo apt install acpica-tools

# Install

Issue ./install.sh to install patched ACPI properties and firmware.

Add the following line to /etc/default/grub

```GRUB_EARLY_INITRD_LINUX_CUSTOM="patched_cirrus_acpi.cpio"```

Add the following line to /etc/modprobe.d/alsa-base.conf to tell alsa to use kernel quirks for UX582ZS, a driver that's already present and works:

```options snd-hda-intel model=1043:1a8f```

Issue ```sudo update-grub``` and reboot.

# Notes

Potentially secure boot must be disabled.

A kernel patch should be made for quirks specific to: H7604JV.

It can be done by adding this line in linux/sound/pci/hda/patch_realtek.c: 

```SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VV", ALC245_FIXUP_CS35L41_SPI_2),```

Below:

```SND_PCI_QUIRK(0x1043, 0x1f1f, "ASUS H7604JV", ALC245_FIXUP_CS35L41_SPI_2),```
