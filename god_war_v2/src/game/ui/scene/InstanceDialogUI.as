/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class InstanceDialogUI extends Dialog {
		public var imgBack:Image;
		public var btnClose:Button;
		public var btnNext:Button;
		public var btnPrev:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.scene_instance.chengq4" x="15" y="15" var="imgBack"/>
			  <Image url="png.base.dialog1_bg" x="0" y="0" sizeGrid="40,40,40,40" width="830" height="390"/>
			  <Button skin="png.base.btn_close" x="780" y="0" var="btnClose"/>
			  <Button skin="png.scene_instance.btn_arrow_down" x="389.5" y="329" var="btnNext"/>
			  <Button skin="png.scene_instance.btn_arrow_up" x="389.5" y="22" var="btnPrev"/>
			</Dialog>;
		public function InstanceDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}