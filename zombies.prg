// LAUNCHER DEL MINI-JUEGO
PROCESS launcher_zombies();

PRIVATE

	cont;

BEGIN

	LOOP
	
		cont++;
		
		IF (cont==30) fade(brillo,brillo,brillo,2); pr36=zombies(); BREAK; END
		
		FRAME;
		
	END
	
END


// MINI JUEGO DE LOS ZOMBIES (pr36)
PROCESS zombies();

PRIVATE

	col_barr; // colocación barrera
	x_barr=20; // posición de la barrera
	flags_barr; // flags de la barrera
	
BEGIN

	put_screen(fpg4,100);

	LOOP
	
		FROM col_barr=0 TO 8; // COLOCAMOS LAS BARRERAS
			IF (flags_barr==0) barr(x_barr,1); flags_barr=2; END
			IF (flags_barr==1) barr(x_barr,0); flags_barr=0; END
			IF (flags_barr==2) flags_barr=1; END
			x_barr+=47; col_barr++;
		END
	
		FRAME;
	
	END
	
END

PROCESS barr(x,flags);

BEGIN

	file=fpg4;
	graph=1;
	y=45;
	
	LOOP
	
		FRAME;
		
	END
	
END