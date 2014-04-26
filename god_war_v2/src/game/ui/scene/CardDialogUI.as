/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class CardDialogUI extends Dialog {
		public var btnClose:Button;
		public var imgBlank:Image;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="164.5" y="105.5" sizeGrid="40,40,40,40" width="871" height="589"/>
			  <Image url="png.base.dialog_title" x="431.5" y="89"/>
			  <Label text="卡牌" x="513" y="99" width="172" height="23" align="center" color="0xff9900" font="Microsoft YaHei" size="16"/>
			  <Button skin="png.base.btn_close" x="996" y="95" var="btnClose"/>
			  <Image url="png.base.blank" x="485" y="92" width="229" height="37" var="imgBlank" name="drag"/>
			</Dialog>;
		public function CardDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}