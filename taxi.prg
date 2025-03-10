//**************************************
// VIAJANDO EN TAXI
//**************************************

PROCESS viaje_taxi();

PRIVATE

	est;
	cont;
	cont_f; // contador para llamar a las farolas del scroll
	fondo;
	volumen=100;

BEGIN

	file=fpg3;
	fade(brillo,brillo,brillo,2);
	scroll_start(0,fpg3,100,101,0,5);
	
	loc=1000;
	
	graph=1;	
	x=630; y=155;
	
	IF (music==0) fondo=sound_play(snd69,volumen,256); END
	IF (audio==0) sound_play(snd74,fxv,256); END
	
	LOOP
	
		scroll.x0-=15; 
		scroll.x1-=2;
		cont++;
		cont_f++;
		
		IF (cont_f==1) farola_scroll(); END
		IF (cont_f==30) cont_f=0; END
		
		IF (cont==8) graph++; cont=0; END
		IF (graph>3) graph=1; END
		IF (graph==1) y=154; ELSE y=155; END
	
		IF (est==0)	x-=4;
			IF (x=<165) x=165; est=1; END
		END
		
		IF (est>0 AND est!=100) est++;
			IF (est==28) est=100; END
		END
		
		IF (est==100) x-=4; END
		
		IF (x<10)
			volumen-=1;
			soundchannel_set_volume(fondo,volumen);
		END
		
		IF (x=<-270) fade(0,0,0,2); END
		IF (x=<-485) 
			IF (destino==1) destino=0; 
				signal(id,s_kill_tree); stop_scroll(0); stop_sound(all_sound); pr32=barricada(); 
			END
			IF (destino==2) destino=0; 
				signal(id,s_kill_tree); stop_scroll(0); stop_sound(all_sound); pr1=bar(); 
			END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// FAROLA SCROLL
//**************************************

PROCESS farola_scroll();

BEGIN

	file=fpg3;
	graph=4;
	size=130;
	x=-150; y=145;
	
	LOOP
	
		x+=24;
		
		IF (x>470) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// LLAMANDO AL TAXI 
//**************************************

PROCESS llama_taxi();

PRIVATE
	
	snd_motor; // sonido del motor
	tope_snd; // tope para reproducir sonidos

BEGIN

	graph=417;
	ctype=c_scroll;
	x=85; y=667;
	z=-200;
	luz_coche(0);
	cont_taxi=0;
	
	IF (audio==0) snd_motor=sound_play(snd73,fxv,256); END
	
	LOOP
		
		// ES LLAMADO DESDE EL PARKING
		IF (loc==4)
			IF (est_taxi==1) // APARECE Y LA CÁMARA SE CENTRA EN ÉL
				scroll.camera=id;
				y-=10; 
				IF (cont_taxi==40) cont_taxi=0; est_taxi=2; 
					IF (audio==0) stop_sound(snd_motor); sound_play(snd72,fxv,256); END
				END
			END
			IF (est_taxi==2) // LLEGA AL PUNTO INDICADO PARA HACER SU TROMPO TRIUNFAL xD
				y-=3; x+=1; angle-=11750;
				IF (cont_taxi==30) cont_taxi=0; est_taxi=3; angle=0; END
			END
			IF (est_taxi==4) // SE ABRE LA PUERTA
				graph=418;
				IF (cont_taxi==10) cont_taxi=0; est_taxi=5; END
			END
			IF (est_taxi==5) // EL PROTA SUBE AL TAXI
				graph=419;
				IF (cont_taxi==10) cont_taxi=0; est_taxi=6; END
			END
			IF (est_taxi==6) // SE CIERRA LA PUERTA
				graph=420;
				IF (cont_taxi==12) cont_taxi=0; est_taxi=7; graph=417; 
					IF (audio==0) sound_play(snd71,fxv,256); END
				END
			END
			IF (est_taxi==7)
				IF (cont_taxi==10) signal(pr14,s_freeze_tree); est_c=85; vent_conv(); END
			END
		
			IF (est_taxi==50) // EL CLIENTE SE BAJA Y EL TAXI SE VA
				IF (loc==4) // Parking BAR
					IF (cont_taxi>6) cont_taxi=0; END
					IF (audio==0 AND cont_taxi==1) sound_play(snd70,fxv,256); END
					graph=420;
					IF (cont_taxi==6) graph=418;
						cont_taxi=0; est_taxi=51; pr11.visible=1; scroll.camera=pr11; pr11.x+=25; pr11.angle=90000;
					END
				END
			END
			IF (est_taxi==51) 
				IF (cont_taxi==10) graph=417; transicion=0; est_taxi=52; 
					IF (audio==0) sound_play(snd71,fxv,256); END
					IF (audio==0) sound_play(snd73,fxv,256); sound_play(snd72,fxv,390); END
				END
			END
			IF (est_taxi==52) // EL TAXI SALE DE PANTALLA (SIN CLIENTE)
				y-=4; angle+=2500;
				IF (y<120) est_taxi=53; END
			END
			IF (est_taxi==53)
				y-=10; x-=2; angle-=1250;
				IF (y<-200) cont_taxi=0; est_taxi=0; signal(id,s_kill_tree); BREAK; END
			END
			IF (est_taxi==55) // EL TAXI SALE DE PANTALLA(CON CLIENTE)
				IF (audio==0 AND tope_snd==0) tope_snd=1;
					sound_play(snd73,fxv,256); sound_play(snd72,fxv,390); 
				END
				y-=4; angle+=2500;
				IF (y<120) est_taxi=56; END
			END
			IF (est_taxi==56)
				y-=10; x-=2; angle-=1250;
				IF (y<-200) 
					cont_taxi=0; est_taxi=57;
					fade(0,0,0,2); stop_song(); 
				END
			END
		END
	
		FRAME;
		
	END
	
END