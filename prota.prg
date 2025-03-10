//**************************************
// PROTAGONISTA (pr11)
//**************************************

PROCESS prota();

PRIVATE

	dir; dir2; // direcciones del prota
	cont; cont2;
	cont_tr; // contador de transición
	t; // tope
	x2; y2; // coordenadas antiguas para usar al colisionar
	touch; // colisionando con otros procesos
	distm; // distancia de la música fuera del bar
	dist_arc; // distancia Arcade
	dist_gra; // distancia Gramola
	zona_r; // zona ruleta rusa (detección)
	zona_cliente1; // zona de cliente ricachón (detección)
	zona_arcade; // zona arcade (detección)
	zona_gramola; // zona gramola (detección)
	zona_traga; // zona tragaperras (detección)
	zona_jarras; // zona lanzamiento jarras (detección)
	a_text; a_text2; a_text4; // animación del texto
	cont_t; cont_t2; cont_t3; cont_t4; cont_t5; // contadores de texto
	t1; t2; t3; t4; // textos
	tope_text; tope_text2; tope_text3; tope_text4; tope_text5; // topes de textos
	g_text; // texto gramola
	t_text; // texto TAXI
	hayboca; // para saber si hay bocadillo
	snd_pasos;
	s1=1; // solo1
	
BEGIN

	IF (loc!=5) file=fpg1; graph=1; ELSE file=fpg2; graph=100; END
	
	angle=90000;
	
	z=-1;
	
	vol=mem_vol; // recordamos el volumen de la música que teníamos asignado
	
	// VOLVIENDO AL BAR (O ENTRANDO)
	IF (loc==1) 
		IF (bajando==0)
			x=-10; y=120; transicion=2;
		ELSE
			x=295; y=15; angle=-90000; size=130; transicion=0; bajando=0;
		END
		// VOLVIENDO DE UN MINI JUEGO
		IF (volviendo_minijuego==1) 
			x=x_pr; y=y_pr; angle=angle_pr; volviendo_minijuego=0; transicion=0;
		END 
	END
	// SUBIENDO O BAJANDO DEL PISO DE ARRIBA
	IF (loc==2) x=295; y=15; angle=-90000; transicion=0; END
	// SALIENDO AL PARKING
	IF (loc==4) ctype=c_scroll; scroll.camera=id; x=830; y=310; angle=-90000; transicion=0; END
	// LLEGANDO A LA BARRICADA
	IF (loc==5) ctype=c_scroll; scroll.camera=id; x=268; y=395; angle=180000; transicion=2; END
	
	/* write_int(0,5,5,0,OFFSET x);
	write_int(0,5,15,0,OFFSET y); */
	
	LOOP
		
		// LLEGANDO A LOS SITIOS
		IF (transicion==2)
			IF (loc==1) // Bar
				angle=90000;
				IF (x<35) x+=3; cont++; ELSE transicion=0; END
			END
			IF (loc==5) // Barricada
				angle=180000;
				IF (y>335) y-=3; cont++; ELSE transicion=0; END
			END
		END
		
		IF (muerto==0)
			// MOVIMIENTO DEL PROTA
			IF (touch==0 AND transicion==0)
				IF (keydown(_up)) y-=4; angle=180000; cont++; 
					dir=1; dir2=dir;
				END
				IF (keydown(_down)) y+=4; angle=0; cont++; 
					dir=2; dir2=dir;
				END
				IF (keydown(_left)) x-=4; angle=-90000; cont++; IF (keydown(_up)) cont--; angle=215000; END IF (keydown(_down)) cont--; angle=-35000; END 
					dir=3; dir2=dir;
				END
				IF (keydown(_right)) x+=4; angle=90000; cont++; IF (keydown(_up)) cont--; angle=-215000; END IF (keydown(_down)) cont--; angle=35000; END 
					dir=4; dir2=dir;
				END
			END

			// ANIMACIÓN
			IF (cont=>3) cont=0; graph++; END
			IF (loc<4)
				file=fpg1;
				IF (graph>8) graph=1; END
			ELSE
				file=fpg2;
				IF (graph<100) graph=100; END
				IF (graph>107) graph=100; END
			END
			
			// SONIDO DE LOS PASOS
			IF (audio==0)
				IF (transicion==0 OR transicion==2)
					IF (graph==3 OR graph==7 OR graph==103 OR graph==107)
						snd_pasos=rand(1,4);
						IF (loc==1 OR loc==2)
							SWITCH (snd_pasos)
								CASE 1:	sound_play(snd47,fxv+30,300); END
								CASE 2:	sound_play(snd48,fxv+30,300); END
								CASE 3:	sound_play(snd49,fxv+30,300); END
								CASE 4:	sound_play(snd50,fxv+30,300); END
							END
						END
						IF (loc==4)
							SWITCH (snd_pasos)
								CASE 1: sound_play(snd51,fxv,256); END
								CASE 2: sound_play(snd52,fxv,256); END
								CASE 3: sound_play(snd53,fxv,256); END
								CASE 4: sound_play(snd54,fxv,256); END
							END
						END
					END
				END
			END

			// LEVANTAMOS EL TOPE SI NO SE PULSAN LAS TECLAS
			IF (NOT keydown(_up) AND NOT keydown(_down) AND NOT keydown(_left) AND NOT keydown(_right) AND transicion==0) 
				IF (loc<4) file=fpg1; graph=1; ELSE file=fpg2; graph=100; END cont=0; 
			END
			
			// COLISIONES 1ª PLANTA
			IF (loc==1 AND transicion!=2)
				IF (collision(TYPE taburete) OR collision(TYPE barra) OR collision (TYPE arcade) 
					OR collision (TYPE mesa) OR collision (TYPE silla) OR collision (TYPE gramola) 
					OR collision(TYPE tragaperras))
				IF (dir==dir2) 
					touch=1;
				END
				ELSE 
					touch=0;
				END
				IF (collision(TYPE escaleras) AND y>19 AND dir==dir2) touch=1; END
			END
			
			// COLISIONES PARKING
			IF (loc==4)
				IF (collision (TYPE big_car) OR collision(TYPE guardia) OR collision(TYPE palo_cartel)
					OR collision (TYPE llama_taxi) OR collision(TYPE indy)
					AND dir==dir2) 
					touch=1;
					ELSE touch=0; 
				END
			END
			
			// COLISIONES BARRICADA
			IF (loc==5)
				IF (collision (TYPE tank) OR collision(TYPE soldat_col)
					AND dir==dir2) 
					touch=1;
					ELSE touch=0;
				END
			END

			IF (touch==1) x=x2; y=y2; touch=0; END
			x2=x; y2=y;
		
		END
		
		// ATROPELLO POR EL COCHE
		IF (atropellado==1) muerto=1; graph=108; atropellado=2; IF (audio==0) sound_play(snd11,100,256); END END
		
		//********************************
		IF (loc==1) // BAR, PRIMERA PLANTA
		//********************************
		
			dist_arc=fget_dist(x,y,30,10);
			dist_gra=fget_dist(x,y,82,10);	
	
			// DETECTAMOS LA DISTANCIA DE LA MÁQUINA RECREATIVA
			IF (dist_arc<35) a_text=1; cont_t++; END 
			IF (dist_arc=>35) a_text=0; cont_t=0; END 
		
			// DETECTAMOS LA DISTANCIA DE LA GRAMOLA
			IF (dist_gra<25) g_text=1; cont_t4++; END
			IF (dist_gra=>25) g_text=0; cont_t4=0; END
		
			// DETECTAMOS LA ZONA APROPIADA PARA EL LANZAMIENTO DE JARRAS
			IF (x>225 AND x<280 AND y>210 AND y<222) a_text2=1; 
			ELSE a_text2=0; 
			END
		
			// DETECTAMOS LA ZONA PARA LA RULETA RUSA
			IF (x>213 AND x<304 AND y>44 AND y<136) zona_r=1; 
			ELSE 
				IF (zona_r==1) signal(pr28,s_kill); hayboca=0; zona_r=0; END
			END
			
			// DETECTAMOS LA ZONA PARA LA TRAGAPERRAS
			IF (x>112 AND x<156 AND y<40) a_text4=1;
			ELSE a_text4=0;
			END
		
			IF (a_text==1 AND transicion==0) // TEXTO DE RECREATIVA PARA JUGAR
				IF (cont_t==1) 
					tope_text=1; t1=write(0,5,4,0,"PULSA ENTER"); t2=write(0,8,16,0,"PARA JUGAR");
				END
				IF (cont_t==20)
					delete_text(t1); delete_text(t2); tope_text=0; 
				END
				IF (cont_t==35) cont_t=0; END
				
				// SI PULSAMOS ENTER LANZAMOS EL SPACE INVADERS
				IF (keydown(_ENTER) AND t_ENTER==0) 
					x_pr=x; y_pr=y; angle_pr=angle;
					t_ENTER=1; space_invaders(); transicion=1; a_text=0;					
				END
			END
		
			IF (g_text==1 AND transicion==0) // TEXTO DE GRAMOLA
				IF (cont_t4==1)
					tope_text4=1;
					t3=write(0,35,5,0,"PULSA ENTER PARA");
					t4=write(0,38,17,0,"USAR LA GRAMOLA");
				END
				IF (cont_t4==20) delete_text(t1); delete_text(t2); tope_text4=0; END
				IF (cont_t4==35) cont_t4=0; END
				
				// SI PULSAMOS ENTER ENTRAMOS A LA PANTALLA DE LA GRAMOLA
				IF (keydown(_ENTER) AND t_ENTER==0) 
					x_pr=x; y_pr=y; angle_pr=angle;
					t_ENTER=1; launcher_gramola(); transicion=1; g_text=0; 
				END
			END
			
			IF (a_text2==1 AND transicion==0) // TEXTO DE MINI-JUEGO DE JARRAS
				cont_t2++;
				IF (cont_t2==1) 
					tope_text2=1; tope_text2=1; t1=write(0,200,170,0,"PULSA ENTER PARA"); t2=write(0,183,185,0,"LANZAMIENTO DE JARRAS");
				END
				IF (cont_t2==20)
					tope_text2=0; delete_text(t1); delete_text(t2); tope_text2=0; 
				END
				IF (cont_t2==35) cont_t2=0; END
			
				// SI PULSAMOS ENTER LANZAMOS EL MINI-JUEGO DE LAS JARRAS
				IF (keydown(_ENTER) AND t_ENTER==0)
					x_pr=x; y_pr=y; angle_pr=angle;
					t_ENTER=1; jarras(); transicion=1; 
				END
			END

			IF (zona_r==1) // BOCADILLO DE EXCLAMACIÓN DE RULETA RUSA
				IF (hayboca==0) hayboca=1; pr28=bocadillo(); END			
				// SI PULSAMOS ENTER LANZAMOS LA CONVERSACIÓN CON EL TIPO DE LA RULETA
				IF (keydown(_ENTER) AND t_ENTER==0)
					x_pr=x; y_pr=y; angle_pr=angle;
					t_ENTER=1; signal(pr1,s_freeze_tree); signal(pr28,s_kill);
					stop_sound(all_sound); est_c=39; vent_conv(); 
				END				
			END
			
			IF (a_text4==1) // TEXTO DE LA TRAGAPERRAS
				cont_t5++;
				IF (cont_t5==1)
					tope_text5=1; t1=write(0,130,13,4,"PULSA ENTER PARA"); t2=write(0,130,25,4,"JUGAR A LA TRAGAPERRAS");
				END
				IF (cont_t5==20)
					tope_text5=0; delete_text(t1); delete_text(t2); tope_text5=0;
				END
				IF (cont_t5==35) cont_t5=0; END
			
				// SI PULSAMOS ENTER LANZAMOS EL MINI-JUEGO DE LA TRAGAPERRAS
				IF (keydown(_ENTER) AND t_ENTER==0)
					x_pr=x; y_pr=y; angle_pr=angle;
					t_ENTER=1; launcher_traga(); transicion=1; 
				END
			END
		
			IF (a_text==0) // BORRAMOS TEXTO DE ARCADE
				cont_t=0;
				IF (tope_text==1) tope_text=0; delete_text(t1); delete_text(t2); END
			END
		
			IF (a_text2==0) // BORRAMOS TEXTO DE JARRAS
				cont_t2=0;
				IF (tope_text2==1) tope_text2=0; delete_text(t1); delete_text(t2); END
			END
		
			IF (a_text4==0) // BORRAMOS TEXTO DE LA TRAGAPERRAS
				cont_t5=0;
				IF (tope_text5==1) tope_text5=0; delete_text(t1); delete_text(t2); END
			END
		
			IF (g_text==0) // BORRAMOS TEXTO DE GRAMOLA
				cont_t4=0;
				IF (tope_text4==1) tope_text4=0; delete_text(t3); delete_text(t4); END
			END

			// ESCALA DEL GRÁFICO SEGÚN SUBE ESCALERAS
			IF (y<20)
				IF (x<245) size=100; END
				IF (x>245 AND x<261) size=110; END
				IF (x>261 AND x<281) size=120; END
				IF (x>281 AND x<301) size=130; END
				
				// SUBIMOS AL SEGUNDO PISO
				IF (x>300 AND cont2==0)
					cont2=1; fade(0,0,0,4); transicion=1;
				END
				IF (cont2>0) cont2++;
					IF (cont2==36) signal(pr1,s_kill_tree); pr12=seg_piso(); END
				END
			END
			
			// MODIFICAMOS LA LUZ SEGÚN CRUZAMOS LA PUERTA
			IF (y>115 AND y<128)
				IF (x<=12 AND x>8) pr13.graph=121; pr13.x=4; pr13.y=120; END
				IF (x<=4 AND x>0) pr13.graph=122; pr13.x=19; pr13.y=129; END
				IF (x<=0) pr13.graph=123; pr13.x=30; pr13.y=120; END
			END
			
			// SALIMOS AL PARKING
			IF (x<0 AND cont2==0 AND transicion==0)
				IF (audio==0) sound_play(snd40,fxv,256); END
				cont2=1; fade(0,0,0,4); transicion=1; IF (music==0) mem_vol=vol; 
				END
			END
			
			IF (cont2>0) cont2++;
				IF (cont2==18) signal(pr1,s_kill_tree); transicion=0; pr14=ext(); END
			END
			
			// CONVERSACIÓN CLIENTE DE BARRA (DESCAPOTABLE)
			IF (x>87 AND x<124 AND y>147 AND y<169) zona_cliente1=1;
				IF (hayboca==0) hayboca=1; pr28=bocadillo(); END
				IF (keydown(_ENTER) AND t_ENTER==0)
					t_ENTER=1; signal(pr1,s_freeze_tree); signal(pr28,s_kill);
					stop_sound(all_sound); est_c=18; vent_conv();
				END
			ELSE IF (zona_cliente1==1) signal(pr28,s_kill); zona_cliente1=0; hayboca=0; END
			END
			
			IF (transicion==0)
				IF (x<12 AND y<115) x=12; END
				IF (x<12 AND y>128) x=12; END
				IF (x>308) x=308; END
				IF (y>228) y=228; END
				IF (y<12) y=12; END
			END
		
		END
		
		//******************************
		IF (loc==2) // BAR, SEGUNDO PISO
		//******************************
		
			// BAJAMOS AL PRIMER PISO
			IF (y<25 AND x>300 AND cont2==0)	
				cont2=1; fade(0,0,0,4); transicion=1; bajando=1;
			END
			IF (cont2>0) cont2++;
				IF (cont2==18) signal(pr12,s_kill_tree); pr1=bar(); END
			END
			
			// ENTRAMOS AL WC
			IF (y>190 AND x<40 AND cont2==0)
				cont2=1; fade(0,0,0,4); transicion=1;
			END
			IF (cont2>0) cont2++;
				IF (cont2==18) signal(pr12,s_kill_tree); loc=10; pr50=wc(); END
			END
		
			// TOPE ESCALERAS 2º PISO
			IF (y>23 AND y<50 AND y!=15 AND x>273) y=50; END
			IF (y>17 AND y<30 AND x>273) y=17; END
			
		END
		
		//*************************************************
		IF (loc==4) // EXTERIOR DEL BAR, PARKING Y CALLEJÓN
		//*************************************************
		
			// ENTRAMOS EN EL BAR
			IF (y>300 AND y<330 AND cont2==0)
				IF (x>860) cont2=1; fade(0,0,0,4); transicion=2;
					IF (audio==0) sound_play(snd40,fxv,256); END
				END
			END				
			IF (cont2>0) cont2++; END
				IF (cont2==18) pr11.ctype=c_screen; stop_sound(all_sound); scroll_stop(0); delete_text(all_text); signal(pr14,s_kill_tree); pr1=bar();
			END
			
			// MIENTRAS NOS ALEJAMOS LA MÚSICA SE OYE MENOS
			IF (music==0)
				distm=fget_dist(860,320,x,y);
				IF (distm<12) vol=mem_vol; END
				IF (distm<50 AND distm>12) vol=40; END
				IF (distm>50) vol=30; END
				IF (distm>100) vol=20; END
				IF (distm>200) vol=10; END
				IF (distm>300) vol=5; END
				IF (distm>350) vol=3; END
				IF (distm>380) vol=1; END
				IF (distm>400) vol=0; END
			END
			
			// DETECTAMOS LA SEÑAL DE TAXI
			IF (x>156 AND x<224 AND y=>154 AND y<173 AND transicion==0 AND est_taxi==0)
				t_text=1; 
			ELSE 
				IF (est_taxi==0) t_text=0; END 
			END
			
			IF (t_text==1) cont_t++;
				IF (cont_t==1)
					tope_text=1; t1=write(0,160,100,4,"PULSA ENTER PARA LLAMAR A UN TAXI");
				END
				IF (cont_t==20 AND tope_text==1)
					tope_text=0; delete_text(t1);
				END
				IF (cont_t==35) cont_t=0; END
				
				// SI PULSAMOS ENTER LLAMAMOS AL TAXI
				IF (keydown(_ENTER) AND t_ENTER==0) 
					est_taxi=100;
					t_ENTER=1; transicion=1; t_text=0;					
				END
			ELSE t_text=0; cont_t=0;
			END
			
			IF (t_text==0) // BORRAMOS TEXTO DE TAXI
				IF (tope_text==1) delete_text(t1); tope_text=0; END
			END
	
			// EL PROTA SE SUBE AL COCHE
			IF (est_taxi==3)
				IF (x>152) z=-201; angle=-90000; x-=3; cont++; ELSE cont_taxi=0; est_taxi=4; 
					IF (audio==0) sound_play(snd70,fxv,256); END
				END
			END
	
			IF (est_taxi==5) z=-1; visible=0; END
	
		END
	
		//*************************************************
		IF (loc==5) // BARRICADA
		//*************************************************			
			
			// NOS VAMOS DE LA ZONA
			IF (y>395 AND transicion==0) transicion=1; cont_tr=1; END
			IF (cont_tr>0) cont_tr++;
				IF (cont_tr<30) y+=3; angle=360000; cont++; END
				IF (cont_tr==30) 
					cont_tr=0; signal(pr32,s_freeze_tree); est_c=85; vent_conv(); 
					est_taxi=1000; // ponemos el est_taxi a 1000 para que el proceso ventana
					// lo detecte al apretar escape y sepa que estamos hablando con el taxista..
				END
			END			
			
			// TOPES DE PANTALLA
			IF (transicion==0)
				IF (x<95) x=95; END
				IF (x>638) x=638; END
				IF (y>390 AND x>304) y=390; END
				IF (y>390 AND x<236) y=390; END
				IF (y<12) y=12; END
			END
			
		END
		
		// TOPES DE EXTREMO DE PANTALLA
		
		// 2º PISO
		IF (loc==2 AND transicion==0)
			IF (x<12) x=12; END
			IF (x>308) x=308; END
			IF (y>228) y=228; END
			IF (y<12) y=12; END
		END
		
		// PARKING
		IF (loc==4 AND transicion==0)
			IF (x>292) 
				IF (y<122 AND y>117) y=122; END
				IF (y>88 AND y<122) y=88; END
			END
			
			IF (x>264)
				IF (y<27) y=27; END
			END
			IF (x<264)
				IF (y<15) y=15; END
			END
				
			IF (y>335) y=335; END
			IF (y<15) y=15; END
			IF (x<15) x=15; END
			IF (y<300 AND x>840) x=840; END
			IF (y>330 AND x>840) x=840; END
		END
		
		FRAME;
		
	END
	
END