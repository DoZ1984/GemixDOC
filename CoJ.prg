//********************************************************************
// CALL OF JOFRE
// ------------------------------
// AUTOR: DoZ --- EMAIL: md_jille@hotmail.com
//
// VERSION: 1.0 --- FECHA: 07/06/2016
//
//********************************************************************

PROGRAM Call_Of_Jofre;

GLOBAL

	sng_pause; // para hacer la pausa de la música

	modop; // modo de pantalla

	x2; nocount; godmode; speed; // Variables de los items

	speed2;
	
	secs; // segundos del contador
	
	fase; // número de fase
	
	gameover; // para saber si estamos en gameover
	
	nivel; // nivel de juego
	
	level_up; // para indicar que subimos de nivel
	
	sumacombo; // para controlar si se consigue combo

	archivo; // archivo para el ranking
	
	archivo2; // archivo para los stats
	
	score; // puntuación
	
	score_extra; // para manejar las vidas extra

	sel_audio; // selección del audio
	
	vidas; // vidas
	
	vidaextra; // para cuando ganamos una vida extra
	
	quitavida; // para quitar vidas
	
	sumavida; // para sumar vidas
	
	comercial_cruzando; // para saber si Comercial ya está cruzando
	
	pref_cruzando; // para saber si Preferencias ya está cruzando
	
	encargado_cruzando; // para saber si Encargado ya está cruzando
	
	encargado_returns; // para retardar un poco el retorno tras la muerte de Encargado
	
	alpinista_cruzando; // para saber si la Alpinista está cruzando
	
	alpinista_returns; // para retardar un poco el reorno tras la muerte de Alpinista
	
	alpinista_muerte; // para saber si está o no
	
	pepe_cruzando; // para saber si Pepe cruza
	
	sindic_cruzando; // para saber si los sindicalistas cruzan
	
	exped; // Alpinista expedida
	
	enganche; // para saber si la alpinista está enganchada a la moto
	
	choque; // para saber si hemos topado con el Preferencias u otras cosas, más adelante..
	
	palefuera; // para lo mismo con el palé
	
	rejofre; // Para llamar al Jofre de nuevo
	
	carga; // Para saber si estamos cargados con un palé o no
	
	haypale; // Para saber si hay un palé existente
	
	lado; // dirección de la moto para sincronizarlo con el palé
	
	expedidos; // número de palés expedidos
	
	expedint; // expidiendo palés
	
	deaths; // número de muertos
	
	deathsj; // número de muertos por el Jofre
	
	ninja; // variable para el Ninja-Torero
	
	ninja_text; // para avisar de que Jofre ya no es Ninja-Torero
		
	volvertexto=1; // variable para que vuelva
	
	congelar; // si se pulsa congelar...
	
	tope_esc; // tope escape
	
	bloqueo; // bloqueo para el enter
	
	dkm; km; cm; // decenas de kilómetros, kilómetros y centenares de metros recorridos
	
	vel_m; // velocidad de la moto
	
	vel_j1=4; vel_j2=8; // Velocidades de Jofre
	
	vel_e=4; // Velocidad de la estrella ninja
	
	num_e=284; // Número de estrellas (probabilidad)
	
	tam_e=60; // Tamaño de estrellas
	
	vel_p1=2; vel_p2=4; // Velocidades del Preferencias
	
	vel_a=24; // Velocidad del Aura del Preferencias
	
	tam_a=4; // Tamaño del aura
	
	num_t=270; // Número de trabajadores cruzando
	
	vel_pepe=3; // Velocidad con la que el Pepe cruza
	
	prob_pepe=990; // Probabilidad para que Pepe aparezca
	
	d1; d2; d3; d4; d5; d6; d7; d8; d9; d10; // variables de texto de los datos
	d11; d12; d13; d14; d15; d16; d17; d18;
	
	t1; t2; t3; t4; t5;
	t6; t7; t8; t9; t10; // variables de texto
		
	pr0; // proceso Principal
	pr1; // proceso moto
	pr2; // proceso Comercial
	pr3; // proceso Preferencias
	pr4; // proceso aura
	pr5; // proceso trabajador
	pr6; // proceso Jofre
	pr7; // proceso ventana Jofre
	pr8; // proceso Money
	pr9; // proceso ventana Jofre
	pr10; // proceso Zona Recepción
	pr11; // proceso Muelle
	pr12; // proceso ventana expedido
	pr13; // proceso Encargado
	pr14; // proceso Palé
	pr15; // proceso Mini-Mapa
	pr16; // proceso Esfera Mini-Mapa
	pr17; // proceso Mancha de Sangre
	pr18; // proceso Vida
	pr19; // proceso Ventana Ninja-Torero
	pr20; // proceso Estrella Ninja
	pr21; // proceso Alpinista
	pr22; // proceso "Vas cap alla?"
	pr50; // proceso Menú
	pr51; // proceso Congelar
	pr52; // proceso Tiempo
	pr53; // proceso Highscores
	pr54; // proceso Highscores GAME OVER
	pr55; // proceso Pepe
	pr56; // proceso aviso Preferencias
	
	pr100; // proceso Música
	
	fnt1; // fuente 1 - Para ventana Jofre
	fnt2; // fuente 2 - Menú
	fnt3; // fuente 3 - Mensaje de Vida Extra
	
	msc0; msc1; msc2; msc3; msc4; msc5; // Música
	msc6; msc7; msc8; msc9; msc10; 
	
	int sng_id[6];
	
	ultima; // para que no se repita la última canción
	
	snd1; // sonido Game Over
	snd2; // sonido 1UP
	snd3; // sonido Coin Cash
	snd4; snd5; snd6; snd7; // sonidos de aplastamiento
	snd8; // sonido Aura
	snd9; // sonido Life Lost
	snd10; // sonido Pausa
	snd11; // sonido beep Menú
	snd12; // sonido selec Menú
	snd13; // sonido Expedido
	snd14; // sonido COMBO
	snd15; // sonido "Quita coño!"
	snd16; // sonido Ventana Ninja
	snd17; // sonido Grito 1
	snd18; // sonido Grito Alpinista Chafada
	snd19; // sonido Grito Alpinista A tomar por culo
	snd20; // sonido Auuup Alpinista, de cuando se engancha
	snd21; // sonido de FX para cuando se engancha la Alpinista
	snd22; // sonido Aplausos
	snd23; // sonido Three
	snd24; // sonido Two
	snd25; // sonido One
	snd26; // sonido Beep
	snd27; // sonido Coger palé
	snd28; // sonido Soltar palé
	snd29; // sonido Alpinista Expidida
	snd30; // sonido Ventana Jofre
	snd31; // sonido Lanzamiento Estrella
	snd32; // sonido level up
	snd33; // sonido Música level up
	snd34; // sonido Aura FX
	snd35; // sonido item seleccionado
	snd36; // sonido 1 del pasar de los items
	snd37; // sonido 2 del pasar de los items
	snd38; // sonido de contacto con el item y la moto
	snd39; // sonido de aviso de que el item se va
	
	struct punt[4] // ESTRUCTURA PARA EL RANK
	string name;
	points;
	end
	
	struct stats[0]
	n_muertos; // número de muertos
	n_jmuertos; // número de muertos por el Jofre
	n_estrellas; // número de estrellas lanzadas
	n_exp; // número de expedidos
	n_jofres; // número de conversaciones con Jofre
	n_preferencias; // número de veces que nos jode el preferencias
	n_combos; // número de combos
	n_alpinistas; // número de finas expedidas
	n_sindic; // número de sindicalistas muertos
	n_encargados; // número de encargados atropellaados
	n_comerciales; // número de comerciales atropellados
	n_km; // número de km recorridos
	n_secs; // tiemp de juego
	n_minuts; 
	n_hores;
	n_punt; // puntuación total
	end
	
LOCAL

	valor; // para saber el valor del premio del fajo de billetes en cuestión
	
	mini; maxi;
	
BEGIN
	
	sng_id[0] = song_load("../files/sounds/backmenu.wav");
	sng_id[1] = song_load("../files/sounds/music1.wav");
	sng_id[2] = song_load("../files/sounds/music2.wav");
	sng_id[3] = song_load("../files/sounds/music3.wav");
	sng_id[4] = song_load("../files/sounds/music4.wav");
	sng_id[5] = song_load("../files/sounds/music5.wav");
	sng_id[6] = song_load("../files/sounds/music6.wav");
	
	MODE_SET(320,240,32,mode_window,filter_scale_NORMAL2x,filter_scanline_50percent);
	
	//MODE_SET(320,240,32,mode_fullscreen,filter_scale_NORMAL2x,filter_scanline_50percent);
	
	load_fpg("../files/cos.fpg");
	
	fnt1=load_fnt("../files/fonts/jofre.fnt");
	
	fnt2=load_fnt("../files/fonts/menu.fnt");
	
	fnt3=load_fnt("../files/fonts/vida.fnt");
	
	msc0=sound_load("../files/sounds/backmenu.wav");
	msc1=sound_load("../files/sounds/music1.wav");
	msc2=sound_load("../files/sounds/music2.wav");
	msc3=sound_load("../files/sounds/music3.wav");
	msc4=sound_load("../files/sounds/music4.wav");
	msc5=sound_load("../files/sounds/music5.wav");
	msc6=sound_load("../files/sounds/music6.wav");
	
	snd1=sound_load("../files/sounds/gameover.wav");
	snd2=sound_load("../files/sounds/1up.wav");
	snd3=sound_load("../files/sounds/Coin.wav");
	snd4=sound_load("../files/sounds/chof1.wav");
	snd5=sound_load("../files/sounds/chof2.wav");
	snd6=sound_load("../files/sounds/chof3.wav");
	snd7=sound_load("../files/sounds/chof4.wav");
	snd8=sound_load("../files/sounds/aura.wav");
	snd9=sound_load("../files/sounds/life_lost.wav");
	snd10=sound_load("../files/sounds/pause.wav");
	snd11=sound_load("../files/sounds/menu.wav");
	snd12=sound_load("../files/sounds/menu2.wav");
	snd13=sound_load("../files/sounds/expedit.wav");
	snd14=sound_load("../files/sounds/combo.wav");
	snd15=sound_load("../files/sounds/quita.wav");
	snd16=sound_load("../files/sounds/vent_ninja.wav");
	snd17=sound_load("../files/sounds/grito.wav");
	snd18=sound_load("../files/sounds/crit_alp.wav");
	snd19=sound_load("../files/sounds/crit_alp2.wav");
	snd20=sound_load("../files/sounds/auup_alp.wav");
	snd21=sound_load("../files/sounds/fx_auup.wav");	
	snd22=sound_load("../files/sounds/aplausos.wav");
	snd23=sound_load("../files/sounds/three.wav");
	snd24=sound_load("../files/sounds/two.wav");
	snd25=sound_load("../files/sounds/one.wav");
	snd26=sound_load("../files/sounds/bip.wav");
	snd27=sound_load("../files/sounds/coge.wav");
	snd28=sound_load("../files/sounds/suelta.wav");
	snd29=sound_load("../files/sounds/alp_exp.wav");
	snd30=sound_load("../files/sounds/ventana_jofre.wav");
	snd31=sound_load("../files/sounds/star_launch.wav");
	snd32=sound_load("../files/sounds/levelup.wav");
	snd33=sound_load("../files/sounds/levelup_music.wav");
	snd34=sound_load("../files/sounds/aura_fx.wav");
	snd35=sound_load("../files/sounds/item_sel.wav");
	snd36=sound_load("../files/sounds/itempass.wav");
	snd37=sound_load("../files/sounds/itempass2.wav");
	snd38=sound_load("../files/sounds/item.wav");
	snd39=sound_load("../files/sounds/item_out.wav");

	modop=1;
	
	gemix();
	
	/*punt[0].name="DOZ"; punt[0].points=80000;
	punt[1].name="GMB"; punt[1].points=50000;
	punt[2].name="XMC"; punt[2].points=35000;
	punt[3].name="ALS"; punt[3].points=20000;
	punt[4].name="JAF"; punt[4].points=10000;
	
	archivo = fopen("../files/scores.dat", "w");
	fwrite(&punt, sizeof(punt), archivo);
	fclose(archivo);*/
	
	// LEEMOS EL FICHERO PARA LOS HIGHSCORES
	
	archivo = fopen("../files/scores.dat", "r");
	fread(&punt, sizeof(punt), archivo);
	fclose(archivo);
	
	/*archivo2 = fopen("../files/stats.dat", "w");
	fwrite(&stats, sizeof(stats), archivo2);
	fclose(archivo2);*/
	
	archivo2 = fopen("../files/stats.dat", "r");
	fread(&stats, sizeof(stats), archivo2);
	fclose(archivo2);
	
END

//*******************************************************************************************
// MÚSICA
//*******************************************************************************************

PROCESS musica();

PRIVATE

	mus_selected;
	mus_playing;

BEGIN

	// seleccionamos una musica casual
	mus_selected = rand(1, 6);
	// hacemos sonar la musica
	IF (sel_audio==0) sng_id = song_play(mus_selected); END 
	// guardamos cual es la musica que estamos sonando
	mus_playing = mus_selected;
	
	songchannel_set_volume(0, 55);
	
	LOOP
	
		// averiguamos que la musica haya acabado de sonar y seleccionamos otra asegurandonos que no sea la misma		
		if(!songchannel_is_playing(sng_id) AND sng_pause==0)
			mus_selected = rand(1, 6);
			while(mus_selected == mus_playing)
				mus_selected = rand(1, 6);
			end  
			sng_id = song_play(mus_selected); 
			mus_playing = mus_selected;
		end
		
		IF (mus_selected==2)
			songchannel_set_volume(0,80);
			ELSE
			songchannel_set_volume(0,70);
		END

		IF (sng_pause==1) songchannel_pause(0); END

		FRAME;
		
	end

	
END


//*******************************************************************************************
// CABECERA GEMIX
//*******************************************************************************************


PROCESS gemix();

PRIVATE

	cont;

BEGIN
	
	fade(0,0,0,100);
	put_screen(0,300);
	
	LOOP
	
		cont++;
		
		IF (cont==1) fade(100,100,100,1); END
		IF (cont==100) fade(0,0,0,1); END
		IF (cont==170) pr50=menu(); BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// MAIN
//*******************************************************************************************

PROCESS main();

PRIVATE

	cont; // contador para el retardo de la llamada al Encargado una vez muerto
	
	cont_a; // contador para Alpinista
	
	cont_c; // contador para el combo
	
	noninja; // contador para contar el tiempo en que Jofre no se vuelve ninja
	
	prob=6999; // probabilidad para que Jofre se convierta en ninja
	
	cont_ninja; // contador para el tiempo del ninja-torero
	
	texto_n; // variable para el texto intermitente de que Jofre ya no es Ninja-Torero
	
	cont_t; // contador para el mismo texto
	
	mens; // texto del mensaje
	
	datos; // variable para manejar los textos de los datos en pantalla
	
	temp; // temporizador para activar los textos
	
	ret_pepe; // retardo para el rand de la llamada de Pepe
	
	solo1;
	
	seguro_ninja; // para que Jofre no se vuelva ninja nada más empezar
	
BEGIN

	stop_sound(all_sound);
		
	IF (fase==1) // NUEVA PARTIDA
	
		start_scroll(0,0,100,0,0,0); 
		
		vidas=3; // iniciamos con 3 vidas

		score=0; score_extra=0; deaths=0; deathsj=0; expedidos=0; km=0; dkm=0; cm=0; congelar=0; gameover=0; enganche=0;
		encargado_returns=0; encargado_cruzando=0; pref_cruzando=0; alpinista_cruzando=0; alpinista_returns=0; sindic_cruzando=0;
		carga=0; haypale=0; choque=0; secs=40; ninja=0; noninja=0; tope_esc=0; nivel=1; volvertexto=1; lado=0; x2=0; speed=0; godmode=0; nocount=0;
		prob=6999; vel_j1=4; vel_j2=8; vel_e=4; num_e=284; tam_e=60; vel_p1=2; vel_p2=4; vel_a=24; tam_a=4; num_t=270; vel_pepe=3;
		
		pr1=moto(); // ARRANCAMOS PROCESOS
		pr6=jofre();
		pr10=zona();
		pr11=muelle();
		pr15=mapa();
		pr16=esfera();
		pr18=vida();
		pr52=tiempo();
		turbo();
		
		write(0,96,10,0,"MORTS:"); // muertes
		write_int(0,132,10,0,OFFSET deaths);
	
		write(0,165,10,0,"EXPEDITS:"); // expedidos
		write_int(0,219,10,0,OFFSET expedidos); 
	
		write(0,243,10,0,"PUNTS:"); // puntos
		write_int(0,279,10,0,OFFSET score); 
		
	END

	/*write(0,2,210,0,"X");
	write_int(0,10,210,0,OFFSET pr1.x); // coordenadas
	write(0,2,220,0,"Y");
	write_int(0,10,220,0,OFFSET pr1.y);*/
	
	LOOP 		
	
		IF (congelar==1) signal(pr0,s_freeze_tree); borratexto(); pr9=ventana(); congelar=2; END
		
		IF (seguro_ninja<240) seguro_ninja++; END
	
		// REESCRIBIENDO TEXTOS INFERIORES
		
		IF (volvertexto==1)
		
			t3=write_int(0,68,228,0,OFFSET dkm);
			t4=write_int(0,75,228,0,OFFSET km);
			t5=write_int(0,86,228,0,OFFSET cm);
			t6=write(0,81,228,0,". KM");
	
			t7=write(0,130,228,0,"NIVELL:");
			t8=write_int(0,172,228,0,OFFSET nivel);

			t1=write(0,200,228,0,"MORTS PEL JOFRE:"); // muertos por Jofre
			t2=write_int(0,296,228,0,OFFSET deathsj); 
		
			volvertexto=0;
		
		END
		
		// PULSANDO ESCAPE
		
		IF (keydown(_esc) AND tope_esc==0 AND gameover==0) tope_esc=1; signal(pr0,s_freeze_tree); pr51=menu_esc(); END
		
		IF (tope_esc==1 AND NOT keydown(_esc)) tope_esc=0; END
		
		// NIVELES
		
		IF (score>=10000 AND nivel==1) nivel=2; levelup(); END
		IF (score>=20000 AND nivel==2) nivel=3; levelup(); END
		IF (score>=35000 AND nivel==3) nivel=4; levelup(); END
		IF (score>=50000 AND nivel==4) nivel=5; levelup(); END
		IF (score>=65000 AND nivel==5) nivel=6; levelup(); END
		IF (score>=80000 AND nivel==6) nivel=7; levelup(); END
		IF (score>=100000 AND nivel==7) nivel=8; levelup(); END
		IF (score>=120000 AND nivel==8) nivel=9; levelup(); END
		IF (score>=150000 AND nivel==9) nivel=10; levelup(); END
		
		// GAME OVER
			
		IF (vidas==-1) vidas=-2; game_over(); END
		
		IF (gameover==2) ninja=2; END
		
		// VIDA EXTRA
			
		IF (score_extra-score<-19999) score_extra=score_extra+20000;
			IF (vidas!=8) vida_extra(); END 
		END
			
		IF (keydown(_f2)) score+=5000; stats.n_punt+=5000;
			WHILE (keydown(_f2)) FRAME; END
		END
		
		// COMBO ALPINISTA + PALÉ
		
		IF (sumacombo==1) cont_c++; 
			
			IF (cont_c>2) sumacombo-=1; cont_c=0; END
			
		END
		
		IF (sumacombo==2) combo(); sumacombo=3; END
		
		// VELOCIDAD DE LA MOTO
		
		IF (carga==0)
			
			IF (enganche==0) vel_m=6; ELSE vel_m=5; END
			
		ELSE
			
			IF (enganche==0) vel_m=5; ELSE vel_m=4; END
			
		END

		IF (speed==1) vel_m=vel_m+3; END
		IF (speed2==1) vel_m=vel_m+3; END
		
		/*IF (keydown(_shift)) vel_m=vel_m+3; END
		IF (keydown(_control)) vel_m=vel_m+3; END*/
		
		// FUNCIÓN NINJA-TORERO
		
		IF (ninja==1 AND gameover==0 AND seguro_ninja>239) cont_ninja++; // DURACIÓN DEL ESTADO NINJA-TORERO
			
			IF (cont_ninja==500) ninja=0; IF (gameover==0) ninja_text=1; END cont_ninja=0; END
		
		END
		
		IF (ninja==0 AND rand(0,7000)>prob AND gameover==0 AND expedint==0) // EL RAND PARA QUE JOFRE SE VUELVA TORERO-NINJA
		
			signal(pr0,s_freeze_tree); borratexto(); pr19=ventana_ninja(); ninja=1; congelar=1;
		
		END 
		
		IF (ninja==0) noninja++;  
			
			IF (noninja==170) prob-=1; noninja=0; END
		
			ELSE noninja=0; prob=6999;
		
		END
		
		// MENSAJE DE VUELTA A LA NORMALIDAD DE JOFRE
		
		IF (ninja_text==1) cont_t++;
		
			IF (cont_t==1) mens=write(0,67,105,0,"EN JOFRE HA TORNAT A LA NORMALITAT!!"); END
			IF (cont_t==18) delete_text(mens); END
			IF (cont_t==32) mens=write(0,67,105,0,"EN JOFRE HA TORNAT A LA NORMALITAT!!"); END
			IF (cont_t==56) delete_text(mens); END
			IF (cont_t==70) mens=write(0,67,105,0,"EN JOFRE HA TORNAT A LA NORMALITAT!!"); END 
			IF (cont_t==84) delete_text(mens); cont_t=0; ninja_text=0; END
	
		END
			
		// TECLAS PARA PROBAR PROCESOS COMO JOFRE Y VIDAS
				
		IF (keydown(_0) AND solo1==0) solo1=1;
			IF (datos==0) datos=1; END
			IF (datos==2) 
				delete_text(d1); delete_text(d2); delete_text(d3); delete_text(d4); delete_text(d5); delete_text(d6); delete_text(d7); delete_text(d8);
				delete_text(d9); delete_text(d10); delete_text(d11); delete_text(d12); delete_text(d13); delete_text(d14); delete_text(d15); delete_text(d16);
				delete_text(d17); delete_text(d18); datos=0;
			END
		END
		
		/*IF (keydown(_1)) comercial(); END
		
		IF (keydown(_J)) pr6=jofre(); END
		
		IF (keydown(_K) AND solo1==0 AND vidas>0) solo1=1; quitavida=1; END
		
		IF (keydown(_L) AND solo1==0 AND vidas<8) solo1=1; sumavida=1; END
		
		IF (keydown(_N) AND solo1==0 AND ninja==0) signal(pr0,s_freeze_tree); borratexto(); pr19=ventana_ninja(); ninja=1; congelar=1; END
			
		IF (keydown(_1) AND vel_j1>1) vel_j1-=1; vel_j2-=1; END // velocidad de Jofre
			
		IF (keydown(_2) AND vel_j1<20) vel_j1+=1; vel_j2+=1; END
			
		IF (keydown(_3) AND vel_e>1) vel_e-=1; END // velocidad de Estrella
			
		IF (keydown(_4) AND vel_e<20) vel_e+=1; END
			
		IF (keydown(_5) AND vel_p1>1) vel_p1-=1; vel_p2-=1; END // velocidad de Preferencias
			
		IF (keydown(_6) AND vel_p1<20) vel_p1+=1; vel_p2+=1; END
			
		IF (keydown(_7) AND vel_a>1) vel_a-=1; END // velocidad Aura
			
		IF (keydown(_8) AND vel_a<100) vel_a+=1; END
			
		IF (keydown(_q) AND tam_a>1) tam_a-=1; END // tamaño Aura
			
		IF (keydown(_w) AND tam_a<20) tam_a+=1; END
			
		IF (keydown(_e) AND num_e>1) num_e-=1; END // número Estrellas
			
		IF (keydown(_r) AND num_e<300) num_e+=1; END
			
		IF (keydown(_a) AND tam_e>1) tam_e-=1; END // tamaño Estrellas
			
		IF (keydown(_s) AND tam_e<300) tam_e+=1; END
			
		IF (keydown(_d) AND num_t>1) num_t-=1; END
			
		IF (keydown(_f) AND num_t<300) num_t+=1; END
		
		IF (keydown(_g) AND vel_pepe>2) vel_pepe-=1; END
		
		IF (keydown(_h) AND vel_pepe<20) vel_pepe+=1; END
		
		IF (keydown(_t)) secs+=10; END
		
		IF (solo1==1 AND scan_code==0) solo1=0; END
		
		IF (datos==1)
			
			d1=write(0,5,50,0,"1-2 vel_j:",0);
			d2=write_int(0,65,50,0,OFFSET vel_j1); 
		
			d3=write(0,5,60,0,"3-4 vel_e:",0);
			d4=write_int(0,65,60,0,OFFSET vel_e);
		
			d5=write(0,5,70,0,"E-R num_e:",0);
			d6=write_int(0,65,70,0,OFFSET num_e);
		
			d7=write(0,5,80,0,"A-S tam_e:",0);
			d8=write_int(0,65,80,0,OFFSET tam_e);
		
			d9=write(0,5,90,0,"5-6 vel_p:",0);
			d10=write_int(0,65,90,0,OFFSET vel_p1);
		
			d11=write(0,5,100,0,"7-8 vel_a:",0);
			d12=write_int(0,65,100,0,OFFSET vel_a);
		
			d13=write(0,5,110,0,"Q-W tam_a:",0);
			d14=write_int(0,65,110,0,OFFSET tam_a);
				
			d15=write(0,5,120,0,"D-F num_t:",0);
			d16=write_int(0,65,120,0,OFFSET num_t);
			
			d17=write(0,5,130,0,"G-H vel_p:",0);
			d18=write_int(0,65,130,0,OFFSET vel_pepe);
			
			datos=2;
				
		END*/
		
		IF (congelar==0)
		
			IF (rejofre==1) pr6=jofre(); END // LLAMADA A JOFRE
		
			// LLAMAMOS AL PROCESO COMERCIAL
		
			IF (rand(0,2000)>1998)
				IF (comercial_cruzando==0) comercial_cruzando=1; pr2=comercial(); END
			END
		
			// LLAMAMOS AL PROCESO PREFERENCIAS
	
			IF (rand(0,300)>9)
				IF (pref_cruzando==0) pr3=preferencias(); END
			END
		
			// LLAMAMOS AL PROCESO ENCARGADO
		
			IF (encargado_returns==0)
				IF (encargado_cruzando==0) encargado_cruzando=1; pr13=encargado(); END
			ELSE
				cont++; 
				IF (cont>200) encargado_returns=0; cont=0; END
			END
		
			// LLAMAMOS AL PROCESO ALPINISTA
			
			IF (alpinista_returns==0)
				IF (alpinista_cruzando==0) alpinista_cruzando=1; pr21=alpinista(); END
			ELSE
				cont_a++; 
				IF (cont_a>200) alpinista_returns=0; cont_a=0; END
			END
	
			// LLAMAMOS AL PROCESO TRABAJADOR
		
			IF (rand(0,300)>num_t)
				pr5=trabajador();
			END
			
			// LLAMAMOS AL PROCESO PEPE
			
			IF (rand(0,1000)>prob_pepe AND pepe_cruzando==0) pr55=pepe(); END
			
			// LLAMAMOS AL PROCESO SINDICALISTAS
			
			IF (rand(0,2000)>1997)
				IF (sindic_cruzando==0) sindic_cruzando=1; sindic(); END
			END
		
		END
		
		FRAME;
		
	END 
		
END

//*******************************************************************************************
// MENÚ
//*******************************************************************************************

PROCESS menu();

PRIVATE

	opt=0; // opción a elegir
	
	est=0; // estado de opciones
	
	solo1=1; // tope para las teclas
	
	m1; m2; m3; m4; // textos del menú
	m5; m6; m8; m9;
	
	solot; // tope para el texto
	
	salir=0; // para indicar la salida
	
	jugar=0; // para indicar que iniciamos el juego
	
	vel; // velocidad del aspa
	
	contm=0; // contador de música
	
	cont=0;
	
	jofreddon;
	
	volumen=40;
	
	tope; // tope para quitar la música si se selecciona "sonido no"
	
	string txtscreen; // variable para escribir según esté la pantalla
	
BEGIN
	
	put_screen(0,200);

	fade(100,100,100,3);
	
	x=110; y=138;
	
	graph=18;
	
	IF (gameover==1) gameover=0; END
	
	IF (sel_audio==0) sound(msc0,60,256); END
	
	LOOP
	
		IF (modop==1) txtscreen="PANTALLA COMPLETA"; END
		IF (modop==2) txtscreen="FINESTRA"; END
	
	
		IF(keydown(_f5)) 
			IF (modop==3) mode_change(mode_window); modop=1; END
			IF (modop==4) mode_change(mode_fullscreen); modop=2; END			
		END
	
		IF (sel_audio==0) contm++; ELSE contm=0; END // arrancamos el contador para la música
		
		IF (contm==1006) sound(msc0,60,256); contm=0; END
	
		IF (sel_audio==1 AND tope==0) stop_sound(all_sound); tope=1; END
	
		IF (tope==1 AND sel_audio==0) tope=0; END
	
		angle-=10000;
		
		IF (NOT keydown(_down) AND NOT keydown(_up) AND NOT keydown(_enter) AND solo1==1) solo1=0; END
		
		IF (est==0) // PRINCIPAL
		
			IF (solot==0) solot=1;
			
				m1=write(fnt2,160,100,1,"JUGAR");
				m2=write(fnt2,160,125,1,"OPCIONS");
				m4=write(fnt2,160,150,1,"PUNTUACIONS");
				m3=write(fnt2,160,175,1,"SORTIR");
			
			END
			
			IF (opt==0) x=111; y=113; // JUGAR
			
				IF (keydown(_enter) AND solo1==0) solot=0; solo1=1; est=20; fade(0,0,0,2); jugar=1; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
			
			END
			
			IF (opt==1) x=100; y=137; // OPCIONES
			
				IF (keydown(_enter) AND solo1==0) solo1=1; delete_text(all_text); est=1; opt=0; solot=0; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
			
			END
			
			IF (opt==2) x=74; y=162; // PUNTUACIONS
				
				IF (keydown(_enter) AND solo1==0) solo1=1; 
					
					IF (sel_audio==0) sound(snd12,100,256); END
					
					delete_text(all_text); pr53=highscores(); est=100; 
					
				END
				
			END
			
			IF (opt==3) x=107; y=188; // SORTIR
				
				IF (keydown(_enter) AND solo1==0) est=50; solo1=1; fade(0,0,0,2); salir=1; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
				
			END
		
		END
		
		IF (est==1) // OPCIONES
		
			IF (solot==0) solot=1;
			
				m1=write(fnt2,146,100,1,"AUDIO");
				IF (sel_audio==0) m4=write(fnt2,184,100,0,"SI"); END
				IF (sel_audio==1) m4=write(fnt2,184,100,0,"NO"); END
				m2=write(fnt2,160,125,1,txtscreen);
				m3=write(fnt2,160,150,1,"STATS");
				m5=write(fnt2,160,175,1,"TORNAR");
			
			END
			
			IF (opt==0) x=98; y=112; // AUDIO
							
					IF (keydown(_enter) AND solo1==0) 
					solo1=1;
					sound(snd12,100,256);			
					IF (sel_audio==0) sel_audio=3; sng_pause=1; delete_text(m4); m4=write(fnt2,184,100,0,"NO"); END
					IF (sel_audio==1) sel_audio=4; delete_text(m4); m4=write(fnt2,184,100,0,"SI"); sound(msc0,60,256); END
					IF (sel_audio==3) sel_audio=1; END
					IF (sel_audio==4) sel_audio=0; END
				END
			
			END
			
			IF (opt==1) y=136; // PANTALLA COMPLETA
			
				IF (modop==1) x=41; END
				IF (modop==2) x=99; END
			
				IF (keydown(_enter) AND solo1==0) solo1=1; 
					
					IF (sel_audio==0) sound(snd12,100,256); END
					IF (modop==1) mode_change(mode_fullscreen); modop=3; END			
					IF (modop==2) mode_change(mode_window); modop=4; END					
				END
				
				IF (modop==3) modop=2; END
				IF (modop==4) modop=1; END
			
			END
			
			IF (opt==2) x=111; y=163; // STATS
			
				IF (keydown(_enter) AND solo1==0) solo1=1; 
					
					IF (sel_audio==0) sound(snd12,100,256); END
					
					delete_text(all_text); estadisticas(); est=101; 
					
				END
			
			END
			
			IF (opt==3) x=106; y=188; // VOLVER
				
				IF (keydown(_enter) AND solo1==0) solo1=1; delete_text(all_text); est=0; opt=1; solot=0; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
				
			END
		
		END
			
		IF (est==2) // JUGAR - NUEVA PARTIDA 
			
			IF (solot==0) solot=1;
			
				m1=write(fnt2,160,125,1,"NOVA PARTIDA");
				m2=write(fnt2,160,150,1,"MODO ARJOFREDDON");
				m3=write(fnt2,160,175,1,"TORNAR");
			
			END
			
			IF (opt==0) x=70; y=136; // NUEVA PARTIDA
			
				IF (keydown(_enter) AND solo1==0) est=20; solo1=1; fade(0,0,0,2); jugar=1; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
			
			END
			
			IF (opt==1) x=46; y=163; // ARJOFREDDON
			
				IF (keydown(_enter) AND solo1==0) solo1=1;
					IF (sel_audio==0) sound(snd12,100,256); END
				END
			
			END
			
			IF (opt==2) x=105; y=188; // VOLVER
				
				IF (keydown(_enter) AND solo1==0) solo1=1; delete_text(all_text); est=0; opt=0; solot=0; 
					IF (sel_audio==0) sound(snd12,100,256); END
				END
				
			END
			
		END
		
		IF (est==100) // LLAMANDO A HIGHSCORES
		
			x=105; y=219;
		
			IF (keydown(_enter) AND solo1==0) solo1=1; delete_text(all_text); solot=0; est=0; opt=2; 
			
				stop_scroll(0); put_screen(0,200); signal(pr53,s_kill);
			
				IF (sel_audio==0) sound(snd12,100,256); END
			
			END
			
		END
		
		IF (est==101) // LLAMANDO A HIGHSCORES
		
			x=105; y=219;
		
			IF (keydown(_enter) AND solo1==0) solo1=1; delete_text(all_text); solot=0; est=1; opt=2; put_screen(0,200);
			
				IF (sel_audio==0) sound(snd12,100,256); END
			
			END
			
		END
		
		IF (keydown(_down) AND solo1==0 AND jugar==0 AND salir==0 AND est!=100) solo1=1; opt+=1;
		
			IF (sel_audio==0) sound(snd11,100,256); END

			IF (est==2)
			
				IF (opt>2) opt=0; END
				
			ELSE IF (est==0 OR est==1)
					
					IF (opt>3) opt=0; END
					
				END
				
			END
			
		END
		
		IF (keydown(_up) AND solo1==0 AND jugar==0 AND salir==0 AND est!=100) opt-=1; solo1=1;
		
			IF (sel_audio==0) sound(snd11,100,256); END
			
			IF (est==2)
			
				IF (opt<0) opt=2; END
				
			ELSE IF (est==0 OR est==1)
			
					IF (opt<0) opt=3; END
				
				END
				
			END
		
		END
			
		
		IF (jugar==1) cont++; angle-=vel; vel+=1000; // INICIAMOS NUEVA PARTIDA
		
			IF (cont==50) delete_text(all_text); fase=1; 
				pr0=main(); pr100=musica(); fade(100,100,100,2); 
				IF (sel_audio==0) songchannel_stop(0); sng_pause=0; END 
				BREAK; 
			END
			
		END
		
		IF (jofreddon==1) cont++; angle-=vel; vel+=1000; // INICIAMOS MODO ARJOFREDDON
		
			IF (cont==50) delete_text(all_text); fase=1; pr0=main(); fade(100,100,100,2); BREAK; END
			
		END
		
		IF (salir==1) cont++; angle-=vel; vel+=1000; // SALIENDO
		
			IF (cont==40) exit("Quedes expedit!! Gràcies per jugar! :) By DoZ'2016 - md_jille@hotmail.com",0); END
			
		END
	
		FRAME;
		
	END

END

//*******************************************************************************************
// STATS
//*******************************************************************************************

PROCESS estadisticas();

PRIVATE

	escr; // tope para escribir
	temps; 
	
BEGIN

	put_screen(0,218);
	write(fnt2,160,220,4,"TORNAR");	
	
	LOOP
	
		IF (escr==0) escr=1;
	
			write(0,10,40,0,"TEMPS DE JOC:");
			write(0,10,43,0,"____________");
			write(0,92,40,0, itoa(stats.n_hores)+"h "+itoa(stats.n_minuts)+"m "+itoa(stats.n_secs)+"s"); 
			write(0,10,60,0,"DISTANCIA TOTAL:");
			write(0,10,63,0,"_______________");
			write(0,110,60,0,itoa(stats.n_km)+" KM"); 
			write(0,10,80,0,"PUNTUACIO TOTAL:");
			write(0,10,83,0,"_______________");
			write(0,110,80,0,OFFSET stats.n_punt); 
			write(0,10,100,0,"PALETS EXPEDITS:");
			write(0,10,103,0,"_______________");
			write(0,110,100,0,OFFSET stats.n_exp); 
			write(0,10,120,0,"ALP'S EXPEDIDES:");
			write(0,10,123,0,"_______________");
			write(0,110,120,0,OFFSET stats.n_alpinistas); 
			write(0,10,140,0,"COMBOS FETS:");
			write(0,10,143,0,"___________");
			write(0,86,140,0,OFFSET stats.n_combos); 
			write(0,10,160,0,"CONVERS. AMB JOFRE:");
			write(0,10,163,0,"__________________");
			write(0,127,160,0,OFFSET stats.n_jofres); 
			write(0,180,40,0,"ATROPELLATS:");
			write(0,180,43,0,"___________");
			write(0,255,40,0,OFFSET stats.n_muertos); 
			write(0,180,60,0,"ATR. PEL JOFRE:");
			write(0,180,63,0,"______________");
			write(0,273,60,0,OFFSET stats.n_jmuertos); 			
			write(0,180,80,0,"ENCARREGATS MORTS:");
			write(0,180,83,0,"_________________");
			write(0,291,80,0,OFFSET stats.n_encargados);
			write(0,180,100,0,"COMERCIALS MORTS:");
			write(0,180,103,0,"________________");
			write(0,285,100,0,OFFSET stats.n_comerciales); 			
			write(0,180,120,0,"SINDICALS MORTS:");
			write(0,180,123,0,"_______________");
			write(0,280,120,0,OFFSET stats.n_sindic);
			write(0,180,140,0,"ESTR. LLANÇADES:");
			write(0,180,143,0,"_______________");
			write(0,280,140,0,OFFSET stats.n_estrellas);
			write(0,180,160,0,"KARDAT PEL PREF:");
			write(0,180,163,0,"_______________");
			write(0,280,160,0,OFFSET stats.n_preferencias);
		END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// HIGHSCORES MENÚ
//*******************************************************************************************

PROCESS highscores();

BEGIN
	
	start_scroll(0,0,204,203,0,1);
	scroll.camera=id;
	
	write(fnt3,160,25,4,"PUNTUACIONS");
	
	write(fnt2,90,65,4,"1.");
	write(fnt2,90,95,4,"2.");
	write(fnt2,90,125,4,"3.");
	write(fnt2,90,155,4,"4.");
	write(fnt2,90,185,4,"5.");
	
	write(fnt2,125,65,4,punt[0].name);
	write(fnt2,125,95,4,punt[1].name);
	write(fnt2,125,125,4,punt[2].name);
	write(fnt2,125,155,4,punt[3].name);
	write(fnt2,125,185,4,punt[4].name);
	
	write_int(fnt2,210,65,4, OFFSET punt[0].points);
	write_int(fnt2,210,95,4, OFFSET punt[1].points);
	write_int(fnt2,210,125,4, OFFSET punt[2].points);
	write_int(fnt2,210,155,4, OFFSET punt[3].points);
	write_int(fnt2,210,185,4, OFFSET punt[4].points);
	
	write(fnt2,160,220,4,"TORNAR");
	
	LOOP
	
		x+=2;
		
		move_scroll(0);
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// HIGHSCORES EN PARTIDA
//*******************************************************************************************

PROCESS highparty();

PRIVATE

	solo1;

	cont; cont_s; // contador y contador para el scroll

	texto;
	
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
	
BEGIN

	gameover=2;

	IF (score>punt[4].points AND score<=punt[3].points) puesto=5; END // CÁLCULO DE PUESTO SEGÚN PUNTUACIÓN
	IF (score>punt[3].points AND score<=punt[2].points) puesto=4; END
	IF (score>punt[2].points AND score<=punt[1].points) puesto=3; END
	IF (score>punt[1].points AND score<=punt[0].points) puesto=2; END
	IF (score>punt[0].points) puesto=1; END
	
	IF (puesto>0 AND est==0) est=1; // si alcanzamos un puesto en el ranking...
		
		write_int(fnt3,160,24,4,OFFSET score);
		write(fnt2,160,60,4,"ENHORABONA! HAS GUANYAT");
		write(fnt2,160,87,4,"UN LLOC AL RANKING!!");
		write(0,160,155,4,"MOU LES FLETXES ESQUERRA/DRETA I APRETA ENTER");
		write(fnt2,160,190,4,"HAS QUEDAT EN LA    ª POSICIÓ!");
		write_int(fnt2,202,190,4,OFFSET puesto);
	
	END
	
	IF (puesto==0) est=10; END // Si no conseguimos entrar en el ranking, pasamos a mostrarlo
	
	scroll.camera=id;
	
	graph=101;
	
	x=160; y=220;
	
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
			
			IF (cont==1) ti=write(fnt3,140,130,4, ini); END
			IF (cont==16) delete_text(ti); END
			IF (cont==19) cont=0; END 
			
			ini=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; END
			
			IF (keydown(_enter) AND solo1==0) 

				solo1=1; cont=0; delete_text(all_text); write(fnt3,140,130,4, ini); ncar=0; est=2;
				
				write_int(fnt3,160,24,4,OFFSET score);
				write(fnt2,160,60,4,"ENHORABONA! HAS GUANYAT");
				write(fnt2,160,87,4,"UN LLOC AL RANKING!!");
				write(0,160,155,4,"MOU LES FLETXES ESQUERRA/DRETA I APRETA ENTER");
				write(fnt2,160,190,4,"HAS QUEDAT EN LA    ª POSICIÓ!");
				write_int(fnt2,202,190,4,OFFSET puesto);
				
			END
		
		END
		
		IF (est==2) // 2ª INICIAL
		
			cont++;
			
			IF (cont==1) ti2=write(fnt3,162,130,4, ini2); END
			IF (cont==16) delete_text(ti2); END
			IF (cont==19) cont=0; END 
			
			ini2=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; END
			
			IF (keydown(_enter) AND solo1==0) 
				
				solo1=1; cont=0; delete_text(all_text); write(fnt3,140,130,4, ini); write(fnt3,162,130,4, ini2); ncar=0; est=3;
				
				write_int(fnt3,160,24,4,OFFSET score);
				write(fnt2,160,60,4,"ENHORABONA! HAS GUANYAT");
				write(fnt2,160,87,4,"UN LLOC AL RANKING!!");
				write(0,160,155,4,"MOU LES FLETXES ESQUERRA/DRETA I APRETA ENTER");
				write(fnt2,160,190,4,"HAS QUEDAT EN LA    ª POSICIÓ!");
				write_int(fnt2,202,190,4,OFFSET puesto);
				
			END
			
		END
	
		IF (est==3) // 3ª INICIAL
		
			cont++;
			
			IF (cont==1) ti3=write(fnt3,184,130,4, ini3); END
			IF (cont==16) delete_text(ti3); END
			IF (cont==19) cont=0; END 
			
			ini3=char(car[ncar]); 
			
			IF (keydown(_left) AND solo1==0) solo1=1; ncar-=1; END
			IF (keydown(_right) AND solo1==0) solo1=1; ncar+=1; END
			
			IF (keydown(_enter) AND solo1==0) 
				delete_text(all_text); write(fnt3,140,130,4, ini); write(fnt3,162,130,4, ini2); write(fnt3,184,130,4, ini3); 
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
		
			write(fnt3,160,25,4,"PUNTUACIONS");
		
			write(fnt2,90,50,1,"1.");
			write(fnt2,90,80,1,"2.");
			write(fnt2,90,110,1,"3.");
			write(fnt2,90,140,1,"4.");
			write(fnt2,90,170,1,"5.");
	
			write(fnt2,125,50,1,punt[0].name);
			write(fnt2,125,80,1,punt[1].name);
			write(fnt2,125,110,1,punt[2].name);
			write(fnt2,125,140,1,punt[3].name);
			write(fnt2,125,170,1,punt[4].name);
	
			write_int(fnt2,210,50,1, OFFSET punt[0].points);
			write_int(fnt2,210,80,1, OFFSET punt[1].points);
			write_int(fnt2,210,110,1, OFFSET punt[2].points);
			write_int(fnt2,210,140,1, OFFSET punt[3].points);
			write_int(fnt2,210,170,1, OFFSET punt[4].points);
			
			est=11; cont=0;
			
		END
		
		IF (est==11)
		
			cont++;
			
			IF (cont==1) texto=write(0,160,215,4,"- APRETA ENTER PER CONTINUAR -"); END
			IF (cont==24) delete_text(texto); END
			IF (cont==40) cont=0; END
		
			IF (keydown(_enter) AND solo1==0) solo1=1; fade(0,0,0,2); est=12; cont=0; END 
			
		END
		
		IF (est==12)
		
			cont++;
			
			IF (cont==50) delete_text(all_text); let_me_alone(); stop_scroll(0); pr50=menu(); cont=0; BREAK; END
			
		END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// MOTO
//*******************************************************************************************

PROCESS moto();

PRIVATE

	dir; // para indicar la dirección al irse a tomar por culo
	
	cont;
	
	cont2; // contador para el mensaje de que ya tenemos un palé en el almacén
	
	cont3; // contador para la duración de la invulnerabilidad temporal
	
	texto; // texto del mensaje del palé
	
	mens_pale; // para activar o desactivar el mensaje
	
	solo1=1; // tope para la tecla
	
	dist; // para saber la distancia que recorremos
	
	tocado; // para saber si hemos sido alcanzados y aplicar la invulnerabilidad temporal
	
	ret; // retardo para la animación del godmode
	
	modo_dios; // variable para controlar el godmode
	
	clon; // para saber si es un clon
	
	tope_clon;
	cont_clon;
	
BEGIN

	scroll.camera=id;
	
	ctype=c_scroll;
	
	graph=10; 

	z=-5;
	
	x=160; 
	y=1265; 
	
	sombra_moto();
	
	LOOP
	
		IF (vel_m>6) 
			IF (tope_clon<3) 
				CLONE 
					flags=4; z=1; clon=1; tope_clon++;
					LOOP 
						cont_clon++;
						IF (cont_clon==3) tope_clon--; signal(id,s_kill); END 
						FRAME; 
					END 
				END
			END
		END
		
		IF (vel_m<7 AND tope_clon>0) tope_clon--; END
		
		IF (godmode==0) modo_dios=0; graph=10; END
		
		IF (godmode==1)

			IF (modo_dios==0) graph=180; modo_dios=1; END
			IF (modo_dios==1) 
				ret++;
				IF (ret==2) ret=0; graph++; END
				IF (graph>185) graph=180; END
			END
			
		END				
	
		IF (NOT keydown(_enter) AND NOT keydown(_space)) solo1=0; bloqueo=0; END
		
		IF (bloqueo==1)
			IF (keydown(_enter) OR keydown(_space)) solo1=1; END
		END
		
		IF (x=<15) x=15; END // topes para el límite de la pantalla
		IF (x=>305) x=305; END
		IF (y=>1280) y=1280; END
		IF (y=<70) y=70; END
		
		IF (choque==0)
		
			// MOVIMIENTO DE LA MOTO
		
			IF (keydown(_up) AND NOT keydown(_down)) IF (carga==0) y-=vel_m; dist+=vel_m; END IF (carga==2) y-=vel_m; dist+=vel_m; END angle=0; lado=0;
				IF (keydown(_left) AND NOT keydown(_right)) IF (carga==0) x-=vel_m; END IF (carga==2) x-=vel_m; END angle=35000; lado=1; END
				IF (keydown(_right) AND NOT keydown(_left)) IF (carga==0) x+=vel_m; END IF (carga==2) x+=vel_m; END angle=-35000; lado=2; END
			END
		
			IF (keydown(_down) AND NOT keydown(_up)) IF (carga==0) y+=vel_m; dist+=vel_m; END IF (carga==2) y+=vel_m; dist+=vel_m; END angle=180000; lado=3; 
				IF (keydown(_left) AND NOT keydown(_right)) IF (carga==0) x-=vel_m; END IF (carga==2) x-=vel_m; END angle=-215000; lado=4; END
				IF (keydown(_right) AND NOT keydown(_left)) IF (carga==0) x+=vel_m; END IF (carga==2) x+=vel_m; END angle=215000; lado=5; END
			END
		
			IF (keydown(_left) AND NOT keydown(_up) AND NOT keydown(_down)) IF (carga==0) x-=vel_m; dist+=vel_m; END IF (carga==2) x-=vel_m; dist+=vel_m; END angle=90000; lado=6; END
			IF (keydown(_right) AND NOT keydown(_up) AND NOT keydown(_down)) IF (carga==0) x+=vel_m; dist+=vel_m; END IF (carga==2) x+=vel_m; dist+=vel_m; END angle=-90000; lado=7; END
	
		END
		
		// CUENTAKILÓMETROS
		
		IF (dist>999) cm+=1; dist=0; END // Subimos cada cien metros
		IF (cm>9) km+=1; cm=0; stats.n_km+=1; END // Subimos el KM cada x10 CM
		IF (km>9) dkm+=1; km=0; END // subimos el DKM cada x10 KM
		
		IF (godmode==0 AND clon==0)
		
			// COLISIÓN CON JOFRE
		
			IF (collision(TYPE jofre) AND size==100 AND tocado==0 AND gameover==0)
		
				IF (ninja==0) // Si tocamos al toro de Jofre, se abre la ventana de conversación
				
					congelar=1;
				
				END
			
				IF (ninja==1)
			
					dir=rand(1,4); choque=1; quitavida=1;
				
					IF (carga==2) palefuera=1; END 
				
				END
			
			END 
		
			// COLISIÓN CON ESTRELLA NINJA
		
			IF (collision(TYPE star) AND size==100 AND tocado==0 AND gameover==0)
		
				dir=rand(1,4); choque=1; quitavida=1;
			
				IF (carga==2) palefuera=1; END 
		
			END
	
			// COLISIÓN CON EL AURA DEL PREFERENCIAS

			IF (collision(TYPE aura) AND choque==0 AND tocado==0) dir=rand(1,4); choque=1; quitavida=1; // Si chocamos con el aura, iniciamos todo para mandarla a tomar por culo
			
				IF (carga==2) palefuera=1; END stats.n_preferencias+=1;
			
				IF (sel_audio==0) sound(snd8,75,256); sound(snd15,256,256); sound(snd17,40,256); END
			
			END 
		
			// COLISIÓN CON EL PEPE

			IF (collision(TYPE pepe) AND choque==0 AND tocado==0) dir=rand(1,4); choque=1; quitavida=1; 
			
				IF (carga==2) palefuera=1; END 
			
				IF (sel_audio==0) sound(snd17,40,256); END
			
			END 
			
		END
	
		// RECOGER PALE TRAS DEJARLO
		
		IF (collision(TYPE pale) AND carga==0 AND solo1==0) 
			IF (keydown(_space) OR keydown(_enter)) solo1=1; carga=2; 
				IF (sel_audio==0) sound(snd27,60,256); END
			END 
		END
		
		// FUNCIÓN DE RECOGER PALÉ EN ZONA DE RECEPCIÓN
		
		IF (x>102 AND x<230 AND y>1230 AND y<1300) // Estamos en la zona
			
			IF (carga==0 AND haypale==0 AND solo1==0) // Si estamos libres de carga y pulsamos enter, cargamos palé
				IF (keydown(_space) OR keydown(_enter)) solo1=1; carga=1;
					IF (sel_audio==0) sound(snd27,60,256); END
				END
			END
			
			IF (keydown(_space) OR keydown(_enter))
				IF (carga==0 AND haypale==1 AND solo1==0 AND NOT collision(TYPE pale)) solo1=1; mens_pale=1; END
			END
			
		END

		IF (carga==1) pr14=pale(); carga=2; END // Llamamos al proceso palé		
		
		// MENSAJE DE AVISO QUE YA HAY UN PALÉ
		
		IF (mens_pale>0) cont2++;
			
			IF (cont2==1) texto=write(0,82,150,0,"JA TENS UN PALET PEL MAGATZEM!"); END
			
			IF (cont2==12) delete_text(texto); END
			
			IF (cont2==17) mens_pale+=1; cont2=0; END			
			
			IF (mens_pale==5) delete_text(texto); mens_pale=0; cont2=0; END
		
		END
		
		// FUNCIÓN DE DEJAR EL PALÉ
		
		IF (carga==2)
			
			IF (keydown(_space) AND solo1==0 OR keydown(_enter) AND solo1==0) 
				solo1=1; carga=0; IF (sel_audio==0) sound(snd28,60,256); END 
			END			
			
		END
			
		// FUNCIÓN DE CHOQUE, DE A TOMAR POR CULO, VAMOS
		
		IF (choque==1) cont++; 
		
			IF (dir==1) x+=rand(2,10); y+=5; angle+=30000; END
			
			IF (dir==2) x-=rand(2,10); y+=5; angle+=30000; END
			
			IF (dir==3) x+=rand(2,10); y-=5; angle+=30000; END
			
			IF (dir==4) x-=rand(2,10); y-=5; angle+=30000; END
			
		END
		
		IF (cont>0 AND cont<20) size+=2; END
		IF (cont>20) size-=2; END
		IF (cont==40) size=100; choque=0; tocado=1; cont=0; END
		
		// FUNCIÓN DE INVULNERABILIDAD TEMPORAL TRAS SER TOCADOS
		
		IF (tocado==1) cont3++;
		
			IF (cont3==1) flags=4; END IF (cont3==10) flags=0; END IF (cont3==20) flags=4; END IF (cont3==30) flags=0; END
			IF (cont3==40) flags=4; END	IF (cont3==50) flags=0; END	IF (cont3==60) flags=4; END	IF (cont3==70) flags=0; END
			IF (cont3==80) flags=4; END IF (cont3==90) flags=0; END IF (cont3==100) flags=4; END 
			IF (cont3==110) flags=0; tocado=0; cont3=0; END
			
		END

		// FUNCIÓN DE LLEGADA AL MUELLE
		
		IF (x>124 AND x<210 AND y>0 AND y<80 AND carga==2 AND NOT collision(TYPE pr4)) // Cuando llega al punto indicado, cambiamos la carga a 5, indicando que ya se expide
			expedidos+=1; sumacombo+=1; carga=5;
		END 
	
		FRAME;
		
	END

END

//*******************************************************************************************
// TURBO
//*******************************************************************************************

PROCESS turbo();

PRIVATE

	cont;
	cont2;
	barra=9; // lo que nos resta de turbo
	
BEGIN

	graph=208;
	
	flags=0;
	
	x=32; y=221;
	
	LOOP
	
		IF (congelar==0)
				
			IF (keydown(_up) OR keydown(_down) OR keydown(_left) OR keydown(_right))	

				IF (keydown(_shift) AND barra>0) 
					speed2=1; cont++;
				ELSE
					speed2=0;
				END				
				
				IF (cont==6) barra-=1; cont=0; END

			END
			
			IF (barra<9 AND NOT keydown(_shift)) cont2++; 
				IF (cont2==52) barra+=1; cont2=0; END
			END

		END
		
		SWITCH (barra)
			CASE 9: graph=208; END
			CASE 8: graph=209; END
			CASE 7: graph=210; END
			CASE 6: graph=211; END
			CASE 5: graph=212; END
			CASE 4: graph=213; END
			CASE 3: graph=214; END
			CASE 2: graph=215; END
			CASE 1: graph=216; END
			CASE 0: graph=217; END
		END
		
		IF (gameover!=0) BREAK; END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// MINI-MAPA
//*******************************************************************************************

PROCESS mapa();

BEGIN

	graph=73; 

	flags=4;
	
	x=300; y=75;
	
	LOOP
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// ESFERA DEL MINI-MAPA
//*******************************************************************************************
	
PROCESS esfera();

PRIVATE

	check; // para chequear la coordenada de la moto y poder compararla
	
	check2; 
	
	cont;
	
BEGIN

		graph=74;
		
		flags=4;
		
		size=110;
						
		x=302; y=104;
				
		LOOP
					
			IF (gameover==0) check=pr1.y; END
			
			IF (check<check2) cont+=check2-check; END
			IF (check>check2) cont-=check-check2; END
			
			IF (carga==0)
				
				IF (enganche==0)
				
					IF (cont>30) y-=2; cont=0; END
					IF (cont<-30) y+=2; cont=0; END
				
				ELSE
				
					IF (cont>33) y-=2; cont=0; END
					IF (cont<-33) y+=2; cont=0; END
				
				END
				
			END

			IF (carga==2)

				IF (enganche==0)
			
					IF (cont>33) y-=2; cont=0; END
					IF (cont<-33) y+=2; cont=0; END			
				
				ELSE
				
					IF (cont>35) y-=2; cont=0; END
					IF (cont<-35) y+=2; cont=0; END
				
				END
				
			END

			IF (gameover==0) check2=pr1.y; END
					
			IF (y>106) y=106; END
			IF (y<44) y=44; END
			
			FRAME;
			
		END
		
END
			
	
//*******************************************************************************************
// COMERCIAL
//*******************************************************************************************

PROCESS comercial();

PRIVATE

	dist;
	
	cont;

BEGIN

	ctype=c_scroll;
	graph=30;
	
	z=1;
	
	x=-20; y=60;
	
	sombra_comercial();
	
	LOOP
	
		IF (cont<13) cont++; x+=3; angle=90000; END
	
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2) dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
	
		IF (cont==13) y+=3; angle=0; END
		
		graph++; 
		
		angle=-90000; 

		IF (graph==37) graph=30; END
		
		// Colisión con moto
		IF (collision(TYPE moto)) angle=rand(0,360000); IF (sel_audio==0) sound(rand(snd4,snd7),100,256); END
			comercial_cruzando=0; deaths+=1; signal(id,s_kill_tree); blood(x,y); stats.n_comerciales+=1; stats.n_muertos+=1;
			IF (x2==0) money(x,y-20,1000); ELSE money(x,y-20,2000); END
		END
		
		IF (keydown(_x)) x2=1; END
		
		// Lo mismo pero atropellado por Jofre
		IF (collision(TYPE jofre)) angle=rand(0,360000); 
			comercial_cruzando=0; deathsj+=1; signal(id,s_kill_tree); blood(x,y); stats.n_jmuertos+=1;
			IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); END 
		END
		
		IF (collision(TYPE star))  // colisión con estrella ninja
			deathsj+=1; signal(id,s_kill_tree); blood(x,y); stats.n_jmuertos+=1;
			IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); END
		END
		
		IF (collision(TYPE pepe)) // colisión con Pepe
			signal(id,s_kill_tree); blood(x,y); IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); END
		END			
				
		IF (y>1300) comercial_cruzando=0; signal(id,s_kill_tree); END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// MONEY
//*******************************************************************************************

PROCESS money(x,y,valor);

PRIVATE

	cont; // contador privado
	
	cont2; // otro contador
	
	est; // estado
	
	timelife; // contador para la duración del dinero en pantalla

BEGIN

	ctype=c_scroll;
	
	graph=40; 
	
	size=60;
	
	sombra(5,6,43);
	
	IF (x<20) x=20; END
	IF (x>300) x=300; END
	IF (y<60) y=60; END
	IF (y>1280) y=1280; END
	
	LOOP
				
		IF (congelar==0)
			
			cont++;
			timelife++;
		
			IF (cont<6) y-=1; END	// creamos el efecto de que flote en el aire, arriba y abajo...
			IF (cont>5) y+=1; END
			IF (cont==10) cont=0; END
		
		END
		
		IF (collision(TYPE moto) AND est==0) score+=valor; stats.n_punt+=valor; est=1; signal(son,s_kill); END // si el jugador lo coge, suma 500 puntos y desaparece
		
		IF (est==1) IF (sel_audio==0) sound(snd3,150,256); END
			IF (valor==250) graph=102; END
			IF (valor==500) graph=150; END
			IF (valor==1000) graph=103; size=65; END
			IF (valor==1500) graph=108; size=70; END
			IF (valor==2000) graph=107; size=70; END
			IF (valor==2500) graph=104; END
			IF (valor==3000) graph=151; END
			IF (valor==5000) graph=152; END
			est=2; 
		END
		
		IF (est==2 AND congelar==0) cont2++; flags=0; z=-10; signal(son,s_kill); 
			IF (est==2 AND cont2>30) cont=0; est=0; BREAK; END
		END
		
		IF (timelife>190 AND est!=2) flags=4; END // cuando se agota el tiempo se vuelve transparente y desaparece finalmente
		IF (timelife>260 AND est!=2) signal(son,s_kill); BREAK; END
		
		FRAME;
		
	END
END

//*******************************************************************************************
// PREFERENCIAS
//*******************************************************************************************

PROCESS preferencias();

PRIVATE

	cont; // contador privado
	
	cont2; coord; // para la duración de la entrada
	
	dist;
	
	r_aviso; // para resetear la posibilidad de que aparezca el aviso
	
	opt;
	
	ret;
	
	dir; // para conocer cuál es la dirección a seguir

BEGIN

	ctype=c_scroll;
	
	graph=53; 
	
	z=-1;
	
	size=125;
	
	x=rand(45,290);	y=-150;
	
	coord=rand(30,290); 
	
	opt=rand(1,2); 
	
	SWITCH (opt)
		CASE 1:
			x=-30; y=rand(65,90);
		END
		
		CASE 2:
			x=350; y=rand(65,90); 
		END

	END
	
	pref_cruzando=1;
	
	sombra_pref();
	
	pr4=aura();
	
	LOOP
		
		ret++;
		
		IF (ret==2) graph++; ret=0; END
		
		dist=fget_dist(0,y,0,pr1.y); 
		
		// FLECHA DE AVISO
		
		IF (gameover==0)
		
			IF (dist<320 AND r_aviso==0 AND y<pr1.y AND pr1.y<1188) r_aviso=1; pr56=avisoP(); END
		
			IF (dist<180 OR dist>320) signal(pr56,s_kill); r_aviso=0; END
		
		END
	
		IF (graph==60) graph=53; END
	
		IF (opt==1)

			IF (x<coord) x+=rand(vel_p1,vel_p2); angle=90000; ELSE opt=3; END
		
		END
		
		IF (opt==2) 
		
			IF (x>coord) x-=rand(vel_p1,vel_p2); angle=-90000; ELSE opt=3; END
		
		END
	
		IF (opt==3)
	
			angle=0;
	
			cont++;	
		
			y+=rand(vel_p1,vel_p2); 
		
			x+=dir; 
		
			IF (cont>40) dir=rand(-4,4); cont=0; END // vamos cambiando la dirección cada 40 frames
	
			IF (x<45) dir=rand(1,4); x=45; END
			IF (x>290) dir=rand(-1,-4); x=290; END
	
			IF (y>1300) pref_cruzando=0; cont2=0; signal(id,s_kill_tree); END

		END
			
		FRAME;
		
	END
	
END

//*******************************************************************************************
// AURA DEL PREFERENCIAS
//*******************************************************************************************

PROCESS aura();

PRIVATE

	cont; // contador privado
	
	contfx; // contador para el FX
	
	sonido; // para saber si hay sonido
	
	volfx=0; // volumen del fx
	
	dist;

BEGIN

	ctype=c_scroll;
	
	graph=49; 
	
	z=-50;
	
	flags=4;
	
	LOOP
	
		x=father.x; y=father.y;
		
		cont++;
		
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2) dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
		
			IF (dist>1 AND dist<100) volfx=100; END
			IF (dist>100 AND dist<250) volfx=80; END
			IF (dist>250 AND dist<400) volfx=60; END
			IF (dist>400) volfx=0; END
			
			IF (gameover==2 AND volfx>20) volfx=volfx-30; END		
		
		IF (cont<vel_a) size+=tam_a; END // generamos el crecimiento y disminución del aura
		IF (cont>vel_a) size-=tam_a; END
		IF (cont==48) cont=0; size=100; END
		
		IF (sel_audio==0 AND sonido==0) sound(snd34,volfx,240); sonido=1;END
		IF (sonido==1) contfx++;
			IF (contfx==7) sonido=0; contfx=0; END
		END
		
		IF (pref_cruzando==0) cont=0; END // cuando se va el Preferencias, destruimos el proceso
				
		FRAME;
		
	END
	
END

//*******************************************************************************************
// TRABAJADOR
//*******************************************************************************************

PROCESS trabajador();

PRIVATE

	cont;
	
	opt; // opciones de movimiento
	
	cambio;
	
	porculo; // para controlar el proceso de a tomar por culo
	
	randculo;
	
	dir;
	
	dist; // distancia de la moto
	
	muriendo; // para la animación al ser atropellado
	
	premio; // para indicar si hay premio
	
BEGIN

	ctype=c_scroll;

	graph=1;
	
	z=1;
	
	opt=rand(1,2); 
	
	SWITCH (opt)
		CASE 1:
			x=-30; y=rand(70,1200); angle=-90000;
		END
		
		CASE 2:
			x=350; y=rand(70,1200); angle=90000; 
		END

	END

	sombra_curri();
	
	LOOP
		
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2)dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
		
		IF (porculo==0 AND muriendo==0)
		
			IF (graph==8) graph=1; END
		
			IF (muriendo==0) graph++; END
		
			IF (opt==1) x+=3; angle=270000; 
			
				IF (collision(TYPE trabajador)) opt=rand(2,5); END
			
			END
			
			IF (opt==2) x-=3; angle=90000; 
			
				IF (collision(TYPE trabajador)) opt=rand(3,5); END
			
			END
			
			IF (opt==3) y+=3; angle=180000; 
			
				IF (collision(TYPE trabajador)) opt=rand(1,4); END
			
			END
			
			IF (opt==4) x+=2; y+=2; angle=-145000; 
			
				IF (collision(TYPE trabajador)) opt=rand(4,5); END
			
			END
			
			IF (opt==5) x-=2; y+=2; angle=145000; 
			
				IF (collision(TYPE trabajador)) opt=rand(1,3); END
			
			END
			
			IF (rand(0,200)>198) cambio=1; END // el rand para hacer un cambio de dirección
		
			IF (collision(TYPE pr2) or collision(TYPE pr3) or collision(TYPE pr5) or collision(TYPE pr6)) // si colisiona con otros, hace un cambio de dirección
			
				SWITCH (opt)
			
					CASE 1:
						opt=2; x-=2;
					END
				
					CASE 2:
						opt=1; x+=2;
					END
				
					CASE 3:
						opt=rand(1,2); IF (opt==1) x+=2; ELSE x-=2; END
					END
				
					CASE 4:
						opt=rand(1,3);
					END
				
					CASE 5:
						opt=rand(1,4);
					END
			
				END 
			
			END
		
			IF (cambio==1) 
				IF (opt==1 AND cambio==1) opt=rand(3,5); cambio=0; END
				IF (opt==2 AND cambio==1) opt=rand(3,5); cambio=0; END
				IF (opt>2 AND cambio==1) opt=rand(1,5); cambio=0; END
				cambio=0;
			END
		
			IF (collision(TYPE star))  // colisión con estrella ninja
				signal(son,s_kill); blood(x,y); deathsj+=1; muriendo=1; stats.n_jmuertos+=1;
				IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); END 
			END
		
			IF (collision(TYPE aura) AND porculo==0) dir=rand(1,4); porculo=1; // colisión con Aura
				IF (sel_audio==0 AND dist<240) sound(snd8,30,256); sound(snd17,30,rand(220,292)); END
			END 
		
			
			IF (collision(TYPE moto) AND gameover==0) // colisión con Moto
				signal(son,s_kill); deaths+=1; muriendo=1; premio=1; stats.n_muertos+=1;
				IF (x2==0) money(x,y-20,250); ELSE money(x,y-20,500); END
				IF (sel_audio==0) sound(rand(snd4,snd7),100,rand(220,292)); END 
			END
		
			IF (collision(TYPE jofre)) // colisión con Jofre
				signal(son,s_kill); blood(x,y); deathsj+=1; muriendo=1; stats.n_jmuertos+=1;
				IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,rand(200,292)); END 
			END
			
			IF (collision(TYPE pepe)) // colisión con Pepe
				signal(son,s_kill); blood(x,y); muriendo=1; IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,rand(200,292)); END 
			END			
			
		END
		
		// ANIMACIÓN ATROPELLADO
		
		IF (muriendo>0) muriendo++; END
		
		IF (muriendo==1) graph=186; END
		
		IF (muriendo==6) graph=187; END
		
		IF (muriendo==10) graph=188; END
		
		IF (muriendo==15) blood(x,y); BREAK; END
		
		IF (porculo==1) graph=38; z=-100;// A tomar por culo
		
			IF (dir==1) x+=3; y+=4; END
			
			IF (dir==2) x-=3; y+=4; END
			
			IF (dir==3) x+=3; y-=4; END
			
			IF (dir==4) x-=3; y-=4; END
			
			size+=rand(3,6); 
			
			IF (randculo==0) randculo=rand(1,4); END
			
			SWITCH (randculo)
				CASE 1:
					angle+=10000;
				END
				
				CASE 2:
					angle+=20000;
				END
				
				CASE 3:
					angle-=10000;
				END
				
				CASE 4:
					angle-=20000;
				END
			END
			
			IF (size>450) signal(id,s_kill_tree); END
			
		END
	
		IF (x<-40) signal(id,s_kill_tree); END
		IF (x>370) signal(id,s_kill_tree); END
		IF (y>1300) signal(id,s_kill_tree); END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// JOFRE
//*******************************************************************************************

PROCESS jofre();

PRIVATE

	origen; // para saber el origen
	
	cont; // contador básicamente para la duración del torero-ninja
	
	cont_e; // contador para el lanzamiento de estrellas
	
	ret; // retardo para aparecer
	
	dir; // dirección actual
	
	aparta; // para saber si se está apartando
	
	cambio; // cambio de dirección
	
	pos; // las dos opciones de aparecer: arriba de la moto o abajo
	
	rand1; rand2; // rand para las posiciones
	
	dist;
	
	inicio; // para controlar que sigue la dirección inicial 
	cont_i; // contador para lo mismo

BEGIN
	
	rejofre=0;
	
	pos=rand(1,2);
	
	IF (pos==1) rand1=300; rand2=950; END
	IF (pos==2) rand1=-300; rand2=-950; END
	
	ctype=c_scroll; 
	
	graph=13;
	
	z=1; 
	
	origen=rand(1,2); // si el origen es 1 sale del lateral izquierdo, si es de 2 sale del derecho, y si es 3 sale de arriba
	
	SWITCH (origen)

		CASE 1: x=-30; dir=1;
		END
		
		CASE 2: x=350; dir=2;
		END

	END
	
	y=pr1.y+rand(rand1,rand2);
	
	IF (y<160) y=160; END
	
	fget_dist(x,y,pr1.x,pr1.y);
	
	IF (ninja!=0 AND gameover==0) 
	
		IF (x<0) aviso(40,y,96); END
		IF (x>320) aviso(290,y,97); END
	
	END
	
	sombra_jofre();
	
	LOOP

		ret++;
	
		IF (inicio==0) cont_i++; END // CONTROLAMOS QUE SIGA UNA DIRECCIÓN INICIAL CON UN TOPE EN EL CAMBIO DE DIRECCIÓN (inicio)
		IF (cont_i==30) inicio=1; END
	
		IF (ninja==0) graph=13; ELSE graph=14; END
	
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2) dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
	
		// TORERO-NINJA
	
		IF (ninja!=0) 
		
			IF (rand(0,300)>num_e AND cont_e==0) star(x,y); cont_e=1; stats.n_estrellas+=1; // lanzando la estrella ninja		
				IF (sel_audio==0 AND dist <240) sound(snd31,65,256); END 
			END	
		
			IF (cont_e>0) cont_e++; END
			
			IF (cont_e==8) cont_e=0; END
		
			ELSE cont=0;
			
		END
	
		// SI TOCAMOS AL AURA O AL PEPE CAMBIAMOS DIRECCIÓN
		
		IF (collision(TYPE pepe) OR collision(TYPE aura) AND aparta==0) 
		
			aparta=1;
		
			SWITCH (dir)
			
				CASE 1:
					dir=2; x+=5;
				END
				
				CASE 2:
					dir=1; x-=5;
				END
				
				CASE 3:
					dir=4; y+=5;
				END
				
				CASE 4:
					dir=3; y-=5;
				END
				
				CASE 5:
					dir=8; y+=5; x-=5;
				END
				
				CASE 6:
					dir=7; y+=5; x+=5;
				END
				
				CASE 7:
					dir=6; y-=5; x-=5;
				END
				
				CASE 8:
					dir=5; y-=5; x+=5;
				END
			
			END
		
		END
		
		IF (aparta>0) aparta++; END // si se está apartando iniciamos el contador para que no pueda cambiar de nuevo de dirección
		
		IF (aparta==30) aparta=0; END
		
		IF (rand(0,200)>185 AND cambio==0 AND inicio==1) cambio=1; END // hacemos un rand para ver si cambia de dirección

		IF (collision(TYPE jofre)) dir=rand(1,8); END
		
		IF (cambio==1 AND aparta==0)
		
			IF (dir==1 AND cambio==1) dir=rand(5,7); cambio=0; END
				
			IF (dir==2 AND cambio==1) dir=rand(6,8); cambio=0; END
			
			IF (dir==3 AND cambio==1) dir=rand(7,8); cambio=0; END
			
			IF (dir==4 AND cambio==1) dir=rand(5,6); cambio=0; END
			
			IF (dir==5 AND cambio==1) dir=rand(1,4); cambio=0; END
			
			IF (dir==6 AND cambio==1) dir=rand(2,4); cambio=0; END
			
			IF (dir==7 AND cambio==1) dir=rand(1,3); cambio=0; END
			
			IF (dir==8 AND cambio==1) dir=rand(2,3); cambio=0;	END
		
		END
		
		IF (ret>18)
		
			IF (dir==1)
			
				x+=rand(vel_j1,vel_j1); angle=0; // DERECHA
		
			END
		
			IF (dir==2) 
			
				x-=rand(vel_j1,vel_j1); angle=180000; // IZQUIERDA
		
			END
		
			IF (dir==3)
			
				y+=rand(vel_j1,vel_j1); angle=-90000; // ABAJO
			
			END
		
			IF (dir==4)
		
				y-=rand(vel_j1,vel_j1); angle=90000; // ARRIBA
			
			END
		
			IF (dir==5)
		
				x+=rand(vel_j1,vel_j1); y-=rand(vel_j1-1,vel_j1-2); angle=35000; // ARRIBA DERECHA
			
			END
		
			IF (dir==6)
		
				x-=rand(vel_j1,vel_j1); y-=rand(vel_j1-1,vel_j1-2); angle=145000; // ARRIBA IZQUIERA
			
			END
		
			IF (dir==7)
		
				x+=rand(vel_j1,vel_j1); y+=rand(vel_j1-1,vel_j1-2); angle=-35000; // ABAJO DERECHA
			
			END
		
			IF (dir==8)
		
				x-=rand(vel_j1,vel_j1); y+=rand(vel_j1-1,vel_j1-2); angle=215000; // ABAJO IZQUIERDA
			
			END
			
		END
		
		IF (x>355) signal(id,s_kill_tree); rejofre=1; END
		IF (x<-45) signal(id,s_kill_tree); rejofre=1; END
		IF (y=<65) y=65; dir=3; END
		IF (y>1300) signal(id,s_kill_tree); rejofre=1; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// VENTANA JOFRE
//*******************************************************************************************

PROCESS ventana();

PRIVATE

	texto;
	
	frase; // para saber qué combinación toca
	
	STRING f1; STRING f2; STRING f3; // strings para las 3 líneas
	
	l1; l2; l3; // variables para los textos de las líneas
	
	pas; // pas a pas...
	
	solo1;
	
BEGIN
	
	//congelar=1;
	
	stats.n_jofres+=1;
	
	graph=12;
	
	x=160; y=190; 
	
	z=-200;
	text_z=-250;
	
	frase=rand(1,12);
	
	IF (sel_audio==0) sound(snd30,180,256); END
	
	SWITCH (frase)
		CASE 1:
			f1="QUEEEE, COTITZANT ??";
			f2="SI ET TOQUES LA LOTERIA, DEIXARIES DE";
			f3="VINDRE A TREBALLAR ??";
		END
		
		CASE 2:
			f1="JODER TIU... ESTIC CANSAT EH ?";
			f2="AHIR VAIG ESTAR FENT PECES..";
			f3="..I CINTA TAMBE. 2 HORES EH ?";
		END
		
		CASE 3:
			f1="HO SAP EL MURU??";
			f2="...";
			f3="....ZAPATAZO !!!";
		END
		
		CASE 4:
			f1="AQUELL COBRA MES QUE TU I QUE JO..";
			f2="..";
			f3="";
		END
		
		CASE 5:
			f1="NO ET VEIG FELIÇ EH ? ";
			f2="...";
			f3="PRO SI TU ETS D'AQUI !!";
		END
		
		CASE 6:
			f1="PAGA'M UN TALLAT SI US PLAU !";
			f2="QUE SOC DE FORA, MIRA COM PORTO";
			f3="LES BUTXAQUES...";
		END
		
		CASE 7:
			f1="HO SAP EL PEPE ??";
			f2="...";
			f3="HAS PORTAT DATILS?";
		END
		
		CASE 8:
			f1="EL CAP DE SETMANA VAIG ANAR A PESCAR";
			f2="SALMONS A NORUEGA TIU...";
			f3="EL VAM FER AL FORN. EH, BONISSIM...";
		END
		
		CASE 9:
			f1="QUE EN PENSES DE L'ADA COLAU ??";
			f2="";
			f3="...TE LA FOLLARIES ??";			
		END
		
		CASE 10:
			f1="DE QUE PARLEU ??";
			f2="";
			f3="..HO SAP EL MURU ??";			
		END
		
		CASE 11:
			f1="FUAH TIU... QUINES GANES TINC DE QUE";
			f3="";
			f2="SIGUI FINAL DE MES PER COTITZAR..";
		END
		
		CASE 12:
			f1="AHIR VAIG MENJAR POLLASTRE...";
			f2="..UN POLLASTRE SENCER, JO TOT SOL..";
			f3="..AL FORN, EH ??";
		END
		
	END
	
	l1=write(fnt1,90,155,0,f1); 
	l2=write(fnt1,90,180,0,f2);
	l3=write(fnt1,90,205,0,f3); 
	
	LOOP
		
		// CON PALÉ
		IF (keydown(_enter) OR keydown(_space))
			
			IF (solo1==0) solo1=1;
			
				IF (pas==1)
						solo1=1; signal(pr0,s_wakeup_tree); signal(pr6,s_kill_tree); rejofre=1;
						carga=0; volvertexto=1; congelar=0; BREAK; // ponemos el palé en un punto aleatorio		

				END
			
				IF (pas==0)
				
					IF (carga!=0) // CON PALÉ
						solo1=1; delete_text(l1); delete_text(l2); delete_text(l3); graph=106; 
						pr14.x=rand(30,290); pr14.y=rand(150,1125); 
						pas=1;	
					END
					
					IF (carga==0) // SIN PALÉ
						solo1=1; delete_text(l1); delete_text(l2); delete_text(l3);  
						signal(pr0,s_wakeup_tree); signal(pr6,s_kill_tree); rejofre=1; volvertexto=1; congelar=0; 
						BREAK;
					END
					
				END
				
			END
			
		ELSE solo1=0;
			
		END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// ZONA RECEPCIÓN
//*******************************************************************************************

PROCESS zona();

BEGIN

	ctype=c_scroll;

	graph=16;
	
	size=140;
	
	z=101;
	
	x=170; y=1260; 
	
	LOOP
	
		FRAME;
		
	END

END

//*******************************************************************************************
// MUELLE
//*******************************************************************************************

PROCESS muelle();

BEGIN

	ctype=c_scroll;
	
	graph=17;
	
	size=120;
	
	z=101;
	
	x=170; y=52;
	
	LOOP
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// ALPINISTA
//*******************************************************************************************

PROCESS alpinista();

PRIVATE

	cont; cont2; cont3; cont4;

	ret; // retardo para la animación
	
	opt; // opciones de movimiento
	
	cambio; // para saber si tiene que hacer un cambio de dirección
	
	porculo; // para controlar el proceso de a tomar por culo
	
	dir; // dirección para irse a tomar por culo
	
	origen; // para saber el origen
	
	gs; gf; // gráfico de inicio y de final
	
	vas; // vas cap alla?

	dist; // distancia de la moto
	
	clon; // para saber si es un clon
	
	tope_clon; cont_clon;
	
BEGIN

	enganche=0;

	alpinista_muerte=0;

	ctype=c_scroll; 
	
	size=130;
	
	z=1; 
	
	exped=0;
	
	origen=rand(1,2); // si el origen es 1 sale del lateral izquierdo, si es de 2 sale del derecho, y si es 3 sale de arriba
	
	SWITCH (origen)
	
		CASE 1:
			graph=85; angle=-90000; x=0; y=rand(200,1000); 
		END
		
		CASE 2:
			graph=85;  angle=90000; x=320; y=rand(200,1000);
		END
		
	END
	
	sombra_alp();
	
	LOOP
	
		IF (vel_m>6 AND enganche==1) 
			IF (tope_clon<3) 
				CLONE 
					flags=4; z=2; clon=1; tope_clon++;
					LOOP 
						cont_clon++;
						IF (cont_clon==3) tope_clon--; signal(id,s_kill); END 
						FRAME; 
					END 
				END
			END
		END
	
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2) dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
		
		IF (congelar==0 OR gameover>0) ret++; END
		
		IF (porculo==0 AND exped==0)
		
			IF (enganche==0) 
		
				IF (ret==2) graph++; ret=0; END
			
				IF (rand(0,200)>195) origen=rand(1,4); END // hacemos un rand para ver si cambia de dirección

				IF (origen==1) 
			
					gs=85; gf=92; angle=90000;
		
					IF (graph==gf) graph=gs; END
			
					x+=2; 
		
				END
		
				IF (origen==2) 
			
					gs=85; gf=92; angle=-90000;
			
					IF (graph==gf) graph=gs; END
			
					x-=2; 
		
				END
		
				IF (origen==3)
			
					gs=85; gf=92; angle=0;
			
					IF (graph==gf) graph=gs; END
			
					y+=2;
			
				END
		
				IF (origen==4)
			
					gs=85; gf=92; angle=180000;
			
					IF (graph==gf) graph=gs; END
			
					y-=2;
			
				END
			
			END
			
		END
		
		IF (choque==1 AND enganche==1) // SI NOS VAMOS NOSOTROS, ELLA TB SE VA A TOMAR POR CULO
		
			IF (sel_audio==0) sound(snd19,100,256); END 
			
			porculo=1; enganche=2; dir=rand(1,4); 
			
		END
		
		IF (porculo==1) enganche=0; graph=93; z=-20;
		
			IF (dir==1) x+=3; y+=4; angle+=30000; END
			
			IF (dir==2) x-=3; y+=4; angle+=30000; END
			
			IF (dir==3) x+=3; y-=4; angle+=30000; END
			
			IF (dir==4) x-=3; y-=4; angle+=30000; END
			
			size+=5;
			
			IF (size>450) signal(id,s_kill_tree); alpinista_cruzando=0; alpinista_returns=1; END
			
		END
		
		IF (enganche==1) graph=93; // CAMBIANDO EL ÁNGULO SEGÚN LA DIRECCIÓN DE LA MOTO
		
			IF (vas==0) vas=1; pr22=vas_cap_alla(); END
		
			x=pr1.x; y=pr1.y+27;
						
			IF (lado==0) x=pr1.x-3; y=pr1.y+29; angle=0; // Dirección Arriba
				IF (keydown(_up)) angle=rand(-15000,15000); ELSE angle=0; END
			END
		
			IF (lado==1) x=pr1.x+15; y=pr1.y+27; angle=43500; // Dirección Arriba/Izquierda
				IF (keydown(_up)) angle=rand(28500,58500); ELSE angle=43500; END
			END 
		
			IF (lado==2) x=pr1.x-18; y=pr1.y+22; angle=-43500; // Dirección Arriba/Derecha
				IF (keydown(_up)) angle=rand(-28500,-58500); ELSE angle=-43500; END
			END
		
			IF (lado==3) x=pr1.x+3; y=pr1.y-30; angle=180000; // Dirección Abajo
				IF (keydown(_down)) angle=rand(165000,195000); ELSE angle=180000; END
			END
		
			IF (lado==4) x=pr1.x+19; y=pr1.y-21; angle=136500; // Dirección Abajo/Izquierda
				IF (keydown(_down)) angle=rand(121500,151500); ELSE angle=136500; END
			END
		
			IF (lado==5) x=pr1.x-16; y=pr1.y-25; angle=223500; // Dirección Abajo/Derecha
				IF (keydown(_down)) angle=rand(208500,238500); ELSE angle=223500; END
			END
		
			IF (lado==6) x=pr1.x+29; y=pr1.y+3; angle=90000; // Dirección Izquierda
				IF (keydown(_left)) angle=rand(75000,105000); ELSE angle=90000; END
			END
		
			IF (lado==7) x=pr1.x-29; y=pr1.y-3; angle=-90000; // Dirección Derecha
				IF (keydown(_right)) angle=rand(-75000,-105000); ELSE angle=-90000; END
			END
			
			// LLEGADA AL MUELLE DE LA ALPINISTA
			
			IF (pr1.x>124 AND pr1.x<210 AND pr1.y>0 AND pr1.y<80 AND exped==0) 
			
				enganche=0; sumacombo+=1; stats.n_alpinistas+=1;
			
				IF (x2==0) score+=1500; stats.n_punt+=1500; secs+=10; graph=136; 
				ELSE score+=3000; stats.n_punt+=3000; secs+=20; graph=137; 
				END
			
				IF (sumacombo<2)
			
					size=100; angle=0; x=170; Y=80; exped=1; 

					IF (sel_audio==0) sound(snd29,250,256); END
					
				ELSE
				
					signal(id,s_kill_tree); alpinista_cruzando=0; alpinista_returns=1;
			
				END
				
			END
		
		END
		
		IF (exped==1)			
			signal(pr22,s_kill);
			cont3++;
			z=-100;
			IF (cont3>1 AND cont3<12) y+=1; END
			IF (cont3>12) y-=1; END
			IF (cont3==23) cont3=0; cont4+=1; END
			IF (cont4==3) signal(id,s_kill_tree); alpinista_cruzando=0; alpinista_returns=1; enganche=0; END
			
		END
		
		// COLISIONES
		
		IF (exped==0 AND porculo==0 AND clon==0) 
		
			IF (choque==0)
		
				IF (enganche==0 AND collision(TYPE moto) AND gameover==0 AND choque==0) enganche=1; // colisión con Moto
				
					IF (sel_audio==0) sound(snd20,150,256); sound(snd21,40,256); END
				
				END 
				
				ELSE
				
				alpinista_muerte=1; deathsj+=1; signal(id,s_kill_tree); blood(x,y); alpinista_cruzando=0; alpinista_returns=1; enganche=0; // si se topa con nosotros con 
				IF (sel_audio==0 AND dist<240) sound(snd18,100,256); END BREAK; 								   // choque = 1 se chafa en lugar de engancharse
			
			END
		
			IF (collision(TYPE pepe)) 
				signal(id,s_kill_tree); alpinista_muerte=1; graph=rand(50,52); alpinista_cruzando=0; blood(x,y); alpinista_returns=1; enganche=0; 
				IF (sel_audio==0 AND dist<240) sound(snd18,100,256); END BREAK;
			END
		
			IF (collision(TYPE aura)) // colisión con Aura
				alpinista_muerte=1; dir=rand(1,4); porculo=1; enganche=2; signal(pr22,s_kill);
				IF (sel_audio==0 AND dist<240) sound(snd8,100,256); sound(snd19,100,256); END
			END
		
			IF (collision(TYPE jofre)) // colisión con Jofre
				signal(id,s_kill_tree); alpinista_muerte=1; graph=rand(50,52); deathsj+=1; alpinista_cruzando=0; 
				blood(x,y); alpinista_returns=1; enganche=0; stats.n_jmuertos+=1;
				IF (sel_audio==0 AND dist<240) sound(snd18,100,256); END BREAK;
			END
		
			IF (collision(TYPE star))  // colisión con estrella ninja
				signal(id,s_kill_tree); alpinista_muerte=1; deathsj+=1; blood(x,y); alpinista_cruzando=0; 
				alpinista_returns=1; enganche=0; stats.n_jmuertos+=1;
				IF (sel_audio==0 AND dist<240) sound(snd18,100,256); END BREAK;
			END
		
		END
		
		IF (porculo==0)
		
			IF (x<-20) alpinista_cruzando=0; signal(id,s_kill_tree); BREAK; END
			IF (x>340) alpinista_cruzando=0; signal(id,s_kill_tree); BREAK; END
			IF (y>1350) alpinista_cruzando=0; signal(id,s_kill_tree); BREAK; END
			IF (y=<65) y=65; origen=4; END
		
		END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// PALÉ
//*******************************************************************************************

PROCESS pale();

PRIVATE

	cont; acont;
	
	dir; // para saber dónde se va a ir a tomar por culo
	
	est;
	
	cont2;
	
	tope_clon; cont_clon;

BEGIN

	ctype=c_scroll;
	
	graph=15; 
	
	z=-6;
	
	haypale=1;
	
	sombra_pale();
	
	LOOP
	
		IF (vel_m>60) 
			IF (tope_clon<3) 
				CLONE 
					flags=4; tope_clon++;
					LOOP 
						cont_clon++;
						IF (cont_clon==3) tope_clon--; signal(id,s_kill); END 
						FRAME; 
					END 
				END
			END
		END
	
		IF (carga==2) flags=0; // Siempre que estemos cargando con el palé...
	
			IF (lado==0) x=pr1.x; y=pr1.y-14; angle=0; END // Dirección Arriba
		
			IF (lado==1) x=pr1.x-10; y=pr1.y-10; angle=43500; END // Dirección Arriba/Izquierda

			IF (lado==2) x=pr1.x+10; y=pr1.y-10; angle=-43500; END // Dirección Arriba/Derecha
				
			IF (lado==3) x=pr1.x; y=pr1.y+14; angle=0; END // Dirección Abajo
				
			IF (lado==4) x=pr1.x-9; y=pr1.y+10; angle=-43500; END // Dirección Abajo/Izquierda
				
			IF (lado==5) x=pr1.x+9; y=pr1.y+10; angle=43500; END // Dirección Abajo/Derecha
				
			IF (lado==6) x=pr1.x-14; y=pr1.y-1; angle=0; END // Dirección Izquierda
			
			IF (lado==7) x=pr1.x+14; y=pr1.y-1; angle=0; END // Dirección Derecha
		
		END
		
		IF (carga==0 AND expedint==0) // Si no cargamos con el palé...
		
			cont++; 
			
			IF (cont==1) flags=4; END	IF (cont==12) flags=0; END
			IF (cont==24) flags=4; END IF (cont==36) flags=0; END IF (cont==48) flags=4; END IF (cont==60) flags=0; END
			IF (cont==72) flags=4; END IF (cont==84) flags=0; END IF (cont==96) flags=4; END IF (cont==108) flags=0; END
			IF (cont==120) flags=4; END IF (cont==132) flags=0; END	IF (cont==144) flags=4; END	IF (cont==156) flags=0; END
			IF (cont==168) flags=4; END	IF (cont==180) flags=0; END	IF (cont==192) flags=4; END	IF (cont==204) flags=0; END
			IF (cont==210) flags=4; END	IF (cont==216) flags=0; END	IF (cont==222) flags=4; END	IF (cont==228) flags=0; END
			IF (cont==234) flags=4; END	IF (cont==240) flags=0; END	IF (cont==246) flags=4; END	IF (cont==252) flags=0; END
			IF (cont==258) flags=4; END	IF (cont==264) flags=0; END	IF (cont==270) flags=4; END	IF (cont==276) flags=0; END
			IF (cont==282) flags=4; END IF (cont==288) flags=0; END IF (cont==294) flags=4; END IF (cont==300) cont=0; haypale=0; signal(id,s_kill_tree); END
			
			ELSE cont=0; 
		END
		
		// FUNCIÓN DE CHOQUE, DE A TOMAR POR CULO, VAMOS
		
		IF (palefuera==1 AND carga==2) carga=3;  
			dir=rand(10,-10); 
			IF (dir<10 AND dir>-1) dir=10; END
			IF (dir>-10 AND dir<0) dir=-10; END 
			palefuera=2;
		END
		
		IF (palefuera==2) carga=0; x+=dir+2; y+=5; angle+=50000;
			IF (x>350 OR x<-30) palefuera=0; haypale=0; signal(id,s_kill_tree); END
		END
		
		// FUNCIÓN DE PALÉ EXPEDIDO
		
		IF (carga==5)
			carga=0; stats.n_exp+=1;
			IF (x2==0) score+=2500; stats.n_punt+=2500; secs+=25; ELSE score+=5000; stats.n_punt+=5000; secs+=50; END
			signal(id,s_kill_tree); haypale=0;
			IF (sumacombo==1) pr12=vent_exp(); END
			
		END
		
		FRAME;
		
	END

END

//*******************************************************************************************
// VENTANA DE PALÉ EXPEDIDO
//*******************************************************************************************

PROCESS vent_exp();

PRIVATE

	cont; cont2;

BEGIN

	IF (x2==0) graph=140; ELSE graph=141; END
	
	ctype=c_scroll;
	
	z=-12;
	
	size=85;
	
	x=170; y=80;
	
	IF (sel_audio==0) sound(snd13,80,256); sound(snd22,60,256); END
	
	LOOP
	
		IF (congelar==0)
	
			IF (sumacombo>1) BREAK; END
	
			cont++;
		
			IF (cont2<3)
		
				IF (cont>1 AND cont<12) y+=1; END
				IF (cont>12) y-=1; END
				IF (cont==24) cont=0; cont2+=1; END		
			END
		
			IF (cont>40) BREAK; END
		
			IF (cont2==3) x=-300; END
			
		END
		
		FRAME;
	
	END
	
END

//*******************************************************************************************
// ENCARGADO
//*******************************************************************************************

PROCESS encargado();

PRIVATE

	cont;
	
	ret; // retardo para la animación
	
	opt; // opciones de movimiento
	
	cambio; // para saber si tiene que hacer un cambio de dirección
		
	dir; // para saber qué gráficos usar
	
	origen; // para saber el origen
	
	gs; gf; // gráfico de inicio y de final
	
	dist; // distancia de la moto
	

BEGIN
	
	ctype=c_scroll; 
	
	z=1; 
	
	size=125;
	
	origen=rand(1,2); // si el origen es 1 sale del lateral izquierdo, si es de 2 sale del derecho, y si es 3 sale de arriba
	
	SWITCH (origen)
		CASE 1:
			graph=61; flags=0; x=-30; y=rand(65,1200); 
		END
		
		CASE 2:
			graph=61; flags=1; x=350; y=rand(65,1200);
		END
		
	END
	
	sombra_encargado();
	
	LOOP
		
		IF (gameover==0) dist=fget_dist(x,y,pr1.x,pr1.y); ELSE IF (gameover==2) dist=fget_dist(x,y,scroll.x0,scroll.y0); END END
		
		cont++; ret++;
		
		IF (ret==4) graph++; ret=0; END
		
		IF (rand(0,200)>190) cambio=1; END // hacemos un rand para ver si cambia de dirección
		
		IF (cambio==1) 
			IF (origen==1) origen=3; cambio=2; END
			IF (origen==2 AND cambio==1) origen=3; cambio=2; END
			IF (origen==3 AND cambio==1) origen=rand(1,2); END
			
			SWITCH (origen)
				CASE 1:
					graph=61; flags=0; 
				END
		
				CASE 2:
					graph=61; flags=1; 
				END
		
				CASE 3:
					graph=65; flags=0; 
				END
			END
			
			cambio=0;
			
		END
		
		IF (origen==1) 
						
			gs=61; gf=64;
		
			IF (graph==gf) graph=gs; END
			
			x+=5; 
		
		END
		
		IF (origen==2) 
			
			gs=61; gf=64;
			
			IF (graph==gf) graph=gs; END
			
			x-=5; 
		
		END
		
		IF (origen==3)
			
			gs=65; gf=72;
			
			IF (graph==gf) graph=gs; END
			
			y+=6;
			
		END
		
		IF (collision(TYPE moto)) angle=rand(0,360000); // colisión con Moto
			signal(id,s_kill_tree); deaths+=1; 
			IF (x2==0) money(x,y-20,1500); ELSE money(x,y-20,3000); END 
			encargado_cruzando=0; encargado_returns=1; blood(x,y); stats.n_muertos+=1; stats.n_encargados+=1;
			IF (sel_audio==0) sound(rand(snd4,snd7),100,256); sound(snd22,60,256); END 
		END
		
		IF (collision(TYPE jofre)) angle=rand(0,360000); // colisión con Jofre
			signal(id,s_kill_tree); deathsj+=1; encargado_returns=1; encargado_cruzando=0; blood(x,y); 
			IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); stats.n_jmuertos+=1; END
		END
		
		IF (collision(TYPE star))  // colisión con estrella ninja
			signal(id,s_kill_tree); deathsj+=1; blood(x,y); encargado_returns=1; stats.n_jmuertos+=1;
			IF (sel_audio==0 AND dist<240) sound(rand(snd4,snd7),100,256); END
		END
		
		IF (x<-40) encargado_cruzando=0; signal(son,s_kill); BREAK; END
		IF (x>370) encargado_cruzando=0; signal(son,s_kill); BREAK; END
		IF (y>1300) encargado_cruzando=0; signal(son,s_kill); BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// MANCHA DE SANGRE
//*******************************************************************************************

PROCESS blood(x,y);

PRIVATE

	cont;

BEGIN 
	
	ctype=c_scroll;

	graph=rand(109,113);
	
	z=100;
	
	size=rand(100,140);
	
	angle=rand(0,360000);
	
	LOOP
	
		IF (congelar==0) cont++; END
		
		IF (cont==800) flags=4; END
		IF (cont==1200) cont=0; BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// VIDAS
//*******************************************************************************************

PROCESS vida();

PRIVATE

	cont;

BEGIN

	graph=76;
	
	x=45; y=26;
		
	LOOP

		IF (quitavida==1) vidas-=1; quitavida=0; flash(); IF (sel_audio==0) sound(snd9,150,256); END END
		IF (sumavida==1)
			IF (vidas==8) sumavida=0; 
			ELSE vidas+=1; sumavida=0; IF (sel_audio==0) sound(snd2,35,256); END
			END 
		END
	
		SWITCH (vidas)
			CASE 1: graph=76; END CASE 2: graph=77; END CASE 3: graph=78; END CASE 4: graph=79; END
			CASE 5: graph=80; END CASE 6: graph=81; END CASE 7: graph=82; END CASE 8: graph=83; END
		END
		
		IF (vidas==0) cont++; 
		
			IF (cont==10) graph=76; END
			IF (cont==20) graph=101; cont=0; END
			
			ELSE cont=0;
			
		END
		
		IF (vidas<0) graph=101; END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// VENTANA NINJA-TORERO
//*******************************************************************************************

PROCESS ventana_ninja();
	
BEGIN
	
	graph=84;
	
	x=160; y=190; 
	
	z=-1000;

	IF (sel_audio==0) sound(snd16,100,256); END
	
	LOOP
		
		IF (keydown(_enter) OR keydown(_space)) // SI PULSAMOS ENTER, DESPERTAMOS TODOS LOS PROCESOS
			signal(pr0,s_wakeup_tree); volvertexto=1; bloqueo=1; congelar=0;
			BREAK;			
		END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// ESTRELLA NINJA
//*******************************************************************************************

PROCESS star(x,y);

PRIVATE
			
	dir; // dirección a tomar
	
	cont;
	
	ret; // retardo
	
BEGIN

	ctype=c_scroll;
	
	graph=11;

	dir=rand(1,8);

	sombra_star();
	
	LOOP
	
		cont++;
	
		size=tam_e;
	
		SWITCH (dir)
		
			CASE 1:	x-=vel_e; END // izquierda
			
			CASE 2: x-=vel_e; y-=vel_e; END // arriba izquierda
			
			CASE 3: y-=vel_e; END // arriba
			
			CASE 4:	y-=vel_e; x+=vel_e+rand(vel_e-2,vel_e+2);END // arriba derecha
			
			CASE 5:	x+=vel_e; END // derecha
			
			CASE 6: x+=vel_e; y+=vel_e+rand(vel_e-2,vel_e+2); END // derecha abajo
			
			CASE 7: y+=vel_e; END // abajo
			
			CASE 8:	x-=vel_e; y+=vel_e;	END // abajo izquierda
			
		END
		
		angle+=65000;
		
		IF (cont==60) signal(son,s_kill); BREAK; END
		
		IF (ret==1) signal(son,s_kill); BREAK; END
		
		IF (collision(TYPE trabajador) OR collision(TYPE alpinista) OR collision(TYPE comercial) OR collision(TYPE encargado) OR collision(TYPE aura) or collision(TYPE pepe)) 
			ret=1; 
		END
		
		IF (x<20) signal(son,s_kill); BREAK; END
		IF (x>340) signal(son,s_kill); BREAK; END
		IF (y<-20) signal(son,s_kill); BREAK; END
		IF (y>1320) signal(son,s_kill); BREAK; END
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// VIDA EXTRA
//*******************************************************************************************

PROCESS vida_extra();

PRIVATE

	cont;
	cont2;
	texto;

BEGIN
	
	sumavida=1;
	
	LOOP
	
		cont++;
		
		IF (cont==1) texto=write(fnt3,75,78,0,"VIDA EXTRA!!"); END
		IF (cont==17) delete_text(texto); END
		IF (cont==28) cont=0; cont2+=1; END
		
		IF (cont2==3) BREAK; END
	
	FRAME;
	
	END
	
END

//*******************************************************************************************
// MENÚ ESCAPE
//*******************************************************************************************

PROCESS menu_esc(); 

PRIVATE

	cont;
	
	texto; // texto Pausa
	
	t1; t2; t3; t4;
	
	sel; // selección
	
	est; // estado
	
	string txt_screen; string txt_audio;
	
	solo1;
	
BEGIN
	
	archivo2 = fopen("../files/stats.dat", "w");
	fwrite(&stats, sizeof(stats), archivo2);
	fclose(archivo2);
	
	sng_pause=1;
	
	fade(75,75,75,4);
	
	graph=201;
	
	congelar=1;
	
	IF (sel_audio==0) sound(snd10,100,256); END
	
	sel=0;
	
	texto=write(fnt3,160,75,4,"PAUSA"); 
	
	LOOP
	
		IF (solo1==1 AND NOT keydown(_enter)) solo1=0; END
	
		IF (modop==1) txt_screen="PANTALLA COMPLETA"; END
		IF (modop==2) txt_screen="FINESTRA"; END
	
		IF (sel_audio==0) txt_audio="SI"; ELSE txt_audio="NO"; END
	
		IF (keydown(_up) AND NOT keydown(_esc))
				IF (sel_audio==0) sound(snd11,100,256); END
				WHILE (keydown(_up)) FRAME; END sel-=1; 
			END
			
			IF (keydown(_down) AND NOT keydown(_esc))
				IF (sel_audio==0) sound(snd11,100,256); END
				WHILE (keydown(_down)) FRAME; END sel+=1; 
			END
	
		IF (est==0)
		
			t1=write(fnt2,160,120,4,"SEGUIR JUGANT"); 
			t2=write(fnt2,160,150,4,"AJUDA I TECLES");
			t3=write(fnt2,160,180,4,"OPCIONS");
			t4=write(fnt2,160,210,4,"SORTIR");
			est=1;
	
		END
	
		IF (est==1) // PRINCIPAL
			
			IF (sel==4) sel=0; END
			IF (sel==-1) sel=3; END
			
			IF (sel==0) // SEGUIR JUGANDO
			
				x=76; y=120; 
				
				IF (keydown(_enter) AND solo1==0)
				solo1=0; est=5; 
				IF (sel_audio==0) sng_pause=0; songchannel_resume(0); sound(snd12,100,256); END 
				END
				
			END
			
			IF (sel==1) // AYUDA Y TECLAS
			
				x=76; y=150;
				
				IF (keydown(_enter) AND solo1==0) solo1=1; est=50; IF (sel_audio==0) sound(snd12,100,256); END END
				
			END
			
			IF (sel==2) // OPCIONES
			
				x=108; y=180; 
				
				IF (keydown(_enter) AND solo1==0) solo1=1; est=20; sel=0; IF (sel_audio==0) sound(snd12,100,256); END END
				
			END
			
			IF (sel==3) // SALIR AL MENÚ PRINCIPAL
			
				x=115; y=210; 
				
				IF (keydown(_enter)) est=10; IF (sel_audio==0) sound(snd12,100,256); END END
				
			END
			
		END
	
		IF (est==20) // SUB-MENÚ DE OPCIONES
		
			delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4);
			t1=write(fnt2,140,120,4,"AUDIO"); t2=write(fnt2,200,120,4,txt_audio);
			t3=write(fnt2,160,150,4,txt_screen); t4=write(fnt2,160,180,4,"TORNAR");
			est=21;
		END
		
		IF (est==21)
		
			IF (sel==3) sel=0; END
			IF (sel==-1) sel=2; END
		
			IF (sel==0) x=99; y=120; // AUDIO SI/NO
			
				IF (keydown(_enter) AND solo1==0) 
					solo1=1;
					sound(snd12,100,256);			
					IF (sel_audio==0) sel_audio=3; END
					IF (sel_audio==1) sel_audio=4; END
					IF (sel_audio==3) sel_audio=1; END
					IF (sel_audio==4) sel_audio=0; END
				END
			
			END
			
			IF (sel==1) // PANTALLA COMPLETA / VENTANA 
				IF (modop==1) x=47; y=150; END
				IF (modop==2) x=105; y=150; END
				
				IF (keydown(_enter) AND solo1==0) solo1=1; 
					IF (sel_audio==0) sound(snd12,100,256); END
					IF (modop==1) mode_change(mode_fullscreen); modop=3; END			
					IF (modop==2) mode_change(mode_window); modop=4; END					
					IF (modop==3) modop=2; END
					IF (modop==4) modop=1; END
					est=20;
				END
				
			END
			
			IF (sel==2) x=112; y=180; // VOLVER AL MENÚ ESCAPE PRINCIPAL
				
				IF (keydown(_enter) AND solo1==0) solo1=1; 
					IF (sel_audio==0) sound(snd12,100,256); END
					delete_text(t1); delete_text(t2); 
					delete_text(t3); delete_text(t4); sel=2; est=0;
				END
				
			END
			
		END
	
		IF (est==50) // PANEL DE AYUDA
			delete_text(t1); delete_text(t2); 
			delete_text(t3); delete_text(t4); delete_text(texto);
			est=51;
		END
		
		IF (est==51) graph=205; x=160; y=135; 
			IF (key(_enter) AND solo1==0) solo1=1; est=52; END
		END
		
		IF (est==52) graph=206;
			IF (key(_enter) AND solo1==0) solo1=1; est=53; END
		END
		
		IF (est==53) graph=207; 
			IF (key(_enter) AND solo1==0) solo1=1; graph=201;
				texto=write(fnt3,160,75,4,"PAUSA"); est=0;
			END
		END
	
		IF (tope_esc==1 AND NOT keydown(_esc)) tope_esc=0; END
	
		IF (keydown(_esc) AND tope_esc==0 OR est==5) // VOLVER AL JUEGO
			IF (sel_audio==0) sng_pause=0; songchannel_resume(0); END
			signal(pr0,s_wakeup_tree); congelar=0; tope_esc=1; fade(100,100,100,10); bloqueo=1;
			delete_text(texto); delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); BREAK; 
		END
		
		IF (est==10) // SALIR AL MENÚ PRINCIPAL DEL JUEGO
			
			cont++; fade(0,0,0,2); 

			IF (cont==30) delete_text(all_text); signal(pr0, s_kill); let_me_alone(); stop_scroll(0); pr50=menu(); BREAK; END

			IF (sel_audio==0) stop_sound(all_sound); END
			
		END
		
		FRAME;
		
	END

END

//*******************************************************************************************
// TIEMPO
//*******************************************************************************************

PROCESS tiempo();

PRIVATE

	cont;
	finish;
	tope; tope2;
	
BEGIN

	write_int(fnt3,160,35,4,OFFSET secs);

	
	LOOP
	
		IF (secs>0 AND vidas>-1 AND nocount==0) cont++; END
		
		IF (cont==24) secs-=1; cont=0; 
		
			stats.n_secs+=1; 
			IF (stats.n_secs==60) stats.n_minuts+=1; stats.n_secs=0; END
			IF (stats.n_minuts==60) stats.n_hores+=1; stats.n_minuts=0; END
		
		END
		
		IF (secs==0 AND finish==0) finish=1; cont=0; game_over(); END
		
		IF (sel_audio==0)
		
			IF (secs>10) tope=0; tope2=0; END
		
			IF (secs==10 AND tope==0) sound(snd26,100,256); tope=1; END
			
			IF (secs==9 AND tope==1) sound(snd26,100,276); tope=2; END
			
			IF (secs==8 AND tope==2) sound(snd26,100,296); tope=3; END
			
			IF (secs==7 AND tope==3) sound(snd26,100,316); tope=4; END
			
			IF (secs==6 AND tope==4) sound(snd26,100,336); tope=5; END
			
			IF (secs==5 AND tope==5) sound(snd26,100,356); tope=6; END
			
			IF (secs==4 AND tope==6) sound(snd26,100,376); tope=7; END
			
			IF (secs==3 AND tope==7) sound(snd26,100,396); tope=8; END
			
			IF (secs==2 AND tope==8) sound(snd26,100,416); tope=9; END
			
			IF (secs==1 AND tope==9) sound(snd26,100,436); tope=10; END
		
			IF (secs==3 AND tope2==0) sound(snd23,100,256); tope2=1; END
			
			IF (secs==2 AND tope2==1) sound(snd24,100,256); tope2=2; END
			
			IF (secs==1 AND tope2==2) sound(snd25,100,256); tope2=3; END
			
		END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// GAME OVER
//*******************************************************************************************

PROCESS game_over();

PRIVATE

	cont;

BEGIN

	archivo2 = fopen("../files/stats.dat", "w");
	fwrite(&stats, sizeof(stats), archivo2);
	fclose(archivo2);

	gameover=1;

	enganche=0; IF (alpinista_cruzando==1) pr21.graph=85; END
	
	fade(75,75,75,4);
	
	graph=202;
	
	x=160; y=110;
	
	delete_text(all_text); congelar=0; signal(pr15,s_kill); signal(pr16,s_kill); signal(pr18,s_kill);
	
	IF (sel_audio==0) stop_sound(all_sound); sng_pause=1; songchannel_stop(0); sound(snd1,100,256); sel_audio=10; END

	LOOP
	
		cont++;
		
		IF (secs>0 AND cont==40) END
		
		IF (secs<1) signal(pr1,s_sleep_tree); END
		
		IF (cont==28 AND secs>0) signal(pr1,s_sleep_tree); END
		
		IF (cont==50 AND sel_audio==10) END
		
		IF (cont==135) pr54=highparty(); IF (sel_audio==10) sel_audio=0; END BREAK; END
	
		FRAME;
	
	END
	
END

//*******************************************************************************************
// BOCADILLO "VAS CAP ALLA?"
//*******************************************************************************************

PROCESS vas_cap_alla();

PRIVATE

	cont;

BEGIN

	ctype=c_scroll;

	graph=114;
	
	z=-100;
	
	LOOP
	
		IF (alpinista_muerte==1) BREAK; END
	
		IF (congelar==0 AND alpinista_muerte==0) cont++; END
		
		IF (exped!=0) BREAK; ELSE x=father.x+45; y=father.y-30; END
		
		IF (cont==35) BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// COMBO
//*******************************************************************************************

PROCESS combo();

PRIVATE

	cont; cont2;

BEGIN

	stats.n_combos+=1;

	enganche=0; carga=0;

	IF (x2==0) graph=138; score+=500; stats.n_punt+=500;ELSE graph=139; score+=1000; stats.n_punt+=1000; END
	
	ctype=c_scroll;
	
	z=-12;
	
	size=85;
	
	x=170; y=85;
	
	IF (sel_audio==0) sound(snd13,80,256); sound(snd14,180,256); sound(snd29,100,256); sound(snd22,80,256);END
	
	LOOP
	
		cont++;
		
		IF (cont2<3)
		
			IF (cont>1 AND cont<12) y+=1; END
			IF (cont>12) y-=1; END
			IF (cont==24) cont=0; cont2+=1; END		
		END
		
		IF (cont>40) sumacombo=0; BREAK; END
		
		IF (cont2==3) x=-300; END
		
		FRAME;
	
	END
	
END

//*******************************************************************************************
// LEVEL UP
//*******************************************************************************************

PROCESS levelup();

PRIVATE

cont; cont2;

BEGIN

	graph=117;
	
	x=55; y=195;
	
	IF (sel_audio==0) sound(snd32,180,256); sound(snd33,100,256); END
		
	IF (nivel==2)
	
		tam_e+=5; tam_a+=1; num_t=250; num_e=275; vel_pepe+=1; prob_pepe=985;
		
	END
	
	IF (nivel==3)
	
		vel_j1+=1; vel_j2+=1; tam_a+=1; tam_e+=5; num_e=270; num_t=240; prob_pepe=980;
		
	END
	
	IF (nivel==4)
	
		tam_e+=5; tam_a+=1; vel_e+=1; num_t=230; num_e=265; vel_pepe+=1; prob_pepe=975;
		
	END
	
	IF (nivel==5)
	
		vel_p1+=1; vel_p2+=1; tam_e+=5; tam_a+=1; num_e=260; num_t=220; prob_pepe=970;
		
	END
	
	IF (nivel==6)
	
		vel_j1+=1; vel_j2+=1; vel_e+=1; tam_e+=5; tam_a+=1; num_e=255; num_t=210; vel_pepe+=1; prob_pepe=965;

	END
	
	IF (nivel==7)
	
		tam_a+=1; tam_e+=5; num_e=250; num_t=200; prob_pepe=960;
		
	END
	
	IF (nivel==8)
	
		vel_p1+=1; vel_p2+=1; vel_j1+=1; vel_j2+=1; tam_a+=1; tam_e+=5; num_e=245; num_t=190; vel_pepe+=1; prob_pepe=955;
	
	END
	
	IF (nivel==9)
	
		tam_e+=5; tam_a+=1; num_e=240; num_t=180; prob_pepe=950;
		
	END
	
	IF (nivel==10)
	
		vel_p1+=1; vel_p2+=1; tam_e+=5; tam_a+=1; num_e=235; num_t=170; vel_pepe+=1; prob_pepe=945;
		
	END
	
	LOOP

		cont++;
		
		IF (gameover!=0) BREAK; END
		
		IF (cont<10) y+=1; END
		IF (cont>10) y-=1; END
		IF (cont==20) cont=0; cont2+=1; END
		IF (cont2==5) cont2=0; BREAK; END
		
		FRAME;
		
	END
END

//*******************************************************************************************
// PEPE
//*******************************************************************************************

PROCESS pepe();

PRIVATE

	origen; // si sale de la izquierda o de la derecha

	dist;
	
	ret; // retardo para la animación
	
	cont;
	
	aparta;
	cont_apa;
	
	rand1; rand2; // para las distancias en las que aparecer
	
BEGIN

	pepe_cruzando=1;
	
	graph=19;
	
	size=115;
	
	ctype=c_scroll;
	
	origen=rand(1,2);
	
	IF (gameover==0) y=pr1.y+rand(-320,320); ELSE y=scroll.y0+rand(-300,300); END
	
	IF (y<160) y=160; END
	IF (y>1180) y=1180; END
	
	IF (origen==1) 
		x=-40; angle=0; dist=fget_dist(x,0,pr1.x,0);
		IF (dist<130 AND gameover==0) aviso(30,y,94); END
		
	ELSE 
		x=360; angle=180000; dist=fget_dist(x,0,pr1.x,0);
		IF (dist<130 AND gameover==0) aviso(290,y,95); END
	END
	
	sombra_pepe();
	
	LOOP
	
		ret++;
		
		cont++;
		
		IF (ret==2) graph++; ret=0; END // pasamos de gráfico tras el retraso
		
		IF (graph>26) graph=19; END
		
		IF (cont>16) // pasados poco más de dos segundos, empieza la marcha
		
			IF (origen==1) angle=0; x+=vel_pepe; END
		
			IF (origen==2) angle=180000; x-=vel_pepe; END
			
		END
		
		IF (collision(TYPE aura) AND aparta==0) // se aparta si choca con el aura
		
			IF (origen==1) origen=2; ELSE origen=1; END aparta=1;
	
		END
		
		IF (aparta>0) aparta++; END
		
		IF (aparta==30) aparta=0; END
	
		IF (x<-70 OR x>390) signal(id,s_kill_tree); pepe_cruzando=0; BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// AVISO 
//*******************************************************************************************

PROCESS aviso(x,y,graph);

PRIVATE

	cont; cont2;
	grafico;
	
BEGIN

	ctype=c_scroll;

	grafico=graph;
	
	z=-100;
	
	LOOP
	
		cont++;
		
		IF (cont==4) graph=101; END
		IF (cont==8) graph=grafico; cont2++; cont=0; END
		
		IF (cont2==2) BREAK; END
		
		FRAME;
		
	END
		
END	

//*******************************************************************************************
// AVISO PREFERENCIAS
//*******************************************************************************************

PROCESS avisoP();

BEGIN

	graph=98; 
	
	y=20;
	
	LOOP
	
		x=father.x;
		
		FRAME;
		
	END
	
END
	
//*******************************************************************************************
// SINDICALISTAS
//*******************************************************************************************

PROCESS sindic();

PRIVATE

	origen;

	cont; cont2;
	
	muerto;
	
BEGIN

	graph=27;
	
	ctype=c_scroll;
	
	origen=rand(1,2);
	
	IF (origen==1) x=-30; ELSE x=350; END
	
	IF (gameover==0) y=pr1.y+rand(-320,320); ELSE y=scroll.y0+rand(-320,320); END
	
	IF (y>1050) y=1050; END
	IF (y<300) y=300; END
	
	sombra_sindic();

	LOOP
	
		IF (muerto==0)
	
			cont++;
	
			IF (cont==10) y+=3; END
			IF (cont==20) y-=3; cont=0; END
	
			IF (origen==1) x+=2; ELSE x-=2; END
	
			IF (collision(TYPE moto) AND gameover==0) // colisión con Moto
				signal(son,s_kill); stats.n_sindic+=1;
				IF (sel_audio==0) sound(rand(snd4,snd7),100,rand(220,292)); END 
				graph=28; muerto=1; cont=0; z=100; item(x,y-15); 
			END
		
		END
		
		IF (muerto==1)
		
			cont++;
			
			IF (cont==1300) flags=4; END
			IF (cont==2000) cont=0; BREAK; END
			
		END
		
		IF (x<-50 OR x>370) sindic_cruzando=0; signal(id,s_kill_tree); END
		
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// ITEM
//*******************************************************************************************

PROCESS item(x,y);

PRIVATE

	cont;
	cont2;

BEGIN

	graph=29;
	
	ctype=c_scroll;
	
	IF (x<20) x=20; END
	IF (x>300) x=300; END
	
	z=-20;
	
	LOOP
	
		cont++;
		
		IF (cont>1 AND cont<8) y+=1; END
		IF (cont>8 AND cont<16) y-=1; END
		IF (cont==16) cont2+=1; cont=0; END
		
		IF (cont2==10) flags=4; END
		IF (cont2==15) sindic_cruzando=0; BREAK; END
	
		IF (collision(TYPE moto)) 
			IF (sel_audio==0) sound(snd38,100,256); END
			sel_item(); BREAK; 
		END
	
		FRAME;
		
	END
END

//*******************************************************************************************
// SELECCIÓN DE ITEM (RULETA)
//*******************************************************************************************

PROCESS sel_item();

PRIVATE

	cont; cont2;
	sel;
	est;

BEGIN

	sindic_cruzando=1;

	graph=131;

	x=160;
	
	y=76;
	
	LOOP
		
		IF (est==0)
		
			IF (congelar==0) cont++; END
			
			IF (sel==0) // ANIMACIÓN DE LA RULETA DE ITEMS
				IF (cont==3) 
					graph++; cont2+=1; cont=0;
					IF (sel_audio==0) sound(snd36,100,256); END
				END
			END
		
			IF (graph>135) graph=131; END 
		
			IF (cont2==24) // HACEMOS EL RAND PARA EL ITEM
				sel=rand(1,5); cont2=0; 
				IF (sel_audio==0) sound(snd35,100,256); END
			END
		
			SWITCH (sel)
		
				CASE 1:
					graph=131;
					x2=1;
				END
			
				CASE 2:
					graph=132;
					nocount=1;
				END
			
				CASE 3:
					graph=133;
					speed=1;
				END
			
				CASE 4:
					graph=134;
					godmode=1;
				END
				
				CASE 5:
					graph=135;
					sel=6;
				END
			
			END
		
			IF (cont==45) // UNA VEZ MOSTRADO UN PAR DE SEGUNDOS, SE VUELVE PEQUEÑO (EST=1)
				size=50; x=210; y=35; cont=0; cont2=0; est=1;
				IF (sel==6) sumavida+=1; END
			END
			
		END
		
		IF (est==1) // ITEM EN MINIATURA
		
			IF (sel==6) sindic_cruzando=0; nocount=0; x2=0; godmode=0; speed=0; BREAK; END // SI SUMAMOS VIDA VAMOS AL GRANO
		
			IF (secs<100) x=205; ELSE x=212; END
		
			IF (congelar==0) cont++; 
		
				IF (cont2>19 AND cont2<22)
					IF (cont==12) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==24) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
				END
			
				IF (cont2>21 AND cont2<24)
					IF (cont==6) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==12) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==18) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==24) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
				END
			
				IF (cont2>23 AND cont2<25)
					IF (cont==3) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==6) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==9) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==12) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==15) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==18) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==21) size=25; IF (sel_audio==0) sound(snd39,200,256); END END
					IF (cont==24) size=50; IF (sel_audio==0) sound(snd39,200,256); END END
				END
		
				IF (cont==12) flags=4; END // HACEMOS LA TRANSPARENCIA
				IF (cont==24) flags=0; cont=0; cont2++; END
			
				IF (cont2==25) // ELIMINAMOS Y PONEMOS TODO A 0
					sindic_cruzando=0; 
					nocount=0; x2=0; godmode=0; speed=0;
					BREAK; 
				END
		
			END
		
		END
		
		IF (gameover!=0) BREAK; END
	
		FRAME;
		
	END

END

//*******************************************************************************************
// FLASH
//*******************************************************************************************

PROCESS flash();

PRIVATE

	cont;

BEGIN

	ctype=c_scroll;

	size=0;
	
	x=pr1.x; y=pr1.y;
	
	graph=41;
	
	LOOP
	
		cont++;
		
		size+=20;
		
		IF (cont==5) BREAK; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// BORRAR TEXTOS
//*******************************************************************************************

PROCESS borratexto();

BEGIN

delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4); 
delete_text(t5); delete_text(t6); delete_text(t7); delete_text(t8); 
	
END

//*******************************************************************************************
// SOMBRA
//*******************************************************************************************

PROCESS sombra(mini,maxi,graph);

PRIVATE

	cont;

BEGIN
	
	flags=0;
	
	size=60;
	
	ctype=c_scroll;
	
	x=father.x; y=father.y+10; 
	
	LOOP
	
		IF (congelar==0)
		
			cont++;
	
			IF (cont<maxi) size+=5; END	// creamos el efecto de que la sombra crece y disminuye
			IF (cont>mini) size-=5; END
			IF (cont==10) cont=0; END
		
		END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA CURRI
//*******************************************************************************************

PROCESS sombra_curri();

BEGIN

	graph=44;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP
	
		x=father.x-2; y=father.y+2; 
		
		//IF (father.y<30) BREAK; END
		
		angle=father.angle;
		
		IF (father.size>100) size=father.size+10; ELSE size=father.size+5; END
		
		IF (father.size>100) x=x-father.size/7; y=y-father.size/7; z=-40; graph=47; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA MOTO
//*******************************************************************************************

PROCESS sombra_moto();

BEGIN

	graph=45;

	ctype=c_scroll;
	
	flags=4;
	
	z=-2;
	
	LOOP
	
		x=father.x-2; y=father.y+2; 
		
		IF (choque==1) y=y-father.size/7; x=x-father.size/7; END
		
		angle=father.angle;
		
		size=father.size+5;
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA PALÉ
//*******************************************************************************************

PROCESS sombra_pale();

BEGIN

	graph=46;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP
		
		x=father.x-2; y=father.y+2; 
	
		IF (choque==1 AND carga!=0) y=y-father.size/7; x=x-father.size/7; END
	
		angle=father.angle;
		
		size=father.size+5;
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA PREFERENCIAS
//*******************************************************************************************

PROCESS sombra_pref();

BEGIN

	graph=50;

	ctype=c_scroll;
	
	z=2;
	
	LOOP
	
		x=father.x-2; y=father.y+3; 
	
		IF (father.graph==53 OR father.graph==57) graph=50; flags=0; END
		
		IF (father.graph>53 AND father.graph<57) graph=51; END
		
		IF (father.graph>57) graph=51; flags=1; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA ALPINISTA
//*******************************************************************************************

PROCESS sombra_alp();

BEGIN

	graph=120;

	ctype=c_scroll;
	
	z=2;
	
	flags=4;
	
	LOOP
			
		x=father.x+1; y=father.y+3; 
		
		IF (father.graph==85) graph=120; END
		
		IF (father.graph==89) graph=120; END
		
		IF (father.graph>85 AND father.graph<89) graph=father.graph+35; END
		
		IF (father.graph>89 AND father.graph<93) graph=father.graph+31; END
		
		IF (father.graph==93) graph=124; size=father.size-35; END
		
		IF (father.size>130) x=x-father.size/10; y=y-father.size/10; z=-40; END
		
		angle=father.angle;
		
		IF (father.graph!=93) size=father.size+5; END
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA JOFRE
//*******************************************************************************************

PROCESS sombra_jofre();

BEGIN

	graph=128;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP
	
		x=father.x-2;
		
		angle=father.angle-90000;
		
		SWITCH (father.angle)
		
			CASE 90000:
			
				y=father.y+5;
			
			END
			
			CASE 35000:
			
				y=father.y+3;
				
			END
			
			CASE 145000:
			
				y=father.y+3;
			
			END
			
			DEFAULT:
			
				y=father.y+2;
				
			END
			
		END
		
		size=father.size+5;
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA STAR
//*******************************************************************************************

PROCESS sombra_star();

BEGIN

	graph=127;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP
	
		x=father.x-5; y=father.y+7; 
		
		angle=father.angle;
		
		size=father.size+3;
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA PEPE
//*******************************************************************************************

PROCESS sombra_pepe();

BEGIN

	graph=126;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP
	
		x=father.x-2;

		IF (father.angle==0) y=father.y+6; ELSE  y=father.y+3; END
		
		size=father.size+5;
		
		angle=father.angle;
		
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA COMERCIAL
//*******************************************************************************************

PROCESS sombra_comercial();

BEGIN

	graph=125;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP

		x=father.x-2; y=father.y+2;
		
		size=father.size+5;
		
		angle=father.angle;
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA ENCARGADO
//*******************************************************************************************

PROCESS sombra_encargado();

BEGIN

	graph=130;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP

		x=father.x-2; y=father.y+9;
		
		size=father.size+2;
		
		angle=father.angle;
	
		FRAME;
		
	END
	
END

//*******************************************************************************************
// SOMBRA SINDICALISTAS
//*******************************************************************************************

PROCESS sombra_sindic();

BEGIN

	graph=129;

	ctype=c_scroll;
	
	flags=4;
	
	z=2;
	
	LOOP

		x=father.x-2; y=father.y+9;
		
		size=father.size+2;
		
		angle=father.angle;
	
		FRAME;
		
	END
	
END