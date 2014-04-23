/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class RegisterViewUI extends View {
		public var btnStart:View;
		public var iptPassword:TextInput;
		public var btnRegister:Button;
		public var btnBack:Button;
		public var iptName:TextInput;
		protected var uiXML:XML =
			<View var="btnStart">
			  <Image url="png.login.login_panel_bg" x="375.5" y="245.5"/>
			  <TextInput skin="png.base.textinput" x="499" y="374" width="270" height="46" margin="20,10,10,10" size="16" asPassword="true" var="iptPassword"/>
			  <Button label="注册" skin="png.base.button" x="626" y="454" labelFont="Microsoft YaHei" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" var="btnRegister"/>
			  <Button label="返回" skin="png.base.button" x="432" y="454" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnBack"/>
			  <Label text="用户名" x="431" y="320" color="0xffffff" font="Microsoft YaHei" size="16"/>
			  <TextInput skin="png.base.textinput" x="499" y="311" width="270" height="46" font="Microsoft YaHei" size="16" margin="20,10,10,10" var="iptName"/>
			  <Label text="密码" x="447" y="383" color="0xffffff" font="Microsoft YaHei" size="16"/>
			</View>;
		public function RegisterViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}