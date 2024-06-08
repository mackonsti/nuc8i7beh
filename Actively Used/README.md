# Actively Used Files

:white_check_mark: Currently running **MacOS 10.13 Ventura** since OpenCore **0.9.9**.

**Table Of Contents**
- [Current NUC BIOS Revision](#current-nuc-bios-revision)
- [Generating Personalised SMBIOS](#generating-personalised-smbios)
- [OpenCore Version Installed](#opencore-version-installed)
- [OpenCore Configuration Files](#opencore-configuration-files)
- [Notable Configuration Differences](#notable-differences-in-configurations)
- [OpenCore Main Parameters](#opencore-main-parameters)
- [Regarding CFG Lock in BIOS](#regarding-cfg-lock-in-bios)
- [Sleep/Wake Parameters](#sleepwake-parameters)

## Current NUC BIOS Revision

BECFL357.86A.0089.2021.0621.1343

## Generating Personalised SMBIOS

It is important to generate a personalised SMBIOS using `Macmini8,1` as target model. To complete the respective OpenCore configuration section for SMBIOS (namely `MLB`, `SystemSerialNumber` and `SystemUUID` keys) it is advised to use [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS) scripts and add the generated values in the respective places in `config.plist` file.

As for the _unique_ number needed in the **ROM** value of the `PlatformInfo` section, the recommended method is to take the 12 digits from the **en0** network controler (without the colons) and convert them to [Base64](https://cryptii.com/pipes/hex-to-base64) for use as `<data>` under `<key>ROM</key>` in the OpenCore configuration file. The value `<data>ESIzRFVm</data>` is generic; read more over at [Dortania](https://dortania.github.io/OpenCore-Post-Install/universal/iservices.html#fixing-rom).

To confirm that the injected value works persistently across reboots, one can either run in Terminal [iMessageDebug](https://mac.softpedia.com/get/System-Utilities/iMessageDebug.shtml) or the command:<br/>
`nvram -x 4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14:ROM` and verify the output.

## OpenCore Version Installed

These files have been running without issues with the official OpenCore releases on [GitHub](https://github.com/acidanthera/OpenCorePkg/releases).

The original configuration, especially setting the "Quirks" to the correct values for this _specific_ NUC chipset and platform, was done by following this [Dortania Guide to OpenCore](https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html) and has remained pretty much the same with the last OpenCore iterations.

## OpenCore Configuration Files

* **config.normal.plist** → Boots to default drive as a normal Mac would do (non-verbose) without any boot options displayed; only a small time-window is set to allow options via keyboard; all kexts are enabled, debug logging is disabled. Keys `ShowPicker` set to false, `Timeout` set to 0 seconds and `TakeoffDelay` set 5000 microseconds.

* **config.picker.plist** → Shows boot options (i.e. picker) with basic tools; all hidden Auxiliary tools are displayed if 'Space' is pressed on keyboard; after a brief time-out, continues (non-verbose) booting to default drive; all kexts are enabled, debug logging is disabled. Keys `ShowPicker` set to true, `Timeout` set to 5 seconds and `TakeoffDelay` set 0 microseconds.

* **config.emergency.plist** → Shows boot options (i.e. picker) with **all** Auxiliary tools displayed; after a brief time-out, continues **verbose** `-v` booting to default drive; Wi-Fi and BTLE kexts are disabled; debug logging is enabled, including boot arguments being present. Keys `HideAuxiliary` set to false, `ShowPicker` set to true, `Timeout` set to 5 seconds. Additionally, `SecureBootModel` is disabled, `PanicNoKextDump`, `AppleDebug`, `ApplePanic`, `AllowNvramReset`, `AllowSetDefault` and `AllowToggleSip` are now enabled. Special boot arguments `keepsyms=1`, `debug=0x100` and `msgbuf=1048576` are set. **This file is notably used for USB installers.** Please note that the argument `npci=0x2000` has been recently removed.

All configuration files have been **validated** with `ocvalidate` tool that has been included in the OpenCore releases since its version 0.7.6.

## Notable Differences in Configurations

According to the [OpenCore documentation available](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf), these are the main points that change between these configurations above:

**Kernel → Quirks → PanicNoKextDump**

When enabled, macOS kernel is prevented from printing kext dumps in the panic log, thus helping observe the panic details themselves (only applicable to macOS 10.13 and newer).

**Misc → Boot → TakeoffDelay**

Delay (in microseconds) executed _before_ handling the OpenCore picker startup and action hotkeys. Introducing a delay may give extra time to hold the right action hotkey sequence to, for instance, boot into recovery mode. On some platforms, setting this option to a minimum of 5000-10000 microseconds may be required to access action hotkeys due to the nature of the keyboard driver.

**Misc → Boot → Timeout**

Timeout (in seconds) in the OpenCore picker _before_ automatic booting of the default boot entry starts; set to 0 to disable.

**Misc → Debug → AppleDebug**

Enables writing the `boot.efi` debug log to the OpenCore log (only applicable to macOS 10.15.4 and newer).

**Misc → Debug → ApplePanic**

Saves macOS kernel panic output to the OpenCore root (EFI) partition. The file is saved as `panic-YYYY-MM-DD-HHMMSS.txt` and it is strongly recommended to include the `keepsyms=1` boot argument that allows printing debug symbols in the panic log.

**Misc → Debug → DisplayLevel**

The following debug output levels are supported, provided that `Target` enables console (on-screen) printing:

* `0x00000002 - DEBUG_WARN in DEBUG, NOOPT, RELEASE`
* `0x00000040 - DEBUG_INFO in DEBUG, NOOPT`
* `0x00400000 - DEBUG_VERBOSE` in custom builds
* `0x80000000 - DEBUG_ERROR in DEBUG, NOOPT, RELEASE`

The most common value found in many configurations is `<integer>2147483648</integer>` that translates to `0x80000000` as well as `<integer>2147483650</integer>` that translates to `0x80000002`.

**Misc → Debug → Target**

The following logging targets are supported, besides `0x00` that is the failsafe value:

* `0x01` Enable logging, otherwise all log is discarded
* `0x02` Enable basic console (on-screen) logging
* `0x04` Enable logging to Data Hub
* `0x08` Enable serial port logging
* `0x10` Enable UEFI variable logging
* `0x20` Enable non-volatile UEFI variable logging
* `0x40` Enable logging to file

**Misc → Security → AllowSetDefault**

Allows using `CTRL+Enter` and `CTRL+Index` keyboard shortcuts that can change the default boot option (drive) in the OpenCore picker.

**Misc → Security → ScanPolicy**

The assigned value allows or prevents OpenCore from scanning and booting from untrusted sources (and partitions). A typical value of `17760515` (integer) or `0x10F0103` (hexadecimal) allows booting from most expected modern sources, whereas a value of `0` (zero) _disables_ this feature and allows booting from **any** source, especially useful for **USB installers.**

* `0x00000001 - OC_SCAN_FILE_SYSTEM_LOCK` restricts scanning to **file systems** defined as a part of this policy
* `0x00000002 - OC_SCAN_DEVICE_LOCK` restricts scanning to **device types** defined as a part of this policy
* `0x00000100 - OC_SCAN_ALLOW_FS_APFS` allows scanning of APFS file system
* `0x00010000 - OC_SCAN_ALLOW_DEVICE_SATA` allow scanning SATA devices
* `0x00020000 - OC_SCAN_ALLOW_DEVICE_SASEX` allow scanning SAS and Mac NVMe devices
* `0x00040000 - OC_SCAN_ALLOW_DEVICE_SCSI` allow scanning SCSI devices
* `0x00080000 - OC_SCAN_ALLOW_DEVICE_NVME` allow scanning NVMe devices
* `0x01000000 - OC_SCAN_ALLOW_DEVICE_PCI` allow scanning devices directly connected to PCI bus

**Misc → Security → SecureBootModel**

Sets Apple Secure Boot hardware model and policy. Specifying this value defines which operating systems will be bootable. Operating systems shipped before the specified model was released, will not boot. A value `Default` will match the model from the SMBIOS defined in the configuration; a value `Disabled` will match no model and Secure Boot will be disabled.

**UEFI → APFS → MinDate**

The APFS driver _date_ connects the APFS driver with the respective _calendar_ release date of macOS. This option allows restricting APFS drivers to modern macOS versions. A default date value of `0` (zero) corresponds to 2021/01/01 and can be used for macOS Big Sur and newer; a date value of `20200306` (integer) is needed for booting macOS Catalina; a value of `-1` permits any macOS release to load, as it actually _disables_ this feature.

**UEFI → APFS → MinVersion**

The APFS driver _version_ connects the APFS driver with the respective macOS _release_. This option allows restricting APFS drivers to modern macOS versions. A default version value of `0` (zero) can be used for macOS Big Sur and newer; a version value of `1412101001000000` (integer) is needed for booting macOS Catalina; a value of `-1` permits any macOS version to load, as it actually _disables_ this feature.

## OpenCore Main Parameters

1. The following **important** DSDT patches are enabled:

Rename `_STA` to `XSTA` for device `(H_EC)` allowing to disable this native device and use **SSDT-EC-USBX.aml** that injects a fake `(EC)` device that is absolutely required for a successful boot into macOS.

2. The following basic IGPU embedded graphics IDs are injected:
```
	<key>AAPL,ig-platform-id</key>
	<data>BAClPg==</data>
	<key>device-id</key>
	<data>pT4AAA==</data>
```
This NUC is embedding the **Intel Iris Plus Graphics 655** display controller with PCI ID of [[8086:3ea5]](http://pci-ids.ucw.cz/read/PC/8086/3ea5) that seems compatible with the one used by `Macmini8,1` natively. However, if no IDs are injected or the wrong ones, **WhateverGreen** may be assigning a different set of IDs (probably due to the CPU platform) which has insofrar led many times to lack of acceleration or computer freezes.

It is thus important to _force_ a `device-id` and an `ig-platform-id` value in OpenCore that reflect this Mac Mini IGPU hardware, thus matching this NUC hardware. This leads to the safe use of `device-id` value `0x3EA50000` and `AAPL,ig-platform-id` as `0x3EA50004` (byte-swapped) thanks to Hackintool. See **DeviceProperties** at [Dortania](https://dortania.github.io/OpenCore-Install-Guide/config-laptop.plist/coffee-lake-plus.html#deviceproperties).

:warning: Starting from OpenCore 0.8.4 configuration, a more precise port definition was added in order to correctly identify the embedded HDMI port.

3. The following custom SSDTs are included, defined and enabled:

* SSDT-APPLE.aml
* SSDT-AWAC.aml
* SSDT-EC-USBX.aml
* SSDT-HPTE.aml
* SSDT-JHL6340.aml
* SSDT-NAMES.aml
* SSDT-PLUG.aml
* SSDT-PMCR.aml
* SSDT-SBUS.aml
* SSDT-XOSI.aml → disabled

The ACPI code and justification for each custom SSDT is described in more detail in the [SSDTs](../SSDTs) section.

4. The following kexts are included, defined and required:

* [AirportItlwm.kext](https://github.com/OpenIntelWireless/itlwm/releases)
* [AppleALC.kext](https://github.com/acidanthera/AppleALC/releases)
* [IntelBluetoothFirmware.kext](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases)
* [IntelBluetoothInjector.kext](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases) → removed :warning:
* [IntelBTPatcher.kext](https://github.com/OpenIntelWireless/IntelBluetoothFirmware/releases)
* [BlueToolFixup.kext](https://github.com/acidanthera/BrcmPatchRAM/releases)
* [IntelMausi.kext](https://github.com/acidanthera/IntelMausi/releases)
* [Lilu.kext](https://github.com/acidanthera/Lilu/releases)
* [NVMeFix.kext](https://github.com/acidanthera/NVMeFix/releases) → disabled
* [SMCProcessor.kext](https://github.com/acidanthera/VirtualSMC/releases)
* [SMCSuperIO.kext](https://github.com/acidanthera/VirtualSMC/releases)
* [VirtualSMC.kext](https://github.com/acidanthera/VirtualSMC/releases)
* [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen/releases)
* USBPorts.kext

:warning: Starting from OpenCore 0.9.4 configuration, this NUC will be running **macOS Monterey** and a major change in the loaded kexts has taken place, namely the replacement of `IntelBluetoothInjector.kext` with `BlueToolFixup.kext` so please be aware.

**Note:** It has not been validated if the use of **NVMeFix.kext** improves overall sleep or power consumption, therefore this kext is at this moment just disabled and won't get loaded.

# Important Notes

## Regarding CFG Lock in BIOS

The latest BIOS revisions do **not** offer any option to set the CPU's value regaring CFG Lock i.e. the MSR `0xE2` register cannot be unlocked, despite efforts using EFI tools such as `CFGLock.efi` and `ControlMsrE2.efi` via the UEFI Shell in OpenCore.

This requires therefore a specific "quirk" in OpenCore _Kernel_ configuration to be set for the current hardware platform, so that kernel panics are avoided at all times: `AppleXcpmCfgLock` must be set to `true`.

As a reminder, according to the OpenCore Configuration manual and a [further clarification](https://github.com/acidanthera/bugtracker/issues/1751#issuecomment-900576662) in a support thread:

* `AppleCpuPmCfgLock` relates only to `AppleIntelCPUPowerManagement.kext` which is no longer used on El Capitan 10.11 or newer systems, for Haswell or newer platforms;
* `AppleXcpmCfgLock` requires Haswell or newer platforms and affects any supported macOS (but is _not_ used on any macOS using IvyBridge or older).

## Sleep/Wake Parameters

The following parameters can be set via Terminal, according to the Dortania guide to [Fixing Sleep](https://dortania.github.io/OpenCore-Post-Install/universal/sleep.html#preparations):

```
sudo pmset autopoweroff 0; \
sudo pmset powernap 0; \
sudo pmset standby 0; \
sudo pmset proximitywake 0; \
sudo pmset tcpkeepalive 0
```

These `pmset` parameters above achieve the following:

* Disable `Auto Power-Off` → prevents this form of hibernation;
* Disable `Power Nap` → prevents periodically waking the computer for network and updates(but not the display);
* Disable `Standby` → minimises the time period between sleep and going into hibernation;
* Disable `Proximity Wake` → does not allow waking from an iPhone or an Apple Watch when they come near;
* Disable `TCP Keep Alive` → prevents the mechanism that wakes the computer up every 2 hours.
