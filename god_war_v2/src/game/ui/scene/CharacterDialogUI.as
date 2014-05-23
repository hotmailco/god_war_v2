/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class CharacterDialogUI extends Dialog {
		public var imgBlank:Image;
		public var btnClose:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="405.5" y="167.5" sizeGrid="40,40,40,40" width="389" height="465"/>
			  <Image url="png.character.back" x="421" y="187.5"/>
			  <Image url="png.base.dialog_title" x="431.5" y="151"/>
			  <Label text="人物" x="523" y="161" font="Microsoft YaHei" size="16" color="0xff9900" align="center" width="153" height="26"/>
			  <Image url="png.character.back1" x="480" y="209"/>
			  <Image url="png.base.blank" x="486" y="157" width="229" height="37" var="imgBlank" name="drag"/>
			  <Button skin="png.base.btn_close" x="761" y="156" var="btnClose"/>
			</Dialog>;
		public function CharacterDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}