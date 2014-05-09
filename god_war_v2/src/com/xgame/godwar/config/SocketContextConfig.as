package com.xgame.godwar.config
{
	
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public final class SocketContextConfig 
	{
		public static var login_ip: String = '';
		public static var login_port: int = 9040;
		public static var server_ip: String = '';
		public static var server_port: int = 0;
		public static var logic_ip: String = '';
		public static var logic_port: int = 0;
		public static var auth_key: String;
		
		public static const	CONTROLLER_SCENE: int								= 5;
		public static const	CONTROLLER_BASE: int								= 4;
		public static const	CONTROLLER_BATTLEROOM: int							= 3;
		public static const	CONTROLLER_MSG: int									= 2;
		public static const	CONTROLLER_MOVE: int								= 1;
		public static const	CONTROLLER_INFO: int								= 0;
		// MOVE
		public static const	ACTION_REQUEST_FINDPATH: int						= 0;
		public static const	ACTION_SYNC_MOVE: int								= 1;
		public static const	ACTION_SEND_PATH: int								= 2;
		// INFO
		public static const	ACTION_LOGIN: int									= 0;
		public static const	ACTION_LOGOUT: int									= 1;
		public static const	ACTION_QUICK_START: int								= 2;
		public static const	ACTION_REGISTER: int								= 3;
		public static const	ACTION_REQUEST_CHARACTER: int						= 4;
		public static const	ACTION_REGISTER_CHARACTER: int						= 5;
		public static const	ACTION_LOGICSERVER_BIND_SESSION: int				= 6;
		public static const	ACTION_BIND_SESSION: int							= 7;
		public static const	ACTION_REQUEST_CARD_GROUP: int						= 8;
		public static const	ACTION_REQUEST_CARD_LIST: int						= 9;
		public static const	ACTION_CREATE_GROUP: int							= 10;
		public static const	ACTION_DELETE_GROUP: int							= 11;
		public static const	ACTION_SAVE_CARD_GROUP: int							= 12;
		public static const	ACTION_HEART_BEAT: int								= 126;
		public static const	ACTION_HEART_BEAT_ECHO: int							= 127;
		// MSG
		public static const	ACTION_SEND_PUBLIC: int								= 0;	// 附近
		public static const	ACTION_SEND_TEAM: int								= 1;	// 组队
		public static const	ACTION_SEND_PRIVATE: int							= 2;	// 密语
		public static const	ACTION_SEND_WORLD: int								= 3;	// 世界
		// BASE
		public static const	ACTION_REGISTER_LOGIC_SERVER: int					= 0;
		public static const	ACTION_REGISTER_LOGIC_SERVER_CONFIRM: int			= 1;
		public static const	ACTION_REQUEST_LOGIC_SERVER_ROOM: int				= 2;
		public static const	ACTION_REQUEST_LOGIC_SERVER_ROOM_CONFIRM: int		= 3;
		public static const	ACTION_LOGIC_SERVER_INFO: int						= 4;
		public static const	ACTION_CONNECT_LOGIC_SERVER: int					= 5;
		public static const	ACTION_VERIFY_MAP: int								= 6;
		public static const	ACTION_UPDATE_STATUS: int							= 7;
		// SCENE
		public static const	ACTION_REQUEST_ROOM: int							= 0;
		public static const	ACTION_SHOW_ROOMLIST: int							= 1;
		public static const	ACTION_ROOM_CREATED: int							= 2;
		public static const	ACTION_REQUEST_ENTER_ROOM: int						= 3;
		public static const	ACTION_REQUEST_ENTER_ROOM_LOGICSERVER: int			= 4;
		public static const	ACTION_SHOW_PLAYER: int								= 5;
		public static const	ACTION_REMOVE_PLAYER: int							= 6;
		public static const	ACTION_SHOW_NPC: int								= 7;
		public static const	ACTION_REMOVE_NPC: int								= 8;
		public static const	ACTION_TRIGGER_NPC: int								= 9;
		// BATTLE ROOM
		public static const	ACTION_INIT_ROOM_DATA: int							= 0;
		public static const	ACTION_PLAYER_ENTER_ROOM_NOTICE: int				= 1;
		public static const	ACTION_PLAYER_SELETED_HERO: int						= 2;
		public static const	ACTION_PLAYER_READY: int							= 3;
		public static const	ACTION_PLAYER_LEAVE_ROOM_NOTICE: int				= 4;
		public static const	ACTION_REQUEST_START_BATTLE: int					= 5;
		public static const	ACTION_INIT_ROOM_DATA_LOGICSERVER: int				= 6;
		public static const	ACTION_PLAYER_ENTER_ROOM_NOTICE_LOGICSERVER: int	= 7;
		public static const	ACTION_START_BATTLE_TIMER: int						= 8;
		public static const	ACTION_START_ROOM_TIMER: int						= 9;
		public static const	ACTION_FIRST_CHOUPAI: int							= 10;
		public static const	ACTION_PLAYER_READY_ERROR: int						= 11;
		public static const	ACTION_DEPLOY_COMPLETE: int							= 12;
		public static const	ACTION_START_DICE: int								= 13;
		public static const	ACTION_ROUND_STANDBY: int							= 14;
		public static const	ACTION_ROUND_STANDBY_CONFIRM: int					= 15;
		public static const	ACTION_ROUND_STANDBY_CHANGE_FORMATION: int			= 16;
		public static const	ACTION_ROUND_STANDBY_EQUIP: int						= 17;
		public static const	ACTION_ROUND_ACTION: int							= 25;
		public static const	ACTION_ROUND_ACTION_ATTACK: int						= 26;
		public static const	ACTION_ROUND_ACTION_SPELL: int						= 27;
		public static const	ACTION_ROUND_ACTION_REST: int						= 28;
		
		// MOVE
		public static const	REQUEST_FIND_PATH: int							= ACTION_REQUEST_FINDPATH << 8
			| CONTROLLER_MOVE;
		public static const	SYNC_MOVE: int									= ACTION_SYNC_MOVE << 8
			| CONTROLLER_MOVE;
		public static const	SEND_PATH: int									= ACTION_SEND_PATH << 8
			| CONTROLLER_MOVE;
		// INFO
		public static const	QUICK_START: int									= ACTION_QUICK_START << 8
			| CONTROLLER_INFO;
		public static const	INFO_LOGIN: int									= ACTION_LOGIN << 8
			| CONTROLLER_INFO;
		public static const	INFO_LOGOUT: int									= ACTION_LOGOUT << 8
			| CONTROLLER_INFO;
		public static const	INFO_REGISTER: int								= ACTION_REGISTER << 8
			| CONTROLLER_INFO;
		public static const	REQUEST_ACCOUNT_ROLE: int						= ACTION_REQUEST_CHARACTER << 8
			| CONTROLLER_INFO;
		public static const	REGISTER_ACCOUNT_ROLE: int						= ACTION_REGISTER_CHARACTER << 8
			| CONTROLLER_INFO;
		public static const	INFO_LOGICSERVER_BIND_SESSION: int				= ACTION_LOGICSERVER_BIND_SESSION << 8
			| CONTROLLER_INFO;
		public static const	INFO_BIND_SESSION: int							= ACTION_BIND_SESSION << 8
			| CONTROLLER_INFO;
		public static const	INFO_REQUEST_CARD_GROUP: int						= ACTION_REQUEST_CARD_GROUP << 8
			| CONTROLLER_INFO;
		public static const	INFO_REQUEST_CARD_LIST: int						= ACTION_REQUEST_CARD_LIST << 8
			| CONTROLLER_INFO;
		public static const	INFO_CREATE_GROUP: int							= ACTION_CREATE_GROUP << 8
			| CONTROLLER_INFO;
		public static const	INFO_DELETE_GROUP: int							= ACTION_DELETE_GROUP << 8
			| CONTROLLER_INFO;
		public static const	INFO_SAVE_CARD_GROUP: int						= ACTION_SAVE_CARD_GROUP << 8
			| CONTROLLER_INFO;
		public static const	INFO_HEART_BEAT: int								= ACTION_HEART_BEAT << 8
			| CONTROLLER_INFO;
		public static const	INFO_HEART_BEAT_ECHO: int							= ACTION_HEART_BEAT_ECHO << 8
			| CONTROLLER_INFO;
		// MSG
		public static const	MSG_SEND_PUBLIC: int								= ACTION_SEND_PUBLIC << 8
			| CONTROLLER_MSG;
		public static const	MSG_SEND_TEAM: int									= ACTION_SEND_TEAM << 8
			| CONTROLLER_MSG;
		public static const	MSG_SEND_PRIVATE: int								= ACTION_SEND_PRIVATE << 8
			| CONTROLLER_MSG;
		public static const	MSG_SEND_WORLD: int									= ACTION_SEND_WORLD << 8
			| CONTROLLER_MSG;
		// BASE
		public static const	BASE_VERIFY_MAP: int								= ACTION_VERIFY_MAP << 8
			| CONTROLLER_BASE;
		public static const	BASE_REGISTER_LOGIC_SERVER: int					= ACTION_REGISTER_LOGIC_SERVER << 8
			| CONTROLLER_BASE;
		public static const	BASE_REGISTER_LOGIC_SERVER_CONFIRM: int			= ACTION_REGISTER_LOGIC_SERVER_CONFIRM << 8
			| CONTROLLER_BASE;
		public static const	BASE_REQUEST_LOGIC_SERVER_ROOM: int				= ACTION_REQUEST_LOGIC_SERVER_ROOM << 8
			| CONTROLLER_BASE;
		public static const	BASE_REQUEST_LOGIC_SERVER_ROOM_CONFIRM: int		= ACTION_REQUEST_LOGIC_SERVER_ROOM_CONFIRM << 8
			| CONTROLLER_BASE;
		public static const	BASE_LOGIC_SERVER_INFO: int						= ACTION_LOGIC_SERVER_INFO << 8
			| CONTROLLER_BASE;
		public static const	BASE_CONNECT_LOGIC_SERVER: int					= ACTION_CONNECT_LOGIC_SERVER << 8
			| CONTROLLER_BASE;
		public static const	BASE_UPDATE_STATUS: int							= ACTION_UPDATE_STATUS << 8
			| CONTROLLER_BASE;
		// SCENE
		public static const	HALL_REQUEST_ROOM: int							= ACTION_REQUEST_ROOM << 8
			| CONTROLLER_SCENE;
		public static const	HALL_SHOW_ROOM_LIST: int							= ACTION_SHOW_ROOMLIST << 8
			| CONTROLLER_SCENE;
		public static const	HALL_ROOM_CREATED: int							= ACTION_ROOM_CREATED << 8
			| CONTROLLER_SCENE;
		public static const	HALL_REQUEST_ENTER_ROOM: int						= ACTION_REQUEST_ENTER_ROOM << 8
			| CONTROLLER_SCENE;
		public static const	HALL_REQUEST_ENTER_ROOM_LOGICSERVER: int			= ACTION_REQUEST_ENTER_ROOM_LOGICSERVER << 8
			| CONTROLLER_SCENE;
		public static const	SCENE_SHOW_PLAYER: int							= ACTION_SHOW_PLAYER << 8
			| CONTROLLER_SCENE;
		public static const	SCENE_REMOVE_PLAYER: int							= ACTION_REMOVE_PLAYER << 8
			| CONTROLLER_SCENE;
		public static const	SCENE_SHOW_NPC: int								= ACTION_SHOW_NPC << 8
			| CONTROLLER_SCENE;
		public static const	SCENE_REMOVE_NPC: int							= ACTION_REMOVE_NPC << 8
			| CONTROLLER_SCENE;
		public static const	SCENE_TRIGGER_NPC: int							= ACTION_TRIGGER_NPC << 8
			| CONTROLLER_SCENE;
		// BATTLE ROOM
		public static const	BATTLEROOM_INIT_ROOM: int						= ACTION_INIT_ROOM_DATA << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_ENTER_ROOM: int				= ACTION_PLAYER_ENTER_ROOM_NOTICE << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_SELECTED_HERO: int				= ACTION_PLAYER_SELETED_HERO << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_READY: int						= ACTION_PLAYER_READY << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_READY_ERROR: int				= ACTION_PLAYER_READY_ERROR << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_LEAVE_ROOM: int				= ACTION_PLAYER_LEAVE_ROOM_NOTICE << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_REQUEST_START_BATTLE: int				= ACTION_REQUEST_START_BATTLE << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_INIT_ROOM_LOGICSERVER: int			= ACTION_INIT_ROOM_DATA_LOGICSERVER << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_PLAYER_ENTER_ROOM_LOGICSERVER: int	= ACTION_PLAYER_ENTER_ROOM_NOTICE_LOGICSERVER << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_START_BATTLE_TIMER: int				= ACTION_START_BATTLE_TIMER << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_START_ROOM_TIMER: int					= ACTION_START_ROOM_TIMER << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_FIRST_CHOUPAI: int					= ACTION_FIRST_CHOUPAI << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_DEPLOY_COMPLETE: int					= ACTION_DEPLOY_COMPLETE << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_START_DICE: int						= ACTION_START_DICE << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_STANDBY: int					= ACTION_ROUND_STANDBY << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_STANDBY_CONFIRM: int			= ACTION_ROUND_STANDBY_CONFIRM << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_STANDBY_CHANGE_FORMATION: int	= ACTION_ROUND_STANDBY_CHANGE_FORMATION << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_STANDBY_EQUIP: int				= ACTION_ROUND_STANDBY_EQUIP << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_ACTION: int						= ACTION_ROUND_ACTION << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_ACTION_ATTACK: int				= ACTION_ROUND_ACTION_ATTACK << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_ACTION_SPELL: int				= ACTION_ROUND_ACTION_SPELL << 8
			| CONTROLLER_BATTLEROOM;
		public static const	BATTLEROOM_ROUND_ACTION_REST: int				= ACTION_ROUND_ACTION_REST << 8
			| CONTROLLER_BATTLEROOM;
		
		public function SocketContextConfig() 
		{
			throw new IllegalOperationError("Config类不允许实例化");
		}
		
	}

}