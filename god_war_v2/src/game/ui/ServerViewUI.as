/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class ServerViewUI extends View {
		public var btnBack:Button;
		public var container:Panel;
		protected var uiXML:XML =
			<View>
			  <Image url="png.login.login_BG2" x="192.5" y="210.5"/>
			  <Button label="返回" skin="png.login.btn_back" x="26" y="721" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" labelSize="14" labelMargin="20,0,0,3" var="btnBack"/>
			  <Button skin="png.login.btn_arrow_up" x="574.5" y="203"/>
			  <Button skin="png.login.btn_arrow_down" x="574.5" y="559"/>
			  <Panel x="250" y="247.5" width="700" height="305" var="container"/>
			</View>;
		public function ServerViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}