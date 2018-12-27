package {

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.utils.setTimeout;

import roipeker.AndroidUtilsAne;
import roipeker.SystemUIFlags;
import roipeker.WindowFlags;

[SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="60")]
public class Main extends Sprite {

    public function Main() {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        stage.displayState = StageDisplayState.NORMAL;

        loaderInfo.addEventListener(Event.COMPLETE, init);
    }

    private var box1:Shape;
    private var box2:Shape;
    private var statusbarLine:Shape;

    private function init(event:Event):void {

        statusbarLine = new Shape();
        addChild(statusbarLine);

        box1 = createDot(0x00ff00);
        box2 = createDot(0x0000ff);

        stage.addEventListener(Event.RESIZE, onStageResize);
        trace("Ane Supported?", AndroidUtilsAne.isSupported);

        AndroidUtilsAne.init();

        trace("System Version (int): " + AndroidUtilsAne.getSystemVersion());

        // in Android 8.x statusbar height > 25dp  means notch.
        trace("Statusbar height px: " + AndroidUtilsAne.getStatusbarHeight());
        trace("Navbar height px: " + AndroidUtilsAne.getNavigationbarHeight());

        AndroidUtilsAne.setTaskbar("My App's name", 0xffff0000, getIcon());
        AndroidUtilsAne.navigationbarDividerColor = 0xff000000; // >= Android.P

        AndroidUtilsAne.navigationbarColor = 0xffff0000;
        AndroidUtilsAne.statusbarColor = 0xffff0000;

        onStageResize(null);

        AndroidUtilsAne.statusbarDarkStyle();
        AndroidUtilsAne.navigationbarDarkStyle();

        // make AIR Activity Window fullscreen with transparent statusbar and navbar.
        setTimeout(makeAirFullscreenWithSystemUI, 3000);
    }

    private function makeAirFullscreenWithSystemUI():void {

        AndroidUtilsAne.statusbarColorTransparent();
        AndroidUtilsAne.navigationbarColorTransparent();

        AndroidUtilsAne.setWindowFlags(
                WindowFlags.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS
        );

        // use bitwise methods for simplicity to toggle flags:
        // systemUISetFlags, systemUIRemoveFlags, systemUIHasFlags
        AndroidUtilsAne.systemUISetFlags(
                SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_STABLE
                | SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                | SystemUIFlags.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
        );

        // "LightStyle" means light background, black ui/text, so is the opposite of what you might expect.
        AndroidUtilsAne.statusbarLightStyle();
        AndroidUtilsAne.navigationbarLightStyle();
    }

    private function onStageResize(event:Event):void {
        trace("Stage resize:", stage.stageWidth, stage.stageHeight);
        box1.x = box1.y = 5;
        box2.x = stage.stageWidth - box2.width - 5;
        box2.y = stage.stageHeight - box2.height - 5;

        // draw line.
        statusbarLine.graphics.clear();
        statusbarLine.graphics.beginFill(0x00ff00);
        statusbarLine.graphics.drawRect(0, 0, stage.stageWidth, 3);
        statusbarLine.graphics.endFill();
        statusbarLine.y = AndroidUtilsAne.getStatusbarHeight();
    }

    private function testBrightness():void {
        var b:Number = AndroidUtilsAne.windowBrightness;
        if (b > 0.5) {
            AndroidUtilsAne.windowBrightness = 0.2;
        } else {
            AndroidUtilsAne.windowBrightness = 1;
        }
    }

    private function getIcon():BitmapData {
        var icon:BitmapData = new BitmapData(32, 32, true, 0x0);
        var sh:Shape = new Shape();
        sh.graphics.clear();
        sh.graphics.beginFill(0x0, 1);
        sh.graphics.drawRoundRect(0, 0, 32, 32, 8);
        sh.graphics.endFill();
        icon.draw(sh);

        sh.graphics.clear();
        sh.graphics.beginFill(0xffffff, 1);
        sh.graphics.drawCircle(32 / 2, 32 / 2, 10);
        sh.graphics.endFill();

        icon.draw(sh);
        return icon;
    }


    private function createDot(color:uint):Shape {
        var shape:Shape = new Shape();
        addChild(shape);
        shape.graphics.beginFill(color);
        shape.graphics.drawCircle(20, 20, 20);
        shape.graphics.endFill();
        return shape;
    }

}
}
