/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class CardDialogUI extends Dialog {
		public var btnClose:Button;
		public var imgBlank:Image;
		public var btnAdd:Button;
		public var btnDelete:Button;
		public var lstGroup:List;
		public var lstChosen:List;
		public var lblEnergyUse:Label;
		public var lblEnergyTotal:Label;
		public var lstStandby:List;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.base.dialog_bg" x="164.5" y="105.5" sizeGrid="40,40,40,40" width="871" height="589"/>
			  <Image url="png.scene_card.seperator" x="466" y="145"/>
			  <Image url="png.base.dialog_title" x="431.5" y="89"/>
			  <Label text="卡牌" x="513" y="99" width="172" height="23" align="center" color="0xff9900" font="Microsoft YaHei" size="16"/>
			  <Button skin="png.base.btn_close" x="996" y="95" var="btnClose"/>
			  <Image url="png.base.blank" x="485" y="92" width="229" height="37" var="imgBlank" name="drag"/>
			  <Label text="卡组列表" x="200" y="143" color="0xc9933e" font="Microsoft YaHei" size="14" bold="true"/>
			  <Button skin="png.scene_card.btn_add" x="415" y="148" var="btnAdd"/>
			  <Button skin="png.scene_card.btn_delete" x="437" y="152" var="btnDelete"/>
			  <List x="194" y="170" repeatY="19" var="lstGroup">
			    <Box name="render">
			      <Clip url="png.scene_card.clip_listitem" clipY="2" name="selectBox" x="0" y="0" width="262" height="26"/>
			      <Label text="label" x="5" y="4" color="0xc9933e" size="12" font="Microsoft YaHei" width="236" height="18" name="label"/>
			    </Box>
			    <VScrollBar skin="png.base.vscroll" x="245" y="0" width="17" height="493" name="scrollBar"/>
			  </List>
			  <Image url="png.scene_card.img_container_left" x="488" y="195"/>
			  <Image url="png.scene_card.title_bg" x="519" y="124"/>
			  <Label text="已选卡牌" x="576" y="153" color="0xc9933e" width="71" height="18" align="center" font="Microsoft YaHei" size="12"/>
			  <List x="488" y="202" repeatY="17" height="433" var="lstChosen">
			    <Box name="render">
			      <Clip url="png.scene_card.clip_listitem" width="250" clipY="2" name="selectBox"/>
			      <Label text="label" x="7" y="4" width="239" height="18" name="label" color="0xc9933e"/>
			    </Box>
			    <VScrollBar skin="png.base.vscroll" x="233" y="0" height="433" name="scrollBar"/>
			  </List>
			  <Label text="80" x="562" y="642" width="35" height="18" var="lblEnergyUse" color="0xff9900" align="right"/>
			  <Label text="/" x="596" y="642" width="10" height="18" color="0xff9900" align="right"/>
			  <Label text="100" x="607" y="642" width="35" height="18" var="lblEnergyTotal" color="0xff9900" align="left"/>
			  <Image url="png.scene_card.img_container_right" x="755" y="195"/>
			  <List x="755" y="202" repeatY="17" height="433" var="lstStandby">
			    <Box name="render">
			      <Clip url="png.scene_card.clip_listitem" width="250" clipY="2" name="selectBox"/>
			      <Label text="label" x="7" y="4" width="239" height="18" name="label" color="0xc9933e"/>
			    </Box>
			    <VScrollBar skin="png.base.vscroll" x="233" y="0" height="433" name="scrollBar"/>
			  </List>
			  <Image url="png.scene_card.title_bg" x="787" y="124"/>
			  <Label text="待选卡牌" x="844" y="153" color="0xc9933e" width="71" height="18" align="center" font="Microsoft YaHei" size="12"/>
			</Dialog>;
		public function CardDialogUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}