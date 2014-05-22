/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class AddGroupDialogUI extends Dialog {
		public var imgBlank:Image;
		public var iptName:TextInput;
		public var btnConfirm:Button;
		public var btnClose:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="403" y="286.5" sizeGrid="40,40,40,40" width="394" height="227"/>
			  <Image url="png.base.dialog_title" x="431.5" y="268"/>
			  <Label text="添加卡组" x="526" y="278" color="0xff9900" size="16" font="Microsoft YaHei" width="147" height="26" align="center"/>
			  <Image url="png.base.blank" x="483" y="272" width="229" height="37" var="imgBlank" name="drag"/>
			  <Label text="名称" x="463" y="367" color="0xc9933e" font="Microsoft YaHei" size="14"/>
			  <TextInput skin="png.base.textinput" x="517" y="358" width="219" height="40" font="Microsoft YaHei" margin="15,6,15,10" size="14" var="iptName"/>
			  <Button label="确定" skin="png.base.button" x="530" y="436" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnConfirm"/>
			  <Button skin="png.base.btn_close" x="762" y="275" var="btnClose"/>
			</Dialog>;
		public function AddGroupDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}