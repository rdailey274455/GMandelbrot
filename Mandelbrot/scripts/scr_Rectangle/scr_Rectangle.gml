function coordToString(_p, _total, _dec, _delim)
	{
	return "(" + string_format(_p.x, _total, _dec) + _delim + string_format(_p.y, _total, _dec) + ")";
	}

function mapRange(_aMin, _aMax, _aVal, bMin, bMax)
	{
	return ((_aVal - _aMin)/(_aMax - _aMin))*(bMax - bMin) + bMin;
	}


function Rectangle(_x1, _y1, _x2, _y2) constructor
	{
	__x1 = _x1;
	__y1 = _y1;
	__x2 = _x2;
	__y2 = _y2;
	
	static scale_about_center = function(_factor)
		{
		var center = {x: (__x2 + __x1)/2, y: (__y2 + __y1)/2};
		__x1 = _factor*(__x1 - center.x) + center.x;
		__x2 = _factor*(__x2 - center.x) + center.x;
		__y1 = _factor*(__y1 - center.y) + center.y;
		__y2 = _factor*(__y2 - center.y) + center.y;
		}
	
	static p1 = function() { return {x:__x1, y:__y1}; }
	
	static p2 = function() { return {x:__x2, y:__y2}; }
	
	static assign = function(_p1, _p2)
		{
		// okay, yes, this is boilerplate...?
		__x1 = _p1.x;
		__y1 = _p1.y;
		__x2 = _p2.x;
		__y2 = _p2.y;
		}
	
	///@param _p
	///@param _oR other Rectangle
	///@description Returns where _p would lie in _o based on where it lies within the calling Rectangle
	static mapPointToOther = function(_p, _oR)
		{
		return
			{
			x: mapRange(__x1, __x2, _p.x, _oR.__x1, _oR.__x2),
			y: mapRange(__y1, __y2, _p.y, _oR.__y1, _oR.__y2)
			};
		}
	
	static overlaps = function(_oR)
		{
		// this one is to the left or right of the other
		if (max(__x1, __x2) < min(_oR.__x1, _oR.__x2) || min(__x1, __x2) > max(_oR.__x1, _oR.__x2)) { return false; }
		// this one is above or below the other
		if (max(__y1, __y2) < min(_oR.__y1, _oR.__y2) || min(__y1, __y2) > max(_oR.__y1, _oR.__y2)) { return false; }
		// not beside vertically nor horizontally
		return true;
		}
	
	}

function RectangleCopy(_otherRectangle)
	{
	return new Rectangle(_otherRectangle.p1().x, _otherRectangle.p1().y, _otherRectangle.p2().x, _otherRectangle.p2().y);
	}