//**************************************
// MAIN RULETA RUSA (pr7)
//**************************************

PROCESS main_ruleta();

PRIVATE

	fase;
	t1; t2; t3; t4; t5; t6;
	tapuesta; // texto de apuesta
	tapuesta2; // texto de apuesta 2 (cantidad)
	tdis; tdis2; // textos de disparos
	solo1;
	cont; cont2; cont3;
	sel; // seleccióN
	archivoR; // archivo para el highscore
	
BEGIN

	minijuego=3;

	delete_text(all_text);
	put_screen(fpg1,99);

	z=-100;
	
	fade(brillo,brillo,brillo,2);
	
	rajarse=0;
	
	pr8=boy_rusa();
	pr9=boy_rusa2();
	pistola();
	
	graph=102;
	visible=0;
	x=90; y=97;
	loc=20;
	transicion=0; 
	humo();
	
	LOOP

		IF (dis==0) prob="16%"; END
		IF (dis==1) prob="20%"; END
		IF (dis==2) prob="25%"; END
		IF (dis==3) prob="33%"; END
		IF (dis==4) prob="50%"; END
		IF (dis==5) prob="IN YOUR FACE!"; END
	
		// FASE INICIAL, TEXTOS EN PANTALLA
		IF (fase_r==0) cont++;
			IF (fase==0)
				t1=write(fnt1,160,25,1,"RULETA RUSA");
				t2=write(fnt2,160,65,1,"ÉCHALE HUEVOS Y");
				t3=write(fnt2,160,85,1,"APRIETA EL GATILLO!");
				fase=1;
			END
			IF (cont==1)
				t4=write(fnt2,160,215,1,"PULSA ENTER PARA EMPEZAR");
			END
			IF (cont==20) delete_text(t4); END
			IF (cont==30) cont=0; END
			
			// PULSAMOS ENTER Y EMPEZAMOS
			IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
				delete_text(t1); delete_text(t2); delete_text(t3);
				IF (audio==0) sound_play(snd30,fxv+50,256); END
				IF (cont<20) delete_text(t4); END // borramos el texto intermitente si es el momento en el que está en pantalla
				fase_r=1; fase=0; cont=0;
			END
		END
		
		IF (fase_r==20) cont=0; fase=2; fase_r=1; END
		
		// FASE INICIAL, EMPEZAMOS SIEMPRE NOSOTROS
		IF (fase_r==1) cont++;
			IF (fase==0)
				tapuesta=write(fnt11,160,30,4,"APUESTA: "+itoa(apuesta_ruleta)+"€");
				fase=1; dis=0; rajarse=0;
				bala=rand(1,6);
			END
			// PRESENTACIÓN INICIAL
			IF (fase==1 AND cont==40) 
				//delete_text(t1); delete_text(t2);
				tdis=write(fnt3,121,200,0,"DISPAROS:");
				tdis2=write(fnt3,193,200,0,OFFSET dis);
				tprob=write(0,112,218,0,"PROBABILIDAD:");
				tprob2=write(0,192,218,0, prob);
				fase=2;
			END
			IF (fase==2)
				visible=1;
				t1=write(fnt2,160,80,1,"DISPARAR");
				t2=write(fnt2,160,110,1,"RAJARSE");
				fase=3; sel=0;
				IF (audio==0) snd_latidos=sound_play(snd33,fxv+50,256); END
			END
			// FASE DE SELECCIÓN DE DISPARAR O RAJARSE
			IF (fase==3)
				IF (keydown(_up) AND solo1==0) solo1=1; sel-=1; END
				IF (keydown(_down) AND solo1==0) solo1=1; sel+=1; END
				IF (sel>1) sel=0; END
				IF (sel<0) sel=1; END
				IF (sel==0) y=97; 
					IF (keydown(_ENTER) AND solo1==0) solo1=1; fase_r=2; // DISPARAMOS
						delete_text(t1); delete_text(t2); visible=0;
					END
				END
				IF (sel==1) y=124; 
					IF (keydown(_ENTER) AND solo1==0) solo1=1; fase_r=3; // NOS RAJAMOS
						IF (audio==0) stop_sound(snd_latidos); END
					END
				END
			END
		END			
		
		// FASE DE RAJARSE
		IF (fase_r==3) cont3++; visible=0;
			
			IF (cont3==1)
				delete_text(tdis); delete_text(tdis2); delete_text(tprob); delete_text(tprob2);
				delete_text(t1); delete_text(t2);
				t1=write(fnt2,160,70,1,"TE RAJAS!");
				t2=write(fnt2,160,110,1,"AHORA TODO DEPENDE DE");
				t3=write(fnt2,160,130,1,"TU CONTRINCANTE:");
				t4=write(fnt2,160,160,1,"-SI VIVE PIERDES");
				t5=write(fnt2,160,190,1,"-SI MUERE GANAS");
			END
			IF (keydown(_ENTER) AND solo1==0) solo1=1; cont3=140; END
			IF (cont3==140) 
				fase_r=4; rajarse=1;
				delete_text(t1); delete_text(t2); delete_text(t3); 
				delete_text(t4); delete_text(t5); 
				tdis=write(fnt3,115,200,0,"DISPAROS:");
				tdis2=write(fnt3,198,200,0,OFFSET dis);
				tprob=write(0,112,218,0,"PROBABILIDAD:");
				tprob2=write(0,192,218,0, prob);
				
				cont3=0;
			END
		END
		
		// GAME OVER
		IF (fase_r==15) cont3++; fase=10;
			IF (cont3==1) 
				delete_text(tdis); delete_text(tdis2);
				delete_text(tprob); delete_text(tprob2);
				t1=write(fnt1,160,50,1,"GAME OVER");
				t2=write(fnt2,160,90,1,"HAS PERDIDO LA APUESTA!");
				t3=write(fnt2,160,115,1,"ALGUIEN TIENE UNA ASPIRINA?");
				IF (audio==0 AND transicion==0) sound_play(snd60,fxv+50,256); END
			END
			IF (cont3==60) fade(0,0,0,2); transicion=1;
				cont2=1;
			END
		END
		
		// RIVAL MUERTO
		IF (fase_r==16) cont3++;
			IF (cont3==1)
				delete_text(tdis); delete_text(tdis2);
				delete_text(tprob); delete_text(tprob2);
				t1=write(fnt1,160,50,1,"HAS GANADO!");
				t2=write(fnt2,160,90,1,"TE LLEVAS LA APUESTA");
				suma_euros(160,150,apuesta_ruleta*2,fnt8,0);
				suma_gscore(pr8.x-17,pr8.y-60,10000,fnt7,0);
				suma_exp(pr8.x-17,pr8.y-50,2500,fnt6,0);
			END
			IF (cont3==60) fade(0,0,0,2); transicion=1; 
				cont2=1; fase_r=17;
			END
		END
		
		// RIVAL GANA TRAS RAJARNOS
		IF (fase_r==30) cont3++;
			IF (cont3==1)
				delete_text(tdis); delete_text(tdis2);
				delete_text(tprob); delete_text(tprob2);
				t1=write(fnt1,160,50,1,"GAME OVER");
				t2=write(fnt2,160,90,1,"HAS PERDIDO LA APUESTA!");
				IF (audio==0 AND transicion==0) sound_play(snd60,fxv+50,256); END
			END
			IF (cont3==60)
				fade(0,0,0,2); transicion=1; cont2=1;
			END
		END
		
		// PULSAR ESCAPE PARA SALIR
		IF (saliendo_minijuego==3) saliendo_minijuego=300;
			transicion=1; cont2=1;
		END
	
		IF (cont2>0) cont3=0; cont2++; END
		
		IF (cont2==35) signal(id,s_kill_tree); clear_screen(); fase_r=0; volviendo_minijuego=1;
			pr1=bar(); fade(brillo,brillo,brillo,2); apuesta_ruleta=100; saliendo_minijuego=0;
		END
		
		// TOPE DE TECLAS
		IF (solo1==1 AND NOT keydown(_up) AND NOT keydown(_down) AND NOT keydown(_ENTER)) 
			solo1=0; 
		END
		
		IF (keydown(_ENTER)) solo1=1; END
		
		FRAME;
		
	END
	
END

//**************************************
// BOY RULETA RUSA (pr8)
//**************************************

PROCESS boy_rusa();

PRIVATE

	cont; cont2; cont3;
	fase;
	
	solo1;
	
BEGIN

	graph=79;
	
	x=293; y=166;
	
	cont=rand(0,59);
	
	//write_int(0,10,40,0,OFFSET x);
	//write_int(0,10,50,0,OFFSET y);
	
	LOOP
	
		IF (fase_r==1) cont2=0; fase=0; END
	
		// CIERRE DE OJOS
		IF (fase_r<2 OR fase_r>5) cont++;
			IF (fase_r!=15)
				IF (cont==60) x=293; y=166; graph=80; END
				IF (cont==64) graph=81; END
				IF (cont==70) graph=80; END
				IF (cont==74) graph=79; END
				IF (cont==220) graph=80; END
				IF (cont==224) graph=81; END
				IF (cont==228) graph=80; END
				IF (cont==232) graph=79; END
				IF (cont==244) graph=80; END
				IF (cont==248) graph=81; END
				IF (cont==252) graph=80; END
				IF (cont==256) graph=79; END
				IF (cont==370) cont=0; END
			END
		END
		
		// COGEMOS LA PISTOLA
		IF (fase_r==2) cont2++; 
			IF (fase==0) 
				IF (cont2==1) x=290; y=170; graph=82; END
				IF (cont2==6) graph=83; END
				IF (cont2==11) graph=84; x=293; y=166; END
				IF (cont2==15) fase=1; END
			END
			
			IF (fase==1)
				IF (dis!=bala-1) fase=3; END // SI NO NOS TOCA..
				IF (dis==bala-1) fase=2; END // SI NOS TOCA LA BALA.. BOOM
			END
			IF (fase==2) // SE NOS DISPARA CON BALA
				IF (cont2==15) dis+=1; 
					IF (audio==0) stop_sound(snd_latidos); sound_play(snd31,fxv,256); sound_play(snd44,fxv,256); END
				END
				IF (cont2==20) graph=86; END
				IF (cont2==22) graph=87; END
				IF (cont2==26) graph=88; x=263; y=162; END
				IF (cont2==28) graph=89; x=262; y=166; END
				IF (cont2==32) graph=91; x=263; y=168; END
				IF (cont2==42) graph=92; END
				IF (cont2==52) graph=93; END
				IF (cont2==62) graph=94; END
				IF (cont2==72) graph=95; END
				IF (cont2==92) graph=96; END
				IF (cont2==122) cont=0; fase_r=15; END
			END
			IF (fase==3) // NO SE DISPARA
				IF (cont2==15) dis+=1; 
					IF (audio==0) stop_sound(snd_latidos); sound_play(snd32,fxv,256); sound_play(snd43,fxv,300); END
					suma_gscore(x-17,y-60,dis*1000,fnt7,0);
					suma_exp(x-17,y-50,dis*100,fnt6,0);
				END
				IF (cont2<52 AND cont2<40) graph=85; END
				IF (cont2==52) graph=84; END
				IF (cont2==80) graph=83; x=290; y=170; END
				IF (cont2==84) graph=82; est_pist=1; pistola(); END
				IF (cont2==90) graph=79; x=293; y=166; fase_r=5; est_pist=0; 
					IF (audio==0) sound_play(snd34,fxv,200); END
				END
			END
			
		END
		
		// NOS RAJAMOS Y DEVOLVEMOS LA PISTOLA
		IF (fase_r==4)
			fase=3; cont2=83; fase_r=2;
		END
		
		FRAME;
		
	END
	
END

//**************************************
// BOY 2 RULETA RUSA (pr9)
//**************************************

PROCESS boy_rusa2();

PRIVATE

	cont; cont2; cont3;
	fase;
	
	solo1;
	
BEGIN

	graph=103;
	x=39; y=166;
	
	cont=rand(0,59);
	
	LOOP
		
		IF (fase_r==1 AND graph==116) graph=103; x=39; cont=0; END
		IF (fase_r==5) cont2=0; fase=0; END
		
		// COGEMOS LA PISTOLA
		IF (fase_r==6) cont2++; 
			IF (fase==0) 
				IF (cont2==1) x=41; y=171; graph=104; END
				IF (cont2==6) graph=105; END
				IF (cont2==11) graph=106; x=39; y=166; END
				IF (cont2==15) fase=1; END
			END
			
			IF (fase==1)
				IF (dis!=bala-1) fase=3; END // SI NO NOS TOCA..
				IF (dis==bala-1) fase=2; END // SI NOS TOCA LA BALA.. BOOM
			END
			IF (fase==2) // NOS DISPARAMOS CON LA BALA
				IF (cont2==15) dis+=1; 
					IF (audio==0) sound_play(snd31,fxv,256); sound_play(snd44,fxv,256); END
				END
				IF (cont2==20) graph=108; END
				IF (cont2==22) graph=109; END
				IF (cont2==26) graph=110; x=32; y=162; END
				IF (cont2==30) graph=111; x=31; y=166; END
				IF (cont2==34) graph=112; x=31; END
				IF (cont2==44) graph=113; END
				IF (cont2==54) graph=114; END
				IF (cont2==64) graph=115; END
				IF (cont2==74) graph=116; END
				IF (cont2==94) cont=0; fase_r=16; END
			END
			IF (fase==3) // NO NOS DISPARAMOS
				IF (cont2<84) pr8.graph=80; END
				IF (cont2==15) dis+=1; 
					IF (audio==0) sound_play(snd32,fxv,256); sound_play(snd43,fxv,300); END
				END
				IF (cont2<52) graph=107; END
				IF (cont2==52) graph=106; END
				IF (cont2==80) graph=105; x=41; y=171; END
				IF (cont2==84) graph=104; est_pist=1; pistola(); END
				IF (cont2==90) graph=103; x=39; y=166; est_pist=0; 
					IF (rajarse==0) fase_r=10; 
						IF (audio==0) sound_play(snd34,fxv,200); END
					END // SI NO NOS HEMOS RAJADO
					IF (rajarse==1) fase_r=30; END // SI NOS HEMOS RAJADO
				END
			END
		END
		
		FRAME;

	END
	
END

//**************************************
// PISTOLA RULETA RUSA
//**************************************

PROCESS pistola();

PRIVATE

	cont; cont2;
	vel=5;
	
BEGIN

	graph=90;
	
	x=213; y=167;

	IF (fase_r==0 OR fase_r==1) flags=1; END
	IF (fase_r==5) flags=0; END
	IF (fase_r==6) x=115; flags=1; END
	
	LOOP
	
		IF (est_pist==1) cont2++;
			IF (cont2==2) est_pist=0; cont2=0; END
		END
	
		IF (fase_r==2 AND est_pist==0) cont++;
			IF (cont==6) BREAK; END
		END
		
		IF (fase_r==6 AND est_pist==0) cont++;
			IF (cont==6) BREAK;	END
		END
		
		// SE MANDA LA PISTOLA PARA LA IZQUIERDA
		IF (fase_r==5 AND x>115) x-=vel; cont++;
			IF (cont==10) vel-=1; END
			IF (cont==16) vel-=1; END
			IF (cont==24) vel-=1; END
			IF (cont==30) vel-=1; END
		ELSE
			IF (fase_r==5) 
				fase_r=6; cont=0;
				delete_text(tprob2); tprob2=write(0,192,218,0, prob);
			END
		END
		
		// SE MANDA LA PISTOLA PARA LA DERECHA
		IF (fase_r==10 AND x<213) x+=vel; cont++; 
			IF (cont==10) vel-=1; END
			IF (cont==16) vel-=1; END
			IF (cont==24) vel-=1; END
			IF (cont==28) vel-=1; END
		ELSE
			IF (fase_r==10) 
				fase_r=20; cont=0; 
				delete_text(tprob2); tprob2=write(0,192,218,0, prob);
			END
		END
		
		FRAME;
		
	END
	
END
