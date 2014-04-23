/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class ServerListViewUI extends View {
		public var imgHot:Image;
		public var imgStatusNormal:Image;
		public var imgStatusHot:Image;
		public var imgStatusBusy:Image;
		public var lblName:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.login.login_Serverlist_BG" x="22" y="34"/>
			  <Image url="png.login.login_hot" x="0" y="0" var="imgHot"/>
			  <Image url="png.login.login_ServerStatusNOR" x="304" y="33" var="imgStatusNormal"/>
			  <Image url="png.login.login_ServerStatusHOT" x="304" y="33" var="imgStatusHot"/>
			  <Image url="png.login.login_ServerStatusBUSY" x="304" y="33" var="imgStatusBusy"/>
			  <Label x="62" y="52" color="0xe6dcac" width="225" height="27" size="16" autoSize="left" align="left" font="Microsoft YaHei" var="lblName"/>
			</View>;
		public function ServerListViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}