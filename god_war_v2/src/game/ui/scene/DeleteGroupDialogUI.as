/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class DeleteGroupDialogUI extends Dialog {
		public var imgBlank:Image;
		public var lblContent:Label;
		public var btnConfirm:Button;
		public var btnClose:Button;
		public var btnCancel:Button;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="403" y="286.5" sizeGrid="40,40,40,40" width="394" height="227"/>
			  <Image url="png.base.dialog_title" x="431.5" y="268"/>
			  <Label text="删除卡组" x="526" y="278" color="0xff9900" size="16" font="Microsoft YaHei" width="147" height="26" align="center"/>
			  <Image url="png.base.blank" x="484" y="272" width="229" height="37" var="imgBlank" name="drag"/>
			  <Label text="确定要删除这个卡组吗？" x="456" y="358" color="0xc9933e" font="Microsoft YaHei" size="14" width="300" height="61" var="lblContent" isHtml="true"/>
			  <Button label="确定" skin="png.base.button" x="452" y="439" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnConfirm"/>
			  <Button skin="png.base.btn_close" x="762" y="275" var="btnClose"/>
			  <Button label="取消" skin="png.base.button" x="611" y="439" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" var="btnCancel"/>
			</Dialog>;
		public function DeleteGroupDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}