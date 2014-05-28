/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	import game.ui.scene.ItemContainerViewUI;
	public class ItemDialogUI extends Dialog {
		public var btnClose:Button;
		public var list:List;
		public var imgBlank:Image;
		public var lblSpecialGold:Label;
		public var lblGold1:Label;
		public var lblGold2:Label;
		public var lblGold3:Label;
		public var btnFinish:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="0" y="17" sizeGrid="40,40,40,40" width="586" height="463"/>
			  <Image url="png.base.dialog_title" x="131.5" y="0"/>
			  <Button skin="png.base.btn_close" x="550" y="0" var="btnClose"/>
			  <Image url="png.scene_item.funds_back" x="32" y="379"/>
			  <Label text="背包" x="214" y="10" width="172" height="23" align="center" color="0xff9900" font="Microsoft YaHei" size="16"/>
			  <List x="28" y="86" repeatX="9" repeatY="5" var="list">
			    <ItemContainerView name="render" runtime="game.ui.scene.ItemContainerViewUI"/>
			    <VScrollBar skin="png.base.vscroll" x="517" y="3" width="17" height="281" name="scrollBar"/>
			  </List>
			  <Image url="png.base.blank" x="184" y="4" width="229" height="37" var="imgBlank" name="drag"/>
			  <Label text="0" x="64" y="381" color="0xffff00" width="129" height="19" var="lblSpecialGold"/>
			  <Label text="0" x="330" y="381" color="0xffff00" width="90" height="19" align="right" var="lblGold1"/>
			  <Label text="0" x="444" y="381" color="0xffff00" width="30" height="19" align="right" var="lblGold2"/>
			  <Label text="0" x="498" y="381" color="0xffff00" width="30" height="19" align="right" var="lblGold3"/>
			  <Button label="整理" skin="png.scene_item.btn_small" x="34" y="419" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnFinish"/>
			  <Button label="仓库" skin="png.scene_item.btn_small" x="105" y="419" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA"/>
			</Dialog>;
		public function ItemDialogUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.scene.ItemContainerViewUI"] = ItemContainerViewUI;
			createView(uiXML);
		}
	}
}