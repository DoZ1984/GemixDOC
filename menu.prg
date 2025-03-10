//**************************************
// MENÚ INICIAL
//**************************************

PROCESS menu_ini();

PRIVATE

	cont;
	cont_b; // contador para el brillo
	cont_c; // contador para la aparición de coches
	cont_c2;
	cont_p; // contador para los paraguas
	cont_e; // contador del exit
	opt=1; // opción del menú
	tope;
	
BEGIN
	
	delete_text(all_text);
	put_screen(fpg1,150);
	graph=160;
	z=-500;
	x=160; y=168;
	fachada_menu();
	farola_menu();
	brillo_cartel();
	niebla();
	loc=0;
	fade(brillo,brillo,brillo,1);
	transicion=0;
	
	// PONEMOS VARIABLES GLOBALES A SU ESTADO INICIAL
	est_taxi=0; cont_taxi=0; euros=250; sefijaenelcoche=0;
	
	LOOP
	
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
		rain_menu(); rain_menu(); rain_menu(); rain_menu(); rain_menu();
	
		IF (rand(0,400)>399) rayo(); END // RELÁMPAGOS
	
		// ILUMINACIÓN DEL CARTEL
		cont_b++;
		IF (cont_b==1) brillo_cartel(); END
		IF (cont_b==6) brillo_cartel(); END
		IF (cont_b==11) brillo_cartel(); END
		IF (cont_b==35) cont_b=0; END
	
		// APARACIÓN DE COCHES
		IF (rand(0,20)<1 AND cont_c==0) car_menu(0); cont_c=1; END
		IF (cont_c>0) cont_c++; END
		IF (cont_c==24) cont_c=0; END
		
		IF (rand(0,20)<1 AND cont_c2==0) car_menu(1); cont_c2=1; END
		IF (cont_c2>0) cont_c2++; END
		IF (cont_c2==24) cont_c2=0; END
	
		// APARICIÓN DE PARAGUAS
		IF (rand(0,50)<1 AND cont_p==0) paraguas(); cont_p=1; END
		IF (cont_p>0) cont_p++; END
		IF (cont_p==65) cont_p=0; END

		// MOVEMOS OPCIONES DEL MENÚ
		IF (transicion==0)
			IF (keydown(_down) AND tope==0) opt+=1; tope=1; END
			IF (keydown(_up) AND tope==0) opt-=1; tope=1; END
		END
		
		IF (opt>3) opt=1; END
		IF (opt<1) opt=3; END
		
		SWITCH (opt)
			CASE 1: 
				graph=160;
				IF (keydown(_ENTER) AND cont==0 AND t_ENTER==0) t_ENTER=1; fade(0,0,0,2); cont=1; transicion=1; END
			END
			CASE 2: graph=161;
				IF (keydown(_ENTER) AND t_ENTER==0 AND t_ENTER==0) t_ENTER=1; rayo(); t_ENTER=1; END
			END
			CASE 3: 
				graph=162; 
				IF (keydown(_ENTER) AND cont_e==0 AND t_ENTER==0) t_ENTER=1; cont_e=1; fade(0,0,0,2); transicion=1; END
			END
		END
		
		// AVANZAMOS 
		IF (cont>0) cont++; END
		IF (cont==40) signal(id,s_kill_tree); clear_screen(); firsthumo=0; pr1=bar(); END
	
		// LIBERAMOS TOPE DE TECLAS
		IF (tope==1 AND NOT keydown(_up) AND NOT keydown(_down)) tope=0; END
	
		// SALIMOS DEL JUEGO
		IF (cont_e>0) cont_e++; 
			IF (cont_e==40) exit("",0); END
		END
	
		FRAME;
		
	END

END

//**************************************
// FACHADA DEL MENÚ INICIAL
//**************************************

PROCESS fachada_menu();

BEGIN

	graph=151;
	z=-30;
	x=160; y=120;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// FAROLA DEL MENÚ INICIAL
//**************************************

PROCESS farola_menu();

BEGIN

	graph=153;
	z=-20;
	x=283; y=133;
	
	LOOP
	
		FRAME;
		
	END
	
END

//**************************************
// BRILLO DEL CARTEL DEL MENÚ INICIAL
//**************************************

PROCESS brillo_cartel();

PRIVATE

	duracion=34;

BEGIN

	graph=152;
	z=-101;
	x=140; y=67;
	
	LOOP
	
		duracion--;
	
		IF (duracion==0) BREAK; END
	
		FRAME;
		
	END
	
END

//**************************************
// COCHE DEL MENÚ INICIAL
//**************************************

PROCESS car_menu(side);

BEGIN

	graph=154;
	z=-10;
	x=160; y=137;
	IF (side==1) x=370; y=129; flags=1; size=50; END
	
	LOOP
	
		IF (side==0) x+=8; END
		IF (side==1) x-=5; END
		
		IF (x<160 OR x>370) BREAK; END
	
		FRAME;
		
	END
	
END

//**************************************
// PARAGUAS DEL MENÚ INICIAL
//**************************************

PROCESS paraguas();

PRIVATE

	cont;
	lado;

BEGIN

	graph=156;
	size=130;
	z=-100;
	lado=rand(0,1); 
	x=-60; y=228;
	IF (lado==1)
		flags=1; x=380;
	END
	
	LOOP
	
		IF (lado==0)
			x+=3;
		END
		
		IF (lado==1)
			x-=3;
		END
		
		cont++;
		IF (cont==2) y-=1; END
		IF (cont==4) y-=1; END
		IF (cont==5) y-=1; END
		IF (cont==15) y+=1; END
		IF (cont==16) y+=1; END
		IF (cont==18) y+=1; END
		IF (cont==26) cont=0; END
		
		IF (x<-60 OR x>380) BREAK; END
	
		FRAME;
		
	END
	
END		

//**************************************
// NIEBLA DEL MENÚ INICIAL
//**************************************

PROCESS niebla();

PRIVATE

	dir;

BEGIN

	graph=155;
	size=300;
	z=-200;
	x=-800; y=120;
	
	LOOP
	
		IF (dir==0) x+=2; ELSE x-=2; END
		
		IF (x=>800) dir=1; END
		IF (x=<-800) dir=0; END
		
		FRAME;
		
	END
	
END

	
//**************************************
// LLUVIA DEL MENÚ INICIAL
//**************************************

PROCESS rain_menu();

PRIVATE

	cont;

BEGIN

	graph=995;
	z=-100;
	flags=4;
	angle=-45000;
	
	x=rand(5,380); y=rand(-10,180);
	
	LOOP
	
		IF (cont==0) y+=10; x-=10; END
		
		IF (x<260 OR y>180 OR collision(TYPE paraguas))
			IF (rand(1,50)>48) graph=996; cont=1; END
			IF (cont>0) cont++; END
			IF (cont==4) graph=997; END
			IF (cont==7) BREAK; END
		ELSE 
			IF (y>150)
				IF (rand(1,50)>46) graph=996; size=30; cont=1; END
				IF (cont>0) cont++; END
				IF (cont==4) graph=997; END
				IF (cont==7) BREAK; END
			END
		END
		
		IF (y>260) BREAK; END
		
		FRAME;
		
	END

END