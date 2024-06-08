# Original SSDTs Used

All the files found here are SSDTs previously used for this hardware. They were mainly used with older versions of Clover and macOS, too. They are kept for reference purposes.

Most of the SSDTs here simply injected a *Method* after enabling the respective *patch* in Clover:

	<dict>
		<key>Comment</key>
		<string>Rename _DSM to XDSM</string>
		<key>Disabled</key>
		<false/>
		<key>Find</key>
		<data>
		X0RTTQ==
		</data>
		<key>Replace</key>
		<data>
		WERTTQ==
		</data>
	</dict>

By renaming the native `_DSM` to `XDSM` this allowed for custom `Method (_DSM)` to be injected via these SSDTs for device properties, mostly prior to macOS Mojave.

* SSDT-HDEF: Injected Method for device (HDEF) properties and Layout ID;
* SSDT-LPCB: Injected Method for device (LPCB) for improved compatibility;
* SSDT-NVMe: Injected Method for device (SSD0) for improved compatibility;
* SSDT-SATA: Injected Method for device (SATA) for improved compatibility;
* SSDT-SBUS: Added devices (BUS0) and (BUS1) improving MacMini8,1 compatibility.

Additionally:

* SSDT-AWAC: A cleaner, clever way to bypass the recent BIOS problem with device (RTC) by disabling (AWAC) clock;
* SSDT-EC: Prepared for OpenCore migration and macOS Catalina, injecting simple device (EC) while disabling (H_EC);
* SDST-OTHER: Assigned names to devices that appear otherwise nameless in IORegistryExplorer (like XSPI);
* SSDT-PMCR: Added native device (PMCR) while assigning (THMR) that appeared nameless in IORegistryExplorer;
* SSDT-UIAC: Motherboard USB ports definition for using with *USBInjectAll.kext* thus solving USB problems;
* SSDT-XOSI: Routing of official _OSI calls in DSDT to XOSI via Clover patch, allowing for OS simulation.
