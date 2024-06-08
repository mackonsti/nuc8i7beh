/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Original device (SAT0) renamed to (SATA) via Clover DSDT patching.
 * Added compatibility ID to (SATA) for improved vanilla detection.
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/AppleAHCIPort.kext/Contents/Info.plist
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

DefinitionBlock ("SSDT-SATA.aml", "SSDT", 2, "Clover", "SATA", 0x00000000)
{
    External (_SB_.PCI0.SATA, DeviceObj)  // Device must be renamed in Clover!

    Scope (\_SB.PCI0.SATA)
    {
        Method (_DSM, 4, NotSerialized)  // Intel Corporation Coffee Lake SATA Controller [AHCI mode] [8086:9dd3]
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One) {0x03})
            }

            Return (Package (0x04)  // Intel Corporation Sunrise Point-LP SATA Controller [AHCI mode] [8086:9d03]
            {
            //  "device-id",   Buffer (0x04) {0x03, 0x9D, 0x00, 0x00},
                "compatible",  Buffer (0x0D) {"pci8086,9d03"},
            //  "IOName",      Buffer (0x0D) {"pci8086,9d03"},
            //  "name",        Buffer (0x0D) {"pci8086,9d03"},
            //  "device_type", Buffer (0x10) {"SATA controller"},
                "model",       Buffer (0x2D) {"Intel Corporation 100 Series SATA Controller"}
            })
        }
    }
}

