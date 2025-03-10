//**************************************
// FLECHA DE SELECCIÓN DE CONVERSACIÓN
//**************************************

PROCESS conv_arrow(x,y,opciones);

PRIVATE

	pos;
	del; // para eliminar el proceso

BEGIN

	graph=199;
	size=50;
	z=-101;
	
	LOOP
	
		IF (keydown(_down) AND s1==0) s1=1; pos++; 
			IF (audio==0) sound_play(snd37,fxv,256); END
		END		
		IF (keydown(_up) AND s1==0) s1=1; pos--; 
			IF (audio==0) sound_play(snd37,fxv,256); END
		END
		
		SWITCH (opciones)
			CASE 1:
				IF (pos!=0) pos=0; END
			END
			CASE 2:
				IF (pos>1) pos=0; END
				IF (pos<0) pos=1; END
			END
			CASE 3:
				IF (pos>2) pos=0; END
				IF (pos<0) pos=2; END
			END
			CASE 4:
				IF (pos>3) pos=0; END
				IF (pos<0) pos=3; END
			END
		END
		
		// SONIDO DE SELECCIÓN (ENTER)
		IF (keydown(_ENTER) AND t_ENTER==0 AND audio==0) sound_play(snd39,fxv,256); sound_play(snd62,fxv,200); END
		
		IF (est_c==10000) // PETICIÓN DE SUSTITUCIÓN DEL GUARDIA
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) est_c=6; END // Aceptamos (arrancamos Simon-Park)
				IF (pos==1) est_c=3; END // Nos negamos (salimos)
				delete_text(all_text); del=1;
			END
		END
		
		IF (est_c==10001) // CONVERSACIÓN CON PIJO DEL DESCAPOTABLE
			IF (sefijaenelcoche==0 OR sefijaenelcoche==2)
				IF (keydown(_ENTER) AND t_ENTER==0)
					IF (pos==0) est_c=19; END // A qué se debe tanta alegría?
					IF (pos==1) est_c=24; END // Sabes que eres mu tonto?
					IF (pos==2) est_c=29; END // Tengo que irme
					delete_text(all_text); del=1;
				END
			END
			IF (sefijaenelcoche==1)
				IF (keydown(_ENTER) AND t_ENTER==0);
					IF (pos==0) est_c=19; END // A qué se debe tanta alegría?
					IF (pos==1) est_c=24; END // Sabes que eres mu tonto?
					IF (pos==2) est_c=30; END // Es tuyo el descapotable?
					IF (pos==3) est_c=29; END // Tengo que irme
					delete_text(all_text); del=1;
				END
			END
		END
		
		// DECIDIMOS QUÉ LE DECIMOS SOBRE LA INUNDACIÓN DEL DESCAPOTABLE AL PIJO MILLONARIO
		IF (est_c==10002) 
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) est_c=33; END // Se está inundando tu coche
				IF (pos==1) est_c=36; END // No le pasa nada
				delete_text(all_text); del=1;
			END
		END
		
		// CONTESTAMOS AL TIPO DE LA RULETA
		IF (est_c==10003)
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) // Sí claro, juguemos
					IF (euros>99) est_c=43;
					ELSE
						est_c=40;
					END
				END
				IF (pos==1) est_c=48; END // No gracias, valoro vivir
				IF (pos==2) est_c=51; END // Cuéntame algo sobre ti
				IF (pos==3) est_c=82; END // No debería sonarte ya mi cara??
				delete_text(all_text); del=1;
			END
		END
		
		// CONTESTAMOS AL TIPO DE LA RULETA (PREGUNTAS SOBRE SU VIDA)
		IF (est_c==10004)
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) est_c=54; END // ¿Cómo te llamas?
				IF (pos==1) est_c=61; END // ¿A qué te dedicas?
				IF (pos==2) est_c=74; END // En qué lugar se enamoró de ti?
				IF (pos==3) est_c=79; END // Fin de las preguntas
				delete_text(all_text); del=1;				
			END
		END
		
		// ESCOGEMOS DESTINO EN EL TAXI
		IF (est_c==10005)
			IF (keydown(_ENTER) AND t_ENTER==0)
				SWITCH (loc)
					CASE 4:
						IF (pos==0) est_c=200; END // Bolera
						IF (pos==1) est_c=91; END // Barricada
						IF (pos==2) est_c=400; END // Humódromo
					END
					CASE 5:
						IF (pos==0) est_c=94; END // Al bar
						IF (pos==1) est_c=200; END // Bolera
						IF (pos==2) est_c=400; END // Humódromo
					END
				END
				IF (pos==3) est_c=86; END // Bajarse
				delete_text(all_text); del=1;
			END
		END
		
		// HABLAMOS CON INDIANA JONES
		IF (est_c==10006)
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) est_c=99; END // Psst! Pssst!
				IF (pos==1) est_c=104; END // ¡Ey oye! ¡¿Estás bien?!
				IF (pos==2) est_c=110; END // ¡¡MIRA, LA ARCA PERDIDA!!
				IF (pos==3) est_c=109; END // Mejor lo dejo tranquilo..
				delete_text(all_text); del=1;				
			END
		END			
		
		IF (est_c==10007)
			IF (keydown(_ENTER) AND t_ENTER==0)
				IF (pos==0) est_c=116; END // Oye, tú eres Indiana Jones, ¿verdad?
				IF (pos==1) est_c=135; END // ¿Qué haces durmiendo en el suelo?
				IF (pos==2) est_c=190; END // ¿Me dejas el látigo?
				IF (pos==3) est_c=113; END // Te dejo descansar
				delete_text(all_text); del=1;				
			END
		END			
		
		// MOVEMOS LA FLECHA SEGÚN POSICIÓN
		IF (pos==0) y=173; END
		IF (pos==1) y=190; END
		IF (pos==2) y=207; END
		IF (pos==3) y=224; END
		
		IF (keydown(_ENTER)) t_ENTER=1; END
		
		// LIBERAMOS EL TOPE
		IF (NOT keydown(_up) AND NOT keydown(_down) AND s1==1) s1=0; END
		
		// HACEMOS EL BREAK A TRAVES DE "DEL"
		IF (del==1) BREAK; END
		
		FRAME;
		
	END
	
END
