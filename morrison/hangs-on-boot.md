https://discourse.nixos.org/t/new-install-hangs-on-boot/21435

```
Oct 21 12:40:31 spectre systemd[1]: Started Network Time Synchronization.
Oct 21 12:40:31 spectre audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-timesyncd comm="systemd" exe="/nix/store/m6qj9brj0xmigvsadsq5n86kp36cxqb5-systemd-250.4/lib/systemd/systemd" hostname=? addr=? termi>
Oct 21 12:40:31 spectre kernel: videodev: Linux video capture interface: v2.00
Oct 21 12:40:31 spectre kernel: mei_me 0000:00:16.0: enabling device (0000 -> 0002)
Oct 21 12:40:31 spectre kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
Oct 21 12:40:31 spectre kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Oct 21 12:40:31 spectre kernel: i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
Oct 21 12:40:31 spectre kernel: i801_smbus 0000:00:1f.4: SPD Write Disable is set
Oct 21 12:40:31 spectre kernel: i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
Oct 21 12:40:31 spectre kernel: i2c i2c-0: 2/2 memory slots populated (from DMI)
Oct 21 12:40:31 spectre kernel: i2c i2c-0: Memory type 0x22 not supported yet, not instantiating SPD
Oct 21 12:40:31 spectre kernel: usb 1-6: Found UVC 1.00 device Integrated_Webcam_HD (0c45:6a15)
Oct 21 12:40:31 spectre kernel: ACPI Warning: \_SB.PC00.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20210730/nsarguments-61)
Oct 21 12:40:31 spectre kernel: ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20210730/nsarguments-61)
Oct 21 12:40:31 spectre kernel: pci 0000:01:00.0: optimus capabilities: enabled, status dynamic power, hda bios codec supported
Oct 21 12:40:31 spectre kernel: VGA switcheroo: detected Optimus DSM method \_SB_.PC00.PEG1.PEGP handle
Oct 21 12:40:31 spectre kernel: nouveau: detected PR support, will not use DSM
Oct 21 12:40:31 spectre kernel: Console: switching to colour dummy device 80x25
Oct 21 12:40:31 spectre kernel: nouveau 0000:01:00.0: NVIDIA GA107 (b77000a1)
Oct 21 12:40:31 spectre kernel: input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.0/input/input19
Oct 21 12:40:31 spectre kernel: usb 1-6: Found UVC 1.00 device Integrated_Webcam_HD (0c45:6a15)
Oct 21 12:40:31 spectre kernel: input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/input/input20
Oct 21 12:40:31 spectre kernel: usbcore: registered new interface driver uvcvideo
Oct 21 12:40:31 spectre kernel: intel-spi 0000:00:1f.5: w25q512jvq (65536 Kbytes)
Oct 21 12:40:31 spectre kernel: Intel(R) Wireless WiFi driver for Linux
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
Oct 21 12:40:31 spectre kernel: i915 0000:00:02.0: Your graphics device 46a6 is not properly supported by the driver in this
                                kernel version. To force driver probe anyway, use i915.force_probe=46a6
                                module parameter or CONFIG_DRM_I915_FORCE_PROBE=46a6 configuration option,
                                or (recommended) check for kernel updates.
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-66.ucode failed with error -2
Oct 21 12:40:31 spectre kernel: Creating 1 MTD partitions on "0000:00:1f.5":
Oct 21 12:40:31 spectre kernel: 0x000000000000-0x000004000000 : "BIOS"
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: Direct firmware load for iwlwifi-so-a0-gf-a0-65.ucode failed with error -2
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.25
Oct 21 12:40:31 spectre kernel: iwlwifi 0000:00:14.3: loaded firmware version 64.97bbee0a.0 so-a0-gf-a0-64.ucode op_mode iwlmvm
Oct 21 12:40:31 spectre kernel: nouveau 0000:01:00.0: bios: version 94.07.5b.00.8a
Oct 21 12:40:31 spectre kernel: nouveau 0000:01:00.0: fb: 4096 MiB GDDR6
Oct 21 12:40:31 spectre kernel: nouveau 0000:01:00.0: DRM: VRAM: 4096 MiB
```
