package;

import flixel.FlxState;
import linebreak.LineBreakFile;

class PlayState extends FlxState
{
	public var file:LineBreakFile;

	override public function create()
	{
		file = new LineBreakFile('example');

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
