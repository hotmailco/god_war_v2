package com.xgame.godwar.parameter
{
	public class NPCContentParameter
	{
		public var title: String;
		public var content: String;
		public var answer: Vector.<NPCAnswerParameter>;
		
		public function NPCContentParameter()
		{
			answer = new Vector.<NPCAnswerParameter>();
		}
	}
}