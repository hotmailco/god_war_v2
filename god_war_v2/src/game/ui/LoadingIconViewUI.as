/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class LoadingIconViewUI extends View {
		protected var uiXML:XML =
			<View>
			  <FrameClip skin="assets.ui.LoadingIconSkin" x="433.5" y="350.1" autoPlay="true"/>
			</View>;
		public function LoadingIconViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}