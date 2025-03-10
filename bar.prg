PROCESS bar();

BEGIN
	
	loc=1;

	z=100;
	graph=100;
	x=160; y=120;

	delete_text(all_text);
	
	pr10=gramola();
	pr13=rayoluz();
	pr11=prota();
	arcade();
	barra();
	salida();
	salida_t();
	FROM pos_TAB=0 TO 245; taburete(pos_TAB+35,169,2); pos_TAB+=35; END
	taburete(20,39,0);
	mesa(77,150,100,0);
	mesa(78,260,90,0);
	estantes();
	bottles();
	silla(150,63,0);
	silla(113,99,90000);
	silla(222,90,90000);
	silla(298,90,-90000);
	escaleras();
	clientes();
	ruletaboy();
	tragaperras();
	
	fade(brillo,brillo,brillo,4);
	firsthumo=0; humo();
	
	vol=mem_vol;
	
	LOOP
	
		scroll.x0-=1;
	
		FRAME;
		
	END
	
END

//**************************************
// TRAGAPERRAS
//**************************************

PROCESS tragaperras();

PRIVATE

	cont;

BEGIN

	x=130; y=12;
	z=-2;
	size=130;
	
	LOOP
	
		cont++;
		
		IF (cont==3) graph=rand(501,504); cont=0; END
		
		FRAME;
		
	END
	
END

//**************************************
// GRAMOLA (pr10)
//**************************************

PROCESS gramola();

BEGIN

	graph=119;
	z=-2;
	x=82; y=9;
	
	LOOP

		FRAME;
		
	END

END

//**************************************
// ARCADE
//**************************************
PROCESS arcade();

PRIVATE

	cont;

BEGIN

	graph=11;
	
	x=30; y=15;
	
	z=-2;
	
	LOOP
	
		cont++;
	
		// ANIMACIÓN DE LA LUZ EN LA PANTALLA PRINCIPAL
		IF (cont=>rand(3,19)) graph=rand(11,13); cont=0; END
	
		FRAME;
		
	END
	
END

//**************************************
// ESCALERAS
//**************************************

PROCESS escaleras();

BEGIN

	graph=120;
	
	x=278; y=9;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// CLIENTES BAR
//**************************************

PROCESS clientes();

BEGIN

	graph=118;
	z=-11;
	x=124;
	y=167;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// BOY RULETA RUSA
//**************************************

PROCESS ruletaboy();

BEGIN

	graph=117;
	z=-11;
	x=231; y=91;
	
	LOOP
		
		FRAME;
		
	END
	
END

//**************************************
// BARRA
//**************************************

PROCESS barra();

BEGIN

	graph=10;
	
	z=-10;
	
	x=135; y=190;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// TABURETE
//**************************************

PROCESS taburete(x,y,flags);

BEGIN

	graph=16;
	
	z=-10;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// MESA
//**************************************

PROCESS mesa(graph,x,y,angle);

BEGIN
	
	z=-10;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// ESTANTES
//**************************************

PROCESS estantes();

BEGIN

	graph=17;
	
	z=-10;
	
	x=120; y=233;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// BOTELLAS
//**************************************

PROCESS bottles();

BEGIN

	graph=18;
	
	z=-10;
	
	x=115; y=235;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// SILLA
//**************************************

PROCESS silla(x,y,angle);

BEGIN

	graph=15; 
	
	z=-10;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// EXIT
//**************************************

PROCESS salida();

BEGIN
	
	graph=19;
	
	x=10; y=120;
	
	z=-15;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// EXIT 2
//**************************************

PROCESS salida_t();

BEGIN

	graph=20;
	
	x=16; y=120;
	
	z=0;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// EXIT 3 (RAYO DE LUZ) (pr13)
//**************************************

PROCESS rayoluz();

BEGIN

	graph=121;
	
	x=4; y=120;
	
	z=-12;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// LAUNCHER GRAMOLA
//**************************************

PROCESS launcher_gramola();

PRIVATE

	cont;

BEGIN
	
	LOOP
		
		cont++;
		
		IF (cont==1) fade(0,0,0,2); END
		IF (cont==48) delete_text(all_text); signal(pr1,s_kill_tree); gramola_screen(); END
		
	
		FRAME;
		
	END
	
END

//**************************************
// GRAMOLA SCREEN
//**************************************

PROCESS gramola_screen();

PRIVATE

	fase;
	t_cancion; // texto canción actual
	t1; t2; t3; t4; t5;
	cont_e; // contador exit
	solo1;
	
BEGIN

	loc=100;
	graph=352;
	z=-1;
	x=160; y=120;
	fade(brillo,brillo,brillo,2); 
	screen();
	transicion=0;
	humo();
	
	LOOP
	
		IF (fase==0)
			txtmovil(356,130,219,29,1); // texto de canción
			txtmovil(354,146,335,141,2); // texto de pulsar ENTER o CURSORES
			txt(355,95,112);
			fase=1;
		END
		
		IF (keydown(_right) AND solo1==0 AND transicion==0 AND music==0) 
			solo1=1; play=10; music=0; cancion+=1;
		END
		IF (keydown(_left) AND solo1==0 AND transicion==0 AND music==0) 
			solo1=1; play=10; cancion-=1;
		END
		
		IF (play==10) // CAMBIO DE CANCIÓN
			IF (cancion==6) cancion=1; END
			IF (cancion==0) cancion=5; END
			stop_song();
			SWITCH (cancion)
				CASE 1: song_play(s1); END
				CASE 2: song_play(s2); END
				CASE 3: song_play(s3); END
				CASE 4: song_play(s4); END
				CASE 5: song_play(s5); END
			END
			us=cancion; play=11;
		END
		
		IF (keydown(_ENTER) AND solo1==0 AND transicion==0)
			solo1=1; 
			IF (music==1) music=2; play=1; songchannel_resume(0); END
			IF (music==0) music=1; songchannel_pause(0); END
			IF (music==2) music=0; END
		END
		
		IF (solo1==1 AND NOT keydown(_left) AND NOT keydown(_right) AND NOT keydown(_ENTER)) solo1=0; END
	
		// PULSAR ESCAPE PARA SALIR
		IF (keydown(_ESC) AND transicion==0) fade(0,0,0,2); transicion=1; cont_e=1;	END
	
		IF (cont_e>0) cont_e++; END
		
		IF (cont_e==48) signal(id,s_kill_tree); volviendo_minijuego=1; pr1=bar(); fade(brillo,brillo,brillo,2); END	
	
		FRAME;
		
	END
	
END

//**************************************
// PANTALLA IZQUIERDA DE LA GRAMOLA
//**************************************

PROCESS screen();

BEGIN

	graph=353;
	z=1;
	x=95; y=129;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// TEXTO 1 GRAMOLA
//**************************************

PROCESS txt(graph,x,y);

BEGIN
	
	LOOP
	
		FRAME;
		
	END

END

//**************************************
// TEXTO MOVIL GRAMOLA
//**************************************
	
PROCESS txtmovil(graph,y,x_ini,x_fin,vel_t);

PRIVATE

	cont;
	solo1;
	
BEGIN

	x=x_ini;
	
	LOOP
		
		cont++;
		
		IF (graph>355 AND graph<361) // si es un gráfico correspondiente al título de canción...
			SWITCH (cancion)
					CASE 1:
						graph=356;
						x_ini=230; x_fin=50;
					END
					CASE 2:
						graph=357;
						x_ini=225; x_fin=46;
					END
					CASE 3:
						graph=358;
						x_ini=270; x_fin=90;
					END
					CASE 4:
						graph=359;
						x_ini=260; x_fin=83;
					END
					CASE 5:
						graph=360;
						x_ini=182; x_fin=10;
					END
			END
			
			IF (keydown(_left) OR keydown(_right)) 
				IF (solo1==0 AND transicion==0) x=x_ini; solo1=1; END
			END
			IF (NOT keydown(_left) AND NOT keydown(_right)) solo1=0; END
			
		END
		
		IF (x>-x_fin) x-=vel_t; END
		IF (x==-x_fin) x=x_ini; END
		
		FRAME;
		
	END
	
END

//**************************************
// HUMO
//**************************************

PROCESS humo();

BEGIN

	flags=4;
	graph=999;
	z=-999;
	
	IF (firsthumo==0) firsthumo=1; x=200; END
	
	LOOP
	
		x-=1; 
		
		IF (x==-190) humo2(); END
		IF (x<-1500) BREAK; END

		
		FRAME;
		
	END
	
END

//**************************************
// HUMO LIGHT
//**************************************

PROCESS humo2();

BEGIN

	z=-999;
	y=150;
	x=1250;
	
	graph=998;
	flags=0;
	
	IF (firsthumo==0) firsthumo=1; x=200; END
	
	LOOP

		x-=1; 
		
		IF (x==-190) humo2(); END
		IF (x<-1500) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// WC
//**************************************

PROCESS wc();

BEGIN

	graph=450;
	x=160;
	y=120;
	
	LOOP
	
		FRAME;
		
	END
	
END