package linebreak;

import hxp.*;
import lime.utils.Assets;

using StringTools;

class LineBreakFile
{
	public var filepath:String = '';

	public var filecontent:Array<String> = [];

	public function new(filepath:String)
	{
		#if SCRIPT_FILES
		this.filepath = FileManager.getScriptFile(filepath);
		#end

		try
		{
			filecontent = Assets.getText(this.filepath).split('\n');
			/*var line:Int = 1;
			for (item in filecontent)
			{
																																																																										trace('${item}');
				line++;
			}*/
		}
		catch (e)
		{
			trace(e);
		}
		LineBreakFileParser.parse(filepath);
	}
}

class LineBreakFileParser
{
	public static function parse(filepath:String):Int
	{
		trace('Preparing to parse "$filepath"');

		var filecontent:Array<String> = [];

		try
		{
			filecontent = Assets.getText(FileManager.getScriptFile(filepath)).split('\n');
		}
		catch (e)
		{
			trace(e);
		}

		if (filecontent.length > 0)
		{
			trace('"$filepath" has the length of ${filecontent.length} lines');

			var current_function:String = "";
			var function_arguments:Array<Dynamic> = [""];

			var is_comment:Bool = false;
			var is_print_function:Bool = false;

			var linenumber:Int = 0;

			for (line in filecontent)
			{
				linenumber++;

				is_comment = line.startsWith(";");

				if (is_comment == false)
				{
					if (line.contains('(') || line.contains(')'))
					{
						trace(line);

						var charidx:Int = 1;
						for (char in line)
						{
							if (charidx == line.length)
							{
								switch (line.charAt(char))
								{
									case '(':
										trace('$line is the start of a function');
									case ')':
										trace('$line is the end of a function');
								}
							}
							charidx++;
						}
					}
				}
			}

			return 1; // success
		}
		else
		{
			return 0; // failure
		}
	}
}