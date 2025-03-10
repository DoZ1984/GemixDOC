Program test_fxmode;
GLOBAL
	ball,cuad;
	struct texts[11]
		string text;
	end = "Src", "Dst", "Src Over Dst", "Dst Over Src", "Src In Dst", "Dst In Src",
		"Src Out Dst", "Dst Out Src", "Src Atop Dst", "Dst Atop Src", "Src Clear Dst", "Src Xor Dst";
begin
	set_mode(600, 200, 32);

	ball=load_map("ball.map");
	cuad=load_map("cuadrado.map");

	graph=new_map(600,200,0,true);

	screen_set_color(128, 128, 128);

	from fxmode=fx_src to fx_srcxordst;
		MAP_XXPUT(0,graph,ball,x,y,0,100,100,0,0,0,0,255,fx_src);
		MAP_XXPUT(0,graph,cuad,x,y,0,100,100,0,0,0,0,255,fxmode);
		write(0, x, y + 80, 0, texts[fxmode - 1].text);
		x += 100;
		if (x => 600)
			x = 0;
			y += 100;
		end
	end
	x = 300;
	y = 100;
	fxmode = 0;

	while (!key(_esc))
		frame;
	end
end