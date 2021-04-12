var myRect = new Rectangle(x, y, x + mWidth, y + mHeight);
var theirRect = new Rectangle(0, 0, 0, 0);
with (obj_message)  // all others
	{
	theirRect.assign({x: x, y: y}, {x: x + mWidth, y: y + mHeight});
	if (myRect.overlaps(theirRect))
		{
		if (other.creationTime < creationTime)  // other (who owns myRect) is older
			{
			other.y += 2;  // += mHeight*(5/4);  // extension/gap so overlap isn't true twice
			}
		}
	}
delete myRect;
delete theirRect;
lifeTime -= 1/game_get_speed(gamespeed_fps);  //delta_time / 1000000;
if (lifeTime <= 0 || keyboard_check_pressed(killKey)) { instance_destroy(); }