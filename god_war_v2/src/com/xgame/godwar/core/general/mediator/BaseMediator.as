package com.xgame.godwar.core.general.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BaseMediator extends Mediator implements IMediator
	{
		
		public function BaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
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
			
			view.x = UIManager.stage.stageWidth;
			
			TweenLite.to(view, .5, {x: 0, ease: Strong.easeOut, onComplete: callback});
		}
		
		protected function hide(callback: Function = null): void
		{
			if(UIManager.uiLayer.contains(view))
			{
				TweenLite.to(view, .5, {x: -UIManager.stage.stageWidth, ease: Strong.easeIn, onComplete: function(): void
				{
					if(view.parent != null)
					{
						view.parent.removeChild(view);
					}
					view.x = 0;
					if(callback != null)
					{
						callback();
					}
				}});
			}
		}
	}
}