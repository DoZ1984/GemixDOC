//**************************************
// LAUNCHER TRAGAPERRAS
//**************************************

PROCESS launcher_traga(); 

PRIVATE

		cont;
	
BEGIN

	delete_text(all_text);
	
	LOOP
		
		IF (cont==1) fade(0,0,0,2); END

		cont++;
		
		IF (cont==35) signal(pr1,s_kill_tree); fade(brillo,brillo,brillo,2);
			pr22=main_traga(); 
		END 
	
		FRAME;
		
	END
	
END

//**************************************
// TRAGAPERRAS (MAIN) (pr22)
//**************************************

PROCESS main_traga();

PRIVATE

	cont; cont2; 
	cont_e; // contador para el exit
	cont_a; // contador de avancez
	cont_d; // contador para la fase de doblar
	cont_t; // contador para texto
	cont_l; // contador para el loop de doblar o nada
	mov1; mov2; mov3; // rebote final de los rodillos
	cobro; cobro2; // para activar el estado de cobro
	tcoins; tprize; // textos de los créditos y premios
	mem_ret; // memoriza si antes hubo una retención para que no se repita
	sorteo_av; // variable para el sorteo de avances
	snd_giro; // variable para el FX de los rodillos girando
	snd_giro2; snd_giro3;
	snd_cobro; // ID de sonido de monedas cayendo
	text_help; // texto inicial que recuerda cómo se accede a la tabla y ayuda
	cont_h; // contador ayuda
	tx1; // texto para indicar que se puede saltar el cobro
	loop_doblar; // ID de sonido del loop de doblar o nada
	hayloop;
	tope;
	
BEGIN

	put_screen(fpg1,600);
	graph=602;
	loc=20; // habitación que indica mini-juego
	x=160; y=84;
	delete_text(all_text);
	pr27=mano_traga();
	visor_traga();
	pr23=barra1(); pr24=barra2(); pr25=barra3();
	pr26=num_avances();
	fondo_blanco();
	letras_traga();
	lx0(); lx2();
	advances();
	lretencion();
	boton_jugar();
	boton_der();
	boton_med();
	boton_izq();
	boton_x2();
	
	tcoins=write_int(0,33,17,4,OFFSET coins);
	tprize=write_int(0,80,17,4,OFFSET prize);
	
	transicion=0;
	humo();
	
	est_t=0; est_ret=0; avances=0; prize=0; est_b1=0; est_b2=0; est_b3=0;
	
	LOOP

		IF (cont_h<163)
			cont_h++;
			IF (cont_h==1) text_help=write(0,160,230,4,"PULSA F1 PARA ACCEDER A LA TABLA DE PREMIOS Y AYUDA"); END
			IF (cont_h==24) delete_text(text_help); END
			IF (cont_h==36) text_help=write(0,160,230,4,"PULSA F1 PARA ACCEDER A LA TABLA DE PREMIOS Y AYUDA"); END
			IF (cont_h==60) delete_text(text_help); END
			IF (cont_h==70) text_help=write(0,160,230,4,"PULSA F1 PARA ACCEDER A LA TABLA DE PREMIOS Y AYUDA"); END
			IF (cont_h==94) delete_text(text_help); END
			IF (cont_h==104) text_help=write(0,160,230,4,"PULSA F1 PARA ACCEDER A LA TABLA DE PREMIOS Y AYUDA"); END
			IF (cont_h==128) delete_text(text_help); END
			IF (cont_h==138) text_help=write(0,160,230,4,"PULSA F1 PARA ACCEDER A LA TABLA DE PREMIOS Y AYUDA"); END
			IF (cont_h==162) delete_text(text_help); END
		END
	
		// SE PULSA F1 (PANEL DE AYUDA Y TABLA DE PREMIOS)
		IF (keydown(_f1) AND tope==0 AND transicion==0) tope=1; signal(id,s_freeze_tree); 
			tabla_traga(); transicion=1; 
		END
	
		// INSERTAMOS CRÉDITOS
		//IF (keydown(_f3) AND tope==0) tope=1; coins++; END
	
		// GIRAMOS LOS RODILLOS
		IF (est_t==1) est_ret=0; cont++; 
			IF (cont==1)
				suma_exp(275,190,50,fnt10,0);
				IF (audio==0) 
					snd_giro=sound_play(snd14,fxv+200,170); 
					snd_giro2=sound_play(snd14,fxv+200,170);
					snd_giro3=sound_play(snd14,fxv+200,170);
				END
			END
			IF (cont<40 AND bloq1==0) pr23.graph=rand(619,622);	END
			IF (cont<52 AND bloq2==0) pr24.graph=rand(619,622);	END
			IF (cont<64 AND bloq3==0) pr25.graph=rand(619,622);	END
			
			IF (cont==40 AND bloq1==0) pr23.graph=rand(610,618); mov1=1; 
				IF (audio==0) sound_play(snd15,fxv+100,256); END
			END
			IF (cont==52 AND bloq2==0) pr24.graph=rand(650,658); mov2=1; 
				IF (audio==0) sound_play(snd15,fxv+100,256); END
			END
			IF (cont==64 AND bloq3==0) pr25.graph=rand(610,618); mov3=1; 
				IF (audio==0) sound_play(snd15,fxv+100,256); END
			END
			IF (bloq3==0)
				IF (cont>64) cont=0; est_t=2; bloq1=0; bloq2=0; bloq3=0; est_ret=0; 
					stop_sound(snd_giro); stop_sound(snd_giro2); stop_sound(snd_giro3);
				END
			END
			IF (bloq3==1)
				IF (cont>52) cont=0; est_t=2; bloq1=0; bloq2=0; bloq3=0; est_ret=0; 
					stop_sound(snd_giro); stop_sound(snd_giro2); stop_sound(snd_giro3);
				END
			END
			IF (bloq2==1 AND bloq3==1)
				IF (cont>40) cont=0; est_t=2; bloq1=0; bloq2=0; bloq3=0; est_ret=0; 
					stop_sound(snd_giro); stop_sound(snd_giro2); stop_sound(snd_giro3);
				END
			END
		END
		
		// COMPROBAMOS PREMIOS
		IF (est_t==2)
			// CEREZAS
			IF (val1==5 AND val2==5 AND val3==5) prize=10; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// CIRUELAS
			IF (val1==6 AND val2==6 AND val3==6) prize=10; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// NARANJAS
			IF (val1==8 AND val2==8 AND val3==8) prize=20; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// UVAS
			IF (val1==7 AND val2==7 AND val3==7) prize=20; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// LIMONES
			IF (val1==4 AND val2==4 AND val3==4) prize=30; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// MELONES
			IF (val1==1 AND val2==1 AND val3==1) prize=40; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// CAMPANAS
			IF (val1==2 AND val2==2 AND val3==2) prize=50; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// SIETES
			IF (val1==3 AND val2==3 AND val3==3) prize=70; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// BARES
			IF (val1==9 AND val2==9 AND val3==9) prize=100; est_t=10; 
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
			// SIN PREMIO
			IF (val1!=val2 OR val2!=val3 OR val1!=val3) prize=0; est_t=3; END
		END
		
		// LOS RODILLOS HAN GIRADO YA
		IF (est_t==3) 
			// RANDOM PARA VER SI NOS DA RETENCIONES
			IF (val1==val2 OR val1==val3 OR val2==val3)
				IF (mem_ret==0 AND avances==0)
					IF (rand(1,2)==1) est_ret=1; est_t=20; mem_ret=2; 
						IF (audio==0) sound_play(snd22,fxv,256); END
					END
				END
			END
			IF (mem_ret==1) mem_ret=0; END // SI HUBO RETENCIONES ANTES LIBERAMOS EL TOPE
			// RANDOM PARA VER SI NOS DA AVANCES
			IF (av_act==0 AND est_t!=20)
				IF (rand(1,6)==1) av_act=1; sorteo_av=rand(1,4); est_t=4; 
					IF (audio==0) sound_play(snd17,fxv,256); END
				ELSE est_t=0; 
				END
			ELSE 
				IF (avances>0) est_t=5; 
				ELSE 
					IF (est_t!=20) av_act=0; est_t=0; END 
				END
			END
		END
		
		// FASE DE RETENCIÓN
		IF (est_t==20)
			IF (val1==val2)
				bloq1=1; bloq2=1;
			END
			IF (val1==val3)
				bloq1=1; bloq3=1;
			END
			IF (val2==val3)
				bloq2=1; bloq3=1;
			END
			mem_ret=1; est_t=21;
		END
		
		IF (est_t==21) // LUCES BOTONES EN ESTADO DE RETENCIÓN
			IF (bloq1==1) est_b1=1; ELSE est_b1=0; END
			IF (bloq2==1) est_b2=1; ELSE est_b2=0; END
			IF (bloq3==1) est_b3=1; ELSE est_b3=0; END
		END
		
		// FASE DE AVANCES
		IF (est_t==4) cont_a++;
			SWITCH (sorteo_av)
				CASE 1: 
					IF (cont_a==24) avances=1; cont_a=0; est_t=5; 
						IF (audio==0) sound_play(snd18,fxv,256); END
					END
				END
				CASE 2:
					IF (cont_a==24) avances=1; 
						IF (audio==0) sound_play(snd18,fxv,256); END
					END
					IF (cont_a==48) avances=2; cont_a=0; est_t=5; 
						IF (audio==0) sound_play(snd19,fxv,256); END
					END
				END
				CASE 3:
					IF (cont_a==24) avances=1; 
						IF (audio==0) sound_play(snd18,fxv,256); END
					END
					IF (cont_a==48) avances=2; 
						IF (audio==0) sound_play(snd19,fxv,256); END
					END
					IF (cont_a==72) avances=3; cont_a=0; est_t=5; 
						IF (audio==0) sound_play(snd20,fxv,256); END
					END
				END
				CASE 4:
					IF (cont_a==24) avances=1; 
						IF (audio==0) sound_play(snd18,fxv,256); END
					END
					IF (cont_a==48) avances=2; 
						IF (audio==0) sound_play(snd19,fxv,256); END
					END
					IF (cont_a==72) avances=3; 
						IF (audio==0) sound_play(snd20,fxv,256); END
					END
					IF (cont_a==96) avances=4; cont_a=0; est_t=5; 
						IF (audio==0) sound_play(snd21,fxv,256); END
					END
				END
			END
		
		END
		
		IF (est_t==6) // AVANZAMOS RODILLO IZQUIERDO				
			pr23.graph--; avances--; mov1=1; est_t=2; tope=1; 
			IF (audio==0) sound_play(snd15,fxv,256); END
		END
		
		IF (est_t==7) // AVANZAMOS RODILLO CENTRAL
			pr24.graph++; avances--; mov2=1; est_t=2; tope=1; 
			IF (audio==0) sound_play(snd15,fxv,256); END
		END
			
		IF (est_t==8) // AVANZAMOS RODILLO DERECHO
			pr25.graph--; avances--; mov3=1; est_t=2; tope=1; 
			IF (audio==0) sound_play(snd15,fxv,256); END
		END
		
		// FASE DE DOBLAR O COBRAR
		IF (est_t==11) cont_d++; avances=0;
			IF (audio==0)
				cont_l++;
				IF (cont_l==1) hayloop=1; loop_doblar=sound_play(snd28,fxv,256); END
				IF (cont_l==44) hayloop=0; cont_l=0; END
			END
			IF (cont_d<12) est_bx2=1; est_bjugar=0; END
			IF (cont_d>12) est_bx2=0; est_bjugar=1; END
			IF (cont_d==24) cont_d=0; END
			IF (key(_z)) prize+=100; END
		END
		
		IF (est_t!=11 AND hayloop==1) hayloop=0; stop_sound(loop_doblar); END
		
		// COBRAMOS EL PREMIO
		IF (est_t==30) abajo_traga(); delete_text(all_text); est_t=31; 
			IF (audio==0) snd_cobro=sound_play(snd23,fxv+100,256); END
		END
		IF (est_t==31)
			IF (cobro<prize) cont_t++; END // arrancamos contador de texto
			// SI EL SONIDO TERMINA VOLVEMOS A INICIARLO
			IF (audio==0 AND !soundchannel_is_playing(snd_cobro) AND cobro<prize+5)
				stop_sound(all_sound); snd_cobro=sound_play(snd23,fxv+100,256); 
			END
			cobro2++; // contador de cobro
			IF (cobro2==3) cobro++; cobro2=0; 
				IF (cobro<prize) coins_traga(); END
			END
			IF (cobro==prize AND cobro2==1) suma_euros(160,120,prize,fnt8,0); END
			IF (cobro==prize+5 AND cobro2==1) stop_sound(snd_cobro); END
			IF (cobro==prize+15) 
				est_t=0; avances=0; av_act=0; cobro=0; prize=0; stop_sound(all_sound); delete_text(all_text);
				tcoins=write_int(0,33,17,4,OFFSET coins); tprize=write_int(0,80,17,4,OFFSET prize);
			END
			// TEXTO QUE INDICA QUE PODEMOS SALTAR LA ANIMACIÓN DE COBRO
			IF (cont_t==1)
				tx1=write(0,160,25,4,"PULSA ENTER PARA AVANZAR EL COBRO");
			END
			IF (cont_t==20) delete_text(tx1); END
			IF (cont_t==32) cont_t=0; END
			// PULSAMOS ENTER Y SALTAMOS EL COBRO
			IF (keydown(_ENTER) AND t_ENTER==0 AND cobro<prize) t_ENTER=1; cobro=prize; cobro2=0; 
				IF (cont_t<20) delete_text(tx1); END cont_t=0;
			END
		END
		
		// MOVIMIENTO DE REBOTE AL TERMINAR DE GIRAR EL RODILLO
		IF (mov1==1) cont2++;
			IF (cont2<4) pr23.y+=1; END
			IF (cont2>3 AND cont2<6) pr23.y-=1; END
			IF (cont2>5) pr23.y=100; cont2=0; mov1=0; END
		END
		
		IF (mov2==1) cont2++;
			IF (cont2<4) pr24.y+=1; END
			IF (cont2>3 AND cont2<6) pr24.y-=1; END
			IF (cont2>5) pr24.y=100; cont2=0; mov2=0; END
		END
		
		IF (mov3==1) cont2++;
			IF (cont2<4) pr25.y+=1; END
			IF (cont2>3 AND cont2<6) pr25.y-=1; END
			IF (cont2>5) pr25.y=100; cont2=0; mov3=0; END
		END
		
		// GRÁFICOS DE LOS RODILLOS
		IF (est_t==2)
			IF (pr23.graph>618) pr23.graph=610; END
			IF (pr23.graph<610) pr23.graph=618; END
			IF (pr24.graph>658) pr24.graph=650; END
			IF (pr24.graph<650) pr24.graph=658; END
			IF (pr25.graph>618) pr25.graph=610; END
			IF (pr25.graph<610) pr25.graph=618; END
		END
		
		// LIBERAMOS TOPES
		IF (tope==1 AND NOT keydown(_ENTER) AND NOT keydown(_z) AND NOT keydown(_x) AND NOT keydown(_c) AND NOT keydown(_f3)
			AND NOT keydown(_f1)) tope=0; END
	
		// APRETAMOS ESCAPE Y SALIMOS
		IF (saliendo_minijuego==5) saliendo_minijuego=500; transicion=1; cont_e=1; END
		IF (cont_e>0) cont_e++;
			IF (cont_e==35) clear_screen(); signal(id,s_kill_tree); saliendo_minijuego=0; volviendo_minijuego=1;
				pr1=bar(); fade(brillo,brillo,brillo,2); est_t=0;
			END
		END
	
		FRAME;
		
	END

END

//**************************************
// TABLA TRAGAPERRAS
//**************************************

PROCESS tabla_traga();

PRIVATE

	tope;

BEGIN

	graph=696;
	z=-500;
	x=160; y=120;
	
	IF (audio==0) soundchannel_pause(all_channel); END
	
	LOOP
	
		IF (keydown(_ENTER) AND tope==0) tope=1; graph=697; END
		IF (keydown(_ESC)) 
			tope_ESC=1; transicion=0; signal(pr22,s_wakeup_tree); signal(id,s_kill_tree); 
			IF (audio==0) soundchannel_resume(all_channel); END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// MANO TRAGAPERRAS (pr27)
//**************************************

PROCESS mano_traga();

PRIVATE

	pos;
	cont;
	cont_m; // contador para la moneda cayendo
	tope;
	ins; // insertando monedas

BEGIN
	
	minijuego=5;
	
	graph=681;
	z=-50;
	x=275; y=235;
	
	LOOP
	
		IF (keydown(_left) AND tope==0 AND pos!=10) tope=1; pos--; END
		IF (keydown(_right) AND tope==0 AND pos!=10) tope=1; pos++; END
		IF (keydown(_up) AND tope==0 AND pos!=10) tope=1; pos=10; ins=0; END
		IF (keydown(_down) AND tope==0 AND pos==10) tope=1; pos=5; graph=681; END
		
		SWITCH (pos)
			CASE 1: x=51; y=239; // BOTÓN X2
				IF (keydown(_ENTER) AND tope==0) tope=1;
					// INTENTAMOS DOBLAR EL PREMIO
					IF (est_t==11 AND cont==0)
						graph=682; est_bx2=1; cont=1;
						IF (rand(1,2)==1) prize*=2;
							IF (audio==0) sound_play(snd26,fxv,256); END
						ELSE
							prize=0; est_t=0;
							IF (audio==0) sound_play(snd25,fxv,256); sound_play(snd29,fxv+100,256); END
						END
					END
				END
				IF (cont>0) cont++;
					IF (cont==10) graph=681; est_bx2=0; cont=0; END
				END
			END
			CASE 2: x=115; y=237; // BOTÓN IZQUIERDO
				IF (keydown(_ENTER) AND tope==0) tope=1;
					// AVANZAMOS RODILLO IZQUIERDO
					IF (est_t==5 OR est_t==10)
						IF (avances>0) graph=682; est_b1=1; est_t=6; cont=1; END
					END
					// BLOQUEAMOS RODILLO IZQUIERDO
					IF (est_t==21 AND cont==0)
						IF (bloq1==1) 
							graph=682; est_b1=1; cont=1; bloq1=0; 
						ELSE
							graph=682; est_b1=1; cont=1; bloq1=1;
							IF (bloq2==1 AND bloq3==1)
								bloq2=0; bloq3=0; est_b2=0; est_b3=0;
							END
						END
					END
				END
				IF (cont>0) cont++;
					IF (cont==10) graph=681; est_b1=0; cont=0; 
						IF (est_t==12) est_t=11; END
					END
				END
			END
			CASE 3: x=180; y=235; // BOTÓN CENTRAL
				IF (keydown(_ENTER) AND tope==0) tope=1;
					// AVANZAMOS RODILLO CENTRAL
					IF (est_t==5 OR est_t==10) 
						IF (avances>0) graph=682; est_b2=1; est_t=7; cont=1; END
					END
					// BLOQUEAMOS RODILLO CENTRAL
					IF (est_t==21 AND cont==0)
						IF (bloq2==1) 
							graph=682; est_b2=1; cont=1; bloq2=0; 
						ELSE
							graph=682; est_b2=1; cont=1; bloq2=1;
							IF (bloq1==1 AND bloq3==1)
								bloq1=0; bloq3=0; est_b1=0; est_b3=0;
							END
						END
					END
				END
				IF (cont>0) cont++;
					IF (cont==10) graph=681; est_b2=0; cont=0; END
				END
			END
			CASE 4: x=242; y=237; // BOTÓN DERECHO
				IF (keydown(_ENTER) AND tope==0) tope=1;
					// AVANZAMOS RODILLO DERECHO
					IF (est_t==5 OR est_t==10)
						IF (avances>0)
							graph=682; est_b3=1; est_t=8; cont=1;
						END
					END
					// BLOQUEAMOS RODILLO DERECHO
					IF (est_t==21 AND cont==0)
						IF (bloq3==1) 
							graph=682; est_b3=1; cont=1; bloq3=0; 
						ELSE
							graph=682; est_b3=1; cont=1; bloq3=1;
							IF (bloq2==1 AND bloq1==1)
								bloq2=0; bloq1=0; est_b2=0; est_b1=0;
							END
						END
					END
				END
				IF (cont>0) cont++;
					IF (cont==10) graph=681; est_b3=0; cont=0; END
				END
			END
			CASE 5: x=305; y=239; // BOTÓN JUGAR/COBRAR
				IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
					IF (est_t==0 OR est_t==21) // GIRAMOS RODILLOS EN ESTADO 0
						IF (coins>0)
							graph=682; est_bjugar=1; coins--; est_t=1; cont=1;
						END
					END
					IF (est_t==5 AND coins>0) // TENEMOS AVANCES Y LE DAMOS A GIRAR RODILLOS
						IF (av_act==2) graph=682; est_bjugar=1; coins--; est_t=1; cont=1; av_act=0; avances=0; END
						IF (av_act==1) graph=682; est_bjugar=1; coins--; est_t=1; cont=1; av_act=2; END
					END
					IF (est_t==11) // ESCOGEMOS COBRAR EL PREMIO OBTENIDO DOBLADO O NO
						graph=682; est_bjugar=1; est_t=30; cont=1;
					END
					IF (est_t==10) // AVANZAMOS UNA VEZ OBTENEMOS PREMIO
						graph=682; est_bjugar=1; est_t=11; cont=1; suma_gscore(160,120,prize*100,fnt10,0);
						IF (audio==0) sound_play(snd26,fxv,256); sound_play(snd63,fxv,256); END
					END
					est_b1=0; est_b2=0; est_b3=0;
				END
				IF (cont>0) cont++;
					IF (cont==10) graph=681; est_bjugar=0; cont=0; END
				END
			END
			CASE 10: // INSERTAMOS MONEDAS
				IF (ins==0) 
					IF (euros>0) graph=683; x=320; y=58; ELSE graph=685; x=320; y=58; END
				END
				IF (keydown(_ENTER) AND tope==0 AND euros>0) tope=1; ins=1; END
			END 
		END
		
		// MONEDA CAYENDO
		IF (ins==1) cont_m++; END
		IF (cont_m==3) 
			IF (pos==10) graph=684; x=314; y=62; resta_euros(280,33,1,fnt9,0); END 
			IF (audio==0) sound_play(snd16,fxv,256); END 
		END
		IF (cont_m==6) 
			IF (pos==10) graph=685; y=65; END
		END
		
		IF (cont_m==20) coins++; cont_m=0; ins=0;  
			IF (pos==10) x=320; y=58; END
		END
		
		IF (pos!=10)
			IF (pos>5) pos=1; END
			IF (pos<1) pos=5; END
		END
		
		// LIBERAMOS TOPES		
		IF (tope==1 AND NOT keydown(_left) AND NOT keydown(_right) AND NOT keydown(_up) 
			AND NOT keydown(_down) AND NOT keydown(_ENTER)) 
			tope=0; 
		END
			
		FRAME;
		
	END
	
END

//**************************************
// FONDO BLANCO TRAGAPERRAS
//**************************************

PROCESS fondo_blanco();

BEGIN

	graph=603;
	z=3;	
	x=160; y=100;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// VISOR TRAGAPERRAS
//**************************************

PROCESS visor_traga();

BEGIN

	graph=601;
	
	size=34;
	
	x=160; y=100;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// BARRA 1 TRAGAPERRAS (pr23)
//**************************************

PROCESS barra1();

BEGIN

	graph=rand(610,618);
	
	x=80; y=100;
	
	z=1;
	
	LOOP
	
		IF (graph==610) val1=1; END
		IF (graph==611) val1=2; END
		IF (graph==612) val1=3; END
		IF (graph==613) val1=4; END
		IF (graph==614) val1=5; END
		IF (graph==615) val1=6; END
		IF (graph==616) val1=7; END
		IF (graph==617) val1=8; END
		IF (graph==618) val1=9; END
	
		FRAME;
		
	END
	
END

//**************************************
// BARRA 2 TRAGAPERRAS (pr24)
//**************************************

PROCESS barra2();

BEGIN

	graph=rand(650,658);
	
	x=160; y=100;
	
	z=1;
	
	LOOP
	
		IF (graph==650) val2=1; END
		IF (graph==651) val2=2; END
		IF (graph==652) val2=3; END
		IF (graph==653) val2=4; END
		IF (graph==654) val2=5; END
		IF (graph==655) val2=6; END
		IF (graph==656) val2=7; END
		IF (graph==657) val2=8; END
		IF (graph==658) val2=9; END
	
		FRAME;
		
	END
	
END

//**************************************
// BARRA 3 TRAGAPERRAS (pr25)
//**************************************

PROCESS barra3();

BEGIN

	graph=rand(610,618);
	
	x=240; y=100;
	
	z=1;
	
	LOOP
	
		IF (graph==610) val3=1; END
		IF (graph==611) val3=2; END
		IF (graph==612) val3=3; END
		IF (graph==613) val3=4; END
		IF (graph==614) val3=5; END
		IF (graph==615) val3=6; END
		IF (graph==616) val3=7; END
		IF (graph==617) val3=8; END
		IF (graph==618) val3=9; END
	
		FRAME;
		
	END
	
END

//**************************************
// NUMEROS AVANCES (pr26)
//**************************************

PROCESS num_avances();

BEGIN

	graph=642;
	
	x=160; y=169;
	
	LOOP
	
		IF (keydown(_1)) avances=1; graph=643; END
		IF (keydown(_2)) avances=2; graph=644; END
		IF (keydown(_3)) avances=3; graph=645; END
		IF (keydown(_4)) avances=4; graph=646; END
		IF (keydown(_0)) avances=0; graph=642; END
		
		SWITCH (avances)
			CASE 0: graph=642; END
			CASE 1: graph=643; END
			CASE 2: graph=644; END
			CASE 3: graph=645; END
			CASE 4: graph=646; END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// LETRAS TRAGAPERRAS
//**************************************

PROCESS letras_traga();

PRIVATE

	est;
	cont; cont2;

BEGIN

	graph=630;
	x=200; y=20;
	
	LOOP
	
		IF (est==0) cont++;
			IF (cont==3) graph++; cont=0;
				IF (graph>640) cont=0; est=1; END
			END
		END
		
		IF (est==1) cont++;
			IF (cont==3) graph--; cont=0;
				IF (graph<631) cont=0; est=2; END
			END
		END
		
		IF (est==2) cont++;
			IF (cont==10) graph=641; END
			IF (cont==20) graph=630; END
			IF (cont==30) graph=641; END
			IF (cont==40) graph=630; END
			IF (cont==50) graph=641; END
			IF (cont==60) graph=630; END
			IF (cont==70) graph=641; END
			IF (cont==80) graph=630; cont=0; est=0; END
		END
	
		FRAME;
		
	END
	
END


//**************************************
// X0 TRAGAPERRAS
//**************************************

PROCESS lx0();

PRIVATE

	cont;

BEGIN

	graph=659;
	
	x=25; y=169;
	
	LOOP
	
		IF (est_x==1) graph=660; ELSE graph=659; END
		
		IF (est_t==11) cont++;
			IF (cont==12) est_x=2; END
			IF (cont==24) est_x=1; cont=0; END
			ELSE cont=0; est_x=0; 
		END
		
		FRAME;
		
	END
	
END

//**************************************
// X2 TRAGAPERRAS
//**************************************

PROCESS lx2();

BEGIN

	graph=661;
	
	x=295; y=169;
	
	LOOP
	
		IF (est_x==2) graph=662; ELSE graph=661; END
		
		FRAME;
		
	END
	
END

//**************************************
// LETRAS AVANCES TRAGAPERRAS
//**************************************

PROCESS advances();

PRIVATE

	cont;

BEGIN

	graph=663;
	
	x=80; y=169; 
	
	LOOP
	
		IF (avances>0) cont++;
			IF (cont==1) graph=664; END
			IF (cont==12) graph=663; END
			IF (cont==23) cont=0; END
		ELSE
			cont=0; graph=663;
		END
		
		FRAME;
		
	END
	
END

//**************************************
// LETRAS RETENCIÓN TRAGAPERRAS
//**************************************

PROCESS lretencion();

PRIVATE

	cont;

BEGIN

	graph=665;
	
	x=240; y=169; 
	
	LOOP
	
		IF (est_ret==1) cont++;
			IF (cont==1) graph=666; END
			IF (cont==12) graph=665; END
			IF (cont==23) cont=0; END
		ELSE
			cont=0; graph=665;
		END
		
		FRAME;
		
	END
	
END

//**************************************
// BOTÓN JUGAR/COBRAR TRAGAPERRAS
//**************************************

PROCESS boton_jugar();

PRIVATE

	cont;
	cont2;

BEGIN

	graph=670;
	
	x=290; y=210;
	
	LOOP
	
		IF (est_t==0 OR est_t==5 OR est_t==21) cont++; 
			IF (cont==12) est_bjugar=1; END
			IF (cont==24) est_bjugar=0; cont=0; END
		ELSE IF (cont>0 AND pr27.graph!=682) cont=0; est_bjugar=0; END
		END
	
		IF (est_t==10) cont2++;
			IF (cont2==12) est_bjugar=1; END
			IF (cont2==24) est_bjugar=0; cont2=0; END
		END
			
	
		IF (est_bjugar==1) graph=671; ELSE graph=670; END
	
		FRAME;
		
	END
	
END

//**************************************
// BOTÓN DERECHA TRAGAPERRAS
//**************************************

PROCESS boton_der();

PRIVATE

	cont;
	cont2;

BEGIN

	graph=676;
	
	x=230; y=211;
	
	LOOP
	
		IF (est_t==5 OR est_t==10) cont++;
			IF (avances>0)
				IF (cont==36) est_b3=1; END
				IF (cont==48) est_b3=0; END
				IF (cont==72) cont=0; END
			END
		ELSE
			IF (cont>0 AND pr27.graph!=682) est_b3=0; cont=0; END
		END
		
		IF (est_t==10) cont2++;
			IF (cont2==12) est_b3=1; END
			IF (cont2==24) est_b3=0; cont2=0; END
		END
	
		IF (est_b3==1) graph=677; ELSE graph=676; END
	
		FRAME;
		
	END
	
END

//**************************************
// BOTÓN MEDIO TRAGAPERRAS
//**************************************

PROCESS boton_med();

PRIVATE

	cont;
	cont2;

BEGIN
	
	graph=674;
	
	x=164; y=211;
	
	LOOP
	
		IF (est_t==5 OR est_t==10) cont++;
			IF (avances>0)
				IF (cont==24) est_b2=1; END
				IF (cont==36) est_b2=0; END
				IF (cont==48) est_b2=1; END
				IF (cont==60) est_b2=0; END
				IF (cont==72) cont=0; END
			END
		ELSE
			IF (cont>0 AND pr27.graph!=682) est_b2=0; cont=0; END	
		END
		
		IF (est_t==10) cont2++;
			IF (cont2==12) est_b2=1; END
			IF (cont2==24) est_b2=0; cont2=0; END
		END
	
		IF (est_b2==1) graph=675; ELSE graph=674; END
	
		FRAME;
		
	END
	
END

//**************************************
// BOTÓN IZQUIERDO TRAGAPERRAS
//**************************************

PROCESS boton_izq();

PRIVATE

	cont;
	cont2;

BEGIN
	
	graph=672;
	
	x=96; y=211;
	
	LOOP
	
		IF (est_t==5 OR est_t==10) cont++;
			IF (avances>0)
				IF (cont==12) est_b1=1; END
				IF (cont==24) est_b1=0; END
				IF (cont==60) est_b1=1; END
				IF (cont==72) est_b1=0; cont=0; END
			END
		ELSE
			IF (cont>0 AND pr27.graph!=682) est_b1=0; cont=0; END
		END
		
		IF (est_t==10) cont2++;
			IF (cont2==12) est_b1=1; END
			IF (cont2==24) est_b1=0; cont2=0; END
		END
	
		IF (est_b1==1) graph=673; ELSE graph=672; END
	
		FRAME;
		
	END
	
END

//**************************************
// BOTÓN X2
//**************************************

PROCESS boton_x2();

PRIVATE

	cont;

BEGIN
	
	graph=679;
	
	x=34; y=211;
	
	LOOP
	
		IF (est_t==10) cont++;
			IF (cont==12) est_bx2=1; END
			IF (cont==24) est_bx2=0; cont=0; END
		END
	
		IF (est_bx2==1) graph=680; ELSE graph=679; END
	
		FRAME;
		
	END
	
END

//**************************************
// PARTE DE ABAJO TRAGAPERRAS (pr29)
//**************************************

PROCESS abajo_traga();

BEGIN

	graph=690;
	z=-200;
	x=160; y=120;
	
	carcasa();
	bandeja_cobro();
	
	LOOP
	
		IF (est_t<30 OR est_t>31) signal(id,s_kill_tree); END
	
		FRAME;
		
	END
	
END

//**************************************
// CARCASA PARTE DE ABAJO
//**************************************

PROCESS carcasa();

BEGIN

	graph=691;
	z=-201;
	x=160; y=120;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// BANDEJA DE COBRO
//**************************************

PROCESS bandeja_cobro();

BEGIN

	graph=692;
	z=-202;
	x=160; y=193;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// MONEDAS TRAGAPERRAS
//**************************************

PROCESS coins_traga();

BEGIN

	graph=rand(693,695);	
	flags=rand(0,1);
	size=130;
	z=-200;
	x=rand(50,270);
	y=100;
	
	LOOP
	
		graph++;
		IF (graph>695) graph=693; END
		y+=10;
		IF (y=>280) BREAK; END
		
		FRAME;
		
	END
	
END
