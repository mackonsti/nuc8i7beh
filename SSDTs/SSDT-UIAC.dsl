/*
 * Intel ACPI Name Space Architecture for NUC8i7BEH2 device
 *
 * USB ports customization for USBInjectAll.kext
 * https://github.com/Sniki/OS-X-USB-Inject-All/releases
 *
 * Change the UsbConnector or portType as needed to match actual USB configuration:
 *
 *     UsbConnector = 0 for USB 2.0 connector(s)
 *     UsbConnector = 3 for USB 3.0 connector(s)
 *     UsbConnector = 9 for USB 3.1 connector(s) with Switch
 *     UsbConnector = 255 for Internal header(s)
 *
 * More on ports and types at: https://github.com/corpnewt/USBMap/
 *
 * Intel chipset 0x9ded8086 and 0x15db8086 is supported natively in Mojave 10.14.6:
 * /System/Library/Extensions/IOUSBHostFamily.kext/Contents/PlugIns/AppleUSBXHCIPCI.kext/Contents/Info.plist
 */

DefinitionBlock ("SSDT-UIAC.aml", "SSDT", 2, "Clover", "UIAC", 0x00000000)
{
    Device (UIAC)
    {
        Name (_HID, "UIA00000")

        // Hardware location on NUC chassis
        //
        // HS01 - USB 2.0 is the front RIGHT socket
        // HS02 - USB 2.0 is the front LEFT socket
        // HS03 - USB 2.0 is the rear TOP socket
        // HS04 - USB 2.0 is the rear BOTTOM socket
        // USR1 - Unused
        // USR2 - Unused
        // SS01 - USB 3.0 is the front RIGHT socket
        // SS02 - USB 3.0 is the front LEFT socket
        // SS03 - USB 3.0 is the rear TOP socket
        // SS04 - USB 3.0 is the rear BOTTOM socket

        Name (RMCF, Package (0x04)
        {
            "8086_9ded", Package (0x04)  // Intel Corporation Coffee Lake USB 3.1 xHCI Controller [8086:9ded]
            {
                "port-count", Buffer (0x04) {0x10, Zero, Zero, Zero},  // Last port number used in list
                "ports", Package (0x10)
                {
                    "HS01", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x01, Zero, Zero, Zero},
                    },
                    "HS02", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x02, Zero, Zero, Zero},
                    },
                    "HS03", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x03, Zero, Zero, Zero},
                    },
                    "HS04", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x04, Zero, Zero, Zero},
                    },
//                  "HS05", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x05, Zero, Zero, Zero},
//                  },
//                  "HS06", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x06, Zero, Zero, Zero},
//                  },
//                  "HS07", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x07, Zero, Zero, Zero},
//                  },
//                  "HS08", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x08, Zero, Zero, Zero},
//                  },
//                  "HS09", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x09, Zero, Zero, Zero},
//                  },
//                  "HS10", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x0A, Zero, Zero, Zero},
//                  },
//                  "USR1", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x0B, Zero, Zero, Zero},
//                  },
//                  "USR2", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x0C, Zero, Zero, Zero},
//                  },
                    "SS01", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x0D, Zero, Zero, Zero},
                    },
                    "SS02", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x0E, Zero, Zero, Zero},
                    },
                    "SS03", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x0F, Zero, Zero, Zero},
                    },
                    "SS04", Package (0x04)
                    {
                        "UsbConnector", 0x03,
                        "port", Buffer (0x04) {0x10, Zero, Zero, Zero},
                    },
//                  "SS05", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x11, Zero, Zero, Zero},
//                  },
//                  "SS06", Package (0x04)
//                  {
//                      "UsbConnector", 0x03,
//                      "port", Buffer (0x04) {0x12, Zero, Zero, Zero},
//                  },
                },
            },

            "8086_15db", Package (0x04)  // JHL6340 Thunderbolt 3 USB 3.1 Controller (Alpine Ridge) [8086:15db]
            {
                "port-count", Buffer (0x04) {0x03, Zero, Zero, Zero},  // Last port number used in list
                "ports", Package (0x04)
                {
                    "UC11", Package (0x04)
                    {
                        "UsbConnector", 0x09,
                        "port", Buffer (0x04) {0x01, Zero, Zero, Zero},
                    },
                    "UC21", Package (0x04)
                    {
                        "UsbConnector", 0x09,
                        "port", Buffer (0x04) {0x03,  Zero, Zero, Zero},
                    },
                }
            }
        })
    }
}

