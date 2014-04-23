/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class CreateRoleViewUI extends View {
		public var btnRandName:Button;
		public var iptName:TextInput;
		protected var uiXML:XML =
			<View>
			  <Image url="png.login.role_selected_forward" x="0" y="672"/>
			  <Image url="png.login.login_nameinput_BG" x="446" y="581"/>
			  <Button skin="png.login.btn_random_name" x="686" y="581" var="btnRandName"/>
			  <TextInput x="470" y="600" size="16" width="204" height="28" align="left" font="Microsoft YaHei" var="iptName"/>
			</View>;
		public function CreateRoleViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}