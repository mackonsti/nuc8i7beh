/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Original device (PXSX) renamed to (SSD0) via Clover DSDT patching.
 * Added compatibility ID to (SSD0) for improved vanilla detection.
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/IONVMeFamily.kext/Contents/Info.plist
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

DefinitionBlock ("SSDT-NVMe.aml", "SSDT", 2, "Clover", "NVME", 0x00000000)
{
    External (_SB_.PCI0.RP09.SSD0, DeviceObj)  // Device must be renamed in Clover!

    Scope (\_SB.PCI0.RP09.SSD0)
    {
        Method (_DSM, 4, NotSerialized)  // Samsung Electronics Co. Ltd. NVMe SSD Controller SM981/PM981 [144d:a808]
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One) {0x03})
            }

            Return (Package (0x04)  // Samsung Electronics Co. Ltd. NVMe SSD Controller SM961/PM961 [144d:a804]
            {
            //  "device-id",   Buffer (0x04) {0x04, 0xA8, 0x00, 0x00},
                "compatible",  Buffer (0x0D) {"pci144d,a804"},
            //  "IOName",      Buffer (0x0D) {"pci144d,a804"},
            //  "name",        Buffer (0x0D) {"pci144d,a804"},
            //  "device_type", Buffer (0x1F) {"Non-Volatile memory controller"},
                "model",       Buffer (0x28) {"Samsung Electronics NVMe Storage Controller"}
            })
        }
    }
}

