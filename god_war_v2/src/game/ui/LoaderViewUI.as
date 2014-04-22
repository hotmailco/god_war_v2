/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class LoaderViewUI extends View {
		public var progress:ProgressBar;
		public var lblPercent:Label;
		public var lblMessage:Label;
		protected var uiXML:XML =
			<View>
			  <ProgressBar skin="png.loader.progress" x="470" y="392" width="260" height="16" sizeGrid="6,3,6,3" var="progress"/>
			  <Label text="0%" x="555" y="417" autoSize="none" color="0xffffff" align="center" font="Microsoft YaHei" size="12" stroke="0xff6600" width="89" height="21" var="lblPercent"/>
			  <Label text="label" x="476" y="358" width="247" height="18" align="center" color="0xffffff" var="lblMessage"/>
			</View>;
		public function LoaderViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}