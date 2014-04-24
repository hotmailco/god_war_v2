package com.xgame
{
	public class Global extends Object
	{
		/**
		 * 游戏计时器
		 */
		public static var Timer: uint;
		/**
		 * 资源更新周期(秒)
		 */
		public static var resourceDelay: uint = 3600;
		/**
		 * 移动同步间隔（毫秒）
		 */
		public static var sync_trigger: uint = 1000;
		/**
		 * 场景刷新间隔（毫秒）
		 */
		public static var cameraview_trigger: uint = 1000;
		/**
		 * 死亡后尸体保留时间
		 */
		public static var deadRetainTime: uint = 10000;
		/**
		 * 资源服务器地址
		 */
		public static var resource_server_ip: String = '';
		/**
		 * 配置文件目录
		 */
		public static const CONFIG_PATH: String = 'config/';
		/**
		 * 脚本目录
		 */
		public static const SCRIPT_PATH: String = 'scripts/';
		/**
		 * 资源目录
		 */
		public static const RESOURCE_PATH: String = 'assets/';
		/**
		 * 地图资源目录
		 */
		public static const MAP_RES_PATH: String = 'assets/map/';
		/**
		 * 角色资源目录
		 */
		public static const CHAR_RES_PATH: String = 'assets/characters/';
		
		public function Global()
		{
		}
	}
}