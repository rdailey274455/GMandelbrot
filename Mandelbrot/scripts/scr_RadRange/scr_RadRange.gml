function RadRange(_start, _stop, _stepCount) constructor
	{
	__start = _start;
	__stop = _stop;
	__stepAmt = (__stop - __start)/_stepCount;
	__value = _start;
	__active = true;
	
	static currentValue = function() { return __value; }
	
	static percent = function() { return (__value - __start)/(__stop - __start); }
	
	static step = function()
		{
		__value += __stepAmt;
		if (__stepAmt > 0 && __value >= __stop) || (__stepAmt < 0 && __value <= __stop)
			{
			__active = false;
			}
		}
	
	static active = function() { return __active; }
	
	static restart = function()
		{
		__value = __start;
		__active = true;
		}
	
	}