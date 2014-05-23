package game.view.scene
{
	import flash.events.MouseEvent;
	
	import game.ui.scene.ItemContainerViewUI;
	import game.view.IDroppable;
	
	public class ItemContainerView extends ItemContainerViewUI implements IDroppable
	{
		public function ItemContainerView()
		{
			super();
		}
		
		public function droppable(): void
		{
			addEventListener(MouseEvent.MOUSE_UP, onDropped);
		}
		
		private function onDropped(evt: MouseEvent): void
		{
			
		}
	}
}