program test_fnt_generator;

const
	text = "1!&#AaóîñÑç{}€¬~^[¡¿ºª";

private
	int fnt_id;
	int i;

begin
	set_mode(800, 600, 32);

	set_screen_color(128, 128, 128);

	y = 10;
	for (i = 0; i < 11; i++)
		fnt_id = load_fnt("test" + itoa(i + 1) + ".fnt");
		write(fnt_id, 400, y, 1, text);
		y += get_fnt_strheight(fnt_id, text) + 20;
	end

	repeat
		frame;
	until(key(_esc))
end
