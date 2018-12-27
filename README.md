# AndroidUtilsAne
Simple Android Utilities ANE for Adobe AIR.
This is my first ANE, so is a work in progress.

- Include the extension in you app descriptor:
<extensions>
  <extensionID>roipeker.AndroidUtilsAne</extensionID>
</extensions>

- Include the AndroidUtilsAne.ane as a library in your sourcepath.

Has a default implementation so it can be compiled in any AIR platform without compilation exceptions.

Make a call to AndroidUtilsAne.init() before any other method call to initialize it.
Most API calls that require colors, expect them in 24bits (ARGB)

ANEs API:

AndroidUtilsAne.init();
AndroidUtilsAne.isSupported ;
AndroidUtilsAne.setTaskbar( "App taskbar name!", 0xffff0000, new BitmapData(32,32,0xff0000, false));

AndroidUtilsAne.setWindowFlags(WindowFlags.FLAG_TRANSLUCENT_STATUS);
AndroidUtilsAne.getWindowFlags();

AndroidUtilsAne.setUIVisibility(
                    SystemUIFlags.SYSTEM_UI_FLAG_LOW_PROFILE|
                    SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_STABLE |
                    SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN |
                    SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
);
AndroidUtilsAne.getUIVisibility();

// for easier SystemUI flag usage, using internal invalidation to avoid making continuous ANE calls.
AndroidUtilsAne.systemUISetFlags();
AndroidUtilsAne.systemUIRemoveFlags();
AndroidUtilsAne.systemUIHasFlags();

AndroidUtilsAne.navigationbarColor = 0x88ffffff;
AndroidUtilsAne.statusbarColor = 0x88ff0000;

// set and get Activity's Window brightness.
AndroidUtilsAne.windowBrightness = 0.2;

// Android Build SDK version (int)
AndroidUtilsAne.getSystemVersion();

// Device ID.
AndroidUtilsAne.deviceUDID

// in px, in Android > 8.x, a statusbar height bigger than 25dp means it's a notched phone.
AndroidUtilsAne.getStatusbarHeight();

// in px, return 0 if the device doesn't have a navbar.
AndroidUtilsAne.getNavigationbarHeight();
