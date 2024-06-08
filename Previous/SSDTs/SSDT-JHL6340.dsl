/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * KEXT REFERENCES:
 * /System/Library/Extensions/AppleThunderboltNHI.kext/Contents/Info.plist
 * /System/Library/Extensions/IOUSBHostFamily.kext/Contents/PlugIns/AppleUSBXHCIPCI.kext/Contents/Info.plist
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

DefinitionBlock ("SSDT-JHL6340.aml", "SSDT", 2, "Clover", "TBOLT", 0x00000000)
{
    External (_SB_.PCI0.RP05, DeviceObj)
    External (_SB_.PCI0.RP05.PXSX, DeviceObj)

    Scope (\_SB.PCI0.RP05)
    {
        Scope (PXSX)
        {
            Name (_STA, Zero)  // _STA: Status
        }

        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (Zero)
        }

        Device (UPSB)  // Intel JHL6340 Thunderbolt 3 Bridge (Alpine Ridge 2C 2016) [8086:15da]
        {
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
            Field (A1E0, ByteAcc, NoLock, Preserve)
            {
                AVND,   32,
                BMIE,   3,
                Offset (0x18),
                PRIB,   8,
                SECB,   8,
                SUBB,   8,
                Offset (0x1E),
                    ,   13,
                MABT,   1
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (SECB)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
            {
                Return (Zero)
            }

//          Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
//          {
//              Return (Package (0x02) {0x69, 0x03})
//          }

            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One) {0x03})
                }

                Return (Package (0x06)
                {
                    "AAPL,slot-name",  Buffer (0x09) {"Built In"},
                //  "built-in",        Buffer (0x01) {0x00},
                    "model",           Buffer (0x23) {"Intel JHL6340 Thunderbolt 3 Bridge"},
                //  "name",            Buffer (0x0B) {"pci-bridge"},
                    "PCI-Thunderbolt", 0x01
                })
            }

            Device (DSB0)  // Intel JHL6340 Thunderbolt 3 Bridge (Alpine Ridge 2C 2016) [8086:15da]
            {
                Name (_ADR, 0x00000000)  // _ADR: Address
                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32,
                    BMIE,   3,
                    Offset (0x18),
                    PRIB,   8,
                    SECB,   8,
                    SUBB,   8,
                    Offset (0x1E),
                        ,   13,
                    MABT,   1
                }

                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                {
                    Return (SECB)
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

//              Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
//              {
//                  Return (Package (0x02) {0x69, 0x03})
//              }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One) {0x03})
                    }

                    Return (Package (0x02)
                    {
                    //  "built-in",          Buffer (0x01) {0x00},
                    //  "model",             Buffer (0x23) {"Intel JHL6340 Thunderbolt 3 Bridge"},
                    //  "name",              Buffer (0x0B) {"pci-bridge"},
                    //  "IOPCIHPType",       0x01,
                        "PCIHotplugCapable", 0x00
                    })
                }

                Device (NHI0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (_STR, Unicode ("Thunderbolt"))  // _STR: Description String

                    ///////////////////////////////////////////////////////////////////////////
                    // This is just a placeholder device as it does not appear in IORegistry //
                    // since this NUC device is not supported nor recognised by macOS at all //
                    ///////////////////////////////////////////////////////////////////////////

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (DSB1)  // Intel JHL6340 Thunderbolt 3 Bridge (Alpine Ridge 2C 2016) [8086:15da]
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32,
                    BMIE,   3,
                    Offset (0x18),
                    PRIB,   8,
                    SECB,   8,
                    SUBB,   8,
                    Offset (0x1E),
                        ,   13,
                    MABT,   1
                }

                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                {
                    Return (SECB)
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

//              Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
//              {
//                  Return (Package (0x02) {0x69, 0x03})
//              }

                Device (UPS0)
                {
                    Name (_ADR, Zero)  // _ADR: Address

                    ///////////////////////////////////////////////////////////////////////////
                    // This is just a placeholder device as it does not appear in IORegistry //
                    // since this NUC device is not supported nor recognised by macOS at all //
                    ///////////////////////////////////////////////////////////////////////////

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }

                    Device (DSB0)
                    {
                        Name (_ADR, 0x00000000)  // _ADR: Address
                    }

                    Device (DSB3)
                    {
                        Name (_ADR, 0x00030000)  // _ADR: Address
                    }

                    Device (DSB4)
                    {
                        Name (_ADR, 0x00040000)  // _ADR: Address
                    }

                    Device (DSB5)
                    {
                        Name (_ADR, 0x00050000)  // _ADR: Address
                    }

                    Device (DSB6)
                    {
                        Name (_ADR, 0x00060000)  // _ADR: Address
                    }
                }
            }

            Device (DSB2)  // Intel JHL6340 Thunderbolt 3 Bridge (Alpine Ridge 2C 2016) [8086:15da]
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32,
                    BMIE,   3,
                    Offset (0x18),
                    PRIB,   8,
                    SECB,   8,
                    SUBB,   8,
                    Offset (0x1E),
                        ,   13,
                    MABT,   1
                }

                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                {
                    Return (SECB)
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

//              Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
//              {
//                  Return (Package (0x02) {0x69, 0x03})
//              }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One) {0x03})
                    }

                    Return (Package (0x04)
                    {
                        "AAPL,slot-name",    Buffer (0x09) {"Built In"},
                    //  "built-in",          Buffer (0x01) {0x00},
                    //  "model",             Buffer (0x23) {"Intel JHL6340 Thunderbolt 3 Bridge"},
                    //  "name",              Buffer (0x0B) {"pci-bridge"},
                    //  "IOPCIHPType",       0x02,
                        "PCIHotplugCapable", 0x00
                    })
                }

                Device (XHC2)  // Intel JHL6340 Thunderbolt 3 USB 3.1 Controller (Alpine Ridge 2C 2016) [8086:15db]
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One) {0x03})
                        }

                        Return (Package (0x0A)
                        {
                            "AAPL,slot-name",          Buffer (0x09) {"Built In"},
                            "AAPL,xhci-clock-id",      0x01,
                            "device_type",             Buffer (0x1B) {"Thunderbolt USB Controller"},
                        //  "IOPCIExpressCapabilites", 0x02,
                        //  "IOPCIHPType",             0x02,
                            "model",                   Buffer (0x2B) {"Intel JHL6340 Thunderbolt 3 USB Controller"},
                            "USBBusNumber",            0x00
                        })
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        Return (Package (0x02) {0x69, 0x03})
                    }

                    Device (RHUB)
                    {
                        Name (_ADR, Zero)  // _ADR: Address

                        // According to the ACPI specification, we can define the USB port capabilities (_UPC)
                        // and physical location description (_PLD) objects. The use of both objects more precisely
                        // indicates the user's ability to connect devices to the port. Using only the _UPC object
                        // might not set the device container grouping correctly or as expected. Examples:
                        //
                        // Name(_UPC, Package (0x04) {
                        //     0xFF,   // Port is connectable
                        //     0x09,   // Connector type: Type C connector - USB2 and SS with Switch
                        //     Zero,   // Reserved 0, must be zero
                        //     Zero})  // Reserved 1, must be zero

                        Device (HS01)
                        {
                            Name (_ADR, 0x01)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 0x09, Zero, Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x1,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "UNKNOWN",
                                    PLD_VerticalPosition   = "UPPER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "UNKNOWN",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x0,
                                    PLD_GroupPosition      = 0x0,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x0,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0x0,
                                    PLD_HorizontalOffset   = 0x0)
                            })
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg2 == Zero))
                                {
                                    Return (Buffer (One) {0x03})
                                }

                                Return (Package (0x04)
                                {
                                    "UsbCPortNumber", 0x02,
                                    "UsbPowerSource", 0x02
                                })
                            }
                        }

                        Device (HS02)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero, 0x09, Zero, Zero
                            })
                        }

                        Device (SS01)
                        {
                            Name (_ADR, 0x03)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                0xFF, 0x09, Zero, Zero
                            })
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x1,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x1,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x0,
                                    PLD_Panel              = "UNKNOWN",
                                    PLD_VerticalPosition   = "UPPER",
                                    PLD_HorizontalPosition = "LEFT",
                                    PLD_Shape              = "UNKNOWN",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x0,
                                    PLD_GroupPosition      = 0x0,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x0,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0x0,
                                    PLD_HorizontalOffset   = 0x0)
                            })
                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg2 == Zero))
                                {
                                    Return (Buffer (One) {0x03})
                                }

                                Return (Package (0x04)
                                {
                                    "UsbCPortNumber", 0x01,
                                    "UsbPowerSource", 0x02
                                })
                            }
                        }

                        Device (SS02)
                        {
                            Name (_ADR, 0x04)  // _ADR: Address
                            Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                            {
                                Zero, 0x09, Zero, Zero
                            })
                        }
                    }
                }
            }
        }
    }
}

