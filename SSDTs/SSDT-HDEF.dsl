/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Original device (HDAS) renamed (HDEF) via Clover DSDT patching.
 * Introduced minor code fixes to (HDEF) for improved device detection.
 *
 * KEXT REFERENCES:
 * No macOS kext reference found.
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

DefinitionBlock ("SSDT-HDEF.aml", "SSDT", 2, "Clover", "HDEF", 0x00000000)
{
    External (_SB_.PCI0.HDEF, DeviceObj)  // Device must be renamed in Clover!

    Scope (\_SB.PCI0.HDEF)
    {
        Method (_DSM, 4, NotSerialized)  // Intel Corporation Coffee Lake High Definition Audio Controller [8086:9dc8]
        {
            If (LEqual (Arg2, Zero))
            {
                Return (Buffer (One) {0x03})
            }

            Return (Package (0x08)  // Do not inject 'hda-gfx' at all because IGPU/HDAU are already present in the system!
            {
            // https://github.com/acidanthera/AppleALC/wiki/Supported-codecs
            //
            // 0x1C = Internal Speakers, Line In, Microphone (ID 28)
            //
            //  "device_type",       Buffer (0x06) {"audio"},
            //  "hda-gfx",           Buffer (0x0A) {"onboard-1"},
                "alc-layout-id",     Buffer (0x04) {0x1C, 0x00, 0x00, 0x00},
                "layout-id",         Buffer (0x04) {0x1C, 0x00, 0x00, 0x00},
                "model",             Buffer (0x23) {"Realtek ALC235 HD Audio Controller"},
             // "name",              Buffer (0x0D) {"Audio device"},
                "PinConfigurations", Buffer (0x01) {Zero}
            })
        }
    }
}

