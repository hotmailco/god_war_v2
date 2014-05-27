/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class ItemContainerViewUI extends View {
		protected var uiXML:XML =
			<View>
			  <Image url="png.base.equipment_back" x="0" y="0"/>
			  <Image y="0" x="0" width="57" height="57" name="item"/>
			</View>;
		public function ItemContainerViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}