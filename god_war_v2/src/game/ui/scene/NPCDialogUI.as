/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class NPCDialogUI extends Dialog {
		public var btnClose:Button;
		public var lblName:Label;
		public var lblContent:Label;
		public var imgBlank:Image;
		public var lstAnswer:List;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="15" y="48.5" sizeGrid="40,40,40,40" width="570" height="303"/>
			  <Button skin="png.base.btn_close" x="550" y="35" var="btnClose"/>
			  <Label text="&lt;风暴战将>加斯特" x="46" y="78" width="502" height="25" color="0xffcc00" bold="true" align="left" autoSize="left" size="14" font="Microsoft YaHei" var="lblName"/>
			  <Panel x="49" y="113" width="504" height="130" vScrollBarSkin="png.base.vscroll">
			    <Label color="0xffffff" width="505" height="123" wordWrap="true" multiline="true" isHtml="true" font="Microsoft YaHei" align="left" x="0" y="0" var="lblContent"/>
			  </Panel>
			  <Image url="png.base.blank" x="41" y="251" width="521" height="75"/>
			  <Image url="png.base.blank" x="38" y="74" width="515" height="36" name="drag" var="imgBlank"/>
			  <List x="56" y="256" repeatY="3" var="lstAnswer">
			    <Box name="render">
			      <Clip url="png.base.clip_listitem" width="489" height="22" clipY="2" name="selectBox"/>
			      <Label text="label" x="4" y="2" color="0xff9900" width="481" height="18"/>
			    </Box>
			    <VScrollBar skin="png.base.vscroll" x="487" width="17" height="64"/>
			  </List>
			</Dialog>;
		public function NPCDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}