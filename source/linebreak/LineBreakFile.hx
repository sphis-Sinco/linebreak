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
				trace(line);

				is_comment = line.startsWith(";");

				if (current_function == "")
				{
					trace("No Function in Place");
					if (line.charAt(line.length) == '(')
					{
						current_function = line.split('(')[0];
						trace(current_function);
					}
				}
				else if (is_print_function || current_function != "")
				{
					trace("Function in Place");

					if (line.charAt(0) == ')')
					{
						trace("Function Ending");
						switch (current_function)
						{
							case "printT":
								trace(function_arguments[0], {
									fileName: FileManager.getScriptFile(filepath).replace('assets/', '') + "." + FileManager.SCRIPT_EXT,
									lineNumber: linenumber,
									className: "filepath",
									methodName: current_function,
									customParams: ""
								});
								is_print_function = false;
						}

						current_function = "";
						function_arguments = [];
					}
				}

				is_print_function = false;
				switch (current_function)
				{
					case "printT":
						is_print_function = true;
						if (line.startsWith('"') && line.endsWith('"'))
							function_arguments.push(line.split('"')[1]);
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