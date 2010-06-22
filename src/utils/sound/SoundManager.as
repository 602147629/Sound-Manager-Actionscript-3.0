package utils.sound {
	import gs.TweenMax;

	import flash.display.Loader;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;

	/**
	 * @author rafaelcordoba
	 */
	public class SoundManager 
	{
		private static var NOT_FOUND : String = "No Sound Found";
		
		private var _library : Loader;
		private var _sounds : Dictionary;
		private var _channels : Dictionary;
		private var _volumes : Dictionary;
		private var _volume : Number;

		public function SoundManager() 
		{
			_volume = 1;
			
			_sounds = new Dictionary();
			_channels = new Dictionary();
			_volumes = new Dictionary();
		}
		
		public function library( library : Loader ) : void
		{
			_library = library;
		}

		public function register( linkage : String, key : String ) : void
		{
			var gd : Function;
			var hs : Function;
			
			if ( !_library )
			{
				trace( 'No Library Loaded' );
				return;
			}
			
			gd = _library.contentLoaderInfo.applicationDomain.getDefinition;
			hs = _library.contentLoaderInfo.applicationDomain.hasDefinition;
			
			var sound : *;
			var klass : Class;
			
			if ( hs( linkage ) )
			{
				klass = Class( gd( linkage ) );
				sound = new klass(); 
				
				if ( sound is Sound )
				{
					_sounds[ key ] = sound;
					_volumes[ key ] = _volume;
				}
				else
				{
					trace( 'Linkage is not a Sound: ', sound );
					sound = null;
				}
			}
			else
			{
				trace( 'Invalid Linkage: ', linkage );
			}
		}
		
		public function add_sound( sound : Sound, key : String ) : void
		{
			if ( _sounds[ key ] is Sound )
			{
				trace( 'Key already in use' );
			}
			else
			{
				_sounds[ key ] = sound;
				_volumes[ key ] = 1;
			}
		}
		
		public function play( key : String, loops : int = 0 ) : void
		{
			var sound : Sound;
			var channel : SoundChannel;
			
			if ( _sounds[ key ] is Sound )
			{
				if ( _channels[ key ] is SoundChannel )
					pause( key );
				
				// Sound
				sound = _sounds[ key ];

				// Sound Channel
				channel = sound.play( 0, loops );
				
				// Volume
				TweenMax.to( channel, 0, { volume : _volumes[ key ] } );
				
				_channels[ key ] = channel;
			}
			else
			{
				trace( NOT_FOUND );
			}
		}

		public function pause( key : String ) : void 
		{
			var channel : SoundChannel;
			
			if ( _channels[ key ] is SoundChannel )
			{
				channel = _channels[ key ];
				
				channel.stop();
			}
			else
			{
				trace( NOT_FOUND );
			}
		}
		
		public function set volume( value : Number ) : void 
		{
			if ( value < 0 )
				value = 0;
			
			if ( value > 1 )
				value = 1;
				
			_volume = value;
			
			for (var key : Object in _volumes ) 
			{
				_volumes[ key ] = value;
			}
			
			for each ( var channel : SoundChannel in _channels )
			{
				TweenMax.to( channel, 0, { volume : value } );
			}
		}
		
		public function get volume() : Number
		{
			return _volume;
		}
		
		public function set_volume( key : String, value : Number ) : void
		{
			var channel : SoundChannel;
			
			if ( value < 0 )
				value = 0;
			
			if ( value > 1 )
				value = 1;
			
			if ( _volumes[ key ] is Number ) 
			{
				_volumes[ key ] = value;
				
				if ( _channels[ key ] is SoundChannel )
				{
					channel = _channels[ key ];
					
					TweenMax.to( channel, 0, { volume : value } );
				}
			}
			else
			{
				trace( NOT_FOUND );
			}
		}
		
		public function get_volume( key : String ) : Number
		{
			if ( _volumes[ key ] is Number )
			{
				return _volumes[ key ]; 
			}
			else
			{
				trace( NOT_FOUND );
				
				return NaN;
			}
		}
		
		public function fade_out( key : String = null ) : void
		{
			var channel : SoundChannel;
			
			if ( key )
			{
				if ( _channels[ key ] is SoundChannel ) 
				{
					channel = _channels[ key ];
					
					TweenMax.to( channel, 1, { volume : 0 } );
				}
				else
				{
					trace( NOT_FOUND );
				}
			}
			else
			{
				TweenMax.to( this, 1, { volume : 0 } );
			}
		}
		
		public function fade_in( key : String = null ) : void
		{
			var channel : SoundChannel;
			
			if ( key )
			{
				if ( _channels[ key ] is SoundChannel ) 
				{
					channel = _channels[ key ];
					
					TweenMax.to( channel, 1, { volume : 1 } );
				}
				else
				{
					trace( NOT_FOUND );
				}
			}
			else
			{
				TweenMax.to( this, 1, { volume : 1 } );
			}
		}

		public function kill() : void
		{
			_volumes = new Dictionary();
			_sounds = new Dictionary();
			_channels = new Dictionary();
			
			_volumes = null;
			_sounds = null;
			_channels = null;
			
			_library = null;
		}
	}
}
