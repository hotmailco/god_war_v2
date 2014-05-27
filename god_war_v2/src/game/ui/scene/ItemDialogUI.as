/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	import game.ui.scene.ItemContainerViewUI;
	public class ItemDialogUI extends Dialog {
		public var btnClose:Button;
		public var list:List;
		public var imgBlank:Image;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="0" y="18" sizeGrid="40,40,40,40" width="586" height="382"/>
			  <Image url="png.base.dialog_title" x="131.5" y="0"/>
			  <Button skin="png.base.btn_close" x="550" y="0" var="btnClose"/>
			  <Label text="背包" x="214" y="10" width="172" height="23" align="center" color="0xff9900" font="Microsoft YaHei" size="16"/>
			  <List x="28" y="87" repeatX="9" repeatY="5" var="list">
			    <ItemContainerView name="render" runtime="game.ui.scene.ItemContainerViewUI"/>
			    <VScrollBar skin="png.base.vscroll" x="517" y="3" width="17" height="281" name="scrollBar"/>
			  </List>
			  <Image url="png.base.blank" x="184" y="4" width="229" height="37" var="imgBlank" name="drag"/>
			</Dialog>;
		public function ItemDialogUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.scene.ItemContainerViewUI"] = ItemContainerViewUI;
			createView(uiXML);
		}
	}
}