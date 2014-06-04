/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class InstanceDialogUI extends Dialog {
		public var imgBack:Image;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="jpg.scene_instance.chengq4" x="15" y="15" var="imgBack"/>
			  <Image url="png.base.dialog1_bg" x="0" y="0" sizeGrid="40,40,40,40" width="830" height="390"/>
			  <Button skin="png.base.btn_close" x="780" y="0"/>
			</Dialog>;
		public function InstanceDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}