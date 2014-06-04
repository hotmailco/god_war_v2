/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class InstanceItemViewUI extends View {
		public var imgBg:Image;
		public var imgBg1:Image;
		public var imgBg2:Image;
		public var lblName:Label;
		protected var uiXML:XML =
			<View>
			  <Image x="24" y="24" width="66" height="66" var="imgBg"/>
			  <Image url="png.scene_instance.Elite_Frame_nor" x="0" y="0" var="imgBg1"/>
			  <Image url="png.scene_instance.Elite_Frame_on" x="0" y="0" var="imgBg2"/>
			  <Label x="4.5" y="95" width="105" height="19" align="center" color="0xffcc00" var="lblName"/>
			</View>;
		public function InstanceItemViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}