package;

class FileManager
{
	public static var STATE_FOLDER:String = 'default';
	public static var SOUND_EXT:String = 'wav';

	// this is the amount of times ive used this script and changed it a bit in which the changes can be used in other games
	public static var FILE_MANAGER_VERSION:Int = 3;

	public static function getPath(path:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return '$PATH_TYPE/$path';

	public static function getAssetFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('$STATE_FOLDER/$file', PATH_TYPE);

	public static function getScriptFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('scripts/$file', PATH_TYPE);

	public static function getDataFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('data/$file', PATH_TYPE);

	public static function getImageFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('images/$file.png', PATH_TYPE);

	public static function getSoundFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('$file.$SOUND_EXT', PATH_TYPE);
}

enum abstract PathTypes(String) from String to String
{
	public var ASSETS:String = "assets";
}