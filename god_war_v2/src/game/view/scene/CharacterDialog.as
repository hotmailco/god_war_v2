package game.view.scene
{
	import com.xgame.core.scene.Scene;
	
	import game.ui.scene.CharacterDialogUI;
	
	import morn.core.components.Image;
	import com.xgame.common.display.PlayerDisplay;
	
	public class CharacterDialog extends CharacterDialogUI
	{
		public var itemBlockXiangLian: ItemContainerView;
		public var itemBlockWuQi: ItemContainerView;
		public var itemBlockJieZhi: ItemContainerView;
		public var itemBlockTouKui: ItemContainerView;
		public var itemBlockKuiJia: ItemContainerView;
		public var itemBlockXieZi: ItemContainerView;
		public var avatar: Image;
		
		public function CharacterDialog()
		{
			super();
			
			avatar = new Image();
			avatar.x = 162;
			avatar.y = 120;
			var p: PlayerDisplay = Scene.instance.player;
			avatar.bitmapData = p.graphic.bitmapArray[0][0].bitmapData;
			addChild(avatar);
			
			itemBlockXiangLian = new ItemContainerView();
			itemBlockXiangLian.x = 41;
			itemBlockXiangLian.y = 107;
			addChild(itemBlockXiangLian);
			itemBlockXiangLian.droppable();
			
			itemBlockWuQi = new ItemContainerView();
			itemBlockWuQi.x = 41;
			itemBlockWuQi.y = 169;
			addChild(itemBlockWuQi);
			itemBlockWuQi.droppable();
			
			itemBlockJieZhi = new ItemContainerView();
			itemBlockJieZhi.x = 41;
			itemBlockJieZhi.y = 231;
			addChild(itemBlockJieZhi);
			itemBlockJieZhi.droppable();
			
			itemBlockTouKui = new ItemContainerView();
			itemBlockTouKui.x = 294;
			itemBlockTouKui.y = 107;
			addChild(itemBlockTouKui);
			itemBlockTouKui.droppable();
			
			itemBlockKuiJia = new ItemContainerView();
			itemBlockKuiJia.x = 294;
			itemBlockKuiJia.y = 169;
			addChild(itemBlockKuiJia);
			itemBlockKuiJia.droppable();
			
			itemBlockXieZi = new ItemContainerView();
			itemBlockXieZi.x = 294;
			itemBlockXieZi.y = 231;
			addChild(itemBlockXieZi);
			itemBlockXieZi.droppable();
		}
	}
}