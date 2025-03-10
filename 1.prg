program test;

begin
	set_mode(320, 240, 32, mode_fullscreen, 0, 1, 0);
	set_fps(60,0);
	put_screen(0, load_image("muestra1.png"));
	graph = new_map(8, 8, rgb(255, 255, 255));
	efecto();
	visible = 0;
	loop
		x = mouse.x;
		y = mouse.y;
		frame;
	end
end


process efecto()
private
        mapa;
        mascara;
		ancho = 32;
		alto = 32;
		iluminado;
begin
        graph = mapa = new_map(ancho, alto, 0, 0, 0, 1); //aqui se pega el trozo de fondo
        mascara = load_image("mascara.png");
		iluminado = load_image("iluminado.png");
        set_map_center(0, mascara, 0, 0);
        fxmode = fx_additiveblend;
		fxintensity = 20;
		//fxcolor = rgba(255, 216, 0, 20);
		fxmode = fx_tint;
		
            loop
                    x = father.x + 4;
                    y = father.y + 4;
     
                    MAP_BLOCK_COPY(0, graph, 0, 0, iluminado, x, y, ancho, alto);	
					map_xxput(0, graph, mascara, 0, 0, 0, 100, 100, 0, 0, 0, 0, 255, fx_dstinsrc);  //la mascara se pega en el grafico que contiene al trozo de fondo
                   
                frame;
        end
end
		
		
		
		
		
		
		
		
		
		
		