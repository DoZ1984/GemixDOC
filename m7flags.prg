program m7_flags;
global
	solid=0;
	color=0;
	
begin
	mode_set(800,600,32,mode_window|mode_waitvsync);
	set_fps(60,0);
	fpg_load("m7flags.fpg");
	
	//creamos el modo 7 superior, que contendrá las partes transparentes...
	MODE7_START(0, 0, 1, 0, 0, 300);
	
	//creamos el modo 7 inferior, que será todo sólido
	MODE7_START(1, 0, 2, 2, 0, 300);

	m7[0].camera=id;
	m7[0].height=300;
	m7[0].flags=0;		//hace que no se dibuje también lo transparente
	
	m7[1].camera=id;
	m7[1].height=400;
	m7[1].z=274;      //el mode7 inferior se dibuja ante del superior
	
	write(0,400,550,1,"Pulsa CURSOR ARRIBA para acelerar e IZQUIERDA y DERECHA para girar");
	write(0,400,570,1,"Pulsa ESPACIO para activar/desactivar transparencia de modo 7 superior");
	write(0,400,580,1,&solid);
	write(0,400,590,1,&color);
	
	loop
		if(keydown(_space))
			while(keydown(_space))
				frame;
			end
			
			if(solid)
				solid=0;
				m7[0].flags=0;
			else
				solid=1;
				m7[0].flags=8;
			end
		end
	
		if(keydown(_up)) 	  advance(3);  end
		if(keydown(_left))  angle+=3000; end
		if(keydown(_right)) angle-=3000; end
		
		if(keydown(_c))
			while(keydown(_c))
				frame;
			end

			if(color)
				color=0;
				m7[0].color=0; // seteamos el color exterior del mode7 superior para que no se dibuje
			else
				color=1;
				m7[0].color=0x000000FF; // seteamos el color exterior del mode7 superior al color azul
			end
		end
		
		frame;
	end
end