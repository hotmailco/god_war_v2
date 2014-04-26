package com.xgame.godwar.core.general.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class DialogMediator extends Mediator implements IMediator
	{
		public function DialogMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			view.alpha = 0;
			view.addEventListener(MouseEvent.CLICK, onViewClick);
		}
		
		private function get view(): DisplayObject
		{
			return viewComponent as DisplayObject;
		}
		
		protected function show(callback: Function = null): void
		{
			if(!UIManager.uiLayer.contains(view))
			{
				UIManager.uiLayer.addChild(view);
			}
			
			TweenLite.to(view, .5, {alpha: 1, ease: Strong.easeOut, onComplete: callback});
		}
		
		protected function hide(callback: Function = null): void
		{
			if(UIManager.uiLayer.contains(view))
			{
				TweenLite.to(view, .5, {alpha: 0, ease: Strong.easeIn, onComplete: function(): void
				{
					if(view.parent != null)
					{
						view.parent.removeChild(view);
					}
					if(callback != null)
					{
						callback();
					}
				}});
			}
		}
		
		private function onViewClick(evt: MouseEvent): void
		{
			evt.stopImmediatePropagation();
		}
	}
}