/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class StartViewUI extends View {
		public var btnStart:Button;
		public var btnRegister:Button;
		public var btnLogin:Button;
		protected var uiXML:XML =
			<View>
			  <Button label="开始游戏" skin="png.login.btn_start" x="475" y="361.5" var="btnStart" labelFont="Microsoft YaHei" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelSize="20"/>
			  <Button label="注册" skin="png.base.button" x="1022" y="675" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnRegister"/>
			  <Button label="登录" skin="png.base.button" x="1022" y="725" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnLogin"/>
			</View>;
		public function StartViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}