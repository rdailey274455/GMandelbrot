room_width = get_integer("Render width (px)? ", 512);
room_height = get_integer("Render height (px)? ", 512);
window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);

help_message = 
	"  H - help (currently viewing)\n" +
	"  C - calculate image\n" +
	"  S - export image\n" +
	"  Q - increment iteration count\n" +
	"  A - decrement iteration count\n" +
	"  E - calculate point at manually specified coordinate\n" +
	"  G - lookup calculated value in grid\n" +
	"RMB - retrieve coordinate and hue under mouse cursor\n" +
	"LMB - drag new view rectangle (+Shift to force square)\n" +
	"  I - shrink view rectangle\n" +
	"  O - expand view rectangle\n" +
	"  R - reset view rectangle\n" +
	"  W - get info about view rectangle\n" +
	"  X - clear messages";

help = function()
	{
	////show_debug_message(help_message);
	//show_message(help_message);
	Message(help_message);
	//var hm = Message(help_message);
	// hm.x = 99;  // arbitrary scoot over
	}

help();

calcWidth = 2;
while (calcWidth < room_width) { calcWidth *= 2; show_debug_message("calcWidth = " + string(calcWidth)); }
calcHeight= 2;
while (calcHeight < room_height) { calcHeight *= 2; }
calcGrid = ds_grid_create(calcWidth, calcHeight);
ds_grid_clear(calcGrid, [undefined, 0]);
maxIters = 28;
renderSurf = surface_create(calcWidth, calcHeight);
renderSurf_regenerationDue = false;

rectSelect_init = new Rectangle(0, 0, room_width, room_height);  // screen/room pixels, not complex plane coords nor grid coords nor surface coords
rectSelect = RectangleCopy(rectSelect_init);
rectSelect_isFresh = true;
rectRun_init = new Rectangle(-2.0, 1.5, 1.0, -1.5);
rectRun = RectangleCopy(rectRun_init);

time_start = -1;
time_finish = -1;

colors_bounded = array_create(10);
for (var ib = 0; ib < array_length(colors_bounded); ++ib)
	{
	colors_bounded[ib] = make_colour_hsv(255*(ib/array_length(colors_bounded)), 150, 50);
	}

colors_unbounded = undefined;
generate_unbounded_color_array = function()
	{
	colors_unbounded = array_create(maxIters);
	for (var iu = 0; iu < array_length(colors_unbounded); ++iu)
		{
		colors_unbounded[iu] = make_colour_hsv((255*(iu/array_length(colors_unbounded))), 200, 200);
		}
	}
generate_unbounded_color_array();

calculate = function()
	{
	// Message("Starting calculation!");  //show_message("Starting calculation!");
	time_start = current_time;
	rectRun.assign(rectSelect_init.mapPointToOther(rectSelect.p1(), rectRun), rectSelect_init.mapPointToOther(rectSelect.p2(), rectRun));
	delete rectSelect;
	rectSelect = RectangleCopy(rectSelect_init);
	rectSelect_isFresh = true;
	ds_grid_clear(calcGrid, -1);
	var rrx = new RadRange(rectRun.p1().x, rectRun.p2().x, calcWidth);
	var rry = new RadRange(rectRun.p1().y, rectRun.p2().y, calcHeight);
	var m = undefined;
	var c = new ComplexNum(0.0, 0.0);
	//var pxlCol = undefined;
	for (var calcY = 0; calcY < calcHeight; ++calcY)
		{
		if (!rry.active()) { break; }
		for (var calcX = 0; calcX < calcWidth; ++calcX)
			{
			if (!rrx.active()) { break; }
			c.assign(rrx.currentValue(), rry.currentValue());
			m = mandelbrot(c, maxIters);
			//if (m[0] == "bounded") { pxlCol = colors_bounded[floor(frac(abs(m[1]))*10)]; }
			//else if (is_nan(m[0]) || is_undefined(m[0]) || is_infinity(m[0])) { pxlCol = colors_unbounded[m[1]]; }
			//else { pxlCol = c_black; }
			ds_grid_set(calcGrid, calcX, calcY, m);
			rrx.step();
			}
		show_debug_message("Line " + string(calcY) + " complete");
		rrx.restart();
		rry.step();
		}
	delete rrx;
	delete rry;
	delete c;
	time_finish = current_time;
	//show_message("Finished calculation!\nResolution (px): " + string(calcWidth) + " by " + string(calcHeight) +
		//"\nElapsed time: " + string_format((time_finish - time_start)/1000, 2, 6) + " seconds");
	var finM = Message("Finished calculation!\nResolution (px): " + string(calcWidth) + " by " + string(calcHeight) +
		"\nElapsed time: " + string_format((time_finish - time_start)/1000, 2, 6) + " seconds");
	finM.lifeTime_full += (time_finish - time_start)/1000;  // don't count calculation time in message decay
	finM.lifeTime = finM.lifeTime_full;
	renderSurf_regenerationDue = true;
	}