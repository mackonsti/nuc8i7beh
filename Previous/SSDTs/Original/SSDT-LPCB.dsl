/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Added compatibility ID to (LPCB) for improved vanilla detection.
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/AppleLPC.kext/Contents/Info.plist
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

DefinitionBlock ("SSDT-LPCB.aml", "SSDT", 2, "Clover", "LPCB", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)

    Scope (\_SB.PCI0.LPCB)
    {
        Method (_DSM, 4, NotSerialized)  // Intel Corporation Coffee Lake LPC Controller [8086:9d84]
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One) {0x03})
            }

            Return (Package (0x04)  // Intel Corporation Sunrise Point LPC/eSPI Controller [8086:9d4e]
            {
            //  "device-id",   Buffer (0x04) {0x4E, 0x9D, 0x00, 0x00},
                "compatible",  Buffer (0x0D) {"pci8086,9d4e"},
            //  "IOName",      Buffer (0x0D) {"pci8086,9d4e"},
            //  "name",        Buffer (0x0D) {"pci8086,9d4e"},
            //  "device_type", Buffer (0x0B) {"ISA bridge"},
                "model",       Buffer (0x2A) {"Intel Corporation 100 Series LPC Controller"}
            })
        }
    }
}

