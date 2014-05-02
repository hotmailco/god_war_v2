package 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.xgame.manager.LanguageManager;
	import com.xgame.util.RequestUtils;
	import com.xgame.util.VersionUtils;
	import com.xgame.util.debug.Debug;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import game.ui.LoaderViewUI;
	
	[SWF(width="1200", height="800", backgroundColor="0x000000",frameRate="30")]
	public class IndexLoader extends Sprite
	{
		private var _msgText: TextField;
		private var _loaderView: LoaderViewUI;
		
		public function IndexLoader()
		{
//			if(CONFIG::DebugMode)
//			{
//				MonsterDebugger.initialize(this);
//				Debug.init();
//			}
			UIManager.init(this);
			
			LanguageManager.language = Capabilities.language;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_msgText = new TextField();
			_msgText.text = "初始化Loader...";
			_msgText.autoSize = TextFieldAutoSize.CENTER;
			_msgText.width = 500;
			
			var txtFormat: TextFormat = new TextFormat(null, 14, 0xffffff, true);
			_msgText.defaultTextFormat = txtFormat;
			addChild(_msgText);
			
			loadVersion();
		}
		
		private function loadVersion(): void
		{
			loaderMessage = "加载版本信息...";
			
			var urlLoader: URLLoader = new URLLoader();
			var urlRequest: URLRequest = new URLRequest("config/" + LanguageManager.language + "/version.xml");
			urlLoader.addEventListener(Event.COMPLETE, onVersionLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			urlLoader.load(urlRequest);
		}
		
		private function onVersionLoaded(evt: Event): void
		{
			var _loader: URLLoader = evt.target as URLLoader;
			var _data: XML = XML(_loader.data);
			RequestUtils.version = _data.version;
			VersionUtils.initVersionIndex(_data);
			
			loadLanguage();
		}
		
		private function loadLanguage(): void
		{
			loaderMessage = "加载语言包...";
			
			var urlLoader: URLLoader = new URLLoader();
			var urlRequest: URLRequest = new URLRequest("config/" + LanguageManager.language + "/language.xml");
			urlLoader.addEventListener(Event.COMPLETE, onLanguageLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			urlLoader.load(urlRequest);
		}
		
		private function onLanguageLoaded(evt: Event): void
		{
			var _loader: URLLoader = evt.target as URLLoader;
			var _xml: XML = XML(_loader.data);
			LanguageManager.getInstance().init(_xml);
			
			loadLoaderProgressBar();
		}
		
		private function loadLoaderProgressBar(): void
		{
			loaderMessage = LanguageManager.getInstance().lang("load_loader_progress_ui");
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onProgressBarLoaded);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("assets/loader.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onProgressBarLoaded(evt: Event): void
		{
			UIManager.init(this);
			
			_loaderView = new LoaderViewUI();
			addChild(_loaderView);
			removeChild(_msgText);
			_msgText = null;
			
			loadBaseUI();
		}
		
		private function loadBaseUI(): void
		{
			_loaderView.lblMessage.text = LanguageManager.getInstance().lang("load_base_ui");
			_loaderView.progress.value = 0;
			_loaderView.lblPercent.text = "0%";
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBaseUILoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("assets/base.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onBaseUILoaded(evt: Event): void
		{
			loadCommonUI();
		}
		
		private function loadCommonUI(): void
		{
			_loaderView.lblMessage.text = LanguageManager.getInstance().lang("load_base_ui");
			_loaderView.progress.value = 0;
			_loaderView.lblPercent.text = "0%";
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCommonUILoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("assets/common.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onCommonUILoaded(evt: Event): void
		{
			loadFont();
		}
		
		private function loadFont(): void
		{
			_loaderView.lblMessage.text = LanguageManager.getInstance().lang("load_font");
			_loaderView.progress.value = 0;
			_loaderView.lblPercent.text = "0%";
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onFontLoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("assets/font/font.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onFontLoaded(evt: Event): void
		{
			var MSYH: Class = ApplicationDomain.currentDomain.getDefinition("assets.font.MSYH") as Class;
			Font.registerFont(MSYH);
			loadMain();
		}
		
		private function loadMain(): void
		{
			_loaderView.lblMessage.text = LanguageManager.getInstance().lang("load_main");
			_loaderView.progress.value = 0;
			_loaderView.lblPercent.text = "0%";
			
			var _loader: Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMainLoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
			
			var urlRequest: URLRequest = new URLRequest("Main.swf");
			var loaderContext: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loader.load(urlRequest, loaderContext);
		}
		
		private function onMainLoaded(evt: Event): void
		{
			var _loader: LoaderInfo = evt.target as LoaderInfo;
			var _main: DisplayObject = _loader.content;
			addChild(_main);
//			_main["init"]();
			
			removeChild(_loaderView);
			_loaderView = null;
		}
		
		private function onLoadProgress(evt: ProgressEvent): void
		{
			_loaderView.progress.value = evt.bytesLoaded / evt.bytesTotal;
		}
		
		private function onLoadIOError(evt: IOErrorEvent): void
		{
			loaderMessage = evt.text;
		}
		
		private function center():void
		{
			var sw:Number = stage.stageWidth * 0.5;
			var sh:Number = stage.stageHeight * 0.5;
			
			if (_msgText != null)
			{
				_msgText.x = sw - _msgText.width * 0.5;
				_msgText.y = sh - _msgText.height * 0.5;
			}
		}
		
		private function set loaderMessage(value: String):void
		{
			if(_msgText)
			{
				_msgText.text = value;
				center();
			}
			else
			{
				_loaderView.lblMessage.text = value;
			}
		}
	}
}