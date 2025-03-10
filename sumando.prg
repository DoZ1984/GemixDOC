//**************************************
// + €UROS
//**************************************

PROCESS suma_euros(x,y,cant_euros,fnt,flags);

PRIVATE

	t1; // texto de -€UROS
	cont;
	
BEGIN

	t1=write(fnt,x,y,4,"+"+itoa(cant_euros)+"€");
	//text_fix(t1,true);
	IF (flags==1) text_lock(t1); text_set_flags(t1,4); END
	
	LOOP
		
		cont++;
		move_text(t1,x,y-=1);
		IF (cont==18)
			euros+=cant_euros; cant_euros=0;
			//text_fix(t1,false);
			delete_text(t1); BREAK;
		END
	
		FRAME;
		
	END
	
END	

//**************************************
// - €UROS
//**************************************

PROCESS resta_euros(x,y,cant_euros,fnt,flags);

PRIVATE

	t1; // texto de -€UROS
	cont;
	
BEGIN

	t1=write(fnt,x,y,4,"-"+itoa(cant_euros)+"€");
	//text_fix(t1,true);
	IF (flags==1) text_lock(t1); text_set_flags(t1,4); END
	
	LOOP
		
		cont++;
		move_text(t1,x,y-=1);
		IF (cont==18)
			euros-=cant_euros; cant_euros=0;
			//text_fix(t1,false);
			delete_text(t1); BREAK;
		END
	
		FRAME;
		
	END
	
END		

//**************************************
// + GLOBAL SCORE
//**************************************

PROCESS suma_gscore(x,y,cant_gscore,fnt,flags);

PRIVATE

	t1; // texto de +GSCORE
	cont;
	
METHODS

	METHOD CALLBACK INITIALIZE()
	
		BEGIN
		
			t1=write(fnt,x,y,4,"+"+itoa(cant_gscore)+" SCORE!");
			
		END

	METHOD CALLBACK FINALIZE()
		
		BEGIN
			
			delete_text(t1);
		
		END
	
BEGIN

	IF (flags==1) text_lock(t1); text_set_flags(t1,4); END
	
	LOOP
		
		cont++;
		move_text(t1,x,y-=1);
		IF (cont==18)
			gscore+=cant_gscore; cant_exp=0;
			delete_text(t1); BREAK;
		END
	
		FRAME;
		
	END
	
END		

//**************************************
// + EXP
//**************************************

PROCESS suma_exp(x,y,cant_exp,fnt,flags);

PRIVATE

	t1; // texto de +EXP
	cont;

BEGIN

	t1=write(fnt,x,y,4,"+"+itoa(cant_exp)+" EXP!");
	//text_fix(t1,true);
	IF (flags==1) text_lock(t1); text_set_flags(t1,4); END
	
	LOOP
		
		cont++;
		move_text(t1,x,y-=1);
		IF (cont==18)
			expe+=cant_exp; cant_exp=0;
			//text_fix(t1,false);
			delete_text(t1); BREAK;
		END
	
		FRAME;
		
	END
	
END		