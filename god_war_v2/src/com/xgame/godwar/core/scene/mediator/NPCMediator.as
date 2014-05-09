package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.common.display.NPCDisplay;
	import com.xgame.godwar.command.send.Send_Scene_TriggerNPC;
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.parameter.NPCAnswerParameter;
	import com.xgame.godwar.parameter.NPCContentParameter;
	import com.xgame.manager.CommandManager;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.NPCDialog;
	
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class NPCMediator extends DialogMediator
	{
		public static const NAME: String = "NPCMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		public static const SET_NPC: String = NAME + ".SetNPC";
		public static const SHOW_CONTENT: String = NAME + ".ShowContent";
		
		private var npc: NPCDisplay;
		private var parameter: NPCContentParameter;
		
		public function NPCMediator()
		{
			super(NAME, new NPCDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onButtonCloseClick);
			component.lstAnswer.mouseHandler = new Handler(onItemClick);
		}
		
		public function get component(): NPCDialog
		{
			return viewComponent as NPCDialog;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE, SET_NPC, SHOW_CONTENT];
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
				case SET_NPC:
					setNPC(notification.getBody() as NPCDisplay);
					break;
				case SHOW_CONTENT:
					showContent(notification.getBody() as NPCContentParameter);
					break;
			}
		}
		
		private function setNPC(npc: NPCDisplay): void
		{
			this.npc = npc;
		}
		
		private function showContent(parameter: NPCContentParameter): void
		{
			this.parameter = parameter;
			component.lblName.text = parameter.title;
			component.lblContent.text = parameter.content;
			var arr: Array = new Array();
			for(var i: int = 0; i<parameter.answer.length; i++)
			{
				arr.push({label: parameter.answer[i].content});
			}
			component.lstAnswer.array = arr;
		}
		
		private function onButtonCloseClick(evt: MouseEvent): void
		{
			hide();
		}
		
		private function onItemClick(evt: MouseEvent, index: int): void
		{
			if(evt.type == MouseEvent.CLICK && parameter != null && index < parameter.answer.length)
			{
				var answer: NPCAnswerParameter = parameter.answer[index];
				if(answer.action == "goto")
				{
					if(CommandManager.instance.connected && npc != null)
					{
						var trigger: Send_Scene_TriggerNPC = new Send_Scene_TriggerNPC();
						trigger.guid = npc.objectId;
						trigger.step = answer.position;
						CommandManager.instance.send(trigger);
					}
				}
				else if(answer.action == "close")
				{
					hide();
				}
			}
		}
	}
}