package phoenix;


class Color {

	public var r : Float = 1.0;
	public var g : Float = 1.0;
	public var b : Float = 1.0;
	public var a : Float = 1.0;

	public function new(_r:Float = 1.0, _g:Float = 1.0, _b:Float = 1.0, _a:Float = 1.0) {
		
		r = _r;
		g = _g;
		b = _b;
		a = _a;

	}

	public function rgb(_rgb:Int = 0xFFFFFF) : Color {
		from_int(_rgb);
		return this;
	} //rgb

		//make it traceable
	public function toString() : String {
		return "{ r:"+r+" , g:"+g+" , b:"+b+" , a:"+a+" }";
	}

	public function from_int(_i:Int) {

		var _r = _i >> 16;
		var _g = _i >> 8 & 0xFF;
		var _b = _i & 0xFF;
		
			//convert to 0-1
		r = _r / 255; 
		g = _g / 255;
		b = _b / 255;

			//alpha not specified in 0xFFFFFF
			//but we don't need to clobber it, 
			//it was set in the member list
		// a = 1.0;
	}

}