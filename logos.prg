//**************************************
// LOGOS
//**************************************

PROCESS logos();

PRIVATE

	cont;
	vel;
	
BEGIN

	loc=0;
	fade(0,0,0,10);

	LOOP
	
		cont++;
	
		IF (cont==1) put_screen(fpg1,990); fade(brillo,brillo,brillo,1); END
		IF (cont==130) fade(0,0,0,1); END
		IF (cont==200) clear_screen(); put_screen(fpg1,988); fade(brillo,brillo,brillo,1); latidos(); END
		IF (cont==200) write(fnt3,160,220,4,"© by DoZ 2016 - dozdin@gmail.com"); END
		IF (cont==380) fade(0,0,0,1); END
		IF (cont==450) delete_text(all_text); END
		IF (cont==460) signal(id,s_kill_tree); menu_ini(); END
	
		IF (keydown(_ENTER) AND t_ENTER==0) t_ENTER=1;
			IF (cont<130) cont=129; END
			IF (cont>220 AND cont<380) cont=379; END
		END
	
		FRAME;
	
	END
	
END

//**************************************
// LATIDOS (CORAZÓN ANIMADO)
//**************************************

PROCESS latidos();

PRIVATE

	cont;

BEGIN

	graph=980;
	size=100;
	x=160; y=65;
	letras();
	
	LOOP
		
		cont++;
		
		IF (cont==2) graph++; cont=0; END
		
		IF (graph>986) graph=980; END
		
		FRAME;
		
	END
	
END

//**************************************
// LETRAS LOGO
//**************************************

PROCESS letras();

BEGIN

	graph=987;
	x=160; y=120;
	
	LOOP
	
		FRAME;
		
	END
	
END