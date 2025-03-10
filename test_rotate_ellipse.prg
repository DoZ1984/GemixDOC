program test_rotate_ellipse;

private
	int ang;

begin
	// initialize
	set_mode(640, 480, 32);
	set_fps(60, 0);

	set_screen_color(rgb(230, 255, 128));
	clear_screen();
	put_line(0, 300, 640, 300, rgb(128, 200, 0));

	// load resources
	graph = load_image("ellipse.png");

	x = 320;
	y = 300;

	while (!key(_esc))
		if (key(_right))
			ang += 1000;
		elseif (key(_left))
			ang -= 1000;
		end
		angle = -(ang + 90000);
		set_map_center(0, graph, 50 + cos((float)ang) * 50, 25 + -sin((float)ang) * 25);
		frame;
	end
end