package {
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	import utils.sound.SoundManager;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author rafaelcordoba
	 */
	public class Test extends Sprite
	{
		private var _manager : SoundManager;
		private var _loader : Loader;
		
		private var btn1 : Sprite;
		private var btn2 : Sprite;
		private var btn3 : Sprite;
		private var btn4 : Sprite;
		
		private var btn_play_loop : Sprite;
		private var btn_pause_loop : Sprite;
		
		private var btn_volume_up : Sprite;
		private var btn_volume_down : Sprite;
		
		private var btn_volume_fx_up : Sprite;
		private var btn_volume_fx_down : Sprite;
		
		public function Test()
		{
			_loader = new Loader();
			_loader.load( new URLRequest( 'swf/sound-library.swf' ) );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete );
			
			btn1 = new Sprite();
			btn1.graphics.beginFill( 0xCC0000 );
			btn1.graphics.drawRect(0, 0, 10, 10);
			btn1.graphics.endFill();
			btn1.addEventListener(MouseEvent.CLICK, _click );
			 
			btn2 = new Sprite();
			btn2.graphics.beginFill( 0xCC0000 );
			btn2.graphics.drawRect(15, 0, 10, 10);
			btn2.graphics.endFill();
			btn2.addEventListener(MouseEvent.CLICK, _click );
			 
			btn3 = new Sprite();
			btn3.graphics.beginFill( 0xCC0000 );
			btn3.graphics.drawRect(30, 0, 10, 10);
			btn3.graphics.endFill();
			btn3.addEventListener(MouseEvent.CLICK, _click );
			 
			btn4 = new Sprite();
			btn4.graphics.beginFill( 0xCC0000 );
			btn4.graphics.drawRect(45, 0, 10, 10);
			btn4.graphics.endFill();
			btn4.addEventListener(MouseEvent.CLICK, _click );
			
			btn_play_loop = new Sprite();
			btn_play_loop.graphics.beginFill( 0x000000 );
			btn_play_loop.graphics.drawRect(0, 15, 10, 10);
			btn_play_loop.graphics.endFill();
			btn_play_loop.addEventListener(MouseEvent.CLICK, _click );
			
			btn_pause_loop = new Sprite();
			btn_pause_loop.graphics.beginFill( 0x000000 );
			btn_pause_loop.graphics.drawRect(15, 15, 10, 10);
			btn_pause_loop.graphics.endFill();
			btn_pause_loop.addEventListener(MouseEvent.CLICK, _click );
			
			btn_volume_up = new Sprite();
			btn_volume_up.graphics.beginFill( 0xFF0000 );
			btn_volume_up.graphics.drawRect(0, 30, 10, 10);
			btn_volume_up.graphics.endFill();
			btn_volume_up.addEventListener(MouseEvent.CLICK, _click );
			
			btn_volume_down = new Sprite();
			btn_volume_down.graphics.beginFill( 0xFF0000 );
			btn_volume_down.graphics.drawRect(15, 30, 10, 10);
			btn_volume_down.graphics.endFill();
			btn_volume_down.addEventListener(MouseEvent.CLICK, _click );
			
			btn_volume_fx_up = new Sprite();
			btn_volume_fx_up.graphics.beginFill( 0x00CC00 );
			btn_volume_fx_up.graphics.drawRect(0, 45, 10, 10);
			btn_volume_fx_up.graphics.endFill();
			btn_volume_fx_up.addEventListener(MouseEvent.CLICK, _click );
			
			btn_volume_fx_down = new Sprite();
			btn_volume_fx_down.graphics.beginFill( 0x00CC00 );
			btn_volume_fx_down.graphics.drawRect(15, 45, 10, 10);
			btn_volume_fx_down.graphics.endFill();
			btn_volume_fx_down.addEventListener(MouseEvent.CLICK, _click );
			 
			addChild( btn1 );
			addChild( btn2 );
			addChild( btn3 );
			addChild( btn4 );
			addChild( btn_play_loop );
			addChild( btn_pause_loop );
			addChild( btn_volume_up );
			addChild( btn_volume_down );
			addChild( btn_volume_fx_up );
			addChild( btn_volume_fx_down );
		}

		private function _click(event : MouseEvent) : void 
		{
			switch( event.currentTarget )
			{
				case btn1 : 
					_manager.play( 'fx1' );
					break;
					
				case btn2 : 
					_manager.play( 'fx2' );
					break;
					
				case btn3 : 
					_manager.play( 'fx3' );
					break;
					
				case btn4 : 
					_manager.play( 'fx4' );
					break;
					
				case btn_play_loop :
					_manager.play( 'loop1', 9999 );
					break;
					
				case btn_pause_loop : 
					_manager.pause( 'loop1' );
					break;
					
				case btn_volume_up : 
					//_manager.volume = _manager.volume + 0.1;
					_manager.fade_in();
					break;
					
				case btn_volume_down : 
					//_manager.volume = _manager.volume - 0.1;
					_manager.fade_out();
					break;
					
				case btn_volume_fx_up : 
					//_manager.set_volume( 'fx2', _manager.get_volume( 'fx2' ) + 0.1 );
					_manager.fade_in( 'loop1' );
					break;
					
				case btn_volume_fx_down : 
					//_manager.set_volume( 'fx2', _manager.get_volume( 'fx2' ) - 0.1 );
					_manager.fade_out( 'loop1' );
					break;
			}
		}

		private function _complete( event : Event ) : void 
		{
			_manager = new SoundManager();
			
			_manager.library( _loader );
			
			_manager.register( 'Loop1', 'loop1' );
			_manager.register( 'Effect1', 'fx1' );
			_manager.register( 'Effect2', 'fx2' );
			_manager.register( 'Effect3', 'fx3' );
			//_manager.register( 'Effect4', 'fx4' );
			_manager.register( 'asdas', 'fxddd' );		// Invalid linkage
			_manager.register( 'MyClip', 'my' );		// Linkage is different than Sound
			
			// Set volume for specific sound
			_manager.set_volume( 'fx2', 0.1 );
			
			// Add Sound Object
			_add_sound_object();
		}
		
		private function _add_sound_object() : void
		{
			var gd : Function;
			var klass : Class;
			var sound : *;
			gd = _loader.contentLoaderInfo.applicationDomain.getDefinition;
			klass = Class( gd( 'Effect4' ) );
			sound = new klass();
			 
			_manager.add_sound( sound, 'fx4' );
		}
	}
}
