/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Assigned working ACPI device name (THRM) to undefined PCI device in IODeviceTree list.
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/AppleIntelPCHPMC.kext/Contents/Info.plist
 *
 * DefinitionBlock (AMLFileName, TableSignature, ComplianceRevision, OEMID, TableID, OEMRevision)
 *
 *    AMLFileName = Name of the AML file (string); can be a null string too;
 *    TableSignature = Signature of the AML file (DSDT or SSDT) (4-character string);
 *    ComplianceRevision = 1 or less for 32-bit arithmetic; 2 or greater for 64-bit arithmetic (8-bit unsigned integer);
 *    OEMID = ID of the Original Equipment Manufacturer of this ACPI table (6-character string);
 *    TableID = A specific identifier for the table (8-character string);
 *    OEMRevision = A revision number set by the OEM (32-bit number).
 */

DefinitionBlock ("SSDT-PMCR.aml", "SSDT", 2, "Clover", "PMCR", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)

    // According to the original Apple kext and supported devices in AppleIntelPCHPMC keys,
    // compatibility of this controller can be set as "pci8086,9d21" within Clover device properties injection.
    //
    // Intel NUC8i7BEH2 firmware allows injecting this Device (THRM) resulting to immediate vanilla detection.
    // Additionally, injecting vanilla Device (PMCR) allows to activate the native AppleACPIPMC service.

    Scope (\_SB.PCI0)
    {
        Device (THRM)  // Intel Corporation Coffee Lake Thermal Controller [8086:9df9]
        {
            Name (_ADR, 0x00120000)  // _ADR: Address
        }

        Device (PMCR)
        {
            Name (_HID, EisaId ("APP9876"))  // _HID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
            {
                Memory32Fixed (ReadWrite,
                    0xFE000000,         // Address Base
                    0x00010000,         // Address Length
                    )
            })

            // Original _STA value for Device (PMCR) found in MacMini8,1 DSDT was 0x0B which
            // is 1011 in binary. Reading from right to left, it represents the following:
            //
            // 1 - Bit [0] – Set if the device is present
            // 1 - Bit [1] – Set if the device is enabled and decoding its resources
            // 0 - Bit [2] – Set if the device should be shown in the UI
            // 1 - Bit [3] – Set if the device is functioning properly (cleared if device failed its diagnostics)
            //
            // Converter: https://www.rapidtables.com/convert/number/hex-to-binary.html
            // Source: https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
}

