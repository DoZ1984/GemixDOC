//**************************************
// ESTADO DEL JUGADOR
//**************************************

PROCESS est_jug();

PRIVATE

	cont;
	cont2;
	t1; t2; t3; t4; t5; 
	
BEGIN

	graph=989;
	z=-1000;
	x=160; y=120;
	flags=4;

	soundchannel_pause(all_channel);
	t1=write(fnt4,190,187,3,itoa(cont_h)+"h "+itoa(cont_m)+"m "+itoa(cont_s)+"s");
	t2=write(fnt5,125,86,3,itoa(euros)+"€");
	t3=write(fnt5,125,130,3,itoa(gscore));
	t4=write(fnt4,70,212,3,itoa(expe));
	t5=write(fnt4,275,212,3,itoa(nivel));
	text_lock(t1); text_lock(t2); text_lock(t3); text_lock(t4); text_lock(t5);
	text_set_z(t1,-1001); text_set_z(t2,-1001); text_set_z(t3,-1001);
	text_set_z(t4,-1001); text_set_z(t5,-1001);
	haypanel=1;
	
	LOOP
	
	
		IF (cont<5) cont++; END
		IF (cont==3) flags=0; END
		
		IF (NOT keydown(_TAB) AND cont2==0) tope_ESC=1; cont2=1; 
			delete_text(t1); delete_text(t2); delete_text(t3);
			delete_text(t4); delete_text(t5); haypanel=0;
			IF (loc==1) signal(pr1,s_wakeup_tree); END
			IF (loc==2) signal(pr12,s_wakeup_tree); END
			IF (loc==4) signal(pr14,s_wakeup_tree); END
			IF (loc==5) signal(pr32,s_wakeup_tree); END
			IF (loc==20)
				signal(pr3,s_wakeup_tree); signal(pr4,s_wakeup_tree); signal(pr7,s_wakeup_tree); 
				signal(pr19,s_wakeup_tree); signal(pr22,s_wakeup_tree); 
			END
			soundchannel_resume(all_channel);
		END
		
		IF (cont2>0) flags=4; cont2++; END
		IF (cont2==3) transicion=0; signal(id,s_kill); END
		
		FRAME;
		
	END

END



//**************************************
// BOCADILLO EXCLAMACIÓN (pr28)
//**************************************

PROCESS bocadillo();

BEGIN

	graph=124;
	
	z=-99;
	
	IF (loc==4) ctype=c_scroll; END
	
	LOOP

		x=pr11.x+12;
		y=pr11.y-20;
	
		FRAME;
		
	END
	
END

//**************************************
// VENTANA PEQUEÑA (pr31)
//**************************************

PROCESS vent_peq();

PRIVATE

	tope_textos; // tope para no escribir más de una vez
	t1; t2; t3; t4; t5;
	tope; // tope de cursores
	cant; // cantidad a sumar o restar en apuestas
	cont; // contador para calcular el tiempo de pulsación de los cursores
	cont_t; // contador para la transición

BEGIN

	graph=198;
	z=-200;
	x=160; y=100;
	haypanel=1;
	
	LOOP
	
		// BORRAMOS TEXTOS Y VOLVEMOS AL ESTADO QUE LOS ESCRIBE
		IF (est_vent==3) 
			delete_text(t1); delete_text(t2); delete_text(t3); est_vent=1; 
		END
	
		SWITCH (est_vent)
			CASE 1: // APUESTA PREVIA A LA RULETA RUSA
				t1=write(fnt9,160,91,4,"APUESTA"); 
				t2=write(fnt4,160,113,4, "<  "+itoa(apuesta_ruleta)+"€"+"  >");
				t3=write(fnt3,160,140,4,"AJUSTA CON LOS CURSORES Y PULSA ENTER");
				est_vent=2;
			END
		END
		
		// MODIFICAMOS LA APUESTA
		IF (est_vent==2 AND transicion==0)
			IF (keydown(_left)) cont++; est_vent=3;
				IF (tope==0)
					IF (tope==0 AND cont<2) tope=1; END
					cant=cont/10; IF (cant<1) cant=1; END
					apuesta_ruleta-=cant;
					IF (audio==0 AND apuesta_ruleta>99) sound_play(snd37,fxv,256); END
				END
				IF (cont>15) tope=0; END
			END
			IF (keydown(_right)) cont++; est_vent=3;
				IF (tope==0)
					IF (tope==0 AND cont<2) tope=1; END
					cant=cont/10; IF (cant<1) cant=1; END
					apuesta_ruleta+=cant;
					IF (audio==0 AND apuesta_ruleta<euros+1) sound_play(snd37,fxv,256); END
				END
				IF (cont>15) tope=0; END				
			END
			IF (apuesta_ruleta<100) apuesta_ruleta=100; END
			IF (apuesta_ruleta>euros) apuesta_ruleta=euros; END
		END
		
		// PULSAMOS ENTER Y CONFIRMAMOS APUESTA
		IF (est_vent==1 OR est_vent==2)
			IF (keydown(_ENTER) AND t_ENTER==0 AND transicion==0) 
				est_vent=3; t_ENTER=1; cont_t=1; 
				resta_euros(270,110,apuesta_ruleta,fnt9,0);
				IF (audio==0) sound_play(snd27,fxv,256); END
			END
		END
		
		// LANZAMOS EL MINI-JUEGO RULETA
		IF (cont_t>0) cont_t++; transicion=1;
			IF (cont_t==2) 
				fade(0,0,0,2); angle_pr=angle;
			END
			IF (cont_t==40)
				signal(pr1,s_kill_tree); signal(id,s_kill_tree);
				pr7=main_ruleta(); haypanel=0;
			END
		END
		
		IF (NOT keydown(_left) AND NOT keydown(_right)) cont=0; tope=0; END
	
		// APRETAMOS ESCAPE
		IF (keydown(_ESC) AND tope_ESC==0 AND transicion==0) tope_ESC=1; 
			IF (audio==0) sound_play(snd36,fxv,256); END
			IF (loc==1) // BAR
				signal(pr1,s_wakeup_tree);
			END
			delete_text(t1); delete_text(t2); delete_text(t3); delete_text(t4);
			est_vent=0; transicion=0; apuesta_ruleta=100; haypanel=0; BREAK; 
		END
	
		FRAME;		
		
	END
	
END