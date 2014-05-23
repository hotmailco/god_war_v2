package game.view.scene
{
	import game.ui.scene.CharacterDialogUI;
	
	public class CharacterDialog extends CharacterDialogUI
	{
		public var itemBlockXiangLian: ItemContainerView;
		public var itemBlockWuQi: ItemContainerView;
		public var itemBlockJieZhi: ItemContainerView;
		public var itemBlockTouKui: ItemContainerView;
		public var itemBlockKuiJia: ItemContainerView;
		public var itemBlockXieZi: ItemContainerView;
		
		public function CharacterDialog()
		{
			super();
			
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