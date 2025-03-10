program mask;

private
	int id_img_bg;
	int id_img_mask;

begin
	set_mode(480, 360, 32);

	id_img_bg = load_image("bg.png");
	id_img_mask = load_image("mask.png");
	set_map_center(0, id_img_mask, 0, 0);
	graph = new_map(get_map_width(0, id_img_mask), get_map_height(0, id_img_mask), 0, 0, 0, 1);

	set_screen_color(rgb(200, 200, 200));

	map_put_tile(0, graph, id_img_bg, 0, 0);
	map_xxput(0, graph, id_img_mask, 0, 0, 0, 100, 100, 0, 0, 0, 0, 255, fx_dstinsrc);

	loop
		frame;
	end
end