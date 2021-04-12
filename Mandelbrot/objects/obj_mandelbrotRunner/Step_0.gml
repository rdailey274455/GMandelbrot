if (keyboard_check_pressed(ord("H"))) { help(); }
if (keyboard_check_pressed(ord("Q")))
	{
	maxIters++;
	Message("Maximum iterations: " + string(maxIters));
	generate_unbounded_color_array();
	}
if (keyboard_check_pressed(ord("A")))
	{
	maxIters--;
	Message("Maximum iterations: " + string(maxIters));
	generate_unbounded_color_array();
	}
if (keyboard_check_pressed(ord("H"))) { help(); }
if (keyboard_check_pressed(ord("C"))) { Message("Beginning calculation!"); }
if (keyboard_check_released(ord("C"))) { calculate(); }
if (keyboard_check_pressed(ord("E")))
	{
	time_start = current_time;
	var a = real(get_string("a = ", "0.0"));
	var b = real(get_string("b = ", "0.0"));
	var iters = real(string_digits(get_string("iterations = ", "100")));
	var c = new ComplexNum(a, b);
	var m = mandelbrot(c, iters);
	delete c;
	time_finish = current_time;
	//show_message("mandelbrot() = [" + string(m[0]) + ", " + string_format(m[1], 8, 16) + "]");
	var eM = Message("mandelbrot() = [" + string(m[0]) + ", " + string_format(m[1], 8, 16) + "]");
	eM.lifeTime_full += (time_finish - time_start)/1000;  // don't count input time in message decay
	eM.lifeTime = eM.lifeTime_full;
	}
if (keyboard_check_pressed(ord("G")))
	{
	time_start = current_time;
	var gx = get_integer("x = ", 0);
	var gy = get_integer("y = ", 0);
	var m = calcGrid[# gx, gy];
	time_finish = current_time;
	var gM = Message(
		"calcGrid[#" + string(gx) + ", " + string(gy) + "][0] = " + string(m[0]) + "\n" +
		"calcGrid[#" + string(gx) + ", " + string(gy) + "][1] = " + string_format(m[1], 8, 16));
	gM.lifeTime_full += (time_finish - time_start)/1000;  // don't count input time in message decay
	gM.lifeTime = gM.lifeTime_full;
	}
if (mouse_check_button_pressed(mb_right))
	{
	var compPlanePt = rectSelect_init.mapPointToOther({x:mouse_x, y:mouse_y}, rectRun);
	//show_message(
	Message(
		"       x (real) = " + string_format(compPlanePt.x, 4, 16) + "\n" +
		"  y (imaginary) = " + string_format(compPlanePt.y, 4, 16) + "\n" +
		"            hue = " + string(colour_get_hue(surface_getpixel(renderSurf, mouse_x, mouse_y))));
	}
if (mouse_check_button_pressed(mb_left))
	{
	rectSelect_isFresh = false;
	rectSelect.assign({x: mouse_x, y: mouse_y}, rectSelect.p2());
	}
if (mouse_check_button(mb_left))
	{
	rectSelect.assign(rectSelect.p1(),
		(keyboard_check(vk_shift))?({x: mouse_x, y: rectSelect.p1().y + mouse_x - rectSelect.p1().x}):({x: mouse_x, y: mouse_y}));
	}
if (keyboard_check_pressed(ord("I")))
	{
	rectSelect_isFresh = false;
	rectSelect.scale_about_center(1/2);
	}
if (keyboard_check_pressed(ord("O")))
	{
	rectSelect_isFresh = false;
	rectSelect.scale_about_center(2);
	}
if (keyboard_check_pressed(ord("R")))
	{
	// dammit, more boilerplate... maybe?? yeah...
	delete rectSelect;
	rectSelect = RectangleCopy(rectSelect_init);
	rectSelect_isFresh = true;
	delete rectRun;
	rectRun = RectangleCopy(rectRun_init);
	}
if (keyboard_check_pressed(ord("W")))
	{
	//show_message(
	Message(
		"view p1 (plane coord) = " + coordToString(rectSelect.mapPointToOther(rectSelect.p1(), rectRun), 2, 14, ",\n") + "\n" +
		"view p2 (plane coord) = " + coordToString(rectSelect.mapPointToOther(rectSelect.p2(), rectRun), 2, 14, ",\n") + "\n" +
		"view p1 (room pixels) = " + coordToString(rectSelect.p1(), 4, 1, ",\n") + "\n" +
		"view p2 (room pixels) = " + coordToString(rectSelect.p2(), 4, 1, ",\n"));
	}
if (keyboard_check_pressed(ord("S")))
	{
	surface_save(renderSurf, string(date_current_datetime()) + ".png");
	}