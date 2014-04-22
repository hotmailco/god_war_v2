/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class StartBackgroundViewUI extends View {
		public var imgBack:Image;
		protected var uiXML:XML =
			<View>
			  <Image url="png.login.bg" x="0" y="0" var="imgBack"/>
			</View>;
		public function StartBackgroundViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}