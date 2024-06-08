# Recently Used SSDTs

**SSDT-APPLE.aml**<br/>
Adds native vanilla `Device (DMAC)` and `Device (FWHD)` like a real Mac.

**SSDT-AWAC.aml**<br/>
Bypass the newer BIOS real-time clock `Device (AWAC)` that is meant as a replacement of `(RTC)`, by setting **STAS** variable to `One`. This is a much cleaner solution compared to any DSDT "hot-patching" that _replaces_ bytes in a specific sequence.

**SSDT-EC-USBX.aml**<br/>
As this is a desktop computer despite using some mobile components, it is advised to disable device `EC`, `EC0` or `H_EC` instead of renaming it. Via a special DSDT hot-patch that allows for a custon `Method (_STA)`, the original device `(H_EC)` is disabled and a fake, needed `Device (EC)` is injected.

At the same time, needed `Device (USBX)` is injected with USB port(s) power supply and limit values, as found on a real Mac.

**SSDT-HPTE.aml**<br/>
As the presence of High Precision Event Timer `Device (HPET)` may cause performance drop(s) in certain situations, setting **HPTE** variable to `Zero` disables natively `(HPET)` in the firmware.

**SSDT-JHL6340.aml**<br/>
Through various posted and studied Thunderbolt SSDTs on-line, this SSDT _disables_ the `(PXSX)` device in `_SB.PCI0.RP05.PXSX` and re-creates it based on native ACPI code from an original, recent Apple computer. A new main `Device (UPSB)` is created, adding three sub-devices `(DSB0)`, `(DSB1)` and `(DSB2)` that are now visible in IORegistry. The `Device (DSB2)` contains a second hardware XHCI controller with two type "9" `UsbConnector` ports.

This new device structure, including the new XHCI controller name and its related ports, requires a new **USBPorts.kext** to be generated via Hackintool in order to reflect this `(XHC2)` controller name change.

**Note:** Total vanilla functionality _cannot_ be achieved, as the Thunderbolt firmware is not the same as the one found on Apple computers.

**SSDT-NAMES.aml**<br/>
This injects device names to otherwise unnamed IORegistry devices, simply because they are not defined in the original DSDT of the BIOS. Although not needed for a functional macOS, these are mainly done for aesthetic reasons.

**SSDT-PMCR.aml**<br/>
Injects the native vanilla `Device (PMCR)` that is accessed by the **AppleIntelPCHPMC** driver and unlocking the use of NVRAM if otherwise not already done by the BIOS.

**SSDT-SBUS.aml**<br/>
To simulate a real Mac, two sub-devices are injected in the existing SMBus device, namely `(BUS0)` and `(BUS1)`. Although these may not appear in IORegistry, they do exist in the original DSDT of a modern Mac.

**SSDT-XOSI.aml**<br/>
Combined with the needed Clover patching (replacing `_OSI` with `XOSI` in DSDT) this allows to emulate a Windows system running, thus getting increased compatibility in general.

## Note regarding USBPorts.kext generated with Hackintool

This NUC has four visible USB ports and they are all USB 3.1 (Generation 2) connectors, except the two *internal* headers that are USB 2.0 connectors (and disabled in BIOS). This is why **USBPorts.kext** contains and defines both **HSxx** and **SS0x** types of ports as being of `UsbConnector` type "3" because this reflects the actual *electrical* connector.

The additional rear USB port is of Type "C" and defined as type "9" `UsbConnector` respectively, in either **HS0x** or **SS0x** types.
