function ComplexNum(_a, _b) constructor
	{
	__a = _a;
	__b = _b;
	
	toString = function()
		{
		return string_format(__a, 4, 16) + "+" + string_format(__b, 4, 16) + "i";
		}
	
	static assign = function(_a, _b)
		{
		// this is considerably not boilerplate in that the initialization at the
		// beginning of the constructor function body may possibly differ
		// furthermore, plainly declaring members of a struct directly in the body
		// of a constructor function rather than indirecly as through a function
		// call might be mandatory
		__a = _a;
		__b = _b;
		}
	
	static makeNegative = function()
		{
		__a *= -1;
		__b *= -1;
		}
	
	// deprecated
	static addedTo = function(_other) { return new ComplexNum(__a + _other.__a, __b + _other.__b); }
	
	// deprecated
	static squared = function() { return new ComplexNum(sqr(__a) - sqr(__b), 2*__a*__b); }
	
	static absoluteValue = function() { return sqrt(sqr(__a) + sqr(__b)); }
		//{
		//////show_debug_message("a = " + string(__a) + ", b = " + string(__b));
		////show_debug_message(toString());
		//return sqrt(abs(abs(sqr(__a)) + abs(sqr(__b))));
		//}
	
	static square = function()
		{
		var a = __a;
		__a = sqr(__a) - sqr(__b);
		__b = 2*a*__b;
		}
	
	static plus = function(_other)
		{
		__a += _other.__a;
		__b += _other.__b;
		}
	
	static a = function() { return __a; }
	
	static b = function() { return __b; }
	
	}


function iPow(_power)
	{
	_power = floor(_power) mod 4;
	switch (_power)
		{
		case 0:
			return new ComplexNum(1, 0);
		case 1:
			return new ComplexNum(0, 1);
		case 2:
			return new ComplexNum(-1, 0);
		case 3:
			return new ComplexNum(0, -1);
		default:
			return new ComplexNum(0, 0);
		}
	}


// deprecated
function mandelbrot_internal(_z, _c) //{ return (_z.squared()).addedTo(_c); }
	{
	var _zSquared = _z.squared();
	//delete _z;
	var answer = _zSquared.addedTo(_c);
	//delete _zSquared;
	return answer;
	}


///@description Returns two-element array, first element says whether successful, second element is value of interest
function mandelbrot(_c, _iterationCount)
	{
	var z = new ComplexNum(0.0, 0.0);
	//var result = 0.0;
	for (var i = 0; i < _iterationCount; ++i)
		{
		//result = z.absoluteValue();
		//z = mandelbrot_internal(z, _c);
		z.square();
		z.plus(_c);
		if (is_undefined(z.a()) || is_undefined(z.b())) { return [undefined, i]; }
		if (is_infinity(z.a()) || is_infinity(z.b())) { return [infinity, i]; }
		if (is_nan(z.a()) || is_nan(z.b())) { return [NaN, i]; }  // just curious, is NaN the only built-in name with capitals?
		//show_debug_message(z.toString());  // z without the dot toString call should be equivalent, but this is to be safe
		}
	var result = z.absoluteValue();
	delete z;
	return ["bounded", result];
	}