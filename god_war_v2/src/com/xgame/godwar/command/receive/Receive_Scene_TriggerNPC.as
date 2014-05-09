package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.NPCAnswerParameter;
	import com.xgame.godwar.parameter.NPCContentParameter;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class Receive_Scene_TriggerNPC extends ReceiveBase
	{
		public var guid: String;
		public var content: NPCContentParameter;
		
		public function Receive_Scene_TriggerNPC()
		{
			super(SocketContextConfig.SCENE_TRIGGER_NPC);
			content = new NPCContentParameter();
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var answer: NPCAnswerParameter = new NPCAnswerParameter();
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_STRING:
							if(StringUtils.empty(guid))
							{
								guid = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(content.title))
							{
								content.title = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(content.content))
							{
								content.content = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(answer.content))
							{
								answer.content = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(answer.action))
							{
								answer.action = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(answer.command))
							{
								answer.command = data.readUTFBytes(length);
							}
							break;
						case TYPE_INT:
							if(answer.position == int.MIN_VALUE)
							{
								answer.position = data.readInt();
							}
							break;						
					}
					
					if(!StringUtils.empty(answer.content) && 
						!StringUtils.empty(answer.action) && 
						answer.position != int.MIN_VALUE &&
						answer.command != null)
					{
						content.answer.push(answer);
						answer = new NPCAnswerParameter();
					}
				}
			}
			
		}
	}
}