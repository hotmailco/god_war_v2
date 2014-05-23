/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class ItemContainerViewUI extends View {
		protected var uiXML:XML =
			<View>
			  <Image url="png.character.equipment_back" x="0" y="0"/>
			</View>;
		public function ItemContainerViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}