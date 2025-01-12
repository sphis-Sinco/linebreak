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
	static var current_function:String = "";
	static var function_arguments:Array<Dynamic> = [""];

	static var is_comment:Bool = false;
	static var is_print_function:Bool = false;

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

			var linenumber:Int = 0;

			for (line in filecontent)
			{
				linenumber++;

				is_comment = line.startsWith(";");

				if (!is_comment)
				{
					if (line.contains('/'))
					{
						var before:Null<String> = "";
						var after:Null<String> = "";
						for (charidx in 0...line.length)
						{
							before = line.charAt(charidx - 1);
							after = line.charAt(charidx + 1);
							switch (line.charAt(charidx))
							{
								case '/':
										setfunction(line);
							}
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

	static var valid_functions:Array<String> = [
		"info",
		"printF",
		"printT",
	];

	static var valid_function_declarations:Array<String> = [
		"overW ",
		"local ",
		"call "
	];

	public static function setfunction(line:String)
	{
		var readline:String = line;

		for (declaration in valid_function_declarations)
			{
				if (line.startsWith(declaration))
				{
					readline = line.split(declaration)[0];
				}
			}

		if (current_function == "" && valid_functions.contains(readline.split('/')[0])) {
			current_function = readline.split('/')[0];
		} else if (current_function != "") {
			current_function = "";
		}
	}
}
