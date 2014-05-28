package com.xgame.godwar.core.scene.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.godwar.core.scene.command.ShowCardMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowCharacterMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowItemMediatorCommand;
	import com.xgame.godwar.core.scene.proxy.ChatProxy;
	import com.xgame.util.StringUtils;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.SceneView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class SceneMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "SceneMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function SceneMediator()
		{
			super(NAME, new SceneView());
			
			component.boxChat.x = -component.boxChat.width;
			component.boxMenu.y = UIManager.stage.stageHeight;
			component.boxRole.x = -component.boxRole.width;
			
			component.addEventListener(MouseEvent.CLICK, onSceneUIClick);
			component.btnRole.addEventListener(MouseEvent.CLICK, onButtonRoleClick);
			component.btnPackage.addEventListener(MouseEvent.CLICK, onButtonPackageClick);
			component.btnCard.addEventListener(MouseEvent.CLICK, onButtonCardClick);
			component.btnSend.addEventListener(MouseEvent.CLICK, onButtonSendClick);
		}
		
		public function get component(): SceneView
		{
			return viewComponent as SceneView;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					show(notification.getBody() as Function);
					break;
				case HIDE_NOTE:
					hide(notification.getBody() as Function);
					break;
			}
		}
		
		protected function show(callback: Function = null): void
		{
			if(!UIManager.uiLayer.contains(component))
			{
				UIManager.uiLayer.addChild(component);
			}
			
			TweenLite.to(component.boxChat, .5, {x: 0, ease: Strong.easeOut, onComplete: callback});
			TweenLite.to(component.boxMenu, .5, {y: UIManager.stage.stageHeight - component.boxMenu.height, ease: Strong.easeOut, onComplete: callback});
			TweenLite.to(component.boxRole, .5, {x: 0, ease: Strong.easeOut, onComplete: callback});
		}
		
		protected function hide(callback: Function = null): void
		{
			if(UIManager.uiLayer.contains(component))
			{
				TweenLite.to(component.boxChat, .5, {x: -component.boxChat.width, ease: Strong.easeIn, onComplete: callback});
				TweenLite.to(component.boxMenu, .5, {x: UIManager.stage.stageHeight, ease: Strong.easeIn, onComplete: callback});
				TweenLite.to(component.boxRole, .5, {x: -component.boxRole.width, ease: Strong.easeIn, onComplete: function(): void
				{
					if(component.parent != null)
					{
						component.parent.removeChild(component);
					}
					if(callback != null)
					{
						callback();
					}
				}});
			}
		}
		
		private function onSceneUIClick(evt: MouseEvent): void
		{
			evt.stopImmediatePropagation();
		}
		
		private function onButtonCardClick(evt: MouseEvent): void
		{
			facade.sendNotification(ShowCardMediatorCommand.SHOW_NOTE);
		}
		
		private function onButtonRoleClick(evt: MouseEvent): void
		{
			facade.sendNotification(ShowCharacterMediatorCommand.SHOW_NOTE);
		}
		
		private function onButtonPackageClick(evt: MouseEvent): void
		{
			facade.sendNotification(ShowItemMediatorCommand.SHOW_NOTE);
		}
		
		private function onButtonSendClick(evt: MouseEvent): void
		{
			var message: String = component.iptMessage.text;
			if(!StringUtils.empty(message))
			{
				var proxy: ChatProxy = facade.retrieveProxy(ChatProxy.NAME) as ChatProxy;
				proxy.sendMessagePublic(message);
				
				component.iptMessage.text = "";
			}
		}
	}
}