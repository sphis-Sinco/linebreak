package linebreak;

import hxp.*;
import lime.utils.Assets;

class LineBreakFile
{
	public var filepath:String = '';

	public var filecontent:Array<Dynamic> = [];

	public function new(filepath:String)
	{
		#if SCRIPT_FILES
		this.filepath = FileManager.getScriptFile(filepath);
		#else
		this.filepath = FileManager.get('scripts/$filepath.lb');
		#end

		try
		{
			filecontent = Assets.getText(this.filepath).split('\n');
			var line:Int = 1;
			for (item in filecontent)
			{
				Log.info('[LINEBREAKFILE] ${item}');
				line++;
			}
		}
		catch (e)
		{
			Log.error('[LINEBREAKFILE] ${e}');
		}
	}
}