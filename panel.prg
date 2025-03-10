//**************************************
// PANEL ESCAPE
//**************************************

PROCESS panel();

PRIVATE

	est; 
	cont; cont2;
	cont_e; // contador para el exit
	pos; // posición de la flecha
	sel; // selección menú
	pos_bot; // posición del botón
	tope=1; // tope para el escape
	s1; // solo1
	borrado; // para saber si ya se han borrado textos

BEGIN

	graph=800;
	z=-300;
	x=160; y=520;
	
	soundchannel_pause(all_channel);
	haypanel=1;
	
	LOOP
	
		cyp=y;
	
		IF (est==0) // SUBIMOS EL PANEL
	
			IF (y>120) cont++;

				IF (cont<10) y-=30; END
				IF (cont>10 AND cont<18) y-=20; END
				IF (cont>18 AND cont<24) y-=10; END
				IF (cont>24 AND cont<28) y-=5; END
				IF (cont>28) y-=2; END
			ELSE y=120; est=1; cont=0; graph=801; pr15=flecha_panel();
			END
		
		END
		
		IF (est==1)	cont++; pr15.y=y-25;
			IF (cont==3) cont2++; cont=0;
				IF (cont2<8) y++; END
				IF (cont2>8) y--; END 
			END
			IF (cont2==15) cont=0; cont2=0; END

		END
		
		// SONIDO DE SELECCIÓN (ENTER)
		IF (keydown(_ENTER) AND t_ENTER==0 AND audio==0) sound_play(snd39,fxv,256); END
		
		// MOVEMOS LA FLECHA
		IF (est==1 AND transicion==0)
			IF (keydown(_down) AND s1==0) pos+=1; s1=1; 
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
			IF (keydown(_up) AND s1==0) pos-=1; s1=1;
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
		END
		
		IF (sel==0 OR sel==3 OR sel==4)
			IF (pos>2) pos=0; END
			IF (pos<0) pos=2; END
		END
		
		IF (sel==1 OR sel==2)
			IF (pos>3) pos=0; END
			IF (pos<0) pos=3; END
		END
		
		// POSICIÓN DE LA FLECHA SEGÚN 'POS'
		IF (est==1)
			
			IF (sel==0) // PANEL PRINCIPAL
				SWITCH (pos)
					CASE 0: pr15.x=101; pr15.y=y-25; // SEGUIR
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; sel=100; END
					END
					CASE 1: pr15.x=87; pr15.y=y+5; // OPCIONES
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; sel=1; graph=802; pos=0; END 
					END
					CASE 2: pr15.x=106; pr15.y=y+35; // SALIR
						IF (keydown(_ENTER) AND cont_e==0) fade(0,0,0,2); cont_e=1; transicion=1; END 
					END
				END
			END
			
			IF (sel==1) // PANEL OPCIONES
				SWITCH (pos)
					CASE 0: pr15.x=50; pr15.y=y-25; // GUARDAR/CARGAR
						
					END
					CASE 1: pr15.x=87; pr15.y=y+5; // GRÁFICOS
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; sel=4; pos=0; pr18=boton_vol(); END
					END
					CASE 2: pr15.x=106; pr15.y=y+35; // AUDIO
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; sel=2; pos=0; 
							IF (audio==0 AND music==0) graph=803; END
							IF (audio==0 AND music==1) graph=806; END
							IF (audio==1 AND music==0) graph=804; END
							IF (audio==1 AND music==1) graph=805; END
						END 
					END
					CASE 3: pr15.x=99; pr15.y=y+65; // VOLVER
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; graph=801; sel=0; pos=0; END 
					END
				END
			END
			
			IF (sel==2) // PANEL AUDIO
				SWITCH (pos)
					CASE 0: pr15.x=93; pr15.y=y-25; // EFECTOS
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
							IF (audio==0 AND music==0) graph=804; fxv=0; audio=2; END
							IF (audio==0 AND music==1) graph=805; fxv=0; audio=2; END
							IF (audio==1 AND music==0) graph=803; fxv=70; audio=0; END
							IF (audio==1 AND music==1) graph=806; fxv=70; audio=0; END
							IF (audio==2) audio=1; stop_sound(all_sound); END
						END 
					END
					CASE 1: pr15.x=99; pr15.y=y+5; // MÚSICA
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; 
							IF (music==0 AND audio==0) mem_vol=vol; vol=0; music=2; graph=806; END
							IF (music==0 AND audio==1) mem_vol=vol; vol=0; music=2; graph=805; END
							IF (music==1 AND audio==0) vol=mem_vol; music=0; play=1; songchannel_resume(0); graph=803; END
							IF (music==1 AND audio==1) vol=mem_vol; music=0; play=1; songchannel_resume(0); graph=804; END
							IF (music==2) music=1; songchannel_pause(0); END
						END 
					END
					CASE 2: pr15.x=94; pr15.y=y+35; // VOLUMEN
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; sel=3; pos=0; graph=807; pr16=boton_vol(); pr17=boton_vol(); END
					END
					CASE 3: pr15.x=99; pr15.y=y+65; // VOLVER
						IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; graph=802; sel=1; pos=0; END 
					END
				END
			END
			
			IF (sel==3) // PANEL VOLUMEN
				pr16.y=y-12; pr17.y=y+38;
				SWITCH (pos)
					CASE 0: pr15.x=124; pr15.y=y-34; // VOL FX
						IF (fxv!=0)
							IF (keydown(_left) AND s1==0 AND fxv>10) s1=1; fxv-=10; sound_play(snd10,fxv,256); END
							IF (keydown(_right) AND s1==0 AND fxv<100) s1=1; fxv+=10; sound_play(snd10,fxv,256); END
						END
					END
					CASE 1: pr15.x=99; pr15.y=y+15; // VOL MUSICA
						IF (vol!=0)
							IF (keydown(_left) AND s1==0 AND vol>10) s1=1; vol-=10; END
							IF (keydown(_right) AND s1==0 AND vol<100) s1=1; vol+=10; END
						END
					END
					CASE 2: pr15.x=101; pr15.y=y+66; // VOLVER
						IF (keydown(_ENTER) AND s1==0) 
							s1=1; graph=802; sel=2; pos=0; signal(pr16,s_kill); signal(pr17,s_kill);
							IF (audio==0 AND music==0) graph=803; END
							IF (audio==0 AND music==1) graph=806; END
							IF (audio==1 AND music==0) graph=804; END
							IF (audio==1 AND music==1) graph=805; END
						END 
					END
				END
				
				SWITCH (fxv)
					CASE 100: pr16.x=230; END
					CASE 90: pr16.x=215; END
					CASE 80: pr16.x=200; END
					CASE 70: pr16.x=185; END
					CASE 60: pr16.x=170; END
					CASE 50: pr16.x=155; END
					CASE 40: pr16.x=140; END
					CASE 30: pr16.x=125; END
					CASE 20: pr16.x=110; END
					CASE 10: pr16.x=95; END
					CASE 0: pr16.x=88; END
				END
				
				SWITCH (vol)
					CASE 100: pr17.x=230; END
					CASE 90: pr17.x=215; END
					CASE 80: pr17.x=200; END
					CASE 70: pr17.x=185; END
					CASE 60: pr17.x=170; END
					CASE 50: pr17.x=155; END
					CASE 40: pr17.x=140; END
					CASE 30: pr17.x=125; END
					CASE 20: pr17.x=110; END
					CASE 10: pr17.x=95; END
					CASE 0: pr17.x=88; END
				END	
				
			END
		
		END
		
		IF (sel==4 AND est!=3) // PANEL GRÁFICOS
			pr18.y=y+35;
			
			IF (pantalla==0) graph=808; END
			IF (pantalla==1) graph=809; END
			
			SWITCH (pos)
				CASE 0: // PANTALLA COMPLETA / VENTANA
					IF (pantalla==0) pr15.x=38; pr15.y=y-29; ELSE pr15.x=64; pr15.y=y-29; END
					IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
						IF (pantalla==0) MODE_CHANGE(mode_fullscreen); pantalla=2; graph=809; END
						IF (pantalla==1) MODE_CHANGE(mode_window); pantalla=0; graph=808; END
						IF (pantalla==2) pantalla=1; END
					END
				END
				CASE 1: pr15.x=107; pr15.y=y+10; // BRILLO
					IF (keydown(_left) AND s1==0 AND brillo>75) s1=1; brillo-=5; fade(brillo,brillo,brillo,10); END
					IF (keydown(_right) AND s1==0 AND brillo<125) s1=1; brillo+=5; fade(brillo,brillo,brillo,10); END
				END
				CASE 2: pr15.x=108; pr15.y=y+71; // VOLVER
					IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; signal(pr18,s_kill); graph=802; sel=1; pos=0; END						
				END
			END
			
			SWITCH (brillo)
				CASE 125: pr18.x=235; END
				CASE 120: pr18.x=220; END
				CASE 115: pr18.x=205; END
				CASE 110: pr18.x=190; END
				CASE 105: pr18.x=175; END
				CASE 100: pr18.x=160; END
				CASE 95: pr18.x=145; END
				CASE 90: pr18.x=130; END
				CASE 85: pr18.x=115; END
				CASE 80: pr18.x=100; END
				CASE 75: pr18.x=85; END
			END
			
		END
			
		IF (est==3) // BAJAMOS EL PANEL
			
			IF (y<300) y+=30; END
			IF (y=>300 AND y<360) y+=20; END
			IF (y=>360 AND y<400) y+=10; END
			IF (y=>400) y+=5; END
					
			IF (y>370)
				signal(all_process,s_wakeup_tree);
				signal(id,s_kill_tree); haypanel=0;
			END
			
		END
		
		// SALIMOS DEL MENÚ PARA VOLVER AL JUEGO
		IF (keydown(_ESC) AND tope==0 AND est!=3 OR sel==100 AND est!=3)
			IF (loc!=20)
				tope=1; est=3; cont=0; signal(pr15,s_kill); signal(pr16,s_kill); sel=0; graph=800; 
			END
			IF (loc==20)
				signal(pr3,s_wakeup_tree); signal(pr4,s_wakeup_tree); signal(pr7,s_wakeup_tree);
				signal(pr19,s_wakeup_tree); signal(pr22,s_wakeup_tree);
				tope=1; est=3; graph=800; signal(pr15,s_kill);
			END
			signal(pr16,s_kill); signal(pr17,s_kill); signal(pr18,s_kill);
			IF (audio==0) soundchannel_resume(all_channel); END
		END
		
		IF (tope==1 AND NOT keydown(_ESC)) tope=0; END
		
		// LIBERAMOS TOPES		
		IF (s1==1 AND NOT keydown(_up) AND NOT keydown(_down) AND NOT keydown(_left) AND NOT keydown(_right)) s1=0; END
		
		// SALIMOS DEL MENÚ AL MENÚ PRINCIPAL O A UNA HABITACIÓN
		IF (cont_e>0) cont_e++; 
			IF (cont_e==5) 	fade(0,0,0,2); haypanel=0;
				IF (loc==20) // VOLVEMOS DE UN MINI-JUEGO
					SWITCH (minijuego)
						CASE 1:	signal(pr3,s_wakeup_tree); saliendo_minijuego=1; END
						CASE 2: signal(pr4,s_wakeup_tree); saliendo_minijuego=2; END
						CASE 3: signal(pr7,s_wakeup_tree); saliendo_minijuego=3; END
						CASE 4: signal(pr19,s_wakeup_tree); saliendo_minijuego=4; END
						CASE 5: signal(pr22,s_wakeup_tree); saliendo_minijuego=5; END
					END
					volviendo_minijuego=1;
				END
				IF (audio==0) stop_sound(all_channel); END
			END
			IF (cont_e==35) signal(id,s_kill_tree);
				IF (loc!=20)
					IF (loc==4 OR loc==5) stop_scroll(0); clear_screen(); END
					IF (audio==0) soundchannel_resume(all_channel); END
					signal(pr1,s_kill_tree); signal(pr14,s_kill_tree); signal(pr12,s_kill_tree); 
					menu_ini(); 
				END
			END
		END
		
		IF (keydown(_ENTER)) t_ENTER=1; END
		
		FRAME;
		
	END
	
END

//**************************************
// FLECHA PANEL (pr15)
//**************************************

PROCESS flecha_panel();

BEGIN

	graph=820;
	z=-301;
	x=85;
	
	LOOP
		
		FRAME;
		
	END

END

//**************************************
// BOTÓN PANEL (pr16,pr17,pr18)
//**************************************

PROCESS boton_vol();

BEGIN

	graph=821;
	z=-302;
	
	LOOP
	
		FRAME;
		
	END

END