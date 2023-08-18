#!/bin/sh
iasl -tc ssdt_csc3551.dsl
mkdir -p kernel/firmware/acpi
cp ssdt_csc3551.aml kernel/firmware/acpi
find kernel | cpio -H newc --create > patched_cirrus_acpi.cpio
sudo cp patched_cirrus_acpi.cpio /boot/patched_cirrus_acpi.cpio
sudo cp firmware/cs35l41* /lib/firmware/cirrus
