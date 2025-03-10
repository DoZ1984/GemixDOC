//**************************************
// LANZAMIENTO DE JARRAS (LAUNCHER)
//**************************************

PROCESS jarras();

PRIVATE

	cont;
	
BEGIN

	delete_text(all_text);
	
	LOOP
		
		IF (cont==1) fade(0,0,0,2); END
	
		cont++;
		
		IF (cont==35) signal(pr1,s_kill_tree); pr4=main_jarras(); END 
	
		FRAME;
		
	END
	
END

//**************************************
// LANZAMIENTO DE JARRAS (MAIN) (pr4)
//**************************************

PROCESS main_jarras();

PRIVATE

	fase; // fase del main
	cont; cont2; cont3; // contadores varios
	n_cliente; // selección de cliente que pide la cerveza
	a_cliente; // cliente anteriormente seleccionado (para no repetirse nunca)
	comp; // comprobación de cliente
	ronda=1; // ronda de juego
	ax; // antigua X. X del scroll del frame anterior para ver si está quieto
	t_rondas; t_nrondas; // textos para el score
	t_highscore; t_hs; 
	highscore;
	archivoJ; // variable de archivo para el highscore
	t1; t2; t3; t4; t5; // textos
	cont_t; // contador de textos
	tb; tb2; // textos para la bronca si fallamos
	atb; // anterior texto de bronca
	vel_scroll; // velocidad actual del scroll
	acel_scroll; // acaeleración del scroll
	lado_scroll;
	ambiente; // sonido de fondo de ambiente
	
BEGIN

	minijuego=2;

	fase_j=0;
	vidas_b=3; 

	scroll_start(0,fpg1,101,0,0,0);

	delete_text(all_text);	
	fade(brillo,brillo,brillo,2);

	archivoJ = fopen("files/saves/hi-scoreJ.dat", "r");
	fread(OFFSET highscore, sizeof(highscore), archivoJ);
	fclose(archivoJ);	
	
	x=750;
	scroll.x0=800;
	
	cliente(6,671);
	cliente(5,511);
	cliente(4,431);
	cliente(3,271);
	cliente(2,111);
	cliente(1,31);
	
	beer_launcher();
	loc=20;
	transicion=0; 
	
	IF (audio==0) ambiente=sound_play(snd35,fxv+30,256); END
	
	LOOP
	
		IF (audio==0 AND!soundchannel_is_playing(ambiente) AND transicion==0) 
			sound_play(snd35,fxv+30,256); 
		END
	
		// FASE DE SCROLL PREVIA A JUGAR
		IF (fase==0 AND cont2==0) 
			t1=write(fnt1,160,40,1,"TIRA LA JARRA!"); fase=1; 
		END
		
		IF (fase==1 AND transicion==0) cont_t++; 
			IF (cont_t==1) t2=write(fnt2,160,213,1,"PULSA ENTER PARA EMPEZAR"); END
			IF (cont_t==20) delete_text(t2); END
			IF (cont_t==30) cont_t=0; END
			
			IF (lado_scroll==0) scroll.x0-=4; END
			IF (scroll.x0<3) lado_scroll=1; END
			IF (lado_scroll==1) scroll.x0+=4; END
			IF (scroll.x0>577) lado_scroll=0; END

			IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; // SI PULSAMOS ENTER PASAMOS A JUGAR
				IF (cont_t>0 AND cont_t<20) delete_text(t2); END 
				delete_text(t1); fase=2; vidas_b=3; 
				vida_b1(); vida_b2(); vida_b3();
			END
			
		END
		
		// INICIAMOS RONDA
		IF (fase==2) scroll.x0=580; // TEXTO DE RONDA
			t1=write(fnt1,95,55,0,"RONDA"); 
			t2=write_int(fnt1,215,55,0,OFFSET ronda); 
			t_rondas=write(fnt2,90,10,0,"RONDAS:"); 
			t_nrondas=write_int(fnt2,177,10,0,OFFSET ronda); 
			t_highscore=write(fnt2,205,10,0,"RECORD:");
			t_hs=write(fnt2,292,10,0,OFFSET highscore);
			fase=3; 
		END
		
		IF (fase==3) cont++; 
		
			IF (cont==24) fase=4; cont=0; delete_text(t1); delete_text(t2); END
		
		END
		
		// SELECCIONAMOS CLIENTE AL AZAR
		IF (fase==4)
			IF (comp==0)
				n_cliente=rand(1,6); 
				IF (n_cliente!=a_cliente) a_cliente=n_cliente; comp=1; END
			END
			
			IF (comp==1) comp=0;
				SWITCH (n_cliente)
					CASE 1: topex=31; END
					CASE 2: topex=111; END
					CASE 3: topex=271; END
					CASE 4: topex=431; END
					CASE 5: topex=511; END
					CASE 6: topex=671; END
				END
				t1=write(fnt2,160,60,1,"UN CLIENTE TIENE SED!!"); fase=5;
			END
		END

		IF (fase==5) cont++; 
			IF (cont==35) 
				fase=6; cont=0; cont2=0; vel_scroll=4;
				pr6=flecha_cliente(topex); delete_text(t1); 
			END
		END
		
		// MOVEMOS EL SCROLL HACIA EL CLIENTE
		IF (fase==6)
			IF (scroll.x0>topex-160) scroll.x0-=vel_scroll; acel_scroll++; END  
			IF (acel_scroll==3) vel_scroll++; acel_scroll=0; END
			IF (scroll.x0==ax) fase=7; END // si el scroll está quieto pasamos de fase
			ax=scroll.x0;
		END
		
		IF (fase==7)
			cont2=0; fase=8;
			IF (topex>111) t1=write(fnt2,178,103,0,"CAÑA AQUI!"); END
			IF (topex==111) t1=write(fnt2,123,103,0,"CAÑA AQUI!"); END
			IF (topex==31) t1=write(fnt2,43,103,0,"CAÑA AQUI!"); END
		END
		
		IF (fase==8)
			cont3++;
			IF (cont3=>30) delete_text(t1); fase=9; vel_scroll=4; END
		END
		
		// VOLVEMOS PARA EL PRINCIPIO DE LA BARRA
		IF (fase==9)
			IF (scroll.x0<580) scroll.x0+=vel_scroll; acel_scroll++; END
			IF (acel_scroll==3) vel_scroll++; acel_scroll=0; END
			IF (scroll.x0>575) scroll.x0=580; fase=10; END
		END
		
		// LLAMAMOS A LA FLECHA Y EL TIRO ESTÁ DISPONIBLE
		IF (fase==10) flecha(); fase=11; mouse.x=scroll.x0; cont=0; END
		
		IF (fase==11) scroll.x0=mouse.x*2; // MOVEMOS EL SCROLL CON EL MOUSE
			IF (mouse.x<0) mouse.x=0; END
			IF (mouse.x>320) mouse.x=320; END
			IF (keydown(_space)) scroll.x0=850; mouse.x=scroll.x0; fase=12; END
		END
		
		// DETECTAMOS QUE EL TIRO HA SIDO EXITOSO
		IF (fase_j==3) cont++;
			IF (cont==1) t1=write(fnt1,160,60,1,"JARRA SERVIDA!!"); 
				IF (audio==0) sound_play(snd38,fxv,256); END
				IF (topex>111)
					suma_exp(213,145,ronda*100/2,fnt6,0);
					suma_gscore(213,135,ronda*100,fnt7,0);
					suma_euros(213,120,5,fnt8,0);
				END
				IF (topex==111)
					suma_exp(158,145,ronda*100/2,fnt6,0);
					suma_gscore(158,135,ronda*100,fnt7,0);
					suma_euros(158,120,5,fnt8,0);
				END
				IF (topex==31)
					suma_exp(78,145,ronda*100/2,fnt6,0);
					suma_gscore(78,135,ronda*100,fnt7,0);
					suma_euros(78,120,5,fnt8,0);
				END
			END
			IF (cont==40)
				delete_text(t1); signal(pr5,s_kill); scroll.camera=0;
				ronda+=1; fase=2; fase_j=0; cont=0; cont3=0; cont_t=0;
			END
		END
		
		// DETECTAMOS QUE EL TIRO HA SIDO FALLIDO
		IF (fase_j==4) cont++;
			IF (cont==15) vidas_b-=1; t1=write(fnt1,160,40,1,"MAL! MUY MAL!!"); 
				IF (audio==0) sound_play(snd45,fxv+50,200); END
			END
			IF (cont==16) 
				tb=rand(1,5);
				IF (tb==atb) cont=15; END
				IF (tb!=atb)
					atb=tb;
					SWITCH (tb)
						CASE 1: tb="CREO QUE HE VISTO"; tb2="PEDOS MEJOR TIRADOS"; END
						CASE 2: tb="NO SERÍAS CAPAZ NI DE"; tb2="TIRAR DE LA CADENA DEL WC"; END
						CASE 3: tb="APUESTO A QUE FALLARÍAS"; tb2="TIRANDO UNA BOTELLA AL MAR"; END
						CASE 4: tb="CAPAZ QUE TE TIRAS A LA"; tb2="CAMA Y TE PARTES LA BOCA"; END
						CASE 5: tb="COMO COMPRES ALGO DE USAR"; tb2="Y TIRAR ESTÁS JODIDO"; END
					END
					t2=write(fnt2,160,100,1,tb);
					t3=write(fnt2,160,125,1,tb2);
				END
			END
			IF (cont==106)
				IF (vidas_b>0)
					delete_text(t1); delete_text(t2); delete_text(t3);
					signal(pr5,s_kill); scroll.camera=0; 
					fase=2; fase_j=0; cont=0; cont3=0; cont_t=0;
				ELSE
					delete_text(t1); delete_text(t2); delete_text(t3);
					cont=0; fase_j=5;
				END
			END
		END
		
		// GAME OVER
		IF (fase_j==5) cont++;
			IF (cont==1)
				t1=write(fnt1,160,40,1,"GAME OVER");
				IF (audio==0) sound_play(snd59,fxv+50,256); END
				IF (ronda<highscore) t2=write(fnt2,160,80,1,"DEDÍCATE A OTRA COSA..."); END
				IF (ronda==highscore) t2=write(fnt2,160,80,1,"POR POCO..."); t3=write(fnt2,160,110,1,"YA TE LLAMAREMOS ;)"); END
				IF (ronda>highscore AND ronda>1) highscore=ronda; 	
				archivoJ = fopen("files/saves/hi-scoreJ.dat", "w");
				fwrite(OFFSET highscore, sizeof(highscore), archivoJ);
				fclose(archivoJ);	
				t2=write(fnt2,160,80,1,"EL MEJOR BARMAN DE LA");
				t3=write(fnt2,160,110,1,"HISTORIA DEL BAR!");
				t4=write(fnt2,160,140,1,"QUE TAMPOCO ES MUCHO..");
				END				
			END
			IF (cont==80)
				fade(0,0,0,2); transicion=1; cont2=1;
			END
		END
		
		// SALIENDO DEL MINIJUEGO
		IF (saliendo_minijuego==2) saliendo_minijuego=200; 
			transicion=1; cont2=1;
			IF (ronda>highscore AND ronda>1) highscore=ronda; 	
				archivoJ = fopen("files/saves/hi-scoreJ.dat", "w");
				fwrite(OFFSET highscore, sizeof(highscore), archivoJ);
				fclose(archivoJ);	
			END 
		END
	
		IF (cont2>0) fase_j=10; fase=0; cont=0; cont_t=0; cont2++; END
		
		IF (cont2==35) stop_scroll(0); signal(id,s_kill_tree); volviendo_minijuego=1;
			pr1=bar(); fade(brillo,brillo,brillo,2); saliendo_minijuego=0;
			IF (audio==0) stop_sound(ambiente); END
		END
	
		FRAME;
		
	END

END

//**************************************
// VIDAS BIRRAS
//**************************************

PROCESS vida_b1();

BEGIN

	graph=76;
	
	x=20; y=20; 
	
	LOOP
	
		IF (vidas_b==0) BREAK; END
		
		FRAME;
		
	END
	
END

PROCESS vida_b2();

BEGIN

	graph=76;
	
	x=45; y=20; 
	
	LOOP
	
		IF (vidas_b==1) BREAK; END
		
		FRAME;
		
	END
	
END

PROCESS vida_b3();

BEGIN

	graph=76;
	
	x=70; y=20; 
	
	LOOP
	
		IF (vidas_b==2) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// LANZADOR DE BIRRAS
//**************************************

PROCESS beer_launcher();

PRIVATE

	cont;

BEGIN

	ctype=c_scroll;

	graph=73;
	
	x=828;
	
	y=197;
	
	LOOP
	
		IF (fase_j==0) graph=73; END
	
		IF (fase_j==1)
			cont++;
			IF (cont==1) graph=74; END
			IF (cont==4) graph=75; pr5=jarra(); cont=0; fase_j=2; END
		END
		
		FRAME;
		
	END

END

//**************************************
// FLECHA DE CLIENTE (pr6)
//**************************************

PROCESS flecha_cliente(x);

PRIVATE
	
	cont;

BEGIN

	ctype=c_scroll;
	graph=52;
	angle=90000; 
	y=72;
	
	LOOP
	
		cont++;
		IF (cont<5) y+=1; END
		IF (cont>5) y-=1; END
		IF (cont==9) cont=0; END
	
		FRAME;
		
	END
	
END
	
//**************************************
// JARRA DE CERVEZA (pr5)
//**************************************

PROCESS jarra();

PRIVATE

	acel; // aceleración
	cont;
	cont_g; // contador graph
	cont_clon;
	ax; // antigua X
	audio_des; // ID del audio de deslizamiento
	hay_des;
	
BEGIN

	graph=950;	

	ctype=c_scroll;
	scroll.camera=id;
	z=10;
	x=812;
	y=170;
	
	angle=angle_j;
	
	LOOP
		
		IF (fase_j==2) advance(-fuerza_j);
			IF (audio==0 AND hay_des==0) audio_des=sound_play(snd41,fxv+50,256); hay_des=1; END
			IF (fuerza_j>0) acel++; END
			IF (acel==3) fuerza_j-=1; acel=0; END
			
			cont_g++; // contador para cambiar el gráfico
			
			IF (cont_g==4) graph=rand(951,953); cont_g=0; END
			
			IF (fuerza_j>8)
				cont_clon++;
				IF (cont_clon==1) 
					rastro_jarra(24); rastro_jarra(16); rastro_jarra(8);
				END
			ELSE
				cont_clon=0;
			END
			
			IF (x<-50)
				fase_j=4; fuerza_j=0;
				IF (audio==0) sound_play(snd46,fxv+50,180); END
			END
			
			IF (ax==x) fase_j=4; fuerza_j=0; END
			ax=x; 
			
			ELSE graph=950; 
		END
		
		IF (fase_j!=2 AND hay_des==1) hay_des=0; 
			IF (soundchannel_is_playing(audio_des)) stop_sound(audio_des); END
		END
	
		FRAME;
		
	END

END

//**************************************
// RASTRO DE JARRA DE CERVEZA
//**************************************

PROCESS rastro_jarra(x);

PRIVATE

	cont;
	ref; // referencia X

BEGIN

	ctype=c_scroll;
	z=11;
	flags=4;
	y=father.y;
	ref=x;
	
	
	LOOP
	
		graph=father.graph;
		IF (fase_j==2) x=pr5.x+ref; END
		
		IF (fuerza_j<16) 
			IF (cont==0)
				IF (ref==24) cont=5; END
			END
		END
		IF (fuerza_j<12)
			IF (cont==0)
				IF (ref==16) cont=5; END
			END
		END
		IF (fuerza_j<8)
			IF (cont==0)
				IF (ref==8) cont=5; END
			END
		END
		
		IF (fase_j!=2 AND cont==0) cont=5; END
		
		IF (cont>0) cont--; 
			IF (cont==0) BREAK; END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// FLECHA JARRA CERVEZA
//**************************************

PROCESS flecha();

PRIVATE

	cont; cont2; cont3; cont4;
	dir;
	tiro;
	fase;

BEGIN

	ctype=c_scroll;
	
	resolution=10;
	
	graph=52;
	
	x=8070;
	y=1730;
	
	LOOP
	
		IF (keydown(_space)) tiro=1; cont2++; ELSE cont2=0; cont=0; END
		IF (NOT keydown(_space) AND tiro==1) fase=1; END
		IF (cont2==2) cont++; cont2=0; END

		IF (fase==1) fase_j=1; angle_j=angle; signal(pr6,s_kill); BREAK; END
	
		SWITCH (cont)
			CASE 0: graph=52; fuerza_j=5; END
			CASE 1: graph=53; fuerza_j=8; END
			CASE 2: graph=54; fuerza_j=10; END
			CASE 3: graph=55; fuerza_j=11; END
			CASE 4: graph=56; fuerza_j=12; END
			CASE 5: graph=57; fuerza_j=13; END
			CASE 6: graph=58; fuerza_j=14; END
			CASE 7: graph=59; fuerza_j=15; END
			CASE 8: graph=60; fuerza_j=16; END
			CASE 9: graph=61; fuerza_j=17; END
			CASE 10: graph=62; fuerza_j=18; END
			CASE 11: graph=63; fuerza_j=19; END
			CASE 12: graph=64; fuerza_j=20; END
			CASE 13: graph=65; fuerza_j=21; END
			CASE 14: graph=66; fuerza_j=22; END
			CASE 15: graph=67; fuerza_j=23; END
			CASE 16: graph=68; fuerza_j=24; END
			CASE 17: graph=69; fuerza_j=26; END
			CASE 18: graph=70; fuerza_j=27; END
			CASE 19: graph=71; fuerza_j=28; END
			CASE 20: graph=71; fuerza_j=29; cont=0; END
		END
		
		FRAME;
		
	END
	
END

//**************************************
// CLIENTE JARRAS
//**************************************

PROCESS cliente(aspecto,x);

PRIVATE

	dist;
	agarra;
	cont;
	pos; // posición equivalente al cliente escogido
	activado; 

BEGIN

	ctype=c_scroll;
	z=10;
	y=118;
	
	SWITCH (aspecto)
	
		CASE 1:
			graph=24;
			head(42,x);
		END
		
		CASE 2:
			graph=30;
			head(43,x);
		END
		
		CASE 3:
			graph=27;
			head(44,x);
		END
		
		CASE 4:
			graph=33;
			head(45,x);
		END
		
		CASE 5:
			graph=36;
			head(46,x);
		END
		
		CASE 6:
			graph=39;
			head(47,x);
		END
		
	END
	
	LOOP
	
		pos=fget_dist(x,0,topex,0);
	
		IF (fase_j==0)
			cont=0; agarra=0; activado=0;
			IF (aspecto==1) graph=24; END
			IF (aspecto==2) graph=30; END
			IF (aspecto==3) graph=27; END
			IF (aspecto==4) graph=33; END
			IF (aspecto==5) graph=36; END
			IF (aspecto==6) graph=39; END
		END
		
		IF (fase_j!=2) activado=0; END
	
		IF (fase_j==2 AND pos<20) activado=1; END
		
		IF (activado==1)
	
			dist=fget_dist(x,y,pr5.x,pr5.y);
		
			IF (dist<98 AND agarra==0) agarra=1; END 
			
			IF (agarra==1) cont++; END
			
			IF (cont==5)
				IF (aspecto==1) graph=25; END
				IF (aspecto==2) graph=31; END
				IF (aspecto==3) graph=28; END
				IF (aspecto==4) graph=34; END
				IF (aspecto==5) graph=37; END
				IF (aspecto==6) graph=40; END
			END
		
			IF (cont==10)
				IF (aspecto==1) graph=26; END
				IF (aspecto==2) graph=32; END
				IF (aspecto==3) graph=29; END
				IF (aspecto==4) graph=35; END
				IF (aspecto==5) graph=38; END
				IF (aspecto==6) graph=41; END
			END
			
			IF (cont==18)
				cont=0; agarra=2;
			END
			
			IF (agarra==2) cont++;
			
				IF (cont==5)
				
					IF (aspecto==1) graph=26; END
					IF (aspecto==2) graph=32; END
					IF (aspecto==3) graph=29; END
					IF (aspecto==4) graph=35; END
					IF (aspecto==5) graph=38; END
					IF (aspecto==6) graph=41; END
				
				END
				
				IF (cont==10) cont=0; agarra=5;
				
					SWITCH (aspecto)
	
						CASE 1: graph=24; END
		
						CASE 2: graph=30; END
		
						CASE 3: graph=27; END
		
						CASE 4:	graph=33; END
		
						CASE 5:	graph=36; END
			
						CASE 6:	graph=39; END
		
					END
					
				END
				
			END
			
			// RECIBE LA JARRA
			IF (collision(TYPE jarra)) activado=0; fase_j=3; 
				IF (audio==0) sound_play(snd42,fxv+50,256); END
			END
				
		END
	
		FRAME;
		
	END
	
END

//**************************************
// CABEZA CLIENTE JARRAS
//**************************************

PROCESS head(graph,x);

PRIVATE

	giro;
	cont;
	fase;
	dist;

BEGIN

	ctype=c_scroll;
	y=124;
	
	LOOP
	
		IF (rand(0,300)>299 AND fase==0) fase=1; END
		
		IF (fase_j==0)
		
			IF (fase==1) giro=rand(1,2); fase=2; END
			IF (fase==2) cont++; END
			IF (giro==1) angle=90000; END
			IF (giro==2) angle=-90000; END		
		
			IF (cont==48) giro=0; cont=0; fase=0; angle=0; END
			ELSE angle=0;
		END
		
		FRAME;
		
	END
	
END