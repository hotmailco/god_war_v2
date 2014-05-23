/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class CharacterDialogUI extends Dialog {
		public var imgBlank:Image;
		public var btnClose:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="0" y="16" sizeGrid="40,40,40,40" width="389" height="465"/>
			  <Image url="png.scene_character.back" x="16" y="36"/>
			  <Image url="png.base.dialog_title" x="26" y="0"/>
			  <Label text="人物" x="118" y="10" font="Microsoft YaHei" size="16" color="0xff9900" align="center" width="153" height="26"/>
			  <Image url="png.scene_character.back1" x="75" y="58"/>
			  <Image url="png.base.blank" x="81" y="6" width="229" height="37" var="imgBlank" name="drag"/>
			  <Button skin="png.base.btn_close" x="356" y="5" var="btnClose"/>
			</Dialog>;
		public function CharacterDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}