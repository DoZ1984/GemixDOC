//**************************************
// 2º PISO (pr12)
//**************************************

PROCESS seg_piso();

BEGIN

	delete_text(all_text);

	z=100;
	graph=500;
	x=160; y=120;
	
	loc=2;
	pr11=prota();
	fade(brillo,brillo,brillo,4);
	humo();
	brillo_wc();
	
	LOOP
	
		// TECLA ESCAPE
		IF (keydown(_ESC) AND tope_ESC==0 AND transicion==0) 
			delete_text(all_text); signal(id,s_freeze_tree); tope_ESC=20; panel(); 
		END
	
		FRAME;
		
	END
	
END

//**************************************
// BRILLO WC
//**************************************

PROCESS brillo_wc();

BEGIN
	
	graph=505;
	
	x=22;
	y=200;
	z=-10;
	
	LOOP
	
		FRAME;
	
	END

END