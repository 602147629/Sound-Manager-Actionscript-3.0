Sound Manager Actionscript 3.0

You can manage multiple sounds with this class, play, pause, set volume for all sounds or individual items.

There is a FDT project already set.

----------------------------------------------------------------------
USAGE 1 - With Sounds in Library (.swf):
----------------------------------------------------------------------

var _manager : SoundManager;
var _loader : Loader;
var _manager : SoundManager;

_loader = new Loader();
_loader.load( new URLRequest( 'swf/sound-library.swf' ) );
_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _complete );

function _complete( event : Event ) : void 
{
	_manager = new SoundManager();	
	_manager.library( _loader );
	
	_manager.register( 'Loop1', 'loop1' );   // library linkage and unique key identifier
	_manager.register( 'Effect1', 'fx1' );   // library linkage and unique key identifier
	_manager.register( 'Effect2', 'fx2' );   // library linkage and unique key identifier
	_manager.register( 'Effect3', 'fx3' );   // library linkage and unique key identifier
	_manager.register( 'Effect4', 'fx4' );   // library linkage and unique key identifier
	
	_manager.play( 'fx1' );
	_manager.fade_in();
	_manager.fade_out();
	_manager.set_volume( 'fx2', 0.1 );
}

----------------------------------------------------------------------
USAGE 2 - Adding sounds directly
----------------------------------------------------------------------

var sound : Sound;

_manager = new SoundManager();
_manager.add_sound( sound, 'fx1' );   // Sound object and unique key identifier
_manager.add_sound( sound, 'fx2' );   // Sound object and unique key identifier
_manager.add_sound( sound, 'fx3' );   // Sound object and unique key identifier
_manager.add_sound( sound, 'fx4' );   // Sound object and unique key identifier







