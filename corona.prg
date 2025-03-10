PROGRAM corona_runner;

/*
	BUGS:

	SIN BUGS DE MOMENTO ^^
	
*/

GLOBAL

	modo_pantalla;

	fnt1;			// FUENTE NORMAL
	fnt2;			// FUENTE NORMAL VERDE
	fnt3;			// FUENTE GRANDE
	fnt4;			// FUENTE +GRANDE
	fnt5;			// FUENTE NORMAL ROJA
	
	sng1;			// CANCIÓN INTRO
	sng2;
	sng3;
	sng4;
	sng5;
	sng7;			// CANCIÓN INTRO NOTICIAS
	sng8;			// CANCIÓN ESCENA HOSPITAL
	sngf;			// CANCIÓN FINAL
	
	conf_son;		// CONFIGURACIÓN DE SONIDO
	conf_mus;		// CONFIGURACIÓN DE MÚSICA
	volumen=80;		// VOLUMEN
	cancion;		// PARA SELECCIONAR LA CANCIÓN
	ult_cancion;	// LA ÚLTIMA CANCIÓN QUE HA SONADO
	
	fx1;			// NAVEGACIÓN MENÚ
	fx2;			// SELECCIÓN MENÚ
	fx3;			// PASOS CAMILLEROS
	fx4;			// CAÍDA
	fx5;			// REBOTE
	fx6;			// REBOTE 2
	fx7;			// VENTANA
	fx8;			// SUPERMAN
	fx9;			// VIENTO SUPERMAN
	fx10;			// AGARRE SUPERMAN
	fx11;			// GOLPE SUELO
	fx12;			// MOTOR ARRANCANDO
	fx13;			// SIRENA AMBULANCIA
	fx14;			// SONIDO VICTORIA
	fx15;			// GENTE CELEBRANDO
	fx16;			// GAME OVER
	fx17;			// CRASH
	fx18;			// CRASH 2 (TV)
	fx19;			// BONUS
	fx20;			// BONUS OUT
	fx21;			// IMPACTO
	fx22;			// SONIDO ATURDIDO
	fx23;			// VOZ VIDA EXTRA
	fx24;			// FX VIDA EXTRA
	fx25;			// FX PEATÓN MUERTE 1
	fx26; 			// FX PEATÓN MUERTE 2
	fx27;			// FX CRASH AMBULANCIA
	fx28;			// BEEP INVENCIBILIDAD
	fx29;			// CLAXON
	fx30;			// METRALLETA
	fx31;			// VOZ PERFECTO
	fx32;			// FX PERFECT
	
	archivo;		// ARCHIVO PARA LAS PUNTUACIONES
	struct punt[4] 	// ESTRUCTURA PARA EL RANK
	string name;
	points;
	end
	
	pr0;			// PROCESO FONDO (MAIN)
	pr1;			// PROCESO CAMILLA
	pr2;			// AMBULANCIA INTRO
	pr3;			// AMBULANCIA CARRETERA
	pr4;			// AMBULANCIA FINAL
	pr5;			// LUCES AMBULANCIA
	
	pos;			// PARA INDICAR LA POSICIÓN DE LA VENTANA QUE SE ABRE
	intro=1;		// INTRODUCCIÓN (0 = JUEGO CAMILLA / 1 = INTRO ACTIVADA / 2 = CARRETERA AMBULANCIA) / 3 = SECUENCIA FINAL DEL HOSPITAL
	salvando;		// PARA INDICAR SI SE ESTÁ SALVANDO A ALGUIEN
	fase;			// FASE DEL CAMILLERO
	menu_out;		// PARA SALIR DEL MENÚ
	bonus;			// VARIABLE PARA EL BONUS POR CERCANÍA
	vidas=3;		// VIDAS
	nivel=1;		// NIVEL ACTUAL
	score;			// PUNTUACIÓN
	score2;			// CONTADOR PARA EL BONUS DE 50K PUNTOS
	turbo_c=110;	// TURBO DE LA CAMILLA
	rescatados=0; 	// NÚMERO ACTUAL DE RESCATADOS
	objetivo=40;	// OBJETIVO DE RESCATADOS
	stage;			// INDICAMOS EN QUÉ TIPO DE PANTALLA NOS ENCONTRAMOS
	bonus_res;		// BONUS MULTIPLICADOR DE RESCATADOS
	aturdido;		// CAMILLA ATURDIDA
	obj_max;		// NÚMERO MÁXIMO DE OBJETOS A LA VEZ EN PANTALLA
	obj_pant;		// NÚMERO DE OBJETOS EN PANTALLA
	tam_det;		// TAMAÑO DEL DETECTOR PARA LOS OBJETOS DE LAS VENTANAS
	vidascore;		// PARA SABER SI HEMOS DADO YA LA VIDA POR PUNTUACIÓN
	perfect;		// PARA SABER SI SE HA HECHO UN PERFECT
	
	x_tipo;			// X DEL ÚLTIMO TIPO
	y_tipo;			// Y DEL ÚLTIMO TIPO
	frec_tipo;		// FRECUENCIA DE SALIDA 
	primer_tipo;	// PRIMER TIPO QUE SE TIRA
	haysuperman;	// PARA SABER SI YA HAY UN SUPERMAN Y NO LLAMAR A OTRO
	cont_superman;	// CONTADOR LÍMITE PARA QUE VUELVA A APARECER EL SUPERMAN
	multirescate;	// CONTADOR DEL MULTIPLICADOR DE RESCATES ENCADENADOS
	arranca_amb;	// PARA INDICAR QUE PODEMOS ARRANCAR LA AMBULANCIA EN EL FINAL DE LA 1ª FASE
	
	saliendo;		// PARA SABER QUE ESTAMOS SALIENDO
	menupausa;		// PARA SABER QUE ESTÁ EL MENÚ DE PAUSA
	gameover;		// GAME OVER
	ayuda_back;		// VOLVEMOS DE LA AYUDA
	
	final;			// PARA INDICAR QUE ES EL FINAL (xD)
	int_final;		// INTERRUPTOR PARA INTERACTUAR CON PROCESOS DEL FINAL
	
	// CARRETERA
	start;			// PARA INDICAR EL INICIO DE FASE
	km;				// KILÓMETROS RESTANTES
	vel;			// VELOCIDAD DEL SCROLL
	puntbonus;		// PUNTUACIÓN CORRESPONDIENTE DEL BONUS POR CERCANÍA
	multibonus;		// MULTIPLICADOR DE BONUS
	pajaros;		// LÍMITE DE PÁJAROS EN PANTALLA
	estrellado;		// CHOQUE DE LA AMBULANCIA
	invencible;		// INVENCIBILIDAD TEMPORAL TRAS CHOQUE
	amb_out;		// PARA INDICAR QUE LA AMBULANCIA YA NO ESTÁ EN LOS SCORES FINALES
	detector;		// PARA INDICAR SI LA AMBULANCIA DEBE COMPROBAR EL COLLISION
	premia;			// PARA INDICAR SI SE ESTÁ PREMIANDO
	ult_proces_bonus;
	
	// HOSPITAL
	yavale;			// PARA CALLAR LAS METRALLETAS
	fin_del_final;	// PARA INDICAR EN LA ÚLTIMA PANTALLA QUE SE VAYAN LOS TEXTOS
	
	// TEXTOS CARRETERA
	t1; t2; t3; t4; t5;
	
LOCAL

	tipo_ventana;	// PARA ESPECIFICAR SI SE TIRA UN TÍO O SE TIRA UN OBJETO
	
BEGIN

	MODE_SET(640,400,32,mode_window,filter_scale_NORMAL2x,filter_scanline_50percent);
	//MODE_SET(640,400,32,mode_window,filter_scale_noscale,filter_scanline_50percent);
	//MODE_SET(640,400,32,mode_fullscreen,filter_scale_NORMAL2x,filter_scanline_50percent);
	
	//set_fps(30,0);
	set_fps(60,0);
	fpg_load("files\coronaC.fpg","coronis84");

	window_set_title("Corona Crisis 1.0 - By Lonely Ant Studio 2020");
	
	fnt1=fnt_load("files\text.fnt");
	fnt2=fnt_load("files\text_green.fnt");
	fnt3=fnt_load("files\text_big.fnt");
	fnt4=fnt_load("files\text_big2.fnt");
	fnt5=fnt_load("files\text_red.fnt");
	
	sng1=song_load("files\songs\intro.mp3");
	sng2=song_load("files\songs\song1.mp3");
	sng3=song_load("files\songs\song2.mp3");
	sng4=song_load("files\songs\song3.mp3");
	sng5=song_load("files\songs\song4.mp3");
	sng7=song_load("files\songs\song_news.mp3");
	sng8=song_load("files\songs\win.mp3");
	sngf=song_load("files\songs\ending.mp3");
	
	fx1=sound_load("files\fx\menu-select0.mp3");
	fx2=sound_load("files\fx\menu-select1.mp3");
	fx3=sound_load("files\fx\paso.wav");
	fx4=sound_load("files\fx\caida.mp3");
	fx5=sound_load("files\fx\rebote.mp3");
	fx6=sound_load("files\fx\rebote2.mp3");
	fx7=sound_load("files\fx\ventana.mp3");
	fx8=sound_load("files\fx\superman.ogg");
	fx9=sound_load("files\fx\viento.mp3");
	fx10=sound_load("files\fx\agarre_superman.mp3");
	fx11=sound_load("files\fx\golpe_cuerpo.mp3");
	fx12=sound_load("files\fx\motor.mp3");
	fx13=sound_load("files\fx\sirena.mp3");
	fx14=sound_load("files\fx\victory.mp3");
	fx15=sound_load("files\fx\victory_gente.mp3");
	fx16=sound_load("files\fx\gameover.mp3");
	fx17=sound_load("files\fx\crash.mp3");
	fx18=sound_load("files\fx\crash2.mp3");
	fx19=sound_load("files\fx\bonus.mp3");
	fx20=sound_load("files\fx\bonus_off.mp3");
	fx21=sound_load("files\fx\impacto.mp3");
	fx22=sound_load("files\fx\aturdido.mp3");
	fx23=sound_load("files\fx\vidaextra.mp3");
	fx24=sound_load("files\fx\fxvida.mp3");
	fx25=sound_load("files\fx\peaton_death1.mp3");
	fx26=sound_load("files\fx\peaton_death2.mp3");
	fx27=sound_load("files\fx\car_crash.mp3");
	fx28=sound_load("files\fx\beep.mp3");
	fx29=sound_load("files\fx\claxon.mp3");
	fx30=sound_load("files\fx\gun.mp3");
	fx31=sound_load("files\fx\perfecto.mp3");
	fx32=sound_load("files\fx\perfect.mp3");
	
	introd();
	
	// LEEMOS EL FICHERO PARA LOS HIGHSCORES
	archivo = fopen("../files/scores.dat", "r");
	fread(&punt, sizeof(punt), archivo);
	fclose(archivo);
	
	key_disable_shortcut(_alt_x);
	key_disable_shortcut(_pause);
	
/* 	punt[0].name="DOZ"; punt[0].points=177400;
	punt[1].name="GMB"; punt[1].points=100000;
	punt[2].name="XMC"; punt[2].points=75000;
	punt[3].name="ALS"; punt[3].points=50000;
	punt[4].name="JAF"; punt[4].points=30000; */
	
	archivo = fopen("../files/scores.dat", "w");
	fwrite(&punt, sizeof(punt), archivo);
	fclose(archivo);
	
END

//***************************************************
// INTRO
//***************************************************
PROCESS introd();

PRIVATE

	cont;
	tope_p;
	
BEGIN
	
	x=320; y=200;
	size=200;
	
	menupausa=0;
	fade(0,0,0,40);
	
	IF (intro==0)
		IF (nivel<4)
			pr0=fondo();
		ELSE
			pantallafinal();
		END
		fade(100,100,100,0);
	END
	
	IF (intro==100) pantallafinal(); intro=0; fade(100,100,100,0); END
	
	LOOP
	
		IF (keydown(_F5) AND tope_p==0) tope_p=1;
			SWITCH (modo_pantalla)
				CASE 0: mode_set_filter(filter_scale_normal2x,filter_scanline_50percent); mode_change(mode_window); modo_pantalla=1; END
				CASE 1: mode_change(mode_fullscreen); modo_pantalla=2; END
				CASE 2: mode_change(mode_window); modo_pantalla=0; mode_set_filter(filter_scale_noscale,filter_scanline_50percent); END
			END
		END
		
		IF (tope_p==1 AND !keydown(_F5)) tope_p=0; END
		
		IF (intro==1)
			cont++;
			IF (cont==1) fade(0,0,0,0); 
				IF (conf_mus==0) song_play(sng1,0); songchannel_set_volume(0,100); END 
			END
			IF (cont==60) fade(100,100,100,0); graph=900;  END
			IF (cont==240) fade(0,0,0,0); END
			IF (cont==360) visible=0; fade(100,100,100,0); intro=0; menu_out=0; menu(); BREAK; END
		END
		
		IF (intro==2) cont++;
			IF (cont==50) fade(100,100,100,0); carretera(); intro=0; BREAK; END
		END
		
		IF (intro==3) cont++;
			IF (cont==50) final=1; secuencia_final(); intro=0; BREAK; END
		END
		
		IF (intro==0) BREAK; END
		
		FRAME;
		
	END

END

//***************************************************
// MAIN
//***************************************************
PROCESS main();

PRIVATE

	tope;
	tope_p;
	punt_bonus;
	comp_bonus; // COMPROBACIÓN DE BONÚS DE RESCATE
	cont; cont2; cont3; cont4;
	t1; t2; t3; t4;
	texto1; texto2;
	vida_dada; // PARA SABER SI YA HEMOS DADO LA VIDA Y NO REPETIRSE
	vida_dada2;
	vidatexto;
	haytexto;
	fueratexto;
	cifra1; cifra2;
	
BEGIN

	text_z=-1;
	cancion=0;
	ult_cancion=0;
	vida_dada=0; 
	vida_dada2=0;
	
	SWITCH (nivel)
		CASE 1: obj_max=2; tam_det=68; END
		CASE 2: obj_max=3; tam_det=56; END
		CASE 3: obj_max=4; tam_det=40; END
	END
	
	IF (conf_mus==0)
		IF (stage==1)
			cancion=rand(1,3);
			SWITCH (cancion)
				CASE 1: song_play(sng2,0); END
				CASE 2: song_play(sng3,0); END
				CASE 3: song_play(sng4,0); END
			END
			songchannel_set_volume(0,80); 
		END
		IF (stage==2) song_play(sng5,0); songchannel_set_volume(0,80); END
		IF (stage==3) song_play(sng8,0); songchannel_set_volume(0,80); END
	END

	LOOP
		
		IF (keydown(_F5) AND tope_p==0) tope_p=1;
			SWITCH (modo_pantalla)
				CASE 0: mode_set_filter(filter_scale_normal2x,filter_scanline_50percent); mode_change(mode_window); modo_pantalla=1; END
				CASE 1: mode_change(mode_fullscreen); modo_pantalla=2; END
				CASE 2: mode_change(mode_window); modo_pantalla=0; mode_set_filter(filter_scale_noscale,filter_scanline_50percent); END
			END
		END
		
		IF (tope_p==1 AND !keydown(_F5)) tope_p=0; END
		
		punt_bonus=bonus_res*100;
	
		IF (score<0) score=0; score2=0; END
	
		// MENSAJE DE BONUS DE RESCATES
		IF (comp_bonus!=bonus_res AND vidas>0 AND stage==1)
			IF (bonus_res==0 AND cont2==0 AND comp_bonus>1) // PERDEMOS EL BONUS
				IF (haytexto==1) 	
					delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); haytexto=0; fueratexto=1;
				END
				t1=write(fnt5,56,97,1,"¡BONUS");
				t2=write(fnt5,56,118,1,"PERDIDO!");
				text_lock(t1); text_lock(t2);
				text_set_z(t1,-60); text_set_z(t2,-60);
				IF (conf_son==0) sound_play(fx20,150,256); END
				cont2=1;
			END
			IF (bonus_res>1 AND vidas>0 AND stage==1) // SUMAMOS BONUS
				IF (haytexto==1) 	
					delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); haytexto=0; 
				END
				cifra1=bonus_res; cifra2=punt_bonus;
				t1=write(fnt2,43,97,0,"x");
				t2=write(fnt2,54,97,0,OFFSET cifra1);
				t3=write(fnt1,32,118,0,"+");
				t4=write(fnt1,43,118,0,OFFSET cifra2);
				text_lock(t1); text_lock(t2); text_lock(t3); text_lock(t4);
				text_set_z(t1,-60); text_set_z(t2,-60); text_set_z(t3,-60); text_set_z(t4,-60);
				score+=bonus_res*100-100; score2+=bonus_res*100-100; haytexto=1;
				IF (conf_son==0) sound_play(fx19,100,256); END
				cont=1;
			END
		END
		comp_bonus=bonus_res;
	
		// VIDA EXTRA POR 15 RESCATES CONSECUTIVOS
		IF (bonus_res==15 OR bonus_res==30)
			IF (vida_dada==0)
				IF (vidatexto==1) 	
					delete_text(texto1); delete_text(texto2); vidatexto=0; 
				END
				texto1=write(fnt2,565,60,0,"¡VIDA"); vidatexto=1;
				texto2=write(fnt2,563,80,0,"EXTRA!"); vidas++; cont3=1;
				text_lock(texto1); text_lock(texto2);
				text_set_z(texto1,-60); text_set_z(texto2,-60);
				IF (conf_son==0)
					sound_play(fx23,256,256); sound_play(fx24,190,256);
				END
				vida_dada=1;
			END
		END
		
		// VIDA EXTRA POR CADA 50K PUNTOS
		IF (score2=>50000 AND vidascore==0) score2-=50000; vidascore=1; END
		
		IF (vidascore==1)
			vidas++; vidascore=2; 
			IF (vidatexto==1) 	
					delete_text(texto1); delete_text(texto2); vidatexto=0; 
			END
			texto1=write(fnt2,565,60,0,"¡VIDA"); vidatexto=1;
			texto2=write(fnt2,563,80,0,"EXTRA!"); vidas++; cont3=1; vidas-=1;
			text_lock(texto1); text_lock(texto2);
			text_set_z(texto1,-60); text_set_z(texto2,-60);
			IF (conf_son==0)
				sound_play(fx23,256,256); sound_play(fx24,190,256);
			END
		END
	
		// VIDA EXTRA POR X5 BONUS
		IF (multibonus==5 OR multibonus==10 OR multibonus==15)
			IF (vida_dada2==0)
				IF (vidatexto==1) 	
					delete_text(texto1); delete_text(texto2); vidatexto=0; 
				END
				texto1=write(fnt2,565,60,0,"¡VIDA"); vidatexto=1;
				texto2=write(fnt2,563,80,0,"EXTRA!"); vidas++; cont4=1;
				text_lock(texto1); text_lock(texto2);
				text_set_z(texto1,-60); text_set_z(texto2,-60);
				IF (conf_son==0)
					sound_play(fx23,256,256); sound_play(fx24,190,256);
				END
				vida_dada2=1;
			END
		END
		
		IF (stage==1 AND fase==10) vida_dada=2; vida_dada2=2; END
		
		IF (vida_dada==1)
				IF (bonus_res==16 OR bonus_res==31 OR bonus_res==0) vida_dada=0; END
		END
		IF (vida_dada2==1)
			IF (multibonus==0 OR multibonus==6 OR multibonus==11 OR multibonus==16) vida_dada2=0; END
		END
	
		IF (cont>0) cont++;
			IF (fueratexto==1) cont=0; fueratexto=0; END
			IF (cont==90) delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); cont=0; haytexto=0; END
		END
		
		IF (cont2>0) cont2++;
			IF (fueratexto==1) cont2=0; fueratexto=0; END
			IF (cont2==90) delete_text(t1); delete_text(t2); cont2=0; END
		END
		
		IF (cont3>0) cont3++;
			IF (fueratexto==1) cont3=0; fueratexto=0; END
			IF (cont3==80) delete_text(texto1); delete_text(texto2); cont3=0; vidascore=0; END
		END
		
		IF (cont4>0) cont4++;
			IF (fueratexto==1) cont4=0; fueratexto=0; END
			IF (cont4==90) delete_text(texto1); delete_text(texto2); cont4=0; END
		END
		
		// MÚSICA DE FONDO
		IF (conf_mus==0)
			IF (!songchannel_is_playing(0)) 
				IF (stage==1) 
					WHILE (cancion==ult_cancion) cancion=rand(1,4); END
					ult_cancion=cancion;
				END
				IF (stage==2) cancion=4; END
				SWITCH (cancion)
					CASE 4: song_play(sng5,0); END
				END
				IF (stage==3) song_play(sng8,0); END
				songchannel_set_volume(0,80); 
			END
		END
	
	
		// ACTIVAR/DESACTIVAR SONIDO
		IF (keydown(_f7) AND tope==0) tope=1;
			IF (conf_son==0)
				sound_play(fx2,255,256); conf_son=1; soundchannel_stop(all_channel);
			ELSE
				sound_play(fx2,255,256); conf_son=0; 
			END
		END
	
		// ACTIVAR/DESACTIVAR MÚSICA
		IF (keydown(_f8) AND tope==0) tope=1; 
			IF (conf_mus==0) 
				IF (conf_son==0) sound_play(fx2,255,256); END
				volumen=0; songchannel_set_volume(0,volumen); conf_mus=1;
			ELSE
				IF (conf_son==0) sound_play(fx2,255,256); END
				volumen=80; conf_mus=0; songchannel_set_volume(0,volumen); 
			END
		END
		
		IF (tope==1 AND !keydown(_f8) AND !keydown(_f7) AND !keydown(_t)) tope=0; END
	
		FRAME;
		
	END
	
END

//***************************************************
// MENÚ
//***************************************************
PROCESS menu();

PRIVATE

	tope_p;

BEGIN

	graph=100;
	x=320; y=200;
	size=200;
	title();
	options();
	pr2=ambulancia_intro();
	
	write(0,320,372,1,"COPYRIGHT - LONELY ANT STUDIO - 2020");
	
	LOOP
	
		IF (keydown(_F5) AND tope_p==0) tope_p=1;
			SWITCH (modo_pantalla)
				CASE 0: mode_set_filter(filter_scale_normal2x,filter_scanline_50percent); mode_change(mode_window); modo_pantalla=1; END
				CASE 1: mode_change(mode_fullscreen); modo_pantalla=2; END
				CASE 2: mode_change(mode_window); modo_pantalla=0; mode_set_filter(filter_scale_noscale,filter_scanline_50percent); END
			END
		END
		
		IF (tope_p==1 AND !keydown(_F5)) tope_p=0; END
	
		IF (rand(1,100)<2) tipo_intro(); END
		IF (menu_out==1) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// AMBULANCIA INTRO
//***************************************************
PROCESS ambulancia_intro();

PRIVATE

	cont;

BEGIN

	graph=50;
	size=200;
	x=-50;
	y=370;
	z=-5;
	
	LOOP
		
		cont++;
		
		IF (cont>600) x+=3; END
		
		IF (x>690) cont=0; x=-50; END
	
		IF (menu_out==1) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// TIPO INTRO
//***************************************************
PROCESS tipo_intro();

PRIVATE

	cont;
	cont2;
	float velo=2;
	suelo;
	
BEGIN

	graph=57;
	x=rand(40,600); y=-30;
	size=200;
	flags=rand(0,1);
	suelo=rand(354,390);
	
	LOOP
	
		cont++;
		
		IF (y<suelo) //rastro(x,y);
			IF (cont==4) graph++; velo+=0.2; cont=0; END
			IF (graph>59) graph=57; END
			y+=velo;
		END
		
		IF (graph<64)
			IF (y=>suelo) cont2++; END
			IF (cont2==1) graph=61; END
			IF (cont2==32) graph++; cont2=2; END
		END		
		
		IF (y>366)
			IF (collision(TYPE ambulancia_intro)) x=pr2.x+rand(30,35); graph=61; END
		END
		
		IF (x>690 OR menu_out==1) BREAK; END

		FRAME;
		
	END
	
END
	
//***************************************************
// TITLE
//***************************************************
PROCESS title();

BEGIN

	graph=902;
	z=-10;
	x=320; y=80;
	
	LOOP
	
		IF (menu_out==1) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// OPTIONS
//***************************************************
PROCESS options();

PRIVATE

	opt=1;
	tope;
	trans;		// TRANSICIÓN DE SALIR O JUGAR
	cont;
	bajada_volumen=100;
	
BEGIN

	graph=903;
	x=320; y=230;
	z=-10;
	
	LOOP
	
		cont++;
	
		IF (tope==0 AND trans==0)
			IF (keydown(_up)) opt--; tope=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			IF (keydown(_down)) opt++; tope=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
		END
		
		IF (tope==1 AND !keydown(_up) AND !keydown(_down) AND !keydown(_enter)) tope=0; END
	
		IF (opt<1) opt=3; END
		IF (opt>3) opt=1; END
	
		SWITCH (opt)
			CASE 1: graph=903;
				IF (keydown(_enter) AND tope==0 AND trans==0) tope=1; trans=1; cont=0; fade(0,0,0,0); 
					IF (conf_son==0) sound_play(fx2,255,256); END
				END
			END
			CASE 2: graph=904; 
				IF (keydown(_enter) AND tope==0 AND trans==0) trans=3; tope=1;  cont=0; fade(0,0,0,2);
					IF (conf_son==0) sound_play(fx2,255,256); END
				END
			END
			CASE 3: graph=905; 
				IF (keydown(_enter) AND tope==0 AND trans==0) tope=1; trans=2; cont=0; fade(0,0,0,0); 
					IF (conf_son==0) sound_play(fx2,255,256); END
				END
			END
		END
	
		SWITCH (trans)
			CASE 1:
				bajada_volumen-=3;
				IF (conf_mus==0) songchannel_set_volume(0,bajada_volumen); END
				IF (cont==120) 
					delete_text(all_text); fade(100,100,100,0); history();
					menu_out=1; BREAK; END
			END
			CASE 2:
				bajada_volumen-=2;
				IF (conf_mus==0) songchannel_set_volume(0,bajada_volumen); END
				IF (cont==120)  exit("",0); END
			END
			CASE 3:
				IF (cont==50) menu_out=1; delete_text(all_text); highmenu(); BREAK; END
			END
		END
		
		IF (conf_mus==0)
			IF (!songchannel_is_playing(0)) song_play(sng1,0); END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// HISTORIA
//***************************************************
PROCESS history();

PRIVATE

	cont;
	cont2;
	saltar;
	bajada_volumen=100;
	
BEGIN

	graph=800;
	x=320; y=200;
	IF (conf_mus==0) song_play(sng7,0); END
	songchannel_set_volume(0,100);
	
	LOOP
	
		cont++;
		cont2++;
		
		IF (cont==20 AND cont2<1280) graph++; cont=0; END
		IF (graph>801) graph=800; END
		
		IF (cont2==20) texto(802); END
		IF (cont2==400) texto(803); END
		IF (cont2==860) texto(804); END
		IF (cont2=>1280) graph=800; END
		IF (cont2==1400) fade(0,0,0,0); END
		IF (cont2>1400) 
			IF (conf_mus==0) bajada_volumen-=3; songchannel_set_volume(0,bajada_volumen); END
		END
		IF (cont2==1560) fade(100,100,100,0); pr0=fondo(); BREAK; END
		
		IF (keydown(_esc) AND saltar==0) saltar=1; END
		
		IF (saltar>0) saltar++; bajada_volumen-=3; 
			IF (conf_mus==0) songchannel_set_volume(0,bajada_volumen); END
			IF (saltar==2) fade(0,0,0,0); END
			IF (saltar==162) fade(100,100,100,0); signal(son,s_kill); pr0=fondo(); BREAK; END
		END
		
		FRAME;
	
	END
	
END

//***************************************************
// TEXTO HISTORIA
//***************************************************
PROCESS texto(graph);

PRIVATE

	cont;
	cont_t;
	cont_t2;
	t1;
	tope;
	
BEGIN

	x=320; y=325;
	
	LOOP
	
		cont++;
		
		SWITCH (graph)
			CASE 802: IF (cont==340) BREAK; END END
			CASE 803: IF (cont==420) BREAK; END END
			CASE 804: IF (cont==420) BREAK; END END
		END

		IF (scan_code!=0 AND tope==0 AND !keydown(_esc)) tope=1; END
		
		IF (tope==1) cont_t++;
			IF (cont_t==40) t1=write(fnt1,330,5,1,"PULSA ESCAPE PARA SALTAR"); END
			IF (cont_t==80) delete_text(t1); cont_t=0; cont_t2++; END
			IF (cont_t2==4) tope=0; cont_t2=0; END
		END
		
		IF (keydown(_esc)) delete_text(all_text); BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// FONDO
//***************************************************
PROCESS fondo();

PRIVATE
	
	tope;
	tx1; tx2; tx3; tx4; tx5; tx6; tx7; tx8; tx9; tx10;
	aparicion;
	cont; cont2; cont3; cont_terr; cont_ini;
	bajada_volumen=80;
	
BEGIN

	delete_text(all_text);
	fase=0;
	stage=1;
	perfect=0;
	turbo_c=110;
	salvando=0;
	gameover=0;
	menupausa=0;
	cont_superman=0;
	primer_tipo=0;
	bonus_res=0;
	
	main();
	ambulancia();
	pr1=camilla();

	set_fps(60,0);
	graph=100;
	size=200;
	x=320;
	y=200;
	text_z=-100;
	
	tx1=write(fnt1,15,5,0,"MARCADOR");
	tx2=write(fnt1,55,25,1,OFFSET score);
	tx3=write(fnt1,560,5,0,"NIVEL:");
	tx4=write(fnt1,617,5,0,OFFSET nivel);
	tx5=write(fnt1,557,30,0,"VIDAS:");
	tx6=write(fnt1,617,30,0,OFFSET vidas);		
	tx7=write(fnt1,16,50,0,"RESCATES");
	tx8=write(fnt1,40,70,1,OFFSET rescatados);
	tx9=write(fnt1,50,70,0,"/40");

	text_lock(tx1); text_lock(tx2); text_lock(tx3); text_lock(tx4); text_lock(tx5); text_lock(tx6); text_lock(tx7); text_lock(tx8); text_lock(tx9);   
	text_set_z(tx1,-1); text_set_z(tx2,-1); text_set_z(tx3,-1); text_set_z(tx4,-1); text_set_z(tx5,-1); 
	text_set_z(tx6,-1); text_set_z(tx7,-1); text_set_z(tx8,-1); text_set_z(tx10,-1);
	
	LOOP	
		
		cont_ini++;
		
		// LLAMAMOS AL MENÚ EN PARTIDA
		IF (keydown(_esc) AND tope==0 AND fase>2 AND saliendo==0 AND fase!=10) tope=1; pausa(); 
			IF (conf_son==0) sound_play(fx2,255,256); END
		END
	
		cont++;
		
		// FRECUENCIA DE APARICIÓN DE TIPOS SEGÚN NIVEL
		IF (aparicion==0) 
			SWITCH (nivel)
				CASE 1: frec_tipo=rand(90,130); END
				CASE 2: frec_tipo=rand(80,110); END
				CASE 3: frec_tipo=rand(70,90); END
			END
			aparicion=1;
		END
		
		IF (cont==frec_tipo AND gameover<1 AND fase!=10 AND fase>0 AND menupausa==0) ventana(0); cont=0; aparicion=0; END
	
		// APARICIÓN DE OBJETOS
		IF (rand(1,260)<3 AND gameover<1 AND fase!=10 AND fase>2 AND menupausa==0) ventana(1); END
	
		// APARICIÓN MANUAL (TECLA Z)
		IF (keydown(_z) AND tope==0) ventana(1); tope=1; END
		IF (tope==1 AND !keydown(_esc) AND !keydown(_z)) tope=0; END
	
		// CONTADOR PARA QUE NO APAREZCA SUPERMAN SEGUIDO
		IF (cont_superman>0) cont_superman++; END
		IF (cont_superman==850) cont_superman=0; END
	
		// SI SE CUMPLE EL OBJETIVO, PASAMOS A FASE 10
		IF (rescatados==objetivo) fase=10; END
	
		IF (fase==10) cont2++;
			IF (cont2==1) write(fnt4,320,115,1,"FASE SUPERADA");
				write(fnt3,320,177,1,"¡PARA EL HOSPITAL!");
				IF (conf_son==0)
					sound_play(fx14,200,256); sound_play(fx15,230,256);
				END
			END
			IF (perfect==0 AND cont2==90) 
				write(fnt3,320,221,1,"¡PERFECT!");
				write(fnt2,320,255,1,"+5.000 PUNTOS");
				score+=5000; score2+=5000;
				IF (conf_son==0)
					sound_play(fx32,140,256); 
				END
			END
			IF (perfect==0 AND cont2==110 AND conf_son==0) sound_play(fx31,256,256); END
				
			IF (arranca_amb==1 AND cont3==0) cont3=1; END
			IF (cont3>0) cont3++;
				IF (cont3>230)
					IF (conf_mus==0)
						bajada_volumen-=1; songchannel_set_volume(0,bajada_volumen);
					END
				END
			END
			IF (cont3==320) let_me_alone(); delete_text(all_text); intro=2; introd(); BREAK; END
		END
		
		IF (keydown(_o)) rescatados++; END
		
		FRAME;
		
	END
	
END

//***************************************************
// MENÚ DE PAUSA -IN GAME-
//***************************************************
PROCESS pausa();

PRIVATE

	t0; t1; t2; t3;
	tope=1;
	tope_t=2;
	sel;
	cont;
	bajada_volumen=80;
	
BEGIN	

	fade(100,100,100,50);
	signal(all_process,s_freeze); 
	songchannel_pause(all_channel);
	soundchannel_pause(all_channel);
	
	menupausa=1;
	
	sel=1;
	text_z=-200;
	
	t0=write(fnt3,320,40,1,"-PANDEMIA PAUSADA-");
	fondo_pausa();
	
	LOOP
	
		IF (keydown(_up) AND tope==0 AND saliendo==0) sel--; tope=1; tope_t=1; 
			IF (conf_son==0) sound_play(fx1,200,256); END
		END
		IF (keydown(_down) AND tope==0 AND saliendo==0) sel++; tope=1; tope_t=1; 
			IF (conf_son==0) sound_play(fx1,200,256); END
		END
		
		IF (tope==1 AND !keydown(_up) AND !keydown(_down) AND !keydown(_esc) AND !keydown(_enter)) tope=0; END
		
		IF (keydown(_esc) AND tope==0 AND saliendo==0) 
			IF (conf_son==0) sound_play(fx2,200,256); END
			signal(all_process,s_wakeup); 
			IF (conf_son==0) soundchannel_resume(all_channel); END
			IF (conf_mus==0) songchannel_resume(all_channel); END
			delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t0); menupausa=0;
			BREAK;		
		END
		
		IF (sel>3) sel=1; END
		IF (sel<1) sel=3; END
		
		IF (keydown(_enter) AND tope==0 AND saliendo==0) tope=1; 
			IF (conf_son==0) sound_play(fx2,255,256); END
			SWITCH (sel)
				CASE 1: // CONTINUAR
					signal(all_process,s_wakeup); 
					IF (conf_son==0) soundchannel_resume(all_channel); END
					IF (conf_mus==0) songchannel_resume(all_channel); END
					delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t0); menupausa=0;
					BREAK;		
				END
				CASE 2: // AYUDA
					ayuda(); tope=10; 
					delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t0);
				END
				CASE 3: // SALIR
					saliendo=1; 
					IF (conf_mus==0) songchannel_resume(all_channel); END
					delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t0); 
					cont=1;
				END
			END
		END
		
		IF (ayuda_back==1) 
			t0=write(fnt3,320,40,1,"-PANDEMIA PAUSADA-");
			t1=write(fnt3,320,150,1,"CONTINUAR");
			t2=write(fnt4,320,200,1,"AYUDA");
			t3=write(fnt3,320,270,1,"SALIR");
			ayuda_back=0; tope=1; 
		END
			
		// SALIENDO AL MENÚ PRINCIPAL
		IF (cont>0) cont++; 
			IF (cont==2) fade(0,0,0,0); fase=0; END
			IF (cont==160) 
				fade(100,100,100,0); let_me_alone(); stop_sound(all_sound); delete_text(all_text); 
				score=0; score2=0; start=0; rescatados=0; vidas=3; saliendo=0; intro=1; introd(); nivel=1; BREAK; 
			END
			bajada_volumen-=3;
			IF (conf_mus==0) songchannel_set_volume(0,bajada_volumen); END
		END
		
		IF (tope_t==1) delete_text(t1); delete_text(t2); delete_text(t3); tope_t=2; END
		
		IF (tope_t==2)
			SWITCH (sel)
				CASE 1:
					t1=write(fnt4,320,140,1,"CONTINUAR");
					t2=write(fnt3,320,210,1,"AYUDA");
					t3=write(fnt3,320,270,1,"SALIR");
					tope_t=0;
				END
				CASE 2:
					t1=write(fnt3,320,150,1,"CONTINUAR");
					t2=write(fnt4,320,200,1,"AYUDA");
					t3=write(fnt3,320,270,1,"SALIR");
					tope_t=0;
				END
				CASE 3:
					t1=write(fnt3,320,150,1,"CONTINUAR");
					t2=write(fnt3,320,210,1,"AYUDA");
					t3=write(fnt4,320,260,1,"SALIR");
					tope_t=0;
				END
			END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// FONDO PAUSA
//***************************************************
PROCESS fondo_pausa();

BEGIN

	graph=910;
	fx.alpha=160;
	size=200;
	x=320; y=200;
	z=-205;
	
	LOOP
	
		IF (menupausa==0) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// PANEL DE AYUDA
//***************************************************
PROCESS ayuda();

PRIVATE

	tope=1;
	num_panel;

BEGIN

	IF (stage==1) graph=700; END
	IF (stage==2) graph=697; END
	x=320; y=200;
	z=-320;
	
	LOOP
	
		SWITCH (stage)
			CASE 1:
				IF (keydown(_enter) AND tope==0 OR keydown(_esc) AND tope==0) tope=1;
					IF (conf_son==0) sound_play(fx2,255,256); END
					IF (num_panel==1) ayuda_back=1; BREAK; END
					IF (num_panel==0) graph=699; num_panel=1; END
				END
			END
			CASE 2:
				IF (keydown(_enter) AND tope==0 OR keydown(_esc) AND tope==0) tope=1;
					IF (conf_son==0) sound_play(fx2,255,256); END
					IF (num_panel==1) ayuda_back=1; BREAK; END
					IF (num_panel==0) graph=698; num_panel=1; END
				END
			END
		END
	
		IF (tope==1 AND !keydown(_enter) AND !keydown(_esc)) tope=0; END
	
		FRAME;
		
	END
	
END

//***************************************************
// CAMILLA
//***************************************************
PROCESS camilla();

PRIVATE

	anim;
	cont;
	cont2;
	vel_c=3;
	vel_a=3;
	t1;
	t2;
	cont_t;	cont_turbo;	cont_over; cont_terr;
	bajada_volumen=80;

BEGIN

	graph=1;
	size=200;
	z=-10;
	x=320;
	y=370;
	
	turbo();
	detect(x,y);

	LOOP
		
		// INICIAMOS NIVEL
		IF (fase==0)
			SWITCH (nivel)
				CASE 1: t1=write(fnt3,320,134,1,"NIVEL 1"); fase=1; END
				CASE 2: t1=write(fnt3,320,134,1,"NIVEL 2"); fase=1; END
				CASE 3: t1=write(fnt3,320,134,1,"NIVEL 3"); fase=1; END
			END
		END
		
		// TEMPORIZADOR PARA QUITAR EL CARTEL DEL NIVEL
		IF (fase==1) cont_t++;
			IF (cont_t==180) delete_text(t1); fase=3; END
		END
		
		// SI NOS QUEDAMOS SIN VIDAS, GAME OVER...
		IF (vidas==0 AND fase!=-1) gameover=1; fase=-1;
			t2=write(fnt4,320,123,1,"GAME OVER"); signal(son,s_kill);
			IF (conf_son==0) sound_play(fx16,255,256); END
			fade(100,100,100,60);
		END
		
		// CONTADOR PARA INICIAR EL FADE Y REINICIAR TODO
		IF (fase==-1) graph=17; cont_over++;
			IF (cont_over==180)
				delete_text(all_text); highscores(); nivel=1;
			END
		END
	
		// DIRECCIÓN DE LA CAMILLA
		IF (salvando==0 AND fase>2 AND fase!=10 AND aturdido==0)
			IF (keydown(_left) AND !keydown(_right) AND x>142) x-=vel_c; cont++; END
			IF (keydown(_right) AND !keydown(_left) AND x<503) x+=vel_c; cont++; END
		END
		
		// PONEMOS EL GRÁFICO INICIAL SI ESTAMOS QUIETOS
		IF (fase!=-1 AND fase!=10)
			IF (!keydown(_left) AND !keydown(_right) OR salvando!=0) graph=1; anim=0; END
		END
		
		// SI PULSAMOS AMBAS TECLAS BLOQUEAMOS GRÁFICO
		IF (keydown(_left) AND keydown(_right)) graph=1; anim=0; END
		
		// SE VA PARA LA AMBULANCIA UNA VEZ COMPLETADA LA FASE
		IF (fase==10) cont2++;
			IF (cont2>100) z=-39; vel_a=2; x+=vel_c; cont++; END
			IF (x>550) arranca_amb=1; BREAK; END
		END
		
		// FUNCIÓN DEL TURBO
		IF (keydown(_shift) AND turbo_c>0 AND salvando==0 AND fase>2) 
			IF (keydown(_left) OR keydown(_right))
				turbo_c--; rastro_camilla();
				IF (turbo_c>0) vel_c=5; vel_a=2;				
				ELSE 
					vel_c=3; vel_a=3; 
				END
			END
		ELSE 
			vel_c=3; vel_a=3; 
			IF (turbo_c<110 AND fase>2) cont_turbo++;
				IF (cont_turbo==5) turbo_c++; cont_turbo=0; END
			END
		END		
		
		// ACTUALIZAMOS GRÁFICO
		IF (cont=>vel_a) graph++; cont=0; END
		
		IF (fase!=10)
			IF (x<142) x=142; END
			IF (x>503) x=503; END
			IF (x==142) graph=1; END
			IF (x==503) graph=1; END
		END
	
		IF (graph>16 AND gameover==0) graph=1; END
		
		// SONIDO PASOS
		IF (graph==9 OR graph==16) 
			IF (conf_son==0) sound_play(fx3,255,rand(200,256)); END
		END
		
		// GRÁFICO DEL GAME OVER (DERROTADOS)
		IF (gameover==1) graph=17; END
	
		FRAME;
		
	END
	
END

//***************************************************
// RASTRO CAMILLA
//***************************************************
PROCESS rastro_camilla();

PRIVATE

	cont;

BEGIN

	graph=father.graph;
	x=father.x; y=father.y;
	size=father.size;
	z=father.z+1;
	fx.alpha=60; 

	LOOP
	
		cont++;
		fx.alpha-=5;
		IF (cont==5) BREAK; END
		
		FRAME;
		
	END
	
END	
	
//***************************************************
// DETECTOR DE CAMILLA
//***************************************************
PROCESS detect(x,y);

BEGIN

	graph=20;
	z=-100;
	visible=0;
	
	LOOP
		
		x=father.x-2; y=father.y;
		
		FRAME;
		
	END
	
END

//***************************************************
// ESTRELLAS CAMILLA
//***************************************************
PROCESS estrellas();

PRIVATE

	cont;
	cont2;

BEGIN

	graph=76;
	size=150;
	z=-11;
	x=pr1.x; y=pr1.y-30;
	
	LOOP

		pr1.graph=17;
		cont++;
		IF (cont==8) graph++; cont=0; cont2++; END
		IF (graph>77) graph=76; END
		IF (cont2==5) aturdido=0; BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// TURBO CAMILLA
//***************************************************
PROCESS turbo();

BEGIN

	graph=211;
	size=110;
	z=-50;
	x=54; y=380;
	
	LOOP
	
		SWITCH (turbo_c)
			CASE 110: graph=211; END
			CASE 100: graph=210; END
			CASE 90: graph=209; END
			CASE 80: graph=208; END
			CASE 70: graph=207; END
			CASE 60: graph=206; END
			CASE 50: graph=205; END
			CASE 40: graph=204; END
			CASE 30: graph=203; END
			CASE 20: graph=202; END
			CASE 10: graph=201; END
			CASE 0: graph=200; END
		END
	
		FRAME;
		
	END
	
END

//***************************************************
// AMBULANCIA
//***************************************************
PROCESS ambulancia();

PRIVATE

	cont;
	cont2;
	cont_terr;
	
BEGIN

	graph=50;
	size=200;
	z=-40;
	x=595;
	y=360;
	
	LOOP
	
		IF (arranca_amb==1) cont++;
			IF (cont==1 AND conf_son==0)
				sound_play(fx12,255,256);
			END
			IF (cont==80 AND conf_son==0)
				sound_play(fx13,180,200);
			END
			IF (cont>50) cont2++; END
			IF (cont>110) x+=1; END
			IF (x>700) arranca_amb=0; fade(0,0,0,0); BREAK; END
			IF (cont2==2) y+=1; END
			IF (cont2==4) y-=1; cont2=0; END
		END
	
		FRAME;
		
	END
	
END

//***************************************************
// VENTANA ABIERTA
//***************************************************
PROCESS ventana(tipo_ventana);

PRIVATE

	cont; cont2; cont_o; cont_terr;
	tope;
	guarda_y;
	dist_ult;
	
BEGIN

	size=200;
	z=-1;	
	
	LOOP
	
		// TIPOS
		IF (primer_tipo==0 AND tipo_ventana==0)
			pos=rand(1,80);
			SWITCH(pos)
				CASE 1: x=142; y=290;  END		CASE 2: x=182; y=290;  END		CASE 3: x=222; y=290;  END		CASE 4: x=262; y=290;  END		CASE 5: x=302; y=290;  END
				CASE 6: x=342; y=290;  END		CASE 7: x=382; y=290;  END		CASE 8: x=422; y=290;  END		CASE 9: x=462; y=290;  END		CASE 10: x=502; y=252; END
				CASE 11: x=142; y=252; END		CASE 12: x=182; y=252; END		CASE 13: x=222; y=252; END		CASE 14: x=262; y=252; END		CASE 15: x=302; y=252; END
				CASE 16: x=342; y=252; END		CASE 17: x=382; y=252; END		CASE 18: x=422; y=252; END		CASE 19: x=462; y=252; END		CASE 20: x=502; y=252; END
				CASE 21: x=142; y=212; END		CASE 22: x=182; y=212; END		CASE 23: x=222; y=212; END		CASE 24: x=262; y=212; END		CASE 25: x=302; y=212; END
				CASE 26: x=342; y=212; END		CASE 27: x=382; y=212; END		CASE 28: x=422; y=212; END		CASE 29: x=462; y=212; END		CASE 30: x=502; y=212; END
				CASE 31: x=142; y=172; END		CASE 32: x=182; y=172; END		CASE 33: x=222; y=172; END		CASE 34: x=262; y=172; END		CASE 35: x=302; y=172; END
				CASE 36: x=342; y=172; END		CASE 37: x=382; y=172; END		CASE 38: x=422; y=172; END		CASE 39: x=462; y=172; END		CASE 40: x=502; y=132; END
				CASE 41: x=142; y=132; END		CASE 42: x=182; y=132; END		CASE 43: x=222; y=132; END		CASE 44: x=262; y=132; END		CASE 45: x=302; y=132; END
				CASE 46: x=342; y=132; END		CASE 47: x=382; y=132; END		CASE 48: x=422; y=132; END		CASE 49: x=462; y=132; END		CASE 50: x=502; y=132; END
				CASE 51: x=142; y=92;  END		CASE 52: x=182; y=92;  END		CASE 53: x=222; y=92;  END		CASE 54: x=262; y=92;  END		CASE 55: x=302; y=92;  END
				CASE 56: x=342; y=92;  END		CASE 57: x=382; y=92;  END		CASE 58: x=422; y=92;  END		CASE 59: x=462; y=92;  END		CASE 60: x=502; y=92;  END
				CASE 61: x=142; y=52;  END		CASE 62: x=182; y=52;  END		CASE 63: x=222; y=52;  END		CASE 64: x=262; y=52;  END		CASE 65: x=302; y=52;  END
				CASE 66: x=342; y=52;  END		CASE 67: x=382; y=52;  END		CASE 68: x=422; y=52;  END		CASE 69: x=462; y=52;  END		CASE 70: x=502; y=52;  END
				CASE 71: x=142; y=14;  END		CASE 72: x=182; y=14;  END		CASE 73: x=222; y=14;  END		CASE 74: x=262; y=14;  END		CASE 75: x=302; y=14;  END
				CASE 76: x=342; y=14;  END		CASE 77: x=382; y=14;  END		CASE 78: x=422; y=14;  END		CASE 79: x=462; y=14;  END		CASE 80: x=502; y=14;  END
			END
			x_tipo=x; y_tipo=y; primer_tipo=1; BREAK; //cont2=1;
		END
		
		// POSICIÓN TIPO
		IF (primer_tipo==1 AND cont2==0 AND tipo_ventana==0)
			pos=rand(1,80);
			SWITCH(pos)
				CASE 1: x=142; y=290;  END		CASE 2: x=182; y=290;  END		CASE 3: x=222; y=290;  END		CASE 4: x=262; y=290;  END		CASE 5: x=302; y=290;  END
				CASE 6: x=342; y=290;  END		CASE 7: x=382; y=290;  END		CASE 8: x=422; y=290;  END		CASE 9: x=462; y=290;  END		CASE 10: x=502; y=252; END
				CASE 11: x=142; y=252; END		CASE 12: x=182; y=252; END		CASE 13: x=222; y=252; END		CASE 14: x=262; y=252; END		CASE 15: x=302; y=252; END
				CASE 16: x=342; y=252; END		CASE 17: x=382; y=252; END		CASE 18: x=422; y=252; END		CASE 19: x=462; y=252; END		CASE 20: x=502; y=252; END
				CASE 21: x=142; y=212; END		CASE 22: x=182; y=212; END		CASE 23: x=222; y=212; END		CASE 24: x=262; y=212; END		CASE 25: x=302; y=212; END
				CASE 26: x=342; y=212; END		CASE 27: x=382; y=212; END		CASE 28: x=422; y=212; END		CASE 29: x=462; y=212; END		CASE 30: x=502; y=212; END
				CASE 31: x=142; y=172; END		CASE 32: x=182; y=172; END		CASE 33: x=222; y=172; END		CASE 34: x=262; y=172; END		CASE 35: x=302; y=172; END
				CASE 36: x=342; y=172; END		CASE 37: x=382; y=172; END		CASE 38: x=422; y=172; END		CASE 39: x=462; y=172; END		CASE 40: x=502; y=132; END
				CASE 41: x=142; y=132; END		CASE 42: x=182; y=132; END		CASE 43: x=222; y=132; END		CASE 44: x=262; y=132; END		CASE 45: x=302; y=132; END
				CASE 46: x=342; y=132; END		CASE 47: x=382; y=132; END		CASE 48: x=422; y=132; END		CASE 49: x=462; y=132; END		CASE 50: x=502; y=132; END
				CASE 51: x=142; y=92;  END		CASE 52: x=182; y=92;  END		CASE 53: x=222; y=92;  END		CASE 54: x=262; y=92;  END		CASE 55: x=302; y=92;  END
				CASE 56: x=342; y=92;  END		CASE 57: x=382; y=92;  END		CASE 58: x=422; y=92;  END		CASE 59: x=462; y=92;  END		CASE 60: x=502; y=92;  END
				CASE 61: x=142; y=52;  END		CASE 62: x=182; y=52;  END		CASE 63: x=222; y=52;  END		CASE 64: x=262; y=52;  END		CASE 65: x=302; y=52;  END
				CASE 66: x=342; y=52;  END		CASE 67: x=382; y=52;  END		CASE 68: x=422; y=52;  END		CASE 69: x=462; y=52;  END		CASE 70: x=502; y=52;  END
				CASE 71: x=142; y=14;  END		CASE 72: x=182; y=14;  END		CASE 73: x=222; y=14;  END		CASE 74: x=262; y=14;  END		CASE 75: x=302; y=14;  END
				CASE 76: x=342; y=14;  END		CASE 77: x=382; y=14;  END		CASE 78: x=422; y=14;  END		CASE 79: x=462; y=14;  END		CASE 80: x=502; y=14;  END
			END
			dist_ult=fget_dist(x,y,x_tipo,y_tipo);
			SWITCH(nivel)
				CASE 1:
					IF (dist_ult<180 AND tope==0 AND x!=x_tipo) cont2=1; tope=1; END
				END
				CASE 2:
					IF (dist_ult<200 AND tope==0 AND x!=x_tipo) cont2=1; tope=1; END
				END
				CASE 3:
					IF (dist_ult<230 AND tope==0 AND x!=x_tipo) cont2=1; tope=1; END
				END
			END
		END
		
		IF (cont2==1 AND tipo_ventana==0) cont++;
			IF (cont==2) size=tam_det; guarda_y=y; y=200; graph=80; visible=0; END
			IF (cont==3)
				IF (collision(TYPE objects)) BREAK; END
				cont2=2; size=200; y=guarda_y; visible=1;
			END
		END
	
		// OBJETOS
		IF (tipo_ventana==1 AND cont==0)
			pos=rand(1,80);
			SWITCH(pos)
				CASE 1: x=142; y=290;  END		CASE 2: x=182; y=290;  END		CASE 3: x=222; y=290;  END		CASE 4: x=262; y=290;  END		CASE 5: x=302; y=290;  END
				CASE 6: x=342; y=290;  END		CASE 7: x=382; y=290;  END		CASE 8: x=422; y=290;  END		CASE 9: x=462; y=290;  END		CASE 10: x=502; y=252; END
				CASE 11: x=142; y=252; END		CASE 12: x=182; y=252; END		CASE 13: x=222; y=252; END		CASE 14: x=262; y=252; END		CASE 15: x=302; y=252; END
				CASE 16: x=342; y=252; END		CASE 17: x=382; y=252; END		CASE 18: x=422; y=252; END		CASE 19: x=462; y=252; END		CASE 20: x=502; y=252; END
				CASE 21: x=142; y=212; END		CASE 22: x=182; y=212; END		CASE 23: x=222; y=212; END		CASE 24: x=262; y=212; END		CASE 25: x=302; y=212; END
				CASE 26: x=342; y=212; END		CASE 27: x=382; y=212; END		CASE 28: x=422; y=212; END		CASE 29: x=462; y=212; END		CASE 30: x=502; y=212; END
				CASE 31: x=142; y=172; END		CASE 32: x=182; y=172; END		CASE 33: x=222; y=172; END		CASE 34: x=262; y=172; END		CASE 35: x=302; y=172; END
				CASE 36: x=342; y=172; END		CASE 37: x=382; y=172; END		CASE 38: x=422; y=172; END		CASE 39: x=462; y=172; END		CASE 40: x=502; y=132; END
				CASE 41: x=142; y=132; END		CASE 42: x=182; y=132; END		CASE 43: x=222; y=132; END		CASE 44: x=262; y=132; END		CASE 45: x=302; y=132; END
				CASE 46: x=342; y=132; END		CASE 47: x=382; y=132; END		CASE 48: x=422; y=132; END		CASE 49: x=462; y=132; END		CASE 50: x=502; y=132; END
				CASE 51: x=142; y=92;  END		CASE 52: x=182; y=92;  END		CASE 53: x=222; y=92;  END		CASE 54: x=262; y=92;  END		CASE 55: x=302; y=92;  END
				CASE 56: x=342; y=92;  END		CASE 57: x=382; y=92;  END		CASE 58: x=422; y=92;  END		CASE 59: x=462; y=92;  END		CASE 60: x=502; y=92;  END
				CASE 61: x=142; y=52;  END		CASE 62: x=182; y=52;  END		CASE 63: x=222; y=52;  END		CASE 64: x=262; y=52;  END		CASE 65: x=302; y=52;  END
				CASE 66: x=342; y=52;  END		CASE 67: x=382; y=52;  END		CASE 68: x=422; y=52;  END		CASE 69: x=462; y=52;  END		CASE 70: x=502; y=52;  END
				CASE 71: x=142; y=14;  END		CASE 72: x=182; y=14;  END		CASE 73: x=222; y=14;  END		CASE 74: x=262; y=14;  END		CASE 75: x=302; y=14;  END
				CASE 76: x=342; y=14;  END		CASE 77: x=382; y=14;  END		CASE 78: x=422; y=14;  END		CASE 79: x=462; y=14;  END		CASE 80: x=502; y=14;  END
			END
			cont=1;
		END
		
		IF (cont>0 AND tipo_ventana==1) cont++;
			IF (cont==2) size=tam_det; guarda_y=y; y=200; graph=80; visible=0; END
			IF (cont==3) 
				IF (collision(TYPE tipo) OR collision(TYPE objects)) cont=0; END
				IF (obj_pant==obj_max) BREAK; END
			END
			IF (cont==4)
				cont2=1; size=200; y=guarda_y; visible=1; obj_pant++;
			END
		END
	
		// ANIMACIÓN Y PROCESO CON TIPO EN VENTANA
		IF (tipo_ventana==0)
			IF (cont2>0) cont2++; END
			IF (cont2==2) graph=101; tipo(); x_tipo=x; y_tipo=y; primer_tipo=1; 
				IF (conf_son==0) sound_play(fx7,80,180); END
			END
			IF (cont2==7) graph=102; END
			IF (cont2==107) graph=101; END
			IF (cont2==114) BREAK; END
		END
		
		// ANIMACIÓN Y PROCESO CON OBJETO EN VENTANA
		IF (tipo_ventana==1)
			IF (cont2>0) cont2++; END
			IF (cont2==2) graph=101; objects(); 
				IF (conf_son==0) sound_play(fx7,80,180); END
			END
			IF (cont2==7) graph=102; END
			IF (cont2==27) graph=101; END
			IF (cont2==34) BREAK; END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// OBJETOS QUE SE TIRAN POR LAS VENTANAS
//***************************************************
PROCESS objects();

PRIVATE

	cont; cont2; cont3;
	fase_o;
	vel_o;
	angulo;
	grav;

BEGIN

	graph=rand(70,72);
	size=200;
	x=father.x; y=father.y;
	z=-6;
	
	angulo=rand(1,2);
	fase_o=1;
	
	LOOP
	
		// CAYENDO
		IF (fase_o==1 AND menupausa==0) grav++; //rastro(x,y);
			IF (angulo==1) angle+=1000; ELSE angle-=1000; END
			y+=vel_o-2;
			IF (grav==13) vel_o++; grav=0; END
			IF (collision(TYPE camilla) AND y<356 AND aturdido==0 AND fase!=10 AND gameover==0) 
				IF (conf_son==0) sound_play(fx21,200,256); sound_play(fx22,200,400); sound_play(fx17,130,256); 
					IF (graph==70 OR graph==71) sound_play(fx18,30,256); END
				END
				estrellas(); aturdido=1; fase_o=2; cont=0; 
			END
			IF (y>370) fase_o=2; cont=0; 
				IF (conf_son==0) sound_play(fx17,130,256); 
					IF (graph==70 OR graph==71) sound_play(fx18,30,256); END
				END
			END
		END
		
		// REBOTE
		IF (fase_o==2 AND menupausa==0) cont2++; cont3++; fx.alpha=128;
			y-=2;
			IF (angulo==1) angle+=11000; x--; ELSE angle-=11000; x++; END
			IF (cont2==4) fx.alpha=64; cont2=0; END
			IF (cont3==30) obj_pant--; BREAK; END
		END
	
		FRAME;
		
	END
	
END
		
//***************************************************
// TÍO QUE SE TIRA
//***************************************************
PROCESS tipo();

PRIVATE

	cont;
	cont2;
	grav;
	vel_t;
	fase_t;
	cont_fade; cont_terr;
	tope;
	
	fx_caida;

BEGIN

	graph=51;
	x=father.x-2; y=father.y-2;
	size=200;
	z=-5;
	
	LOOP
		
		cont++;
		
		// SALIENDO DE LA VENTANA
		IF (fase_t==0 AND menupausa==0)
			IF (cont==18) fase_t=30; cont=0; END
		END
		IF (fase_t==30 AND menupausa==0)
			IF (cont==10) graph++; cont=0; END
			IF (graph==54 AND cont==5) 
				IF (conf_son==0) fx_caida=sound_play(fx4,20,rand(130,220)); END
			END
			IF (graph==56) fase_t=1; y-=10; sombra(x);
				IF (rand(1,20)<3 AND tope==0 AND haysuperman==0 AND cont_superman==0) cont_superman=1; haysuperman=1; superman(y); tope=1; END // LLAMAMOS A SUPERMAN
				//IF (rand(1,2)<3 AND haysuperman==0) cont_superman=1; haysuperman=1; superman(y); tope=1; END // LLAMAMOS A SUPERMAN
			END
		END
		
		// CAYENDO
		IF (fase_t==1) grav++; //rastro(x,y);
			y+=vel_t;
			IF (cont==5) graph++; cont=0; END 
			IF (graph>59) graph=57; END
			IF (grav==10) vel_t++; grav=0; END
			IF (y>380) fase_t=7; graph=61; cont=0; IF (fase!=10 AND gameover==0) bonus_res=0; END // LLEGA AL SUELO
				IF (conf_son==0) stop_sound(fx_caida); sound_play(fx11,255,256); END
				IF (vidas>0 AND fase!=10) fade(100,0,0,10); vidas--; perfect=1; END 
			END
			IF (keydown(_x)) // CHEAT DE IMÁN
				IF (x<pr1.x) x+=4; END
				IF (x>pr1.x) x-=4; END
			END
		END
		
		IF (collision(TYPE superman)) stop_sound(fx_caida); END
		
		// TOCA LA CAMILLA
		IF (collision(TYPE detect) AND fase_t<2 AND aturdido==0 AND fase!=10)
			z=-20; fase_t=2; graph=21; x=pr1.x; y=pr1.y+4; cont=0; salvando=1; score+=100; score2+=100; rescatados++; bonus_res++;
			IF (conf_son==0) stop_sound(fx_caida); sound_play(fx5,200,226); END
		END
		
		IF (fase_t==2)
			IF (cont==2) graph++; cont=0; END
			IF (cont==4 AND conf_son==0) sound_play(fx6,15,226); END
			IF (graph==25) cont+=2; END
			IF (cont=>25) graph=26; cont=0; END
			IF (graph==30) salvando=0; y-=7; fase_t=3; cont=0; END
		END
		
		IF (fase_t==3) y-=1;
			IF (cont==30) graph=31; z=-5; x+=3; fase_t=4; cont=0; END
		END
		
		IF (fase_t==4) graph=32; x++; y++;
			IF (cont==10) graph=32; fase_t=5; END
		END
		
		IF (fase_t==5) 
			IF (cont==15) graph=40; y-=1; x+=3; fase_t=6; cont=0; END
		END
		
		// SE PONE A ANDAR 
		IF (fase_t==6)
			IF (cont==5) graph++; x+=2; cont=0; END
			IF (graph>48) graph=40; END
			IF (x>565 AND fase!=10) BREAK; END
			IF (fase==10 AND collision(TYPE ambulancia)) BREAK; END
			IF (arranca_amb==1) cont2++;
				IF (cont2==120) bocadillo(x+20); END
			END
		END
		
		// SE MATA CONTRA EL SUELO
		IF (fase_t==7) cont_fade++;
			IF (cont_fade==5 AND vidas>0) fade(100,100,100,10); END
			IF (cont==30) graph++; cont=0; END
			IF (graph==64) fase_t=8; cont=0; END
		END
		
		IF (fase_t==8)
			IF (cont==10) fx.alpha--; cont=0; END
			IF (fx.alpha=<10) BREAK; END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// SOMBRA DEL TÍO QUE SE TIRA
//***************************************************
PROCESS sombra(x);

BEGIN
	
	graph=65;
	fx.alpha=140;
	y=386;
	z=-6;
	
	LOOP
		
		size=father.y;
		
		IF (father.y>373 OR gameover==1) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// BOCADILLO
//***************************************************
PROCESS bocadillo(x);

BEGIN

	graph=75;
	size=200;
	y=320;
	
	LOOP
	
		x=father.x+30;
		
		FRAME;
		
	END
	
END

//***************************************************
// SUPERMAN
//***************************************************
PROCESS superman(y);

PRIVATE

	cont;
	graf_i=110;
	graf_f=111;
	dist_tio;
	cogido;
	sonido;

BEGIN

	graph=110;
	size=200;
	z=-30;
	x=660; 
	
	IF (conf_son==0) 
		sound_play(fx8,255,256);
		sonido=sound_play(fx9,50,256);
	END
	
	LOOP
		
		dist_tio=fget_dist(x,y,father.x,father.y);
		cont++;
		IF (cont==5) graph++; cont=0; END
		IF (graph>graf_f) graph=graf_i; END
		
		IF (cogido==0)
			IF (dist_tio>400) x-=16; END
			IF (dist_tio=<400 AND dist_tio>100) x-=14; END
			IF (dist_tio=<100 AND dist_tio>80) x-=13; END
			IF (dist_tio=<80 AND dist_tio>30) x-=9; END
			IF (dist_tio=<30) x-=3; END
			y=father.y;
			IF (x=<father.x) graph=122; graf_i=112; graf_f=113; signal(father,s_kill); cogido=1; 
				IF (conf_son==0) stop_sound(sonido); sound_play(fx10,255,256); END
			END
		END
		
		IF (cogido!=0) cogido++; x-=2; END
		IF (cogido==49) 
			IF (conf_son==0) sonido=sound_play(fx9,50,256); END
		END
		IF (cogido>50) x-=1; END
		IF (cogido>60) x--; END
		IF (cogido>70) x-=2; END
		
		IF (x<-30) haysuperman=0; stop_sound(sonido); BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// CARRETERA
//***************************************************
PROCESS carretera();

PRIVATE

	cont;
	cont2;
	contpunt;
	contkm;
	durkm;
	
	frecuencia=10;
	
	tope;
	
	tx1; tx2; tx3; tx4; tx5; tx6; tx7; tx8; tx10;
	
BEGIN
	
	delete_text(all_text);
	stage=2;
	km=10;
	invencible=0;
	final=0;
	perfect=0;
	amb_out=0;
	multibonus=0;
	bonus_res=0;
	main();
	tx1=write(fnt1,15,5,0,"MARCADOR:");
	tx2=write(fnt1,106,5,0,OFFSET score);
	tx3=write(fnt1,560,5,0,"NIVEL:");
	tx4=write(fnt1,617,5,0,OFFSET nivel);
	tx5=write(fnt1,15,30,0,"KM RESTANTES:");
	tx6=write(fnt1,141,30,0,OFFSET km);
	tx7=write(fnt1,557,30,0,"VIDAS:");
	tx8=write(fnt1,617,30,0,OFFSET vidas);
	tx10=write(fnt3,320,170,1,"PULSA ESPACIO PARA EMPEZAR");
	
	text_lock(tx1); text_lock(tx2); text_lock(tx3); text_lock(tx4); text_lock(tx5); text_lock(tx6); text_lock(tx7); text_lock(tx8); text_lock(tx10);   
	text_set_z(tx1,-60); text_set_z(tx2,-60); text_set_z(tx3,-60); text_set_z(tx4,-60); text_set_z(tx5,-60); 
	text_set_z(tx6,-60); text_set_z(tx7,-60); text_set_z(tx8,-60); text_set_z(tx10,-60);
	
	set_fps(60,0);
	text_z=-50;
	start_scroll(0,0,0,498,0,15);
	pr3=ambulancia_scroll();
	
	SWITCH (nivel)
		CASE 1: vel=3; durkm=325; END
		CASE 2: vel=4; durkm=350; END
		CASE 3: vel=5; durkm=375; END
	END
	
	LOOP
	
		IF (estrellado==0 OR gameover==1)
			IF (rand(1,100)<2 AND km>0 AND start==1) peaton(); END
			//IF (rand(1,1)<2 AND km>0) peaton(); END
			IF (keydown(_z)) peaton(); END
		END
	
		IF (start==0)
			IF (keydown(_space)) start=1; menupausa=0; delete_text(tx10); END
		END
	
		IF (estrellado==0 AND amb_out==0 AND start==1)
			IF (keydown(_esc) AND tope==0 AND km>0) 
				tope=1; pausa(); 
				IF (conf_son==0) sound_play(fx2,255,256); END
			END
			IF (tope==1 AND !keydown(_esc)) tope=0; END
		
			IF (rand(1,150)<2 AND pajaros<6) pajaro(); pajaros++; END
		
			cont++;	cont2++; contpunt++; contkm++;
			
			IF (contpunt==5) score+=5; score2+=5; contpunt=0; END
			IF (contkm==durkm) contkm=0; 
				IF (km>0) km--; END
			END
			
			IF (cont2==300) paso_elevado(); cont2=0; END
			
			IF (km>0)
				IF (rand(1,100)<frecuencia) coche_scroll(rand(222,419),-30); END
				IF (rand(1,200)<4) autobus(rand(242,399),-50); END
			END
		
			scroll.y0-=vel;
			
		END
		
		IF (amb_out==1 OR gameover==1)
			IF (rand(1,150)<2 AND pajaros<6) pajaro(); pajaros++; END
		END
		
		IF (amb_out==1)
			cont++;	cont2++; 
			
			IF (cont2==300) paso_elevado(); cont2=0; END
			IF (km>0)
				IF (rand(1,100)<frecuencia) coche_scroll(rand(222,419),-30); END
				IF (rand(1,200)<4) autobus(rand(242,399),-50); END
			END
		
			scroll.y0-=vel;
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// PASO ELEVADO SCROLL
//***************************************************
PROCESS paso_elevado();	

PRIVATE

	estilo;
	cont;
	
BEGIN

	graph=508;
	x=320;
	y=-200;
	estilo=rand(1,2);
	IF (estilo==1) size=150; ELSE size=230; END
	z=-20;
	
	LOOP
	
		IF (cont<8) 
			IF (estilo==1)
				coche_puentes(rand(x-320,x+320),rand(y-30,y+30),120,-21); cont++;
			END
			IF (estilo==2)
				coche_puentes(rand(x-320,x+320),rand(y-50,y+50),180,-21); cont++;
			END
		END	
	
		IF (estrellado==0)
			IF (estilo==1) y+=vel; ELSE y+=vel+3; END
			IF (y>600) BREAK; END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// AMBULANCIA SCROLL
//***************************************************
PROCESS ambulancia_scroll();

PRIVATE

	cont; cont2; cont3;
	cont_inv; cont_inv2; cant_cont=20;
	finfase;
	bajada_volumen=80;
	retraso_luz;

BEGIN

	graph=510;
	x=320; y=350;
	z=-10;
	estrellado=0;
	
	//write_int(0,10,20,0,OFFSET y);
	
	LOOP
	
		IF (retraso_luz<3) retraso_luz++; END
		IF (retraso_luz==3) pr5=luces_amb(); retraso_luz=4; END
	
		IF (estrellado==0 AND finfase<2 AND start==1 OR estrellado==100)
			graph=510;
			cont++; cont2++;
			IF (cont2==4) humo_scroll(x-6,y+24); cont2=0; END
		
			IF (cont==4) x--; END
			IF (cont==8) x++; cont=0; END
	
			IF (keydown(_right)) angle=-5400; 
				SWITCH (nivel)
					CASE 1: x+=vel; END
					CASE 2: x+=vel-1; END
					CASE 3: x+=vel-2; END
				END
			END
		
			IF (keydown(_left)) angle=5400; 
				SWITCH (nivel)
					CASE 1: x-=vel; END
					CASE 2: x-=vel-1; END
					CASE 3: x-=vel-2; END
				END
			END
		
			IF (keydown(_up)) 
				SWITCH (nivel)
					CASE 1: y-=vel-1; END
					CASE 2: y-=vel-2; END
					CASE 3: y-=vel-3; END
				END
			END
		
			IF (keydown(_down)) y+=vel-1; END
		
			IF (!keydown(_right) AND !keydown(_left)) angle=0; END
			
			IF (y>366) y=366; END
			IF (y<36) y=36; END

			// COLISIÓN CON ALGÚN COCHE O AUTOBÚS
			IF (estrellado==100)
				estrellado=1; graph=512; texto_crash(x+2,y-35); 
			END

			// INVENCIBILIDAD TEMPORAL TRAS CHOCARSE
			IF (invencible==1) cont_inv++;
				IF (cont_inv==cant_cont) fx.alpha=100; END
				IF (cont_inv==cant_cont*2) fx.alpha=226; cont_inv=0; cont_inv2++; cant_cont-=1; 
					IF (conf_son==0) sound_play(fx28,140,326); END
				END
				IF (cont_inv2==19) cont_inv=0; cont_inv2=0; cant_cont=20; invencible=0; fx.alpha=256; END
			END
			
		END
	
		IF (estrellado==10) pr5=luces_amb(); estrellado=0; invencible=1; END
	
		IF (x<212) x=212; END
		IF (x>427) x=427; END
		
		// FINAL DE FASE
		IF (km==0 AND finfase==0) finfase=1; END
		IF (finfase==1 AND estrellado==0) cont3++;
			IF (cont3==240) finfase=2; cont2=0; write(fnt4,320,120,1,"¡FASE SUPERADA!"); 
				IF (perfect==0) 
					write(fnt3,320,221,1,"¡PERFECT!");
					write(fnt2,320,255,1,"+5.000 PUNTOS");
					score+=5000; score2+=5000;
					IF (conf_son==0)
						sound_play(fx32,140,256); 
					END
				END
				IF (conf_son==0)
					sound_play(fx14,200,256); sound_play(fx15,230,256);
				END
			END
		END
		IF (finfase==2) cont3++; cont2++; invencible=0; fx.alpha=256; y-=2; angle=0; 
			IF (perfect==0 AND cont3==270 AND conf_son==0) sound_play(fx31,256,256); END		
			IF (cont2==4) humo_scroll(x-6,y+24); cont2=0; END
		END
		IF (y<-50 AND finfase==2) fade(0,0,0,0); finfase=3; cont3=0; END
		IF (finfase==3) cont3++;
			IF (conf_mus==0)
				bajada_volumen-=1; songchannel_set_volume(0,bajada_volumen);
				IF (bajada_volumen==0) songchannel_stop(0); songchannel_set_volume(0,80); END
			END
			IF (cont3==180) let_me_alone(); delete_text(all_text); intro=3; start=0; introd(); signal(pr5,s_kill); BREAK; END
		END
		
		// MODIFICACIÓN DEL HUMO
		IF (estrellado==2) cont2++;
			IF (cont2=>4) humo_scroll(x,y+5); cont2=0; END
		END
	
		IF (gameover==100) gameover=1; signal(pr5,s_kill); BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// GRÁFICO DEL TEXTO DE "CRASH!"
//***************************************************
PROCESS texto_crash(x,y);

PRIVATE

	mirror;
	txt1; txt2;
	cont;
	fase;
	
BEGIN

	IF (premia>0) 
		signal(ult_proces_bonus,s_kill);
		delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); delete_text(t5);
	END
	
	IF (conf_son==0) sound_play(fx27,150,256); END
	
	mirror=rand(1,2);
	IF (mirror==1) angle=-5000; ELSE angle=5000; END
	graph=513;
	z=-250;
	vidas--;
	multibonus=0;
	puntbonus=0;
	perfect=1;
	
	LOOP
	
		cont++;
		
		IF (cont==80)
			IF (vidas>0)
				txt1=write(fnt4,320,90,1,"¡TE APIÑASTE!");
				txt2=write(fnt3,320,320,1,"Pulsa espacio para continuar");
			END
		END
		
		IF (cont>80 AND fase==0) fx.alpha=0;
			// SI NOS QUEDAMOS SIN VIDAS, GAME OVER...
			IF (vidas==0 AND fase!=-1) gameover=1; fase=-1;
				txt1=write(fnt4,320,123,1,"GAME OVER"); signal(son,s_kill);
				IF (conf_son==0) sound_play(fx16,255,256); END
				fase=1; cont=0; 
			END
			
			IF (vidas>0 AND keydown(_space)) 
				delete_text(txt1); delete_text(txt2); estrellado=10; BREAK; 
			END
		END
		
		IF (fase==1)
			IF (cont>60 AND scan_code!=0) 
				delete_text(all_text); highscores(); fase=2; signal(pr3,s_kill); estrellado=0; amb_out=1; nivel=1; BREAK; 
			END 
			IF (cont==300) 
				delete_text(all_text); highscores(); fase=2; signal(pr3,s_kill); estrellado=0; amb_out=1; nivel=1; BREAK; 
			END 
		END
	
		FRAME;
		
	END	
END

//***************************************************
// LUCES AMBULANCIA SCROLL
//***************************************************
PROCESS luces_amb();

BEGIN

	graph=524;
	size=120;
	fx.alpha=20;
	z=-11;
	IF (final==1) ctype=c_scroll; END
	
	LOOP
	
		x=father.x; y=father.y-4;
		angle+=6000;
		
		IF (estrellado==1) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// HUMO AMBULANCIA SCROLL
//***************************************************
PROCESS humo_scroll(x,y);

BEGIN

	graph=523;
	z=-30;
	fx.alpha=160;
	IF (estrellado==0) z=-11; ELSE z=-5; END
	angle=rand(0,360000);
	size=rand(60,130);
	IF (estrellado!=0) size=280; y-=14; END
	
	LOOP
		
		size+=20;
		
		IF (estrellado==0)
			y+=vel-2; fx.alpha-=10;
		ELSE
			y-=vel-2; fx.alpha-=9;
		END
		
		IF (fx.alpha=<1) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// HUMO COCHES SCROLL
//***************************************************
PROCESS humo_coches(x,y);

BEGIN

	graph=522;
	fx.alpha=160;
	z=-12;
	angle=rand(0,360000);
	size=rand(110,150);
	
	LOOP
		
		IF (estrellado==0) 
			y+=vel-1; fx.alpha-=5; 
		ELSE 
			SWITCH (nivel)
				CASE 1: y-=vel-2; fx.alpha-=6; END
				CASE 2: y-=vel-3; fx.alpha-=7; END
				CASE 3: y-=vel-3; fx.alpha-=8; END
			END
		END
		
		size+=11;
		
		IF (fx.alpha=<1 OR x<212) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// HUMO COCHES SCROLL 2
//***************************************************
PROCESS humo_coches2(x,y);

BEGIN

	graph=522;
	size=father.size;
	fx.alpha=160;
	z=-25;
	angle=rand(0,360000);
	
	LOOP
		
		IF (estrellado==0) 
			y+=vel-1; fx.alpha-=5; 
		ELSE 
			SWITCH (nivel)
				CASE 1: y-=vel-2; fx.alpha-=4; END
				CASE 2: y-=vel-3; fx.alpha-=5; END
				CASE 3: y-=vel-3; fx.alpha-=6; END
			END
		END
		
		size+=11;
		
		IF (fx.alpha=<1 OR x<5) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// COCHE SCROLL PUENTES
//***************************************************
PROCESS coche_puentes(x,y,size,z);

PRIVATE

	cont;
	
BEGIN

	z=-22;
	graph=rand(600,605);
	flags=rand(0,1);
	angle=rand(-20000,20000);
	IF (rand(1,10)<3) fuego(x,y); END
	
	LOOP
		
		IF (collision(TYPE coche_puentes)) BREAK; END
		
		IF (estrellado==0)
			SWITCH (size)
				CASE 100: y+=vel; END
				CASE 120: y+=vel; END
				CASE 180: y+=vel+3; END
			END
		END
		
		IF (y>440) BREAK; END
		
		FRAME;
		
	END
	
END
		
//***************************************************
// COCHE SCROLL
//***************************************************
PROCESS coche_scroll(x,y);

PRIVATE

	dist;
	cont;

BEGIN

	graph=rand(600,605);
	flags=rand(0,1);
	angle=rand(-20000,20000);
	IF (graph>602) angle=rand(-60000,60000); END
	z=-5;
	IF (rand(1,10)<3 AND graph!=599) fuego2(x,y); END
	circulo(x,y,170);
	detect_bonus();
	
	LOOP
		
		IF (estrellado==0)
			cont++;
		
			IF (y<0)
				IF (collision(TYPE paso_elevado)); BREAK; END
			END
		
			IF (menupausa==0) y+=vel; END
		
			IF (amb_out==0) dist=fget_dist(x,y,pr3.x,pr3.y); END
			IF (dist<300 AND invencible==0) 
				IF (collision(TYPE ambulancia_scroll) AND estrellado==0) estrellado=100; END
			END
			
			IF (y>450) BREAK; END
		
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// DETECTOR BONUS COCHES/AUTOBUS
//***************************************************
PROCESS detect_bonus();

PRIVATE

	dist;
	numbonus;
	cont;
	espera;
	haytexto;
	
BEGIN

	visible=0;
	
	SWITCH (father.graph)
		CASE 600..602: 
			graph=921; size=105;
		END
		CASE 603..605:
			graph=922; size=105;
		END
		CASE 534:
			graph=920; size=115;
		END
	END
	flags=father.flags;
	angle=father.angle;
	
	LOOP
		
		x=father.x; y=father.y;
		
		IF (invencible==0 AND gameover==0)
			dist=fget_dist(x,y,pr3.x,pr3.y);
		
			IF (dist<300)
				IF (collision(TYPE ambulancia_scroll) AND espera==0) espera=1; END
			END
		END
			
		IF (espera>0) espera++; END
		IF (espera==24)
			IF (estrellado==1) BREAK; END
			IF (estrellado==0)	
				texto_bonus();
			END
		END
	
		IF (y>450 OR x<200) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// TEXTO BONUS
//***************************************************
PROCESS texto_bonus();

PRIVATE

	haytexto;
	cont;
	
BEGIN

	IF (premia==1)
		delete_text(t1); 
		delete_text(t2); 
		delete_text(t3); 
		delete_text(t4); 
		delete_text(t5);
		signal(ult_proces_bonus,s_kill);
	END

	t1=write(fnt1,pr3.x,pr3.y-80,1,"¡HA ESTADO CERCA!");
	t2=write(fnt1,pr3.x-60,pr3.y-55,0,"X");
	t3=write(fnt1,pr3.x-50,pr3.y-55,0,OFFSET multibonus);
	t4=write(fnt2,pr3.x-10,pr3.y-55,0,"+");
	t5=write(fnt2,pr3.x,pr3.y-55,0,OFFSET puntbonus);
	text_lock(t1); text_lock(t2); text_lock(t3); text_lock(t4); text_lock(t5); 
	text_set_z(t1,-60); text_set_z(t2,-60); text_set_z(t3,-60); text_set_z(t4,-60); text_set_z(t5,-60); 
	
	puntbonus+=100; premia=1; multibonus++;
	score+=puntbonus; score2+=puntbonus; haytexto=1;
	ult_proces_bonus=id;
	
	IF (conf_son==0) sound_play(fx19,100,256); END
	
	LOOP		
	
		IF (haytexto==1 AND amb_out==0) cont++;
			move_text(t1,pr3.x,pr3.y-80);
			move_text(t2,pr3.x+20,pr3.y-55);
			move_text(t3,pr3.x+30,pr3.y-55);
			move_text(t4,pr3.x-40,pr3.y-55);
			move_text(t5,pr3.x-30,pr3.y-55);			
			IF (cont==110)
				delete_text(t1); 
				delete_text(t2); 
				delete_text(t3); 
				delete_text(t4); 
				delete_text(t5); 
				multibonus=0; puntbonus=0; premia=0; BREAK;
			END
		END
	
		FRAME;
	
	END
	
END

//***************************************************
// AUTOBUS SCROLL
//***************************************************
PROCESS autobus(x,y);

PRIVATE

	dist;
	cont;

BEGIN

	graph=534;
	flags=rand(0,1);
	angle=rand(-45000,45000);
	z=-5;
	detect_bonus();
	
	IF (rand(1,10)<3) fuego2(x,y); END
	IF (size==100) circulo(x,y,240); END
	
	LOOP
		
		IF (estrellado==0)
		
			cont++;
			
			IF (y<0)
				IF (collision(TYPE paso_elevado)); BREAK; END
			END
		
			y+=vel;
		
			IF (amb_out==0) dist=fget_dist(x,y,pr3.x,pr3.y); END
			IF (dist<300 AND invencible==0) 
				IF (collision(TYPE ambulancia_scroll) AND estrellado==0) estrellado=100; END
			END
		
			IF (y>450) BREAK; END
		
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// FUEGO COCHES
//***************************************************
PROCESS fuego(x,y);

PRIVATE

	cont;
	cont2;

BEGIN

	z=-21;
	graph=520;
	fx.alpha=200;
	size=father.size-35;	
	
	LOOP
	
		cont++; cont2++;
		
		x=father.x; y=father.y-18;
		
		IF (cont==10) graph++; cont=0; END
		IF (graph>521) graph=520; END
	
		IF (estrellado==0)
			IF (cont2==8) humo_coches2(x,y-20); cont2=0; END
		ELSE
			IF (cont2=>5) humo_coches2(x,y-14); cont2=0; END
		END
		
		IF (y>420) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// FUEGO COCHES 2
//***************************************************
PROCESS fuego2(x,y);

PRIVATE

	cont;
	cont2;

BEGIN

	z=-4;
	graph=520;
	fx.alpha=200;
	size=80;	
	
	LOOP
	
		cont++; cont2++;
		
		x=father.x; y=father.y-15;
		
		IF (cont==10) graph++; cont=0; END
		IF (graph>521) graph=520; END
	
		IF (estrellado==0)
			IF (cont2==8) humo_coches(x,y-20); cont2=0; END
		ELSE
			IF (cont2=>5) humo_coches(x,y-14); cont2=0; END
		END

		IF (y>420) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// CÍRCULO DE DISTANCIA ENTRE COCHES
//***************************************************
PROCESS circulo(x,y,size);

BEGIN

	graph=525;
	z=-4; 
	visible=0;
	
	LOOP
	
		x=father.x; y=father.y;
	
		IF (collision(TYPE circulo)) signal(father,s_kill); BREAK; END
	
		IF (y>420) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// PEATÓN CARRETERA
//***************************************************
PROCESS peaton();

PRIVATE

	cont; cont2;
	dir;
	cambio;
	cont_cambio;
	cont_text;
	atropellado;
	text_p;
	haytext;
	
BEGIN

	graph=530;
	size=160;
	x=rand(200,440);
	y=-20;
	z=-6;
	
	
	IF (x<320) dir=1; ELSE dir=2; END
	
	LOOP
	
		// SI ESTÁ DEBAJO DE UN PUENTE NADA MÁS APARECER, FUERA
		IF (y<0)
			IF (collision(TYPE paso_elevado)); BREAK; END
		END
	
		cont++; cont2++;
		
		// SI NACE JUNTO A UN COCHE, TAMBIÉN FUERA
		IF (cont2==1)
			IF (collision(TYPE coche_scroll) OR collision(TYPE autobus)) BREAK; END
		END
	
		// SI COLISIONA CON UN COCHE O AUTOBÚS...
		IF (overlap(TYPE coche_scroll) OR overlap(TYPE autobus) OR x<200 OR x>440)
			IF (dir==1) x--; dir=2; cambio++; ELSE x++; dir=1; cambio++; END
		END
		
		// CAMBIO DE SENTIDO
		IF (cambio>0) cont_cambio++;
			IF (cont_cambio==3) cambio--; cont_cambio=0; END
			IF (cambio>1) BREAK; END
		END
			
	
		// ANIMACIÓN
		IF (graph!=532)
			IF (cont==10) graph=531; END
			IF (cont==20) graph=530; cont=0; END
			IF (y>420) BREAK; END
			SWITCH (dir)
				CASE 1: x++; flags=0; END
				CASE 2: x--; flags=1; END
			END
		END
	
		// ATROPELLADO
		IF (estrellado==0 AND start==1)			
			y+=vel; 
			IF (collision(TYPE ambulancia_scroll) AND invencible==0 AND atropellado==0) 
				atropellado=1; graph=532; size=140; score-=1000; score2-=1000;
				penaliza(); perfect=1;
				IF (conf_son==0) sound_play(fx25,100,256); sound_play(fx26,100,256); sound_play(fx20,150,256); END
			END
		END
		
		// SI LA AMBULANCIA ESTÁ PARADA CAMBIA DE SENTIDO
		IF (estrellado!=0 AND overlap(TYPE ambulancia_scroll))
			IF (dir==1) x-=2; dir=2; ELSE x+=2; dir=1; END
		END
		
		IF (estrellado==1 AND haytext==1) delete_text(text_p); BREAK; END
		IF (y>420) BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// GRÁFICO -1.000
//***************************************************
PROCESS penaliza();

PRIVATE

	cont;

BEGIN

	graph=940;
	size=125;
	x=father.x;
	y=father.y-12;
	z=-40;
	
	LOOP
	
		cont++;
		
		x=father.x; y=father.y-24;
		
		IF (cont==40 OR y>420) BREAK; END
		
		FRAME;
	
	END
	
END
//***************************************************
// PÁJARO CARRETERA
//***************************************************
PROCESS pajaro();

PRIVATE

	lado;
	cont;
	ide;

BEGIN

	graph=535;
	size=rand(90,120);
	y=-20;
	z=-30;
	
	lado=rand(1,2);
	IF (lado==1) x=rand(40,160); ELSE x=rand(480,600); END
	
	LOOP
	
		IF (menupausa==0) cont++; END
		
		IF (y<0 AND collision(TYPE pajaro)) BREAK; END
		
		IF (cont==8) graph++; cont=0; END
		IF (graph>536) graph=535; END
		
		IF (estrellado==0 AND menupausa==0) y+=vel-2; 
		ELSE 
			SWITCH (nivel)
				CASE 1: y-=vel-2; END
				CASE 2: y-=vel-3; END
				CASE 3: y-=vel-4; END
			END
		END
		
		IF (collision(TYPE paso_elevado)) ide=get_id(TYPE paso_elevado); 
			IF (ide.size==230) z=-19; ELSE z=-30; END
		ELSE z=-21; 
		END
		
		IF (y>520 OR y<-120) pajaros--; BREAK; END
		
		FRAME;
		
	END
	
END

//***************************************************
// SECUENCIA FINAL (HOSPITAL)
//***************************************************
PROCESS secuencia_final();

PRIVATE

	est;
	num_man;
	pancartas;
	ult_rand;
	num_coches;
	
BEGIN

	stage=3;
	main();
	yavale=0;
	start_scroll(0,0,0,850,0,1);
	scroll.y0=998;
	capa2();
	caseta();
	pr3=ambulancia_final();
	set_fps(90,0);
	
	IF (nivel==3)
		militar(85,352); militar(555,352);
		militar(33,453); militar(607,453);
	END
	
	IF (nivel>1)
		pancarta(c_scroll,260,590,rand(855,858));	
		ult_rand=son.graph;
	END
	
	
	
	fade(100,100,100,0);
	
	LOOP		
	
		IF (nivel>1)
			IF (pancartas==0) pancarta(c_scroll,376,560,rand(855,858));	pancartas=1; END
			IF (pancartas==1 AND son.graph==ult_rand) signal(son,s_kill); pancartas=0; END
			FOR (num_man;num_man<250;num_man+=1)
			manifas();
			END
		END
	
		IF (nivel==3)
			IF (rand(0,25)<3) manifa_run(); END
			IF (rand(0,180)<1) camilla_militar(rand(360,408)); END
		END
		
		FRAME;
		
	END
	
END

//***************************************************
// 2ª CAPA SECUENCIA FINAL (HOSPITAL)
//***************************************************
PROCESS capa2();

BEGIN

	graph=851;
	z=-100;
	ctype=c_scroll;
	
	x=320; y=700;
	
	LOOP
	
		FRAME;
		
	END
	
END

//***************************************************
// CASETA SECUENCIA FINAL
//***************************************************
PROCESS caseta();

PRIVATE

	est;
	cont;

BEGIN

	graph=860;
	ctype=c_scroll;
	x=333; y=1200;
	z=-110;
	
	LOOP
	
		IF (int_final==1) est=1; int_final=0; END
		
		IF (est==1) cont++;
			IF (cont==10) graph++; cont=0; END
			IF (graph==863) est=2; cont=0; END
		END
		
		IF (est==2) cont++;
			IF (cont==180) est=3; cont=0; END
		END
		
		IF (est==3) cont++;
			IF (cont==10) graph--; cont=0; END
			IF (graph==860) est=0; END
		END
	
		FRAME;
		
	END
	
END

//***************************************************
// AMBULANCIA SECUENCIA FINAL
//***************************************************
PROCESS ambulancia_final();

PRIVATE

	cont; cont2; cont3; cont_s; cont_h;
	tx1; tx2; tx3;
	velocidad=1;
	fase;
	tope;
	bajada_volumen=80;
	retraso_luz;
	
BEGIN

	graph=510;
	ctype=c_scroll;
	x=320; y=1500;
	z=-10;
	
	scroll.y0=id.y-200;
	
	LOOP

		IF (retraso_luz<3) retraso_luz++; END
		IF (retraso_luz==3) pr5=luces_amb(); retraso_luz=4; END
	
		cont++; cont2++; cont_s++;
		
		/* IF (keydown(_z) AND tope==0) tope=1; set_fps(600,0); END
		IF (keydown(_x) AND tope==0) tope=1; set_fps(60,0); END
		IF (tope==1 AND !keydown(_z) AND !keydown(_x)) tope=0; END */
		
		IF (fase!=12 AND fase!=17)
			IF (cont2==4) 
				IF (angle==0) x++; ELSE y++; END
			END
			IF (cont2==8) 
				IF (angle==0) x--; cont2=0; ELSE y--; cont2=0; END
			END
		END
	
		IF (cont_s>480 AND fase<11) scroll.y0--; END
	
		SWITCH (fase)
			CASE 0: // NOS ACERCAMOS A LA VALLA 
				IF (cont<236) y--; 
				ELSE 
					cont=0; fase=1; int_final=1; 
				END 
			END
			CASE 1: // PASAMOS LA VALLA HASTA LA ROTONDA
				IF (cont>60) fase=2; END
			END
			CASE 2: // INICIAMOS ROTONDA
				y--;
				IF (cont==372) cont=0; fase=3; END
			END
			CASE 3:
				cont3++;
				IF (cont3==5) angle-=5000; cont3=0; cont++; x+=3; y-=2; END
				IF (cont==55) cont3=0; cont=0; fase=4; END
			END
			CASE 4:
				cont3++;
				IF (cont3==5) cont3=0; cont++; x+=3; y-=2; END
				IF (cont==75) cont3=0; cont=0; fase=5; END
			END
			CASE 5:
				cont3++;
				IF (cont3==5) angle+=5000; cont3=0; cont++; x+=2; y-=4; END
				IF (cont==55) cont3=0; cont=0; fase=6; END
			END
			CASE 6:
				cont3++; y--;
				IF (cont3==48) cont=0; cont3=0; fase=7; END
			END
			CASE 7:
				cont3++;
				IF (cont3==5) angle+=5000; cont3=0; cont++; x-=3; y-=3; END
				IF (cont==55) cont3=0; cont=0; fase=8; END
			END
			CASE 8:
				cont3++;
				IF (cont3==5) cont3=0; cont++; x-=3; y-=3; END
				IF (cont==58) cont=0; cont3=0; fase=9; END
			END
			CASE 9:
				cont3++;
				IF (cont3==5) angle-=5000; cont3=0; cont++; x-=3; y-=3; END
				IF (cont==55) fase=10; cont3=0; cont=0; END
			END
			CASE 10: // SALIMOS DE LA ROTONDA
				y--;
				IF (cont==35) 
					IF (nivel!=1) fase=11; ELSE fase=13; cont=0; END
				END
			END
			CASE 11: // MENSAJE DE MANIFESTACIÓN
				IF (conf_son==0) sound_play(fx2,255,256); END
				tx1=write(fnt3,320,152,1,"¡UNA MANIFESTACIÓN TE IMPIDE EL PASO!");
				tx2=write(fnt3,320,285,1,"ESPACIO = Pasar despacio tocando el claxon");
				tx3=write(fnt3,320,335,1,"ENTER = ¡Pisar el acelerador a fondo!");
				fase=12;
			END
			CASE 12: // SELECCIONAMIOS OPCIÓN
				IF (keydown(_space)) fase=13; cont=0; cont2=0;
					IF (conf_son==0) sound_play(fx2,255,256); END
					delete_text(tx1); delete_text(tx2); delete_text(tx3);
					IF (conf_son==0) sound_play(fx29,170,256); END
				END
				IF (keydown(_enter)) fase=20; cont=0; cont2=0;
					IF (conf_son==0) sound_play(fx2,255,256); END
					delete_text(tx1); delete_text(tx2); delete_text(tx3);
				END
			END
			CASE 13: // AVANZA DESPACIO Y PITANDO
				scroll.y0-=1; y--;
				IF (y<390) fase=14; END
			END
			CASE 14: // GIRA A LA IZQUIERDA, FINAL DE RECTA
				scroll.y0--; x--; angle=90000;
				IF (x<182) fase=15; END
			END
			CASE 15: // TIRA PARA ARRIBA
				scroll.y0--; angle=0; y--;
				IF (y<270) fase=16; END
			END
			CASE 16: // GIRA A LA IZQUIERDA HACIA LA ENTRADA
				x++; angle=-90000;
				IF (x>320) fase=17; cont=0; END
			END
			CASE 17:
				IF (cont==1)
					tx2=write(fnt4,320,80,1,"¡NIVEL SUPERADO!");
					yavale=1; set_fps(60,0);
					IF (conf_son==0)
						sound_play(fx14,200,256); sound_play(fx15,230,256);
					END
				END
				IF (cont==160) fade(0,0,0,0); fase=18; cont=0; END
			END
			CASE 18: // AVANZAMOS DE NIVEL
				IF (conf_mus==0)
					bajada_volumen--; songchannel_set_volume(0,bajada_volumen);
				END
				IF (cont==200) 
					delete_text(all_text); let_me_alone(); rescatados=0; nivel++; intro=0; introd(); BREAK;
				END
			END
			CASE 20: // PISA A FONDO!!!
				scroll.y0-=3; y-=3; 
				IF (y<390) fase=14; END
			END
		END
	
		/* IF (fase<17 OR fase==20) cont_h++;
			IF (cont_h=>4) humo_scroll_f(); cont_h=0; END
		END */
	
		FRAME;
		
	END
	
END

//***************************************************
// HUMO AMBULANCIA SCROLL
//***************************************************
PROCESS humo_scroll_f();

BEGIN

	graph=523;
	fx.alpha=120;
	z=-11;
	ctype=c_scroll;
	angle=rand(0,360000);
	size=rand(60,130);
	
	SWITCH (father.angle)
		CASE 0: x=father.x-6; y=father.y+26; END
		CASE 90000: x=father.x+27; y=father.y+6; END
		CASE -90000: x=father.x-27; y=father.y-6; END
	END
	
	LOOP
		
		size+=20; fx.alpha-=10;
		
		SWITCH (father.angle)
			CASE 0:	y+=1; END
			CASE 90000:	x+=1; END
			CASE -90000: x-=1; END
		END

		IF (fx.alpha=<1) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// METRALLETA MILITAR HOSPITAL
//***************************************************
PROCESS militar(x,y);

PRIVATE

	cont; cont2; cont3;
	tiempo; duracion;
	dist;
	
BEGIN

	graph=852;
	size=160;
	z=-10;
	ctype=c_scroll;
	
	LOOP
	
		cont++;
		
		dist=fget_dist(x,y,pr3.x,pr3.y);
		
		IF (tiempo==0) tiempo=rand(100,300); END
		IF (cont==tiempo) cont2=1; duracion=rand(10,50); END
		
		IF (cont2>0) cont2++;
			IF (cont2==10) graph++; cont2=1; cont3++; END
			IF (cont3==duracion) cont=0; cont2=0; cont3=0; tiempo=0; graph=852; END
		END
		
		IF (graph==853 AND conf_son==0 AND scroll.y0<470 AND yavale==0 AND dist<400) sound_play(fx30,15,256); END
		
		IF (graph>853) graph=852; END
		
	
		FRAME;
		
	END
	
END

//***************************************************
// CAMILLEROS MILITARES
//***************************************************
PROCESS camilla_militar(y);

PRIVATE

	lado;
	cambio;
	cont;
	dist;
	distm;
	
BEGIN

	lado=rand(0,1);
	graph=701;
	ctype=c_scroll;
	size=120;
	z=-5;
	
	IF (lado==0) x=-20; ELSE x=660; END
	
	LOOP
	
		cont++;
		
		IF (x<0 OR x>640)
			IF (collision(TYPE camilla_militar)) BREAK; END
		END
		
		IF (cont==3) graph++; cont=0; END
		IF (graph>716) graph=701; END	

		IF (lado==0) x+=2; ELSE x-=2; END
		
		IF (x<-40 OR x>680) BREAK; END
	
		dist=fget_dist(x,y,pr3.x,pr3.y);

		IF (dist<40 AND cambio==0) cambio=1;
			IF (lado==0) x-=4; lado=1; ELSE x+=4; lado=0; END
		END
	
		FRAME;
		
	END
	
END

//***************************************************
// MANIFESTANTES
//***************************************************
PROCESS manifas();

PRIVATE

	cont;
	conti=rand(5,10);
	contf=rand(15,20);
	cont_dist; cont_dist2;
	est;
	apartar;
	dist_amb;
	medio; medio_f=rand(20,50);
	
BEGIN

	graph=531;
	z=-10;
	size=140;
	x=rand(220,420);
	y=rand(440,630);
	ctype=c_scroll;
	flags=rand(0,1);
	
	IF (x>290 AND x<350) medio=1; END
	
	LOOP
	
		dist_amb=fget_dist(x,y,pr3.x,pr3.y);
	
		SWITCH (est)
			CASE 0: cont++;
				IF (cont==conti) y--; END
				IF (cont==contf) y++; cont=0; END
				IF (cont==0) conti=rand(5,10); contf=rand(15,20); END
				IF (collision(TYPE manifas)) est=1; cont=0; END
			END
			CASE 1: cont++;
				IF (collision(TYPE manifas)) apartar=rand(1,4);
					SWITCH (apartar)
						CASE 1: IF (cont==4) x++; cont=0; END END
						CASE 2: IF (cont==4) x--; cont=0; END END
						CASE 3: IF (cont==4) y++; cont=0; END END
						CASE 4: IF (cont==4) y--; cont=0; END END
					END
				ELSE est=0; 
				END
			END
		END
	
		IF (collision(TYPE ambulancia_final) AND est<10) graph=531; z=-100; est=10; cont=0; 
			IF (conf_son==0) sound_play(fx25,100,256); sound_play(fx26,100,256); END
		END
		IF (est==10) cont++;
			angle+=7000; size++;
			IF (cont==30) size=140; angle=0; z=-1; graph=532; x+=rand(-4,4); est=11; END
		END
		
		IF (dist_amb<90 AND x>290 AND x<350 AND est<10) cont_dist++; medio=2;
			IF (cont_dist==2)
				IF (x>320) x+=1; END
				IF (x=<320) x-=1; END
				cont_dist=0;
			END
		ELSE IF (est<10) cont_dist=0; 
				IF (medio>1) cont_dist2++; medio++;
					IF (cont_dist2==2)
						IF (x>320) x-=1; cont_dist2=0; END
						IF (x<320) x+=1; cont_dist2=0; END
					END
					IF (medio==medio_f) medio_f=rand(20,50); medio=1; cont_dist2=0; END
				END
			END
		END 
		
		FRAME;
		
	END
	
END

//***************************************************
// PANCARTA
//***************************************************
PROCESS pancarta(ctype,x,y,graph);

PRIVATE

	cont;
	conti; contf;

BEGIN

	size=160;
	z=-12;
	conti=rand(5,10); 
	contf=rand(15,20);
	
	LOOP
	
		cont++;
		
		IF (cont==conti) y--; END
		IF (cont==contf) y++; cont=0; END
		IF (cont==0) conti=rand(5,10); contf=rand(15,20); END
	
		FRAME;
		
	END
	
END

//***************************************************
// MANIFA CORRIENDO
//***************************************************
PROCESS manifa_run();

PRIVATE

	lado;
	cont;
	tipo_m;
	
BEGIN

	graph=531;
	size=150;
	ctype=c_scroll;
	y=rand(450,620);
	
	tipo_m=rand(0,1);
	lado=rand(0,1);
	
	IF (tipo_m==0)
		IF (lado==0) x=-20; ELSE flags=1; x=660; END
	ELSE
		IF (lado==0) x=350; ELSE x=290; flags=1; END
	END
	
	LOOP
	
		cont++;
		IF (cont==6) graph++; cont=0; END
		IF (graph>531) graph=530; END
		
		IF (lado==0) x++; ELSE x--; END
		
		IF (x<-40 OR x>680) BREAK; END
	
		IF (collision(TYPE manifas) AND x>290 AND x<350) BREAK; END
	
		FRAME;
		
	END
	
END

//***************************************************
// HIGHSCORES
//***************************************************

PROCESS highscores();

PRIVATE

	solo1;

	cont; cont_s; // contador y contador para el scroll

	txt;
	
	puesto; // para definir si se ha ganado un puesto en el rank

	est; // estado
	
	est_i; // estado iniciales
	
	letra;
	posl;
	
	string ini; // inicial
	string ini2; 
	string ini3;
	
	string nombre; // nombre formado por las 3 iniciales
	
	car[37]="A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","-","0","1","2","3","4","5","6","7","8","9","-";
	ncar; // carácteres y el número a escoger
	
	ti; ti2; ti3; // variables para los textos de iniciales
	
	bajada_volumen=80;
	
BEGIN

	IF (score>punt[4].points AND score<=punt[3].points) puesto=5; END // CÁLCULO DE PUESTO SEGÚN PUNTUACIÓN
	IF (score>punt[3].points AND score<=punt[2].points) puesto=4; END
	IF (score>punt[2].points AND score<=punt[1].points) puesto=3; END
	IF (score>punt[1].points AND score<=punt[0].points) puesto=2; END
	IF (score>punt[0].points) puesto=1; END
	
	IF (puesto>0 AND est==0) est=1; // si alcanzamos un puesto en el ranking...
		write(fnt3,320,60,1,"¡ENHORABUENA!");
		write(fnt3,320,100,1,"¡¡ENTRASTE EN LAS MÁXIMAS PUNTUACIONES!!");
		write(fnt1,320,240,1,"MUEVE LOS CURSORES PARA SELECCIONAR INICIAL CON ENTER");
		write(fnt4,320,278,1,OFFSET score);
		write(fnt1,320,350,1,"HAS QUEDADO EN LA   ª POSICIÓN!");
		write_int(fnt1,354,350,1,OFFSET puesto);
	END
	
	IF (puesto==0) est=10; END // Si no conseguimos entrar en el ranking, pasamos a mostrarlo
	
	LOOP
	
		IF (est=>10)
	
			IF (cont_s==0) y+=2; 
				IF (y=>1180) cont_s=1; END
			END
		
			IF (cont_s==1) y-=2; 
				IF (y=<120) cont_s=0; END
			END
			
			move_scroll(0);
			
		END
	
		IF (solo1==1 AND NOT keydown(_left) AND NOT keydown(_right) AND NOT keydown(_enter)) solo1=0; END // Funciones de teclas
	
		IF (ncar==-1) ncar=37; END
		IF (ncar==38) ncar=0; END
		
		IF (est==1) // INTRODUCCIÓN DE INICIALES / est 1 = Inicial 1 / est 2 = Inicial 2 / est 3 = Inicial 3
		
			cont++;
			
			IF (cont==1) ti=write(fnt4,280,154,1, ini); END
			IF (cont==40) delete_text(ti); END
			IF (cont==60) cont=0; END 
			
			ini=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			
			IF (keydown(_enter) AND solo1==0)
				IF (conf_son==0) sound_play(fx2,200,256); END
				
				solo1=1; cont=0; delete_text(all_text); write(fnt4,280,154,1, ini); ncar=0; est=2;
				
				write(fnt3,320,60,1,"¡ENHORABUENA!");
				write(fnt3,320,100,1,"¡¡ENTRASTE EN LAS MÁXIMAS PUNTUACIONES!!");
				write(fnt1,320,240,1,"MUEVE LOS CURSORES PARA SELECCIONAR INICIAL CON ENTER");
				write(fnt4,320,278,1,OFFSET score);
				write(fnt1,320,350,1,"HAS QUEDADO EN LA   ª POSICIÓN!");
				write_int(fnt1,354,350,1,OFFSET puesto);
				
			END
		
		END
		
		IF (est==2) // 2ª INICIAL
		
			cont++;
			
			IF (cont==1) ti2=write(fnt4,320,154,1, ini2); END
			IF (cont==40) delete_text(ti2); END
			IF (cont==60) cont=0; END 
			
			ini2=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			
			IF (keydown(_enter) AND solo1==0)
				IF (conf_son==0) sound_play(fx2,200,256); END
				solo1=1; cont=0; delete_text(all_text); write(fnt4,280,154,1, ini); write(fnt4,320,154,1, ini2); ncar=0; est=3;
				
				write(fnt3,320,60,1,"¡ENHORABUENA!");
				write(fnt3,320,100,1,"¡¡ENTRASTE EN LAS MÁXIMAS PUNTUACIONES!!");
				write(fnt1,320,240,1,"MUEVE LOS CURSORES PARA SELECCIONAR INICIAL CON ENTER");
				write(fnt4,320,278,1,OFFSET score);
				write(fnt1,320,350,1,"HAS QUEDADO EN LA   ª POSICIÓN!");
				write_int(fnt1,354,350,1,OFFSET puesto);
				
			END
			
		END
	
		IF (est==3) // 3ª INICIAL
		
			cont++;
			
			IF (cont==1) ti3=write(fnt4,360,154,1, ini3); END
			IF (cont==40) delete_text(ti3); END
			IF (cont==60) cont=0; END 
			
			ini3=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; 
				IF (conf_son==0) sound_play(fx1,200,256); END
			END
			
			IF (keydown(_enter) AND solo1==0)
				IF (conf_son==0) sound_play(fx2,200,256); END
				delete_text(all_text); write(fnt4,360,154,1, ini); write(fnt4,320,154,1, ini2); write(fnt3,360,154,1, ini3); 
				solo1=1; est=4; cont=0; 
			END
			
		END
		
		IF (est==4) // RECOLOCAMOS LAS POSICIONES DEL RANKING
		
			IF (puesto==5)
			
				punt[4].name=ini+ini2+ini3;
				
				punt[4].points=score;
			
				archivo = fopen("../files/scores.dat", "w");
				fwrite(&punt, sizeof(punt), archivo);
				fclose(archivo);
			
			END
			
			IF (puesto==4)
			
				punt[4].name=punt[3].name;
				
				punt[4].points=punt[3].points;
			
				punt[3].name=ini+ini2+ini3;
				
				punt[3].points=score;
			
				archivo = fopen("../files/scores.dat", "w");
				fwrite(&punt, sizeof(punt), archivo);
				fclose(archivo);
				
			END
		
			IF (puesto==3)
			
				punt[4].name=punt[3].name;
				
				punt[4].points=punt[3].points;
			
				punt[3].name=punt[2].name;
				
				punt[3].points=punt[2].points;
			
				punt[2].name=ini+ini2+ini3;
				
				punt[2].points=score;
			
				archivo = fopen("../files/scores.dat", "w");
				fwrite(&punt, sizeof(punt), archivo);
				fclose(archivo);
				
			END
			
			IF (puesto==2)
			
				punt[4].name=punt[3].name;
				
				punt[4].points=punt[3].points;
			
				punt[3].name=punt[2].name;
				
				punt[3].points=punt[2].points;
			
				punt[2].name=punt[1].name;
				
				punt[2].points=punt[1].points;
			
				punt[1].name=ini+ini2+ini3;
				
				punt[1].points=score;
			
				archivo = fopen("../files/scores.dat", "w");
				fwrite(&punt, sizeof(punt), archivo);
				fclose(archivo);
				
			END
			
			IF (puesto==1)
			
				punt[4].name=punt[3].name;
				
				punt[4].points=punt[3].points;
			
				punt[3].name=punt[2].name;
				
				punt[3].points=punt[2].points;
			
				punt[2].name=punt[1].name;
				
				punt[2].points=punt[1].points;
			
				punt[1].name=punt[0].name;
				
				punt[1].points=punt[0].points;
			
				punt[0].name=ini+ini2+ini3;
				
				punt[0].points=score;
			
				archivo = fopen("../files/scores.dat", "w");
				fwrite(&punt, sizeof(punt), archivo);
				fclose(archivo);
				
			END
		
			delete_text(all_text); est=10;
		
		END
	
		IF (est==10) // MOSTRAMOS RANKING
		
			write(fnt4,320,25,1,"PUNTUACIONES");
		
			write(fnt3,240,122,1,"1.");
			write(fnt3,240,154,1,"2.");
			write(fnt3,240,186,1,"3.");
			write(fnt3,240,218,1,"4.");
			write(fnt3,240,250,1,"5.");
	
			write(fnt3,280,122,1,punt[0].name);
			write(fnt3,280,154,1,punt[1].name);
			write(fnt3,280,186,1,punt[2].name);
			write(fnt3,280,218,1,punt[3].name);
			write(fnt3,280,250,1,punt[4].name);
	
			write_int(fnt3,373,122,1, OFFSET punt[0].points);
			write_int(fnt3,373,154,1, OFFSET punt[1].points);
			write_int(fnt3,373,186,1, OFFSET punt[2].points);
			write_int(fnt3,373,218,1, OFFSET punt[3].points);
			write_int(fnt3,373,250,1, OFFSET punt[4].points);
			
			est=11; cont=0;
			
		END
		
		IF (est==11)
		
			cont++;
			
			IF (cont==1) txt=write(0,320,306,1,"- PULSA ENTER PARA CONTINUAR -"); END	
			IF (cont==40) delete_text(txt); END
			IF (cont>60) cont=0; END
			
			IF (keydown(_enter) AND solo1==0) solo1=1; fade(0,0,0,0); est=12; cont=0; END 
			
		END
		
		IF (est==12)
		
			cont++;
			IF (conf_mus==0)
				bajada_volumen--; songchannel_set_volume(0,bajada_volumen);
			END
			
			IF (cont==180) delete_text(all_text); let_me_alone(); 
				rescatados=0; nivel=1; intro=1; gameover=0; vidas=3; score=0; score2=0; start=0; amb_out=0; fin_del_final=0; introd(); 
				BREAK; 
			END
			
		END
	
		FRAME;
		
	END
	
END

//***************************************************
// HIGHSCORES MENÚ
//***************************************************
PROCESS highmenu();

PRIVATE

	float cord=-100;
	sentido;
	cont; cont2;
	txt;
	tope=1;
	
BEGIN

	define_region(1, 103, 0, 414, 400);
	start_scroll(0,0,950,0,1,2);
	fade(100,100,100,0);
	scroll.z=-10;
	graph=951;
	x=320; y=-100;
	z=10;
	
	brillo(130); 
	
	write(fnt4,320,25,1,"PUNTUACIONES");
	
	write(fnt3,240,122,1,"1.");
	write(fnt3,240,154,1,"2.");
	write(fnt3,240,186,1,"3.");
	write(fnt3,240,218,1,"4.");
	write(fnt3,240,250,1,"5.");
	
	write(fnt3,280,122,1,punt[0].name);
	write(fnt3,280,154,1,punt[1].name);
	write(fnt3,280,186,1,punt[2].name);
	write(fnt3,280,218,1,punt[3].name);
	write(fnt3,280,250,1,punt[4].name);
	
	write_int(fnt3,373,122,1, OFFSET punt[0].points);
	write_int(fnt3,373,154,1, OFFSET punt[1].points);
	write_int(fnt3,373,186,1, OFFSET punt[2].points);
	write_int(fnt3,373,218,1, OFFSET punt[3].points);
	write_int(fnt3,373,250,1, OFFSET punt[4].points);
	
	LOOP
	
		y=cord;
		
		IF (sentido==0)
			cord+=0.4;
			scroll.y0--;
		ELSE
			cord-=0.4;
			scroll.y0++;
		END
		
		IF (y>420)
			IF (sentido==0) sentido=1; END
		END
		
		IF (y<-99) 
			IF (sentido==1) sentido=0; END
		END
		
		cont++;
			
		IF (cont==1) txt=write(0,320,306,1,"- PULSA ENTER PARA CONTINUAR -"); END	
		IF (cont==40) delete_text(txt); END
		IF (cont>60) cont=0; END
		
		IF (keydown(_enter) AND tope==0 OR keydown(_esc) AND tope==0) tope=1; cont2=1; fade(0,0,0,2); END
		
		IF (cont2>0) cont2++;
			IF (cont2==50) signal(son,s_kill_tree); 
				fade(100,100,100,1); intro=0; menu_out=0; menu(); stop_scroll(0); delete_text(all_text); 
				write(0,320,372,1,"COPYRIGHT - LONELY ANT STUDIO - 2020");
				BREAK;
			END
		END
		
		IF (tope==1 AND !keydown(_enter) AND !keydown(_esc)) tope=0; END
		
		FRAME;
		
	END
	
END

//***************************************************
// BRILLO EDIFICIO
//***************************************************
PROCESS brillo(x);

BEGIN

	graph=952;
	fx.alpha=200;
	y=200;
	z=-50;
	brillo2(510);
	
	LOOP
	
		FRAME;
		
	END
	
END

//***************************************************
// BRILLO EDIFICIO 2
//***************************************************
PROCESS brillo2(x);

BEGIN

	graph=952;
	fx.alpha=200;
	y=200;
	z=-50;
	
	LOOP
	
		FRAME;
		
	END
	
END

//***************************************************
// PANTALLA FINAL
//***************************************************
PROCESS pantallafinal();
	
BEGIN

	IF (conf_mus==0)
		song_play(sngf,0); songchannel_set_volume(0,80);
	END
	
	stage=4;
	graph=990;
	size=2000;
	x=320; y=200;
	
	pantallafinal2();
	
	LOOP
	
		FRAME;
		
	END
	
END

//***************************************************
// PANTALLA FINAL 2
//***************************************************
PROCESS pantallafinal2();
	
PRIVATE
	
	cont; cont2; cont3; cont_i;
	hayavion;
	
BEGIN

	graph=999;
	fx.alpha=0;
	x=320; y=200;
	
	LOOP
		
		cont_i++; cont3++;
		
		IF (hayavion==0 AND rand(1,100)<3 AND cont_i>460) avion_final(); hayavion=1; END
		
		IF (hayavion==1) cont2++;
			IF (cont2==600) hayavion=0; cont2=0; END
		END
		
		cont++;
		IF (cont==2 AND fx.alpha<256) cont=0; fx.alpha++; END
	
		IF (cont3==400) tfinal(980,130); END
		IF (cont3==700) tfinal(981,200); END
		IF (cont3==1160) tfinal(982,278); END
		IF (cont3==1550) tfinal(983,350); END
		IF (cont3==2050) fin_del_final=1; END
		IF (cont3==2450) highscores(); END
		FRAME;
		
	END
	
END

//***************************************************
// AVIÓN PANTALLA FINAL
//***************************************************
PROCESS avion_final();

PRIVATE

	lado;
	cont;
	
BEGIN

	lado=rand(1,2);
	IF (lado==1) x=-30; ELSE x=670; flags=1; END
	graph=997;
	y=rand(10,30);
	
	LOOP
	
		cont++;
	
		IF (lado==1) x++; ELSE x--;	END
		
		IF (x<-50 OR x>690) BREAK; END
		
		IF (cont==6) graph++; cont=0; END
		IF (graph>998) graph=997; END
		
		FRAME;
		
	END
	
END

//***************************************************
// TEXTO FINAL
//***************************************************
PROCESS tfinal(graph,y);

PRIVATE

	cont;

BEGIN 

	x=320;
	fx.alpha=0;
	
	LOOP
		
		cont++;
		
		IF (fin_del_final==0)
			IF (fx.alpha<256 AND cont==2) cont=0; fx.alpha+=2; END		
		ELSE
			IF (fx.alpha>0 AND cont=>2) cont=0; fx.alpha-=2; END
		END
		
		FRAME;
		
	END
	
END