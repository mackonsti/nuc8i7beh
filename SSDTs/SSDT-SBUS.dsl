/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * NOTES:
 * Added new (SBUS) sub-system (BUS0) and (BUS1) devices for improved platform compatibility.
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/AppleSMBusPCI.kext/Contents/Info.plist
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

DefinitionBlock ("SSDT-SBUS.aml", "SSDT", 2, "Clover", "SMBUS", 0x00000000)
{
    External (_SB_.PCI0.SBUS, DeviceObj)

    Scope (\_SB.PCI0.SBUS)  // Intel Corporation Coffee Lake SMBus Controller [8086:9da3]
    {
        Device (BUS0)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_CID, "smbus")  // _CID: Compatible ID
        }

        Device (BUS1)
        {
            Name (_ADR, One)  // _ADR: Address
            Name (_CID, "smbus")  // _CID: Compatible ID
        }
    }
}

