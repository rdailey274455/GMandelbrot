draw_set_alpha(1.0);
draw_set_color(c_white);
if (!surface_exists(renderSurf) || renderSurf_regenerationDue)
	{
	Message("Generating render surface!");
	time_start = current_time;
	renderSurf = surface_create(calcWidth, calcHeight);
	surface_set_target(renderSurf);
	var pxlCol = c_purple;
	var m = undefined;
	for (var rsx = 0; rsx < calcWidth; ++rsx)
		{
		for (var rsy = 0; rsy < calcHeight; ++rsy)
			{
			m = calcGrid[# rsx, rsy];  //ds_grid_get(calcGrid, rsx, rsy);
			if (m[0] == "bounded") { pxlCol = colors_bounded[floor(frac(abs(m[1]))*10)]; }
			else if (is_nan(m[0]) || is_undefined(m[0]) || is_infinity(m[0])) { pxlCol = colors_unbounded[m[1]]; }
			else { pxlCol = c_black; }
			draw_point_colour(rsx, rsy, pxlCol);
			}
		}
	surface_reset_target();
	time_finish = current_time;
	Message("Render surface generated in " + string_format((time_finish-time_start)/1000, 3, 12) + " seconds!");
	renderSurf_regenerationDue = false;
	}
draw_surface_stretched(renderSurf, 0, 0, room_width, room_height);

if (!rectSelect_isFresh)
	{
	draw_rectangle_colour(rectSelect.p1().x, rectSelect.p1().y, rectSelect.p2().x, rectSelect.p2().y, c_white, c_white, c_white, c_white, true);
	}