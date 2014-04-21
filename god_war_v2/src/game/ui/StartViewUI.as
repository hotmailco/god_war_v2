/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class StartViewUI extends View {
		public var imgBack:Image;
		public var btnStart:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.ui.bg" x="0" y="0" var="imgBack"/>
			  <Button label="开始游戏" skin="png.ui.btn_start" x="475" y="362" var="btnStart" labelFont="Microsoft YaHei" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelSize="20"/>
			</View>;
		public function StartViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}