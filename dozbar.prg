/*
***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***++
***+++***+++-----------------------------------------------------***+++***+++
***+++***+++***+++***+++          DoZ's BAR          ***+++***+++***+++***+++
***+++***+++-----------------------------------------------------***+++***+++
***+++***+++***+++***+++***    DESARROLLO: 25%    +++***+++***+++***+++***+++
***+++***+++-----------------------------------------------------***+++***+++
***+++***+++***+++***   © Guillem Mairal (DoZ) - 2016   +++***+++***+++***+++
***+++***+++-----------------------------------------------------***+++***+++
***+++***+++***+++***     CONTACTO: dozdin@gmail.com    +++***+++***+++***+++
***+++***+++-----------------------------------------------------***+++***+++
***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***+++***++

***********************************************************
Esta obra está licenciada bajo la Licencia Creative Commons 
Atribución-NoComercial-CompartirIgual 4.0 Internacional. 
-----------------------------------------------------------
Para ver una copia de esta licencia, visita: 
http://creativecommons.org/licenses/by-nc-sa/4.0/.
***********************************************************

BUGS:
*****
- De momento ninguno detectado :)

TAREAS INMEDIATAS PENDIENTES:
*****************************
- Añadir movimiento automático de transición a la salida del parking y al subir y bajar escaleras
- Añadir opción de saltarse el viaje con enter o escape
- Programar función de guardar y cargar (buff, esto va a llevar curro xD)
- Añadir opciones en el menú principal para cargar y guardar
- Añadir personaje General en la barricada (nos da paso al mini-juego de zombies)
- Mini-juego barricada (fondo, gráficos y movimiento lateral)
--- Sistema de apuntar con el ratón y disparo
--- Pistola
--- Escopeta
--- Ametralladora
--- Bazooka
--- Granada
--- Items (1/2 velocidad de zombies, godmode, no recargar, one shoot kill..)
*/

PROGRAM DoZBAR;

Include "prg/menu.prg"; Include "prg/bar.prg"; Include "prg/invaders.prg";
Include "prg/jarras.prg"; Include "prg/ruleta.prg"; Include "prg/parking.prg";
Include "prg/slot.prg"; Include "prg/simon.prg"; Include "prg/conv.prg";
Include "prg/flecha_conv.prg"; Include "prg/barricada.prg"; Include "prg/sumando.prg";
Include "prg/panel.prg"; Include "prg/logos.prg"; Include "prg/prota.prg";
Include "prg/interface.prg"; Include "prg/seg_piso.prg"; Include "prg/taxi.prg";
Include "prg/zombies.prg";

GLOBAL

	intro=1; // para activar o no la intro

	audio; // variable de audio activado/desactivado
	fxv=100; // variable de volumen
	vol=70; // volumen de música
	mem_vol=60; // memorizando el volumen de la música
	play; // está sonando alguna canción?
	music; // variable de música activada/desactivada
	cancion; // canción actual
	s1; s2; s3; s4; s5; s6; s7; s8; // songs
	us; // última canción que ha sonado (para no repetirse)
	
	est_c; // estado de la ventana de conversación
	
	pantalla; // variable para saber si estamos en pantalla completa o no
	brillo=100; // variable de brillo
	
	chn1; // canal de música 1
	chn2; // canal de música 2
	
	fpg1; // fpg principal
	fpg2; // fpg barricada
	fpg3; // fpg viaje en taxi
	fpg4; // fpg del mini-juego zombies
	
	tope_ESC; // tope global para el escape
	t_ENTER; // tope global para el enter
	tope_TAB; // tope global para el tabulador
	cyp; // coordenada Y Panel
	
	snd1; // sonido shoot nave alien
	snd2;
	snd3;
	snd4;
	snd5;
	snd6;
	snd7;
	snd8; // FX lluvia
	snd9; // FX trueno
	snd10; // beep ajuste de volumen de FX
	snd11; // CHOF! sonido del atropellado
	snd12; // sonido de claxon
	snd13; // sonido de coche pasando
	snd14; // rodillos girando
	snd15; // rodillo para
	snd16; // FX de insertar moneda en la traga
	snd17; // vocal AVANCES
	snd18; // vocal 1
	snd19; // vocal 2
	snd20; // vocal 3
	snd21; // vocal 4
	snd22; // vocal RETENCIÓN
	snd23; // cobrando tragaperras
	snd24; // premio en los rodillos
	snd25; // no doblamos
	snd26; // obtenemos premio
	snd27; // sonido de combinación alineada de la tragaperras
	snd28; // LOOP de doblar o nada de la tragaperras
	snd29; // Sonido de Aaarrgght!!
	snd30; // inicio de Ruleta Rusa
	snd31; // FX de disparo de Ruleta Rusa
	snd32; // FX de disparo fake, sin bala de Ruleta Rusa
	snd33; // FX de latidos
	snd_latidos; // id del sonido FX de latidos
	snd34; // FX del rozamiento de la pistola en la mesa
	snd35; // Ambiente del bar (Lanzamiento de Jarras)
	snd36; // FX cremallera (BACK varios)
	snd37; // FX Beep para menús
	snd38; // FX de jarra servida
	snd39; // FX Beep 2 para menús (selección)
	snd40; // FX abrir puerta
	snd41; // FX deslizamiento jarra
	snd42; // FX de recibir la jarra
	snd43; // FX de abucheo ruleta rusa
	snd44; // FX de aplausos ruleta rusa
	snd45; // FX de jarra fallida
	snd46; // FX de jarra rota
	snd47; // FX de pasos madera 1
	snd48; // FX de pasos madera 2
	snd49; // FX de pasos madera 3
	snd50; // FX de pasos madera 4
	snd51; // FX de pasos lluvia 1
	snd52; // FX de pasos lluvia 2
	snd53; // FX de pasos lluvia 3
	snd54; // FX de pasos lluvia 4
	snd55; // FX motor de Simon-Park
	snd56; // FX apagando el motor de Simon-Park
	snd57; // FX Success Simon-Park
	snd58; // FX Ouh Yeah!!
	snd59; // FX GAME OVER 1
	snd60; // FX GAME OVER 2
	snd61; // FX GAME OVER 3
	snd62; // PopUP
	snd63; // FX DOBLA O NO Tragaperras
	snd64; // FX de disparo Machine Gun
	snd65; // FX de casquillos
	snd66; // FX de pasos de zombie
	snd67; // FX de gruñido de zombie
	snd68; // FX de impacto de bala
	snd69; // Música de viaje en taxi
	snd70; // FX de puerta de taxi abriéndose
	snd71; // FX de puerta de taxi cerrándose
	snd72; // FX del taxi llegando y derrapando
	snd73; // FX del motor del taxi
	snd74; // FX del sonido del taxi durante el viaje lateral
	
	fxlluvia; // variable para llamar y detener el FX de lluvia
	
	fnt1; // fuente grande
	fnt2; // fuente mediana
	fnt3; // fuente de explicaciones
	fnt4; // fuente Estado Jugador 1
	fnt5; // fuente de €uros del Estado del Jugador
	fnt6; // fuente de +exp y tal
	fnt7; // fuente de +score
	fnt8; // fuente de +€uros
	fnt9; // fuente de -€uros
	fnt10; // fuente de +EXP grande
	fnt11; // fuente mediana blanca con reborde negro
	fnt12; // fuente €uros grande 
	
	firsthumo; // para saber si es el inicio de la pantalla del bar
	pos_TAB; // posición taburete
	
	pr0; // MAIN PROCESS
	pr1; // bar
	pr2; // laser
	pr3; // main_space();
	pr4; // mini-juego jarras
	pr5; // jarra cerveza
	pr6; // flecha cerveza
	pr7; // ruleta rusa
	pr8; // boy rusa 1
	pr9; // boy rusa 2
	pr10; // gramola
	pr11; // prota
	pr12; // 2º piso
	pr13; // rayo de luz
	pr14; // zona exterior
	pr15; // flecha panel
	pr16; // botón volumen fx panel
	pr17; // botón volumen música panel
	pr18; // botón brillo panel gráficos
	pr19; // simon park (main)
	pr20; // gráfico de selección de plaza
	pr21; // rayo
	pr22; // tragaperras
	pr23; // barra 1
	pr24; // barra 2
	pr25; // barra 3
	pr26; // números avances
	pr27; // mano tragaperras
	pr28; // bocadillo exclamación
	pr29; // parte de abajo de la tragaperras
	pr30; // cara de las ventanas de conversación
	pr31; // proceso ventana pequeña
	pr32; // proceso zona barricada
	pr33; // proceso zombie barricada
	pr34; // proceso Soldat barricada
	pr35; // proceso Indiana Jones
	pr36; // proceso mini-juego Zombies
	pr37; // proceso Stan
	pr50; // proceso WC
	
	transicion; // variable para la transicion
	bajando; // para indicar que bajamos del segundo piso
	haypanel; // para indicar si el panel de escape está activado
	hayconv; // para indicar si hay un panel de conversación activo
	minijuego; // para indicar qué minijuego estamos jugando
	saliendo_minijuego; // para indicar que salimos de un minijuego 
	// 1=Space Invaders 2=Lanzamiento Jarra 3=Ruleta Rusa 4=Simon Park 5=Tragaperras
	
	loc=1; // habitación en la que nos encontramos
	// 1 = bar, planta baja
	// 2 = bar, 2ª planta
	// 3 = baños de la 2ª planta
	// 4 = exteriores
	// 5 = barricada
	
	x_pr; y_pr; // guardar coordenadas del prota para volver al bar
	angle_pr; // lo mismo con el ángulo
	dir_pr; // dirección del prota para guardar
	muerto; // estado del prota
	bajando_2o_piso; // para saber si estamos bajando del 2º piso
	volviendo_minijuego; // para saber si volvemos de un mini-juego
	
	// TEXTOS GLOBALES
	tx1; tx2; tx3; tx4; tx5; // textos globales
	
	// VARIOS (SECRETOS Y EXTRAS)
	
	gscore; // GLOBAL SCORE
	nivel; // nivel del jugador
	expe; // experiencia del jugador
	euros=250; // número de €uros de los que dispone el jugador
	cont_t; cont_s; cont_m; cont_h; // contador de tiempo, segundos, minutos y horas
	est_vent; // estado ventana pequeña
	sefijaenelcoche; // para saber si el jugador se ha fijado en el descapotable
	contador_conv_ruleta; // contador para que aparezca la respuesta de la memoria
	
	// LANZAMIENTO DE JARRA
	
	fase_j; // 1-2 Standby / 3-? Juego
	fuerza_j; // fuerza del lanzamiento de la jarra de cerveza
	angle_j; // ángulo de la jarra al lanzar
	vidas_b; // vidas para el mini-juego de las cervezas
	topex; // tope para el scroll
	
	// RULETA RUSA
	
	fase_r; // fase ruleta rusa
	apuesta_ruleta=100; // cantidad de la apuesta de la ruleta
	bala; // número de disparo en el que se encuentra la bala, y BOOM!! xD
	dis; // número de disparos realizados
	est_pist; // estado pistola
	rajarse; // para saber si nos hemos rajado
	tprob; tprob2; // textos de probabilidad
	prob; // probabilidad de disparo con bala
	
	// MÁQUINA ARCADE
	
	archivo; // archivo Hi-Scores
	fase_arcade; // para indicar la fase del juego
	aliens; // número de aliens
	g_o_a; // game over aliens
	cong_aliens; // para congelar el movimiento de los aliens
	shoot_crash; // para mandar a tomar por culo los disparos si se colisionan
	score_aliens;
	hi_score_aliens;
	linea_aliens;
	cambio_dir;
	salto_linea;
	vidas_alien=3;
	tope_laser;
	x_alien1=60; 
	x_alien2=60;
	x_alien3=60;
	x_alien4=60;
	x_alien5=60;
	y_alien;
	dir_alien; // dirección de los alien
	vel_alien=4; // velocidad de los alien
	vel_space=18; // velocidad del juego space invaders
	var_vel; // variación de velocidad
	score_multiplier;
	difficulty_timer;
	
	score_extra; // variable para la vida extra
	lado_extra; // lado de origen de alien extra
	hayextra; // informamos de que ya está la nave en pantalla
	
	textoy=30;
	
	// MÁQUINA TRAGAPERRAS
	
	est_t; // estado de la tragaperras
	coins; prize=0; // créditos y premios
	val1; val2; val3; // valores de las barras
	bloq1; bloq2; bloq3; // bloqueo de los rodillos por retención
	reten; // retenciones activadas o no
	avances; // número de avances
	av_act; // cuando los avances están activados
	est_x; // estado de las letras de X0 y X2
	est_ad; // estado de las letras de avances
	est_ret; // estado de las letras de retención
	est_bjugar; // estado del botón de jugar/cobrar
	est_b1; est_b2; est_b3; // estado de los botones centrales
	est_bx2; // estado del botón de x2
	
	// PARKING Y ZONA EXTERIOR
	
	est_s; // estado del mini-juego Simon-Park
	ronda_s; // ronda del simon
	plaza; // plaza correspondiente en el mini-juego Simon-Park
	mem_plaza[12]; // el historial de las plazas, 0=libre, 1=ocupada
	STRUCT mem_coche[12]// el historial del color y plaza de los coches
	color;
	plaza;
	END
	cochequetoca=1; // el coche que ya ha salido anteriormente y que toca sacar
	plazaquetoca=1; // lo mismo con la plaza
	stop; // para indicar que ha parado el coche en su plaza
	atropellado; // para indicar que hemos sido atropellados
	haycoche; // para saber si hay ya un coche circulando por la pantalla
	haycoche2; // para saber si hay un coche en sentido contrario
	
	// VIAJE TAXI
	
	est_taxi; // indica el estado del taxi
	cont_taxi; // contador para el taxi
	destino; // destino escogido. 1: Barricada - 2: Bar
	
	// ZONA BARRICADA	
	
	hayzombie; // para indicar si hay un zombie en la pantalla de la zona
	bsz; // Barricada Shoot Zombie - para indicar que se está disparando al zombie
	
LOCAL
	
	status;

	side; // lado por el que aparece el coche del menú
	
	careto; // variable para el careto de la ventana de conversación
	conv; // variable para la conversación que toca
	
	rain_s; // para saber si se corresponde a la lluvia del mini-juego Simon-Park o al exterior (ext)
	
	// Recreativa
	alien1_y; // variable Y de los aliens
	canshoot; // el alien puede disparar
	aspecto; // gráfico del alien
	
	// Variables personaje
	cant_exp; // cantidad de EXP que se gana en cada momento
	cant_gscore; // cantidad de GSCORE que se gana en cada momento
	cant_euros; // cantidad de €UROS que se ganan o se pierden
	
	// Gramola
	x_ini; x_fin; // X inicial y final de los textos de la gramola
	vel_t; // velocidad del texto
	
	// Conversaciones
	opciones; // cantidad de opciones de respuesta
	
BEGIN

	MODE_SET(320,240,32,mode_window,filter_scale_NORMAL2x,filter_scanline_50percent);
	//MODE_SET(320,240,32,mode_fullscreen,filter_scale_NORMAL2x,filter_scanline_50percent);
	fpg1=load_fpg("files/dozbar.fpg");
	fpg2=load_fpg("files/barricada.fpg");
	fpg3=load_fpg("files/taxi.fpg");
	fpg4=load_fpg("files/zombies.fpg");
	
	snd1=sound_load("files/sounds/space inv/shoot.wav");
	snd2=sound_load("files/sounds/space inv/invdeath.wav");
	snd3=sound_load("files/sounds/space inv/b1.wav");
	snd4=sound_load("files/sounds/space inv/b2.wav");
	snd5=sound_load("files/sounds/space inv/b3.wav");
	snd6=sound_load("files/sounds/space inv/b4.wav");
	snd7=sound_load("files/sounds/space inv/ufo.wav");
	snd8=sound_load("files/sounds/rainfx.mp3");
	snd9=sound_load("files/sounds/trueno.mp3");
	snd10=sound_load("files/sounds/menu.wav");
	snd11=sound_load("files/sounds/chof.wav");
	snd12=sound_load("files/sounds/horn.mp3");
	snd13=sound_load("files/sounds/car_pass.mp3");
	snd14=sound_load("files/sounds/rodillosgiran.mp3");
	snd15=sound_load("files/sounds/rodillopara.mp3");
	snd16=sound_load("files/sounds/coin_traga.mp3");
	snd17=sound_load("files/sounds/avances_vocal.mp3");
	snd18=sound_load("files/sounds/uno_vocal.mp3");
	snd19=sound_load("files/sounds/dos_vocal.mp3");
	snd20=sound_load("files/sounds/tres_vocal.mp3");
	snd21=sound_load("files/sounds/cuatro_vocal.mp3");
	snd22=sound_load("files/sounds/retencion_vocal.mp3");
	snd23=sound_load("files/sounds/cobrando.mp3");
	snd24=sound_load("files/sounds/obten_premio.mp3");
	snd25=sound_load("files/sounds/nodobla.mp3");
	snd26=sound_load("files/sounds/obten_premio.mp3");
	snd27=sound_load("files/sounds/combinacion.mp3");
	snd28=sound_load("files/sounds/loop_doblar.mp3");
	snd29=sound_load("files/sounds/arrght.ogg");
	snd30=sound_load("files/sounds/inicio_ruleta.mp3");
	snd31=sound_load("files/sounds/disparo_ruleta.mp3");
	snd32=sound_load("files/sounds/disparo_fake.mp3");
	snd33=sound_load("files/sounds/latidos.mp3");
	snd34=sound_load("files/sounds/mov_pistol.mp3");
	snd35=sound_load("files/sounds/bar_ambient.mp3");
	snd36=sound_load("files/sounds/cremallera.mp3");
	snd37=sound_load("files/sounds/beep.mp3");
	snd38=sound_load("files/sounds/jarra_servida.mp3");
	snd39=sound_load("files/sounds/selec_menu.mp3");
	snd40=sound_load("files/sounds/open_door.mp3");
	snd41=sound_load("files/sounds/deslizamiento_jarra.mp3");
	snd42=sound_load("files/sounds/recibe_jarra.mp3");
	snd43=sound_load("files/sounds/boo.mp3");
	snd44=sound_load("files/sounds/aplausos.mp3");
	snd45=sound_load("files/sounds/jarra_fallida.mp3");
	snd46=sound_load("files/sounds/jarra_rota.mp3");
	snd47=sound_load("files/sounds/walk1.mp3");
	snd48=sound_load("files/sounds/walk2.mp3");
	snd49=sound_load("files/sounds/walk3.mp3");
	snd50=sound_load("files/sounds/walk4.mp3");
	snd51=sound_load("files/sounds/walk_rain1.mp3");
	snd52=sound_load("files/sounds/walk_rain2.mp3");
	snd53=sound_load("files/sounds/walk_rain3.mp3");
	snd54=sound_load("files/sounds/walk_rain4.mp3");
	snd55=sound_load("files/sounds/motor_simon.mp3");
	snd56=sound_load("files/sounds/motor_simon_off.mp3");
	snd57=sound_load("files/sounds/success_simon.mp3");
	snd58=sound_load("files/sounds/ouh_yeah.mp3");
	snd59=sound_load("files/sounds/gameover1.mp3");
	snd60=sound_load("files/sounds/gameover2.mp3");
	snd61=sound_load("files/sounds/gameover3.mp3");
	snd62=sound_load("files/sounds/popup.mp3");
	snd63=sound_load("files/sounds/dobla_o_no.mp3");
	snd64=sound_load("files/sounds/machine_shoot.mp3");
	snd65=sound_load("files/sounds/casquillo.mp3");
	snd66=sound_load("files/sounds/paso_zombie.mp3");
	snd67=sound_load("files/sounds/zombie.mp3");	
	snd68=sound_load("files/sounds/impacto_bala.mp3");
	snd69=sound_load("files/sounds/taxi_song.mp3");
	snd70=sound_load("files/sounds/abre_puerta.mp3");
	snd71=sound_load("files/sounds/cierra_puerta.mp3");
	snd72=sound_load("files/sounds/taxi_derrape.mp3");
	snd73=sound_load("files/sounds/motor_taxi.mp3");
	snd74=sound_load("files/sounds/viaje_taxi.mp3");
	
	fnt1=load_fnt("files/fnts/jarras1.fnt");
	fnt2=load_fnt("files/fnts/jarras2.fnt");
	fnt3=load_fnt("files/fnts/exp.fnt");
	fnt4=load_fnt("files/fnts/est1.fnt");
	fnt5=load_fnt("files/fnts/money.fnt");
	fnt6=load_fnt("files/fnts/score.fnt");
	fnt7=load_fnt("files/fnts/score2.fnt");
	fnt8=load_fnt("files/fnts/+euros.fnt");
	fnt9=load_fnt("files/fnts/-euros.fnt");
	fnt10=load_fnt("files/fnts/score3.fnt");
	fnt11=load_fnt("files/fnts/mediana.fnt");
	fnt12=load_fnt("files/fnts/-eurosBIG.fnt");
	
	intro=0;
	
	IF (intro==0)
		logos();
	END
	
	IF (intro==1)
		pr1=bar();
		music=1;
		audio=1;
	END
	
	IF (intro==2)
		pr32=barricada();
		music=1;
		audio=1;
	END
	
	IF (intro==3)
		viaje_taxi();
		music=1;
	END
	
	IF (intro==4)
		launcher_zombies();
	END

	musica();
	
	pr0=main_process();
	
END

//**************************************
// MAIN PROCESS
//**************************************

PROCESS main_process();

BEGIN

	SIGNAL_SET_BEHAVIOUR(id,s_freeze_tree,s_behaviour_ignore);
	SIGNAL_SET_BEHAVIOUR(id,s_kill,s_behaviour_ignore);
	
	LOOP
	
		IF (keydown(_s)) set_fps(27,0); END
	
		// PULSAMOS ESCAPE PARA EL MENÚ
		IF (keydown(_ESC) AND tope_ESC==0 AND transicion==0 AND loc!=0 AND loc!=100 AND hayconv==0 AND haypanel==0) 
			signal(all_process,s_freeze_tree); panel(); tope_ESC=1;
		END
	
		// PULSAMOS TABULADOR PARA VER EL ESTADO DEL JUGADOR		
		IF (keydown(_TAB) AND transicion==0 AND loc!=0 AND haypanel==0 AND tope_TAB==0 AND hayconv==0)
			signal(all_process,s_freeze_tree); est_jug(); tope_TAB=1; 
		END
		
		// CALCULAMOS EL TIEMPO DE JUEGO
		IF (loc!=0) cont_t++; END
		
		IF (cont_t==27) cont_s++; cont_t=0; END
		IF (cont_s==60) cont_m++; cont_s=0; END
		IF (cont_m==60) cont_h++; cont_m=0; END
	
		// TAXI
		cont_taxi++;
	
		// EL TAXI SE VA Y MATAMOS TODOS LOS PROCESOS
		IF (est_taxi==57)
			IF (cont_taxi=>40)
				hayzombie=0; 
				signal(pr34,s_kill_tree);
				est_taxi=0; cont_taxi=0;
				IF (audio==0) stop_sound(all_sound); END 
				SWITCH (loc)
					CASE 4:
						IF (est_taxi==0) END
						signal(pr14,s_kill_tree); stop_scroll(0); viaje_taxi(); 
					END
					CASE 5:
						signal(pr32,s_kill_tree); stop_scroll(0); viaje_taxi(); 
					END
				END
				
			END
		END
	
		// LIBERAMOS TOPES
		IF (tope_TAB==1 AND NOT keydown(_TAB)) tope_TAB=0; END
		IF (tope_ESC!=0 AND NOT keydown(_ESC)) tope_ESC=0; END
		IF (t_ENTER==1 AND NOT keydown(_ENTER)) t_ENTER=0; END
		
		FRAME;
		
	END
	
END

//**************************************
// MUSICA
//**************************************

PROCESS musica();

PRIVATE 

	cont;
	menu;

BEGIN

	SIGNAL_SET_BEHAVIOUR(id,s_freeze_tree,s_behaviour_ignore);
	SIGNAL_SET_BEHAVIOUR(id,s_kill,s_behaviour_ignore);

	audio_setup.song_channels=2;

	s1=song_load("files/sounds/songs/song1.mp3");
	s2=song_load("files/sounds/songs/song2.mp3");
	s3=song_load("files/sounds/songs/song3.mp3");
	s4=song_load("files/sounds/songs/song4.mp3");
	s5=song_load("files/sounds/songs/song5.mp3");
	
	LOOP
	
		// ZONA BAR/PÁRKING
		IF (loc==1 OR loc==2 OR loc==4 OR loc==0)
			IF (play==0 AND music==0)
				IF (menu==0) cancion=s1; menu=1; ELSE cancion=rand(s1,s5); END
				song_play(cancion); play=1;
				SWITCH (cancion)
					CASE s1: cancion=1; END
					CASE s2: cancion=2; END
					CASE s3: cancion=3; END
					CASE s4: cancion=4; END
					CASE s5: cancion=5; END
					CASE s6: cancion=6; END
					CASE s7: cancion=7; END
					CASE s8: cancion=8; END
				END
				IF (cancion==us) stop_song(); play=0; ELSE us=cancion; END // QUE NO SE REPITA LA CANCIÓN.. us = ÚLTIMA SONG (manda cojones con la variable spanglish xD)
			END
			songchannel_set_volume(0,vol);
		END
			
		IF (!songchannel_is_playing(chn1) AND music==0)	play=0; END // Si no suena ninguna canción, ponemos "play" a 0
	
		IF (vol<0) vol=0; END
		IF (vol>100) vol=100; END
	
		FRAME;

	END

END