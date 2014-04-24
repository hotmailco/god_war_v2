package
{
	import starling.display.Quad;
	import starling.events.Event;

	public class StarlingScene extends SceneManager
	{
		public function StarlingScene()
		{
			super();
		}
		
		override protected function init(evt:Event=null):void
		{
			super.init(evt);
			
			var q: Quad = new Quad(200, 200);
			q.setVertexColor(0, 0x000000);
			q.setVertexColor(1, 0xFF0000);
			q.setVertexColor(2, 0x00FF00);
			q.setVertexColor(3, 0x0000FF);
			
			stage.addChild(q);
		}
	}
}