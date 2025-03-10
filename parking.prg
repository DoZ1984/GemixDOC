//**************************************
// ZONA EXTERIOR (pr14)
//**************************************

PROCESS ext();

PRIVATE

	cont; // contador para el efecto lluvia
	cont2; // contador para los rayos

BEGIN

	delete_text(all_text);
	
	z=100; 

	scroll_start(0,fpg1,749,0,0,0);
	
	volviendo_minijuego=0;
	
	loc=4;
	haycoche=0;
	haycoche2=0;
	est_taxi=0;
	pr11=prota();
	pr35=indy();
	wall();
	farola(753,0,380,130);
	farola(753,0,600,130);
	farola(753,0,820,130);
	farola(752,-90000,190,20);
	farola(752,-90000,190,332);
	darkstreet();
	big_car(699,199,0,409,95);
	big_car(522,201,0,411,95);
	big_car(434,201,0,412,95);
	traffic();
	guardia();
	brillo_ext();
	s_taxi(191,130);
	
	fade(brillo,brillo,brillo,4);
	IF (audio==0) fxlluvia=sound_play(snd8,fxv-30,256); END
	IF (transicion!=2) transicion=0; END
	
	LOOP
	
		IF (audio==0 AND !soundchannel_is_playing(fxlluvia))
			pr21=rayo(); fxlluvia=sound_play(snd8,fxv,256);		
		END
		
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		rain(0); rain(0); rain(0); rain(0); rain(0);
		
		IF (rand(0,400)>399 AND transicion==0) pr21=rayo(); END // RELÁMPAGOS
		
		// ATROPELLADO
		
		IF (atropellado==2)
			delete_text(all_text);
			write(fnt2,160,100,4,"HAS SIDO ATROPELLADO!");
			write(fnt3,160,140,4,"PULSA ENTER PARA RENACER");
			IF (keydown(_ENTER)) atropellado=0; muerto=0; delete_text(all_text); END
		END

		FRAME;
		
	END
	
END

//**************************************
// INDIANA JONES
//**************************************

PROCESS indy();

PRIVATE

	dist;
	hayboca; // para saber si hay bocadillo

BEGIN

	graph=125;
	z=1;
	ctype=c_scroll;
	x=368; y=170;
	
	LOOP
	
		graph=125;
		z=1;
	
		dist=fget_dist(x,y,pr11.x,pr11.y);
		
		IF (dist<40)
			IF (hayboca==0) hayboca=1; pr28=bocadillo(); END
			IF (keydown(_ENTER) AND t_ENTER==0)
				x_pr=pr11.x; y_pr=pr11.y; angle_pr=pr11.angle;
				t_ENTER=1; signal(pr14,s_freeze_tree); signal(pr28,s_kill);
				stop_sound(all_sound); est_c=2513; vent_conv();
			END
		ELSE IF (hayboca==1) signal(pr28,s_kill); hayboca=0; END
		END
	
		FRAME; 
		
	END
	
END
//**************************************
// BRILLO DEL CARTEL (EXTERIOR)
//**************************************

PROCESS brillo_ext();

PRIVATE

	duracion;

BEGIN

	graph=152;
	z=-101;
	ctype=c_scroll;
	x=840; y=300;
	angle=100000;
	
	LOOP
	
		duracion++;
	
		IF (duracion==12) visible=0; END
		IF (duracion==20) visible=1; END
		IF (duracion==30) visible=0; END
		IF (duracion==36) visible=1; duracion=0; END
	
		FRAME;
		
	END
	
END

//**************************************
// RAYO (pr21)
//**************************************

PROCESS rayo();

PRIVATE

	cont;

BEGIN

	graph=756;
	flags=4;
	z=-300;
	x=160; y=120;
	
	IF (audio==0 AND loc==4) sound_play(snd9,fxv+30,256); END
	
	LOOP
	
		IF (cont==4) flags=0; END
		IF (cont==8) flags=4; END
		IF (cont==12) BREAK; END
		cont++;
	
		FRAME;
		
	END
	
END

//**************************************
// MURO DE LADRILLOS
//**************************************

PROCESS wall();

BEGIN

	graph=754;
	ctype=c_scroll;
	x=600; y=90;
	z=0;
	
	LOOP
	
		IF (pr11.y>90) z=0; ELSE z=-1; END
	
		FRAME;
		
	END
	
END

//**************************************
// FAROLA
//**************************************

PROCESS farola(graph,angle,x,y);

BEGIN

	ctype=c_scroll;
	z=-60;

	LOOP
	
		FRAME;
		
	END
	
END	

//**************************************
// CARTEL TAXI Signal Taxi
//**************************************

PROCESS s_taxi(x,y);

BEGIN

	graph=414;
	z=-10;
	ctype=c_scroll;
	
	palo_cartel();
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// PALO CARTEL TAXI 
//**************************************

PROCESS palo_cartel();

BEGIN

	graph=415;
	ctype=c_scroll;
	
	x=father.x;
	y=father.y+11;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// EFECTO LLUVIA
//**************************************

PROCESS rain(rain_s);

PRIVATE

	cont;
	fin;

BEGIN

	graph=995;
	z=-250;
	flags=4;
	angle=-45000;
	IF (rain_s==0) 
		ctype=c_scroll; x=rand(0,900); y=rand(-20,300);
	ELSE
		ctype=c_screen; x=rand(0,330); y=rand(-20,180); size=-50;
	END
	
	LOOP
	
		IF (fin==0) y+=15; x-=15; END
		
		IF (y>rand(0,350)) 
			IF (rand(1,100)>95) fin=1; END
		END

		IF (fin==1) cont++; angle=rand(-10000,10000);
			IF (cont==1) graph=996; END
			IF (cont==3) graph=997; END
			IF (cont==6) BREAK; END
		END
		
		IF (y>360) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// SOMBRA CALLEJÓN
//**************************************

PROCESS darkstreet();

BEGIN

	graph=755; 
	ctype=c_scroll;
	z=-50;
	x=595; y=15;
	
	LOOP
	
		FRAME;
	
	END
	
END

//**************************************
// COCHE GRANDE
//**************************************

PROCESS big_car(x,y,flags,graph,size);

PRIVATE

	dist;
	llamoboca; // llamada al bocadillo

BEGIN

	ctype=c_scroll;
	
	LOOP
	
		IF (graph==409)
			dist=fget_dist(x,y,pr11.x,pr11.y); 
			IF (dist<70)
				IF (llamoboca==0) pr28=bocadillo(); llamoboca=1; END
				IF (keydown(_ENTER) AND t_ENTER==0)
					t_ENTER=1; signal(pr14,s_freeze_tree); stop_sound(all_sound); signal(pr28,s_kill);
					IF (sefijaenelcoche<2) // si el coche no tiene la capota salta un mensaje
						est_c=13; 
					ELSE
						est_c=13;
					END 
					vent_conv();
				END
			ELSE IF (llamoboca==1) signal(pr28,s_kill); llamoboca=0; END
			END
			IF (sefijaenelcoche==2) graph=410; END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// TRÁFICO DE COCHES
//**************************************

PROCESS traffic();

PRIVATE

	cont; cont2;

BEGIN


	LOOP
	
		// coche para arriba
		IF (est_taxi==0) // Siempre que no se esté llamando al taxi iniciamos el tráfico
			IF (haycoche2==0)
				IF (rand(0,500)>496) traffic_car(80,500,0); haycoche2=1; cont2=1; END
			END
		END
		// si se está llamando esperamos que no haya ningún coche y entonces damos paso al taxi
		IF (est_taxi==100)
			IF (haycoche2==0) cont_taxi=0; est_taxi=1; llama_taxi(); END
		END
		
		// coche para abajo
		IF (haycoche==0)
			IF (rand(0,500)>496) traffic_car(-23,-500,2); haycoche=1; cont=1; END
		END			
		
		FRAME;
		
	END
	
END

//**************************************
// COCHES DEL TRÁFICO
//**************************************

PROCESS traffic_car(x,y,flags);

PRIVATE

	dist;
	sonido;
	
BEGIN

	ctype=c_scroll;
	graph=rand(410,412);
	size=95;
	z=-200;
	IF (flags==2) luz_coche(2); ELSE luz_coche(0); END
	
	LOOP
	
		IF (transicion==0) dist=fget_dist(x,0,pr11.x,0); END
	
		IF (collision(TYPE prota) AND atropellado==0) atropellado=1; END
	
		IF (flags==2) y+=20; 
			IF (y>500) signal(son,s_kill); haycoche=0; BREAK; END
			IF (audio==0 AND dist<220 AND sonido==0) sonido=sound_play(snd13,fxv,256); END
		ELSE y-=20; 
			IF (y<-400) signal(son,s_kill); haycoche2=0; BREAK; END
			IF (audio==0 AND dist<240 AND sonido==0) sonido=sound_play(snd13,fxv,256); END
		END
		
		
		
		FRAME;

	END

END

//**************************************
// LUZ DE COCHE
//**************************************

PROCESS luz_coche(flags);

BEGIN

	z=-199;
	ctype=c_scroll;
	graph=413;
	
	LOOP
	
		angle=father.angle;
	
		IF (flags==2) 
			x=father.x;
			y=father.y;
		ELSE
			x=father.x;
			y=father.y;
		END
	
		FRAME;
		
	END
	
END

//**************************************
// GUARDIA DE SEGURIDAD
//**************************************

PROCESS guardia();

PRIVATE

	dist;
	hayboca; // para saber si hay bocadillo

BEGIN

	graph=399;
	ctype=c_scroll;
	
	x=790; y=265;
	
	angle=-90000;
	
	LOOP
		
		dist=fget_dist(x,y,pr11.x,pr11.y);
		
		IF (dist<30)
			IF (hayboca==0) hayboca=1; pr28=bocadillo(); END
			IF (keydown(_ENTER) AND t_ENTER==0)
				x_pr=pr11.x; y_pr=pr11.y; angle_pr=pr11.angle;
				t_ENTER=1; signal(pr14,s_freeze_tree); signal(pr28,s_kill);
				stop_sound(all_sound); est_c=0; vent_conv();
			END
		ELSE IF (hayboca==1) signal(pr28,s_kill); hayboca=0; END
		END
		
		FRAME;
		
	END
	
END