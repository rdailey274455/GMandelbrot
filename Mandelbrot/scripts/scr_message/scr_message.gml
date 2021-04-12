function Message(_message)
	{
	var newMessage = instance_create_layer(0, 0, layer, obj_message);
	with (newMessage)
		{
		myMessage = _message;
		}
	return newMessage;
	}

function CustomMessage(_message, _time, _font, _col, _x, _y, _ha, _va, _sCol, _sAlpha, _sox, _soy)
	{
	var newMessage = Message(_message);
	with (newMessage)
		{
		lifeTime_full = _time;
		lifeTime = lifeTime_full;
		myFont = _font;
		myColor = _col;
		x = _x;
		y = _y;
		myHa = _ha;
		myVa = _va;
		shadow_color = _sCol;
		shadow_alpha = _sAlpha;
		shadow_offset = {x: _sox, y: _soy};
		killKey = vk_enter;
		}
	return newMessage;
	}