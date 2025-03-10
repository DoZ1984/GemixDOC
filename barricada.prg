//**************************************
// ZONA BARRICADA (pr32)
//**************************************

PROCESS barricada();

BEGIN

	delete_text(all_text);

	scroll_start(0,fpg2,500,0,0,0);
	
	loc=5;
	bsz=0;
	pr11=prota();
	vallas();
	pr34=soldat();
	pr37=stan();
	tank();
	foco(400,-330,0);
	foco(400,730,2);
	fade(brillo,brillo,brillo,2);
	
	LOOP
	
		IF (hayzombie==0 AND transicion==0) pr33=zombie_b(); hayzombie=1; END
		
		FRAME;
		
	END
	
END

//**************************************
// VALLAS
//**************************************

PROCESS vallas();

BEGIN

	file=fpg2;
	graph=1;
	z=-20;
	ctype=c_scroll;
	
	x=371; y=385;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// TANQUE
//**************************************

PROCESS tank();

BEGIN
	
	file=fpg2;
	graph=2;
	z=-10;
	ctype=c_scroll;
	
	x=235; y=48;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// SOLDADO BARRICADA (pr34)
//**************************************

PROCESS soldat();

PRIVATE

	est;
	lado;
	cont;
	cont2;
	cont_d; // contador para disparos
	cont_c; // contador para casquillos
	cont_r; // contador de ráfaga
	pos_z; // posición relativa al zombie
	dist;
	vol_p;
	
BEGIN

	file=fpg2;
	graph=10;
	angle=90000;
	z=-20;
	ctype=c_scroll;
	
	x=135; y=199;
	
	soldat_col();
	
	LOOP
	
		IF (dist<200) vol_p=fxv; END
		IF (dist<225 AND dist>200) vol_p=fxv-10; END
		IF (dist<250 AND dist>225) vol_p=fxv-20; END
		IF (dist<275 AND dist>250) vol_p=fxv-30; END
		IF (dist<300 AND dist>275) vol_p=fxv-40; END
		IF (dist<325 AND dist>300) vol_p=fxv-50; END
		IF (dist<350 AND dist>325) vol_p=fxv-60; END
		IF (dist<375 AND dist>350) vol_p=fxv-70; END
		IF (dist<400 AND dist>375) vol_p=fxv-80; END
		IF (dist>425) vol_p=fxv-90; END

		dist=fget_dist(x,0,pr11.x,0);
	
		// CORREGIMOS EL ÁNGULO SEGÚN LA POSICIÓN "Y" DEL ZOMBIE
		IF (hayzombie==1 AND transicion==0) pos_z=pr33.y*450; END
		
		IF (est==0)
			IF (lado==0) angle-=1000; 
				IF (angle<37000) lado=1; cont=1; END
			END
			IF (lado==1) cont2++;
				IF (cont2==20) cont2=0; lado=2; END
			END
			IF (lado==2) angle+=1000;
				IF (angle>160000) lado=3; END
			END
			IF (lado==3) cont2++;
				IF (cont2==20) cont2=0; lado=0; END
			END
			IF (hayzombie==1)
				IF (pr33.x=>-8)
					IF (angle>pos_z AND angle<pos_z+1300) est=100; END
					IF (angle<pos_z AND angle>pos_z-1300) est=100; END
					IF (angle<38000 AND pos_z<38000) est=100; END
					IF (angle>159000 AND pos_z>159000) est=100; END
				END
			END
		END
			
		
		IF (est==100) // DISPARANDO
			angle=pos_z; IF (angle>160000) angle=160000; END IF (angle<37000) angle=37000; END
			cont_d++; cont_c++; cont_r++; bsz=1;
			IF (cont_c==5) cont_c=0; casquillo(); END
			IF (cont_d==0) graph=11; END
			IF (cont_d==1) graph=12; IF (audio==0) sound_play(snd64,vol_p,256); END END
			IF (cont_d==3) graph=10; END
			IF (cont_d==4) cont_d=0; END
			IF (cont_r==30) cont_r=0; est=101; bsz=2; END
		ELSE
			cont_d=0; graph=10;
		END
		
		// SE HA MATADO AL ZOMBIE Y VOLVEMOS A LA NORMALIDAD
		IF (bsz==3) est=0; graph=10; END
	
		FRAME;
		
	END
	
END

//**************************************
// COLISIÓN SOLDADO
//**************************************

PROCESS soldat_col();

BEGIN

	file=fpg2;
	graph=13;
	size=145;
	ctype=c_scroll;
	z=-20;
	x=134; y=200;
	visible=0;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// CASQUILLO SOLDADO
//**************************************

PROCESS casquillo();

PRIVATE

	cant1; cant2;
	cont;
	dist;
	vol_p;

BEGIN

	file=fpg2;
	graph=14;
	x=father.x; y=father.y-8;
	ctype=c_scroll;
	z=-20;
	
	cant1=rand(2,6); cant2=rand(2,6);
	
	LOOP
	
		dist=fget_dist(x,y,pr11.x,pr11.y);
		IF (dist>425) vol_p=fxv-90; END
		IF (dist<400 AND dist>375) vol_p=fxv-80; END
		IF (dist<375 AND dist>350) vol_p=fxv-70; END
		IF (dist<350 AND dist>325) vol_p=fxv-60; END
		IF (dist<325 AND dist>300) vol_p=fxv-50; END
		IF (dist<300 AND dist>275) vol_p=fxv-40; END
		IF (dist<275 AND dist>250) vol_p=fxv-30; END
		IF (dist<250 AND dist>225) vol_p=fxv-20; END
		IF (dist<225 AND dist>200) vol_p=fxv-10; END
		IF (dist<200) vol_p=fxv; END
	
		cont++;
	
		angle+=10000; 
		x+=cant1; y-=cant2;
		
		IF (cont<10) size+=5; END
		IF (cont>10) size-=5; END
		IF (cont==14 AND audio==0) sound_play(snd65,vol_p,256); z=1; END
		IF (cont>17) angle+=40000; END
		IF (cont==24) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// FOCO BARRICADA
//**************************************

PROCESS foco(x,y,flags);

PRIVATE

	cont;

BEGIN

	file=fpg2;
	graph=20;
	size=110;
	ctype=c_scroll;
	z=-100049;
	
	IF (flags==0) angle=-60000; ELSE angle=210000; END
	
	LOOP
	
		cont++;
		
		IF (flags==0) angle+=1200; ELSE angle-=1200; END
		
		FRAME;
		
	END
	
END

//**************************************
// ZOMBIE BARRICADA
//**************************************

PROCESS zombie_b();

PRIVATE

	cont;
	cont_s; // contador para la sangre
	cont_g; // contador para gruñido
	snd_walk; // ID de sonido andando
	snd_gru; // ID de sonido gruñido
	dist; // distancia con el protagonista
	vol_p; // volumen de los audios del proceso

BEGIN

	file=fpg2;
	graph=30;
	size=105;
	ctype=c_scroll;	
	z=-1;
	x=-30;
	y=rand(25,375);
	
	vol_p=fxv;
	
	LOOP
	
		cont++;
		
		dist=fget_dist(x,y,pr11.x,pr11.y);
		IF (dist>240) vol_p=0; END
		IF (dist<230 AND dist>220) vol_p=fxv-90; END
		IF (dist<220 AND dist>210) vol_p=fxv-80; END
		IF (dist<210 AND dist>200) vol_p=fxv-70; END
		IF (dist<200 AND dist>190) vol_p=fxv-60; END
		IF (dist<190 AND dist>180) vol_p=fxv-50; END
		IF (dist<180 AND dist>170) vol_p=fxv-40; END
		IF (dist<170 AND dist>160) vol_p=fxv-30; END
		IF (dist<160 AND dist>150) vol_p=fxv-20; END
		IF (dist<150 AND dist>140) vol_p=fxv-10; END
		IF (dist<140) vol_p=fxv; END
		
		IF (cont==4 AND graph<33) graph++; x+=2; cont=0; END
		
		IF (graph==30 AND audio==0 AND x>-15 AND bsz==0) snd_walk=sound_play(snd66,vol_p-20,180); END
		
		IF (graph==33 AND cont==8) graph=30; cont=0; END
		
		// GRUÑIDOS
		IF (audio==0)
			IF (!soundchannel_is_playing(snd_gru)) cont_g++;
				IF (cont_g==9) snd_gru=sound_play(snd67,vol_p,256); cont_g=0; END
			END
		END
		
		// SIENDO TIROTEADO		
		IF (bsz==1)
			cont_s++;
			IF (cont_s==1) zb_blood(); END
			IF (cont_s==4) cont_s=0; END
		END
		
		// ZOMBIE MUERTO, PONEMOS EL GRÁFICO SOBRE EL SCROLL
		IF (bsz==2)
			IF (soundchannel_is_playing(snd_walk)) stop_sound(snd_walk); END
			map_xput(fpg2,500,34,x+3,y,rand(0,360000),100,rand(0,2)); refresh_scroll(0);
			bsz=3; hayzombie=0; BREAK;
		END
		
		// TOPE X DE BARRICADA
		IF (x>41) x=41; END
		
		IF (keydown(_q)) y-=1; END
		IF (keydown(_a)) y+=1; END		
	
		FRAME;
		
	END
	
END

//**************************************
// SANGRE ZOMBIE BARRICADA
//**************************************

PROCESS zb_blood();

PRIVATE

	cont;
	dist;
	vol_p;

BEGIN

	file=fpg2;
	graph=rand(40,42);
	angle=rand(0,360000);
	z=0;
	ctype=c_scroll;
	x=father.x+3; y=father.y;
	
	dist=fget_dist(x,y,pr11.x,pr11.y);
	IF (dist>240) vol_p=0; END
	IF (dist<230 AND dist>220) vol_p=fxv-90; END
	IF (dist<220 AND dist>210) vol_p=fxv-80; END
	IF (dist<210 AND dist>200) vol_p=fxv-70; END
	IF (dist<200 AND dist>190) vol_p=fxv-60; END
	IF (dist<190 AND dist>180) vol_p=fxv-50; END
	IF (dist<180 AND dist>170) vol_p=fxv-40; END
	IF (dist<170 AND dist>160) vol_p=fxv-30; END
	IF (dist<160 AND dist>150) vol_p=fxv-20; END
	IF (dist<150 AND dist>140) vol_p=fxv-10; END
	IF (dist<140) vol_p=fxv; END
	
	
	IF (audio==0) sound_play(snd68,vol_p,256); END
	
	LOOP
	
		cont++;
		
		IF (cont==4) BREAK; END
		
		FRAME;
		
	END
	
END

//**************************************
// PROCESO STAN
//**************************************

PROCESS stan();

BEGIN

	file=fpg2;
	graph=50;
	ctype=c_scroll;
	x=550; y=270;
	size=100;
	
	LOOP
	
		FRAME;
		
	END
	
END