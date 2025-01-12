package;

class FileManager
{
	public static var STATE_FOLDER:String = 'default';
	public static var SOUND_EXT:String = 'wav';

	/**
		this is the amount of times ive used this script
		and changed it a bit in which the changes can be used in other games.

		SYNTAX: `major`.`minor`
			
		@param major 
			it has some BIG changes like a new way of managing files... 
			new way of returning them. ETC. 	
			Also this is just what I said earlier. 
			the amount of times ive used this script and changed it a bit in which the changes can be used in other games.
		@param minor 
			small changes to the specific major version. 
			MAYBE there is now a feature flag required to be specified for specific functions to function. 
			I mean these can be big too but yknow. 1 thing at a time.
	 */
	public static var FILE_MANAGER_VERSION:Float = 3.2;

	public static function getPath(path:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return '$PATH_TYPE/$path';

	public static function getAssetFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
		return getPath('$STATE_FOLDER/$file', PATH_TYPE);

	#if SCRIPT_FILES
	public static var SCRIPT_EXT:String = 'lb';

	public static function getScriptFile(file:String, ?PATH_TYPE:PathTypes = ASSETS):String
	{
		var finalPath:Dynamic = 'scripts/$file.$SCRIPT_EXT';

		#if SCRIPT_FILES_IN_DATA_FOLDER
		return getDataFile(finalPath, PATH_TYPE);
		#end

		return getPath(finalPath, PATH_TYPE);
	}
	#end

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