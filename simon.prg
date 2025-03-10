//**************************************
// LAUNCHER SIMON
//**************************************

PROCESS launcher_simon();

PRIVATE

		cont;
	
BEGIN

	delete_text(all_text);
	
	LOOP
		
		IF (cont==1) fade(0,0,0,2); END

		cont++;
		
		IF (cont==35) signal(pr14,s_kill_tree); fade(brillo,brillo,brillo,2);
			pr19=main_simon(); 
		END 
	
		FRAME;
		
	END
	
END

//**************************************
// SIMON PARK (MAIN) - pr19
//**************************************

PROCESS main_simon();

PRIVATE

	fase; // fase actual
	ncoches; // los coches que llevamos en el juego para memorizar
	col_coche; // color (gráfico) del coche
	rec_s; // record
	t1; t2; t3; t4; t5; // textos
	cont;
	cont_e; // contador para salir
	
	t_highscore; t_hs; 
	highscore;
	
	archivoS; // variable de archivo para el highscore
	
BEGIN

	minijuego=4;
	
	est_s=0;
	cochequetoca=1;
	plazaquetoca=1;
	mem_plaza[1]=0; mem_plaza[2]=0; mem_plaza[3]=0; mem_plaza[4]=0; mem_plaza[5]=0; mem_plaza[6]=0;
	mem_plaza[7]=0; mem_plaza[8]=0; mem_plaza[9]=0; mem_plaza[10]=0; mem_plaza[11]=0; mem_plaza[12]=0;
	stop=0;
	vol=mem_vol;
	
	archivoS = fopen("files/saves/hi-scoreS.dat", "r");
	fread(OFFSET highscore, sizeof(highscore), archivoS);
	fclose(archivoS);	
	
	graph=400;
	x=160; y=120; 
	loc=20;
	transicion=0;
	
	LOOP
	
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
		rain(1); rain(1); rain(1); rain(1); rain(1);
	
		IF (est_s==0)
	
			IF (cont<35) cont++; END
		
			IF (cont==35)
				t1=write(fnt1,160,70,4,"SIMON-PARK");
				t2=write(fnt2,160,110,4,"Memoriza el orden de");
				t3=write(fnt2,160,130,4,"los aparcamientos!");
				cont=36;
			END
		
			IF (cont>35) cont++;
				IF (cont==37) t4=write(fnt3,160,210,4,"PULSA ENTER PARA EMPEZAR"); END
				IF (cont==53) delete_text(t4); END
				IF (cont==67) cont=36; END
				IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; cont=0; est_s=1; END
			END
			
		END
		
		// ESTADO 1, INICIAMOS: PONEMOS TEXTOS DE RONDA Y RECORD
		IF (est_s==1)
			delete_text(all_text); ronda_s=1;
			t1=write(fnt2,10,5,0,"RONDA:");
			t2=write(fnt2,87,5,0,OFFSET ronda_s);
			t_highscore=write(fnt2,190,5,0,"RECORD:");
			t_hs=write(fnt2,277,5,0,OFFSET highscore);
			est_s=2;
		END
		
		// INICIO DE RONDA
		IF (est_s==2)			
			IF (ncoches==0) est_s=3;
			ELSE
				est_s=6; // Si no es la inicial pasamos a reproducir los anteriores
			END
		END
		
		IF (est_s==3) // APARECE UN COCHE NUEVO QUE NO HA SALIDO ANTES
			REPEAT
				plaza=rand(1,12);
			UNTIL (mem_plaza[plaza]==0) // Hasta que la plaza escogida no esté libre no avanzamos
			ncoches+=1; col_coche=rand(402,405); car_s(col_coche); // Random para color y llamamos al coche
			mem_coche[ronda_s].plaza=plaza; mem_coche[ronda_s].color=son.graph; // guardamos la plaza y color en la memoria
			mem_plaza[plaza]=1; est_s=4; // Indicamos que esa plaza ya está ocupada poniéndola a 1
		END
		
		IF (est_s==30) est_s=3; END
		
		IF (est_s==5) // EL JUGADOR HA ACERTADO EL COCHE Y PLAZA
			IF (cochequetoca==ncoches)
				cont++;
				IF (cont>30) cont=0; END 
				IF (cont==30) ronda_s+=1; delete_text(tx1); est_s=2; suma_exp(160,130,ronda_s*100,fnt8,0); suma_gscore(160,105,ronda_s*1000,fnt9,0); END
			ELSE 
				est_s=2;
			END
		END
		
		// REPRODUCIMOS EL MOVIMIENTO BIEN REALIZADO DEL JUGADOR A CÁMARA RÁPIDA
		IF (est_s==6)
			SWITCH (cochequetoca)
				CASE 1: col_coche=mem_coche[1].color; plaza=mem_coche[1].plaza; END
				CASE 2: col_coche=mem_coche[2].color; plaza=mem_coche[2].plaza; END
				CASE 3: col_coche=mem_coche[3].color; plaza=mem_coche[3].plaza; END
				CASE 4: col_coche=mem_coche[4].color; plaza=mem_coche[4].plaza; END
				CASE 5: col_coche=mem_coche[5].color; plaza=mem_coche[5].plaza; END
				CASE 6: col_coche=mem_coche[6].color; plaza=mem_coche[6].plaza; END
				CASE 7: col_coche=mem_coche[7].color; plaza=mem_coche[7].plaza; END
				CASE 8: col_coche=mem_coche[8].color; plaza=mem_coche[8].plaza; END
				CASE 9: col_coche=mem_coche[9].color; plaza=mem_coche[9].plaza; END
				CASE 10: col_coche=mem_coche[10].color; plaza=mem_coche[10].plaza; END
				CASE 11: col_coche=mem_coche[11].color; plaza=mem_coche[11].plaza; END
				CASE 12: col_coche=mem_coche[12].color; plaza=mem_coche[12].plaza; END				
			END
			// Avanzamos de coche en la lista de reproducción de aparcamientos
			stop=0; car_s(col_coche); cochequetoca+=1; plazaquetoca+=1; est_s=7; set_fps(30,0);
		END
		
		// EL COCHE HA APARCADO YA
		IF (stop==1)
			IF (cochequetoca>ncoches)
				est_s=3; stop=0; cont=0; cochequetoca=1; plazaquetoca=1;
			ELSE 
				selec_car(); stop=2;
			END
		END
		
		// GAME OVER
		IF (est_s==100)
			t1=write(fnt1,160,105,4,"GAME OVER!");
			est_s=101; cont=0;
		END
		
		IF (est_s==101) cont++; 
			IF (cont==50) fade(0,0,0,2); transicion=1; cont_e=1; est_s=102; 
				volviendo_minijuego=1;
			END
		END
		
		// PULSAMOS ESCAPE Y SALIMOS
		IF (saliendo_minijuego==4) saliendo_minijuego=400; 
			transicion=1; cont_e=1; tope_ESC=1;
		END
		
		IF (cont_e>0) cont_e++; 
			IF (cont_e==35) signal(pr20,s_kill_tree); signal(id,s_kill_tree); saliendo_minijuego=0;
				fade(brillo,brillo,brillo,2); volviendo_minijuego=1; pr14=ext();
			END
			IF (ronda_s>highscore) highscore=ronda_s;
					archivoS = fopen("files/saves/hi-scoreS.dat", "w");
					fwrite(OFFSET highscore, sizeof(highscore), archivoS);
					fclose(archivoS);
			END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// CAR SIMON PARK
//**************************************

PROCESS car_s(graph);

PRIVATE

	est; // estado
	tope_x; // tope para saber cuando tiene que girar para su plaza
	lado; // para indicar hacia donde debe girar
	cont; // contador
	snd_motor; // ID sonido del motor
	snd_motor_off; // ID sonido del motor apagándose

BEGIN

	x=-50; y=115;
	
	SWITCH (plaza) 
		CASE 1: tope_x=5; lado=1; END
		CASE 2: tope_x=5; END
		CASE 3: tope_x=40; lado=1; END
		CASE 4: tope_x=40; END
		CASE 5: tope_x=76; lado=1; END
		CASE 6: tope_x=76; END
		CASE 7: tope_x=112; lado=1; END
		CASE 8: tope_x=112; END
		CASE 9: tope_x=148; lado=1; END
		CASE 10: tope_x=148; END
		CASE 11: tope_x=184; lado=1; END
		CASE 12: tope_x=184; END
	END
	
	LOOP
		
		// SECUENCIA DE APARCAMIENTO
		IF (est==0)
			IF (audio==0 AND !soundchannel_is_playing(snd_motor)) snd_motor=sound_play(snd55,fxv+35,256); END
			IF (x<tope_x) x+=5; ELSE tope_x=tope_x+20; est=2; END // EMPEZAMOS A VELOCIDAD 4			
		END
		IF (est==2)
			IF (x<tope_x) x+=4; ELSE tope_x=tope_x+20; est=3; END // REDUCIMOS
		END
		IF (est==3)	
			IF (x<tope_x) x+=3; ELSE est=4; END // Y EMPEZAMOS EL GIRO
		END
		
		// INICIAMOS GIRO
		IF (est==4) 
			// SI ES UNA PLAZA DE LAS DE ABAJO..
			IF (lado==0)
				IF (angle>-90000) angle-=6000; 
					IF (angle>-60000) x+=2; y+=1; ELSE x+=1; y+=3; END
					IF (audio==0 AND snd_motor_off==0) snd_motor_off=sound_play(snd56,fxv+35,256); END
				ELSE 
					angle=-90000; cont++;
					IF (audio==0) 
						stop_sound(snd_motor);
					END
					IF (cont<16) y+=2; ELSE est=5; cont=0; END
				END
			END
				
			// SI ES UNA PLAZA DE LAS DE ARRIBA..
			IF (lado==1)
				IF (angle<90000) angle+=6000; 
					IF (angle<60000) x+=2; y-=1; ELSE x+=1; y-=3; END
					IF (snd_motor_off==0 AND audio==0) 
						snd_motor_off=sound_play(snd56,fxv+35,256); 
					END
				ELSE 
					angle=90000; cont++;
					IF (audio==0) 
						stop_sound(snd_motor);
					END
					IF (cont<16) y-=2;  ELSE est=5; cont=0; END
				END
			END
		
		END
		
		IF (cochequetoca==1 AND stop==2) BREAK; END 
		
		// ESPERAMOS UN POCO
		IF (est==5) 
			IF (cont<40) cont++; END
			IF (cont==40) stop=1; est=6; END
			IF (est_s==7) set_fps(24,0); END
		END
		
		FRAME;
		
	END
	
END

//**************************************
// SELECCIÓN DE COCHE
//**************************************

PROCESS selec_car();

PRIVATE

	sel_color;
	pos=1;
	s1;
	t1; t2;
	
BEGIN

	graph=406;
	
	x=160; y=120;
	
	marco_sel();
	
	t1=write(fnt3,160,92,4,"SELECCIONA EL COCHE");
	
	LOOP
	
		IF (transicion==0)
			IF (keydown(_left) AND s1==0) pos--; s1=1;
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
			IF (keydown(_right) AND s1==0) pos++; s1=1;
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
		END
		
		IF (pos>4) pos=1; END
		IF (pos<1) pos=4; END
		
		SWITCH (pos)
			CASE 1: son.x=131; sel_color=402; END
			CASE 2: son.x=150; sel_color=403; END
			CASE 3: son.x=170; sel_color=404; END
			CASE 4: son.x=189; sel_color=405; END
		END
		
		IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1; signal(id,s_kill_tree); delete_text(t1); 
			IF (audio==0) sound_play(snd39,fxv,256); END
			IF (sel_color!=mem_coche[cochequetoca].color) 
				t1=write(fnt2,160,134,4,"NO! NO ERA ESE COCHE!"); est_s=100; 
				IF (audio==0) sound_play(snd61,fxv+50,280); END
			END
			IF (sel_color==mem_coche[cochequetoca].color)
				IF (audio==0) sound_play(snd57,fxv,300); END
				tx1=write(fnt3,160,104,4,"Si! Era ese. Ahora selecciona"); 
				tx2=write(fnt3,160,120,4,"la plaza correspondiente");
				pr20=selec_plaza(); BREAK; 
			END
		END
		
		IF (s1==1 AND NOT keydown(_left) AND NOT keydown(_right)) s1=0; END
	
		FRAME;

	END
	
END

//**************************************
// SELECCIÓN DE PLAZA
//**************************************

PROCESS selec_plaza();

PRIVATE

	est; // estado de la selección
	pos=1;
	sel_pl; // selección de plaza por el jugador
	s1;
	t1;

BEGIN

	marco_plaza();

	LOOP
	
		IF (est==0)
		
			SWITCH (pos)
				CASE 1: son.x=70; son.y=56; END
				CASE 2: son.x=70; son.y=174; END
				CASE 3: son.x=106; son.y=56; END
				CASE 4: son.x=106; son.y=174; END
				CASE 5: son.x=142; son.y=56; END
				CASE 6: son.x=142; son.y=174; END
				CASE 7: son.x=178; son.y=56; END
				CASE 8: son.x=178; son.y=174; END
				CASE 9: son.x=214; son.y=56; END
				CASE 10: son.x=214; son.y=174; END
				CASE 11: son.x=250; son.y=56; END
				CASE 12: son.x=250; son.y=174; END
			END
		
			sel_pl=pos;
		
			IF (keydown(_right) AND s1==0 AND son.x<250) s1=1; pos+=2; 
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
			IF (keydown(_left) AND s1==0 AND son.x>70) s1=1; pos-=2; 
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
			IF (keydown(_down) AND s1==0 AND son.y<174) s1=1; pos+=1; 
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
			IF (keydown(_up) AND s1==0AND son.y>56) s1=1; pos-=1; 
				IF (audio==0) sound_play(snd37,fxv,256); END
			END
		
			IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
				IF (audio==0) sound_play(snd39,fxv,256); END
				signal(son,s_kill); est=1;
				
				IF (sel_pl==mem_coche[plazaquetoca].plaza) // ACERTAMOS LA PLAZA
					delete_text(tx1); delete_text(tx2);
					t1=rand(1,4); est_s=5;
					IF (cochequetoca==ronda_s)
						IF (audio==0) sound_play(snd58,fxv+50,256); END
						SWITCH (t1)
							CASE 1: tx1=write(fnt2,160,114,4,"EXACTO!!"); END
							CASE 2: tx1=write(fnt2,160,114,4,"ESO ES!!"); END
							CASE 3: tx1=write(fnt2,160,114,4,"ASI SE HACE!"); END
							CASE 4: tx1=write(fnt2,160,114,4,"LO HAS CLAVADO!"); END
						END
					END
				END				
				
				IF (sel_pl!=mem_coche[plazaquetoca].plaza) // ERRAMOS LA PLAZA
					delete_text(tx1); delete_text(tx2);
					t1=rand(1,4); est_s=100;
					IF (audio==0) sound_play(snd61,fxv+50,280); END
					SWITCH (t1)
						CASE 1: tx1=write(fnt2,160,134,4,"NO, NO ERA AHÍ!"); END
						CASE 2: tx1=write(fnt2,160,134,4,"MAL, MUY MAL!"); END
						CASE 3: tx1=write(fnt2,160,134,4,"PUES VA A SER QUE NO!"); END
						CASE 4: tx1=write(fnt2,160,134,4,"ERROR! ESA NO ERA!"); END
					END
				END	
				BREAK;
			END
		
		END
		
		// LIBERAMOS TOPES
		IF (s1==1 AND NOT keydown(_up) AND NOT keydown(_down) AND NOT keydown(_left) AND NOT keydown(_right)) s1=0; END
		
		FRAME;
		
	END
	
END

//**************************************
// MARCO DE SELECCION DE MINICOCHE
//**************************************

PROCESS marco_sel();

BEGIN

	graph=401;
	
	x=80; y=120;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// MARCO DE SELECCION DE PLAZA
//**************************************

PROCESS marco_plaza();

PRIVATE

BEGIN

	graph=407; 
	flags=4;
	x=30; y=60;
	
	LOOP
	
		FRAME;
		
	END
	
END