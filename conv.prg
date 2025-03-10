//**************************************
// VENTANA DE CONVERSACIÓN
//**************************************

PROCESS vent_conv();

PRIVATE

	esc; // variable para indicar que escriba
	
BEGIN

	graph=200;
	x=160; y=198;
	z=-100;
	
	hayconv=1;
	
	signal(pr21,s_kill);
	IF (audio==0) soundchannel_pause(all_channel); sound_play(snd62,fxv,256); END
	
	LOOP
	
		IF (est_c==0) // CONV. CON GUARDIA 1/2
			pr30=cabeza_conv(202);
			tx1="Vaya mierda de tiempo no?";
			tx2="Y encima llevo un buen rato con un";
			tx3="apretón como la cabeza de un enano..."; 
			esc=3;
			est_c=1;
		END
		
		IF (est_c==2) // CONV. CON GUARDIA 2/2
			pr30=cabeza_conv(202);
			tx1="Oye.. Te importaria sustituírme un";
			tx2="momentito mientras yo voy a soltar";
			tx3="lastre?"; 
			tx4="Me harías un gran favor..";
			esc=4;
			est_c=2500;
		END
		
		IF (est_c==3) // RESPONDEMOS AL GUARDIA
			pr30=cabeza_conv(201);
			tx1="Sí claro, no tengo yo otra cosa que";
			tx2="hacer que quedarme aquí haciendo tu"; 
			tx3="trabajo.. ¡¡Aprieta el ojete!!";
			esc=3;
			est_c=4;
		END
		
		IF (est_c==5)
			pr30=cabeza_conv(202);
			tx1="Ya, supongo que es pedir mucho..";
			tx2="Pues nada, a apretar se ha dicho."; 
			tx3="Eso sí, no sé yo si llegaré al cambio de";
			tx4="turno sin cagarme..";
			esc=4;
			est_c=-1;
		END
		
		IF (est_c==6) // RESPONDEMOS AL GUARDIA
			pr30=cabeza_conv(201);
			tx1="No hay problema amigo.";
			tx2="Ve tranquilo, que yo me quedo aquí"; 
			tx3="vigilando el parking.";
			esc=3;
			est_c=7;
		END
		
		IF (est_c==8)
			pr30=cabeza_conv(202);
			tx1="Ufff! Gracias, mil gracias!";
			tx2="No tardo nada. Fijo que embozo el"; 
			tx3="retrete.. ¡¡Pensaré en ti mientras!!";
			esc=3;
			est_c=9;
		END
		
		// LANZAMOS EL SIMON - PARK
		IF (est_c==10) signal(id,s_kill_tree); launcher_simon(); transicion=1; 
			est_c=0; hayconv=0;
		END
			
		IF (est_c==2501) // OPCIONES DE RESPUESTA AL GUARDIA
			signal(son,s_kill_tree);
			tx1="- Claro. Ve a cagar, yo te cubro.";
			tx2="- Ni de broma.";
			esc=12;
			conv_arrow(20,173,2); est_c=10000;
		END
		
		IF (est_c==2504) // OPCIONES DE RESPUESTA AL PIJO DEL DESCAPOTABLE
			tx1="- A que se debe tanta alegría?";
			tx2="- Te han dicho lo tonto que eres?";
			tx3="- Esto.. Adiós!";
			esc=13;
			IF (sefijaenelcoche==1)
				tx3="- Es tuyo el descapotable del parking?";
				tx4="- Esto.. Adiós!";
				conv_arrow(20,173,4);
				esc=14;
			ELSE 
				conv_arrow(20,173,3);
			END
			est_c=10001;
		END
		
		IF (est_c==2506) // OPCIONES DE RESPUESTA RESPECTO AL DESCAPOTABLE DEL PIJO (AVISARLE O NO)
			tx1="- No es nada, solo se está inundando..";
			tx2="- Qué va, qué va, está perfectamente. =)";
			conv_arrow(20,173,2); est_c=10002;
			esc=12;
		END
		
		IF (est_c==2508) // OPCIONES DE RESPUESTA AL TIPO DE LA RULETA RUSA
			IF (euros>99)
				tx1="- Claro, ¿por qué no? ¡Apostemos!";
			ELSE
				tx1="- Ya me gustaría, pero no me alcanza.";
			END
			tx2="- No gracias, valoro mi vida.";
			tx3="- Háblame sobre ti..";
			IF (contador_conv_ruleta>2)
				tx4="- Oye, pues debería empezar a sonarte ya...";
				conv_arrow(20,173,4);
				esc=14;
			ELSE 
				conv_arrow(20,173,3);
				esc=13;
			END
			est_c=10003;
		END
		
		IF (est_c==2510) // OPCIONES DE RESPUESTA AL TIPO DE LA RULETA (SOBRE SU VIDA)
			tx1="- ¿Cómo te llamas?";
			tx2="- ¿A qué te dedicas?";
			tx3="- ¿En qué lugar se enamoró de ti?";
			tx4="- ¿Sabes? En realidad no me interesas tanto...";
			esc=14;
			conv_arrow(20,173,4); est_c=10004;
		END
		
		IF (est_c==2512) // OPCIONES DE RESPUESTA AL TAXISTA
			SWITCH (loc)
				CASE 4:
					tx1="- A la bolera";
					tx2="- A la barricada";
					tx3="- Al humódromo";
				END
				CASE 5:
					tx1="- Al bar";
					tx2="- A la bolera";
					tx3="- Al humódromo";
				END
			END
			tx4="- Me quedo aquí";
			esc=14;
			conv_arrow(20,173,4); est_c=10005;
		END
		
		IF (est_c==2513) // OPCIONES DE RESPUESTA A INDIANA JONES
			tx1="- Psst! Pssst!";
			tx2="- ¡Ey oye! ¡¿Estás bien?!";
			tx3="- ¡¡EY MIRA, LA ARCA PERDIDA!!";
			tx4="- Mejor lo dejo tranquilo..";
			esc=14;
			conv_arrow(20,173,4); est_c=10006;
		END
		
		IF (est_c==2515) // OPCIONES DE RESPUESTA A INDIANA JONES
			tx1="- Eres Indiana Jones, ¿verdad?";
			tx2="- ¿Qué haces aquí tirado?";
			tx3="- ¿Me prestas el látigo?";
			tx4="- Te dejo descansar";
			esc=14;
			conv_arrow(20,173,4); est_c=10007;
		END
		
		IF (est_c==500000) // OPCIONES DE RESPUESTA POR DEFECTO
			tx1="";
			tx2="";
			tx3="";
			tx4="";
			esc=14;
		END
		
		// OBSERVAMOS EL DESCAPOTABLE
		IF (est_c==13)
			pr30=cabeza_conv(201);
			tx1="Muy bonito el descapotable pero se";
			tx2="está poniendo toda la tapicería";
			tx3="perdida de agua!";
			esc=3;
			IF (sefijaenelcoche==0) sefijaenelcoche=1; END
			est_c=14;
		END
		
		IF (est_c==15)
			pr30=cabeza_conv(201);
			tx1="Eso sí, el muy cabrito ha aparcado en";
			tx2="una plaza de movilidad reducida sin";
			tx3="tener el cartel ni nada...";
			esc=3;
			est_c=16;
		END
		
		IF (est_c==17)
			pr30=cabeza_conv(201);
			tx1="Algunos ricachones se creen con el";
			tx2="derecho de hacer lo que les sale de";
			tx3="los cojones...";
			esc=3;
			est_c=-1;
		END
		
		// HABLAMOS CON EL CLIENTE DEL DESCAPOTABLE EN LA BARRA
		IF (est_c==18)
			pr30=cabeza_conv(203);
			tx1="Buenas noches pringao!";
			tx2="Cómo va con tu insignificante";
			tx3="existencia, eh?";
			tx4="Ay.. La vida es maravillosa!!";
			esc=4;
			est_c=2503;
		END
		
		IF (est_c==19)
			pr30=cabeza_conv(201);
			tx1="Vaya humos llevamos, no?";
			tx2="He roto costillas por menos, amigo...";
			tx3="¿Cómo es que estas tan eufórico?";
			esc=3;
			est_c=20;
		END
		
		IF (est_c==21)
			pr30=cabeza_conv(203);
			tx1="¡Pues se debe a que me ha tocado la";
			tx2="lotería hace un par de días!";
			tx3="¿Te parece suficiente motivo, pringao?";
			esc=3;
			est_c=22;
		END
		
		IF (est_c==23)
			pr30=cabeza_conv(201);
			tx1="Es un buen motivo, sin duda.";
			tx2="Lo que me pregunto es si ya eras así";
			tx3="de idiota antes de que te tocara.";
			tx4="Me temo que sí...";
			esc=4;
			est_c=2503;
		END
		
		IF (est_c==24)
			pr30=cabeza_conv(201);
			tx1="Es probable que ya te lo hayan dicho";
			tx2="antes pero...";
			tx3="Sabes que eres muuuu tonto??";
			esc=3;
			est_c=25;
		END
		
		IF (est_c==26)
			pr30=cabeza_conv(203);
			tx1="Pues sí, más de las que puedas contar";
			tx2="sin coger aire.";
			tx3="Pero aun así, soy más rico que tonto.";
			tx4="Imagina si tengo dinero!";
			esc=4;
			est_c=27;
		END
		
		IF (est_c==28)
			pr30=cabeza_conv(201);
			tx1="Ya te digo. Debes tener muchísimos,";
			tx2="pero que muchísimos millones...";
			esc=2;
			est_c=2503;
		END
		
		IF (est_c==29)
			pr30=cabeza_conv(201);
			tx1="Lamento tener que dejarte, pero tengo";
			tx2="clase de petanca...";
			esc=2;
			est_c=-1;
		END
		
		IF (est_c==30)
			pr30=cabeza_conv(201);
			tx1="¿Por casualidad no será tuyo el";
			tx2="descapotable que esta aparcado ahí";
			tx3="afuera en el parking?";
			esc=3;
			est_c=31;
		END
		
		IF (est_c==32)
			pr30=cabeza_conv(203);
			tx1="Sí, de quién si no? JA! JA! JA!";
			tx2="...Por qué?? Le ha pasado algo??";
			esc=2;
			est_c=2505;
		END
		
		IF (est_c==33)
			pr30=cabeza_conv(201);
			tx1="Bueno, nada... Solamente se esta";
			tx2="inundando debido a que no tienes la";
			tx3="capota puesta y está cayendo el";
			tx4="diluvio universal..";
			esc=4;
			est_c=34;
		END
		
		IF (est_c==35)
			pr30=cabeza_conv(203);
			tx1="No jodas!? Ahora mismo la pongo con";
			tx2="el mando...";
			tx3="Muchas gracias, pringao!";
			tx4="Toma esto como agradecimiento.";
			esc=4;
			suma_euros(90,140,200,fnt10,0);
			sefijaenelcoche=2;
			est_c=2503;
		END
		
		IF (est_c==36)
			pr30=cabeza_conv(201);
			tx1="No, nada, nada, en absoluto.";
			tx2="Está perfectamente. Sigue bebiendo,";
			tx3="tranquilo =)";
			esc=3;
			est_c=37;
		END
		
		IF (est_c==38)
			pr30=cabeza_conv(203);
			tx1="Ah bueno.. Me había asustado.";
			tx2="Ese coche tiene más valor para mí que";
			tx3="las vidas de todos los miserables de";
			tx4="este bar. JA! JA! JA! JA!";
			esc=4;
			est_c=2503;
		END

		// CONVERSACIÓN TIPO RULETA	
		IF (est_c==39)
			pr30=cabeza_conv(204);
			tx1="Hola forastero. Tu cara no me suena...";
			tx2="¿Te apetece jugártela a todo o nada?";
			tx3="Para jugar a la ruleta rusa la apuesta";
			tx4="mínima son 100€ ¿Qué me dices?";
			contador_conv_ruleta++;
			esc=4;
			est_c=2507;
		END
		
		IF (est_c==40)
			pr30=cabeza_conv(201);
			tx1="Pues mira que ya me gustaría, pero";
			tx2="es que no tengo 100€.";
			tx3="En otra ocasión tal vez..";
			esc=3;
			est_c=41;
		END
		
		IF (est_c==42)
			pr30=cabeza_conv(204);
			tx1="Es una lástima, pero aquí no se fía.";
			tx2="Vuelve cuando consigas esos 100 pavos.";
			tx3="Mientras llega el momento, te tendré";
			tx4="en mi cabeza. =)";
			esc=4;
			est_c=-1;
		END
		
		IF (est_c==43)
			pr30=cabeza_conv(201);
			tx1="Claro que sí, ¿por qué debería valorar";
			tx2="el privilegio de vivir y no jugarme los";
			tx3="putos sesos por unos cochinos y";
			tx4="miserables €uros..? ¡¡Vamos allá!!";
			esc=4;
			est_c=44;
		END
		
		IF (est_c==45)
			pr30=cabeza_conv(204);
			tx1="¡¡Así se habla campeón!!";
			tx2="¡Tener los sesos bien guardados dentro";
			tx3="del cráneo está sobrevalorado!";
			esc=3;
			est_c=46;
		END
		
		IF (est_c==47)
			signal(id,s_kill_tree); vent_peq(); est_vent=1; hayconv=0;
		END
		
		IF (est_c==48)
			pr30=cabeza_conv(201);
			tx1="Pues te pareceré un quisquilloso, pero";
			tx2="resulta que valoro esto de vivir...";
			tx3="Va a ser que no, pero gracias.";
			esc=3;
			est_c=49;
		END
		
		IF (est_c==50)
			pr30=cabeza_conv(204);
			tx1="Vaya... Una pena.";
			tx2="Vuelve cuando tengas agallas.";
			esc=2;
			est_c=-1;
		END
		
		IF (est_c==51)
			pr30=cabeza_conv(201);
			tx1="Oye tú, ¿Por qué no me cuentas algo";
			tx2="sobre tu vida?";
			esc=2;
			est_c=52;
		END
		
		IF (est_c==53)
			pr30=cabeza_conv(204);
			tx1="Claro, sin problema.";
			tx2="¿Qué quieres saber?";
			esc=2;
			est_c=2509;
		END
		
		IF (est_c==54)
			pr30=cabeza_conv(201);
			tx1="¿Cuál es tu nombre?";
			esc=1;
			est_c=55;
		END
		
		IF (est_c==56)
			pr30=cabeza_conv(204);
			tx1="Me llamo Francisco Casquillo Cascales.";
			tx2="Francisco se llamaba mi padre, y de";
			tx3="igual forma se llamaba mi abuelo.";
			tx4="Mi bisabuelo se llamaba Felipe...";
			esc=4;
			est_c=57;
		END
		
		IF (est_c==58)
			pr30=cabeza_conv(201);
			tx1="....Ahmmm...";
			tx2="..Apasionante oye.";
			tx3="..Y dime, ¿cómo es que tu bisabuelo se";
			tx4="llamaba Felipe?";
			esc=4;
			est_c=59;
		END
		
		IF (est_c==60)
			pr30=cabeza_conv(204);
			tx1="Bueno, él fue el que inició la tradición";
			tx2="de poner el nombre de Francisco. Le";
			tx3="gustaría el nombre, qué sé yo...";
			esc=3;
			est_c=2509;
		END
		
		IF (est_c==61)
			pr30=cabeza_conv(201);
			tx1="Dime, ¿te dedicas a algo más aparte de";
			tx2="pasarte el día aquí esperando a alguien";
			tx3="con quien volarte la cabeza?";
			esc=3;
			est_c=62;
		END
		
		IF (est_c==63)
			pr30=cabeza_conv(204);
			tx1="Pues no, la verdad. Provengo de una";
			tx2="familia de apostadores natos...";
			esc=2;
			est_c=64;
		END
		
		IF (est_c==65)
			pr30=cabeza_conv(201);
			tx1="De gilipollas natos querrás decir..";
			esc=1;
			est_c=66;
		END
		
		IF (est_c==67)
			pr30=cabeza_conv(204);
			tx1="Sí bueno, llámalo como quieras..";
			tx2="Pues eso, que me dedico exclusivamente";
			tx3="a esto. No es problema, porque en esta";
			tx4="ciudad tenemos un excelente equipo.. +";
			esc=4;
			est_c=68;
		END
		
		IF (est_c==69)
			pr30=cabeza_conv(204);
			tx1="..de urgencias y el hospital con el";
			tx2="equipamiento más moderno del mundo.";
			tx3="Estoy harto de volarme la tapa de los";
			tx4="sesos y que esos genios lo pongan.. +";
			esc=4;
			est_c=70;
		END
		
		IF (est_c==71)
			pr30=cabeza_conv(204);
			tx1="..todo en su sitio.";
			tx2="De hecho, el sindicato de suicidas de";
			tx3="la ciudad está muy molesto con esto.";
			tx4="Dicen que así no hay quien se mate...";
			esc=4;
			est_c=72;
		END
		
		IF (est_c==73)
			pr30=cabeza_conv(201);
			tx1="Vaya, pobrecitos ellos..";
			tx2="Bueno, me tranquiliza escuchar eso.";
			tx3="Espero no necesitar ese equipo tan";
			tx4="maravilloso, pero va bien saberlo.";
			esc=4;
			est_c=2509;
		END
		
		IF (est_c==74)
			pr30=cabeza_conv(201);
			tx1="....";
			tx2="..¿Y en qué lugar se enamoró de ti?";
			esc=2;
			est_c=75;
		END
		
		IF (est_c==76)
			pr30=cabeza_conv(204);
			tx1="....";
			tx2="..¿Perdona?";
			esc=2;
			est_c=77;
		END
		
		IF (est_c==78)
			pr30=cabeza_conv(201);
			tx1="...";
			tx2="¿No conoces a Perales..?";
			tx3="..Da igual, déjalo.";
			esc=3;
			est_c=2509;
		END
		
		IF (est_c==79)
			pr30=cabeza_conv(201);
			tx1="Bueno, ya está bien de preguntar,";
			tx2="tampoco quiero agobiarte..";
			esc=2;
			est_c=80;
		END
		
		IF (est_c==81)
			pr30=cabeza_conv(204);
			tx1="Sí eso, no me agobies, porque no tengo";
			tx2="la cabeza para muchas historias, como";
			tx3="comprenderás.. Muchas balas ya.";
			esc=3;
			est_c=-1;
		END
		
		IF (est_c==82)
			pr30=cabeza_conv(201);
			tx1="Oye, ya hemos hablado unas cuantas";
			tx2="veces..¿No deberías empezar a recordar";
			tx3="mi cara? ¿Qué te pasa? ¿Eres ciego?";
			tx4="¿O las balas te han jodido la memoria?";
			esc=4;
			est_c=83;
		END
		
		IF (est_c==84)
			pr30=cabeza_conv(204);
			tx1="Ey, ey, no te lo tomes mal, amigo...";
			tx2="En realidad, las dos cosas.";
			tx3="Solo conservo el 20% de visión de un";
			tx4="ojo, y mi memoria está algo jodida..";
			esc=4;
			est_c=2507;
		END
		
		// CONVERSACIÓN TAXISTA
		IF (est_c==85)
			pr30=cabeza_conv(205);
			tx1="¡¡BueEEenaAasSsSsSSh NoOochEeSsh!!";
			tx2="¿Hash llamado tú -hips!- a un tac..shi?";
			tx3="..Bueno.. shupongo que shí..";
			tx4="¿A -hips!- dónde te lliievo?";
			esc=4;
			est_c=2511;
		END
		
		IF (est_c==86)
			pr30=cabeza_conv(201);
			tx1="Disculpa, pero me lo he pensado mejor";
			tx2="y no voy a ningún sitio. Me bajo aquí.";
			esc=2;
			est_c=87;
		END
		
		IF (est_c==88)
			pr30=cabeza_conv(205);
			tx1="¡¿Jjquéee?! ¿Y para esshhto me..";
			tx2="-hips!- ..llamash?";
			tx3="La prrrocshima vessh.. shi me pillash";
			tx4="shobrio te meto una paliza...";
			esc=4;
			est_c=89;
		END
		
		IF (est_c==90)
			pr30=cabeza_conv(205);
			tx1="¡¡FUERA DE MI TAXSHI!!";
			esc=1;
			SWITCH (loc)
				CASE 4:
					est_c=-1; cont_taxi=0; est_taxi=50; 
				END
				CASE 5:
					est_c=-1; cont_taxi=0; est_taxi=0; transicion=2;
				END
			END
		END
		
		IF (est_c==91)
			pr30=cabeza_conv(201);
			tx1="A la zona de la barricada por favor.";
			destino=1; 
			esc=1;
			est_c=92;
		END
		
		IF (est_c==93)
			pr30=cabeza_conv(205);
			tx1="Por shupuesshto!! -hips!- VAMOOSSH!!";
			esc=1;
			est_c=-1; cont_taxi=0; est_taxi=55;
		END
		
		IF (est_c==94)
			pr30=cabeza_conv(201);
			tx1="Llévame al bar por favor.";
			esc=1;
			est_c=95;
		END
		
		IF (est_c==96)
			pr30=cabeza_conv(205);
			tx1="¡¡Puesh claro que shí!!";
			tx2="Y yoo.. ¡¡me bajo contigouu!!";
			destino=2;
			esc=2;
			est_c=97; cont_taxi=0;
		END
		
		IF (est_c==98)
			signal(id,s_kill_tree); est_c=0; hayconv=0;
			cont_taxi=0; est_taxi=57; fade(0,0,0,2); stop_song(); 
		END
		
		IF (est_c==200)
			pr30=cabeza_conv(201);
			tx1="A la bolera por favor.";
			esc=1;
			est_c=201;
		END
		
		IF (est_c==202)
			pr30=cabeza_conv(205);
			tx1="Puesh ya lo shiieento, peerouh el";
			tx2="manta del creador del.. juego..";
			tx3="..todavía no ha creado esha..";
			tx4="...localishashión, ¿shabes..?";
			esc=4;
			est_c=2511;
		END
		
		IF (est_c==400)
			pr30=cabeza_conv(201);
			tx1="Al humódromo si es tan amable.";
			esc=1;
			est_c=401;
		END
		
		IF (est_c==402)
			pr30=cabeza_conv(205);
			tx1="Puesh ya lo shiieento, peerouh el";
			tx2="manta del creador del.. juego..";
			tx3="..todavía no ha creado esha..";
			tx4="...localishashión, ¿shabes..?";
			esc=4;
			est_c=2511;
		END
		
		// CONVERSACIÓN CON INDIANA JONES
		IF (est_c==99)
			pr30=cabeza_conv(201);
			tx1="Psst! Pssst!";
			tx2="........";
			tx3="...¿Me oyes?";
			esc=3;
			est_c=100;
		END
		
		IF (est_c==101)
			tx1="........................";
			esc=1;
			est_c=102;
		END
		
		IF (est_c==103)
			pr30=cabeza_conv(201);
			tx1="...Pues va a ser que no..";
			esc=1;
			est_c=-1;
		END
		
		IF (est_c==104)
			pr30=cabeza_conv(201);
			tx1="¡Ey oye! ¡¿Estás bien?!";
			esc=1;
			est_c=105;
		END
		
		IF (est_c==106)
			tx1="........................";
			esc=1;
			est_c=107;
		END
		
		IF (est_c==108)
			pr30=cabeza_conv(201);
			tx1="...Bueno, dicen que quien calla otorga";
			tx2="¿no? Pues eso.";
			esc=2;
			est_c=-1;
		END
		
		IF (est_c==109)
			pr30=cabeza_conv(201);
			tx1="No lo voy a molestar. Parece que duerme";
			tx2="plácidamente en el suelo del parking..";
			esc=2;
			est_c=-1;
		END
		
		IF (est_c==110)
			pr30=cabeza_conv(201);
			tx1="¡¡¡MIRA, AHÍ ESTÁ LA ARCA PERDIDA!!!";
			esc=1;
			est_c=111;
		END
		
		IF (est_c==112)
			pr35.graph=126; pr35.z=-10;
			pr30=cabeza_conv(206);
			tx1="¡¡¿¿DÓNDE??!! ¡¡¿¿DÓOONDEE??!!";
			esc=1;
			est_c=2514;
		END
		
		IF (est_c==113)
			pr30=cabeza_conv(201);
			tx1="Te dejo descansando en tu cómoda";
			tx2="plaza de párking... ¡Hasta luego!";
			esc=2;
			est_c=114;
		END
		
		IF (est_c==115)
			pr30=cabeza_conv(206);
			tx1="Te lo agradezco. Apaga la luz al salir.";
			esc=1;
			est_c=-1;
		END
		
		IF (est_c==116)
			pr30=cabeza_conv(201);
			tx1="Oye, tú eres Indiana Jones ¿verdad?";
			tx2="El de las películas y los juegos de";
			tx3="Lucasfilms.";
			esc=3;
			est_c=117;
		END
		
		IF (est_c==118)
			pr30=cabeza_conv(206);
			tx1="Sí, el mismo que pixela y calza.";
			tx2="¿Y tú quién eres, y qué quieres?";
			tx3="¿No ves que estaba durmiendo?";
			esc=3;
			est_c=119;
		END
		
		IF (est_c==120)
			pr30=cabeza_conv(201);
			tx1="Bueno.. Yo soy el prota..";
			esc=1;
			est_c=121;
		END
		
		IF (est_c==122)
			pr30=cabeza_conv(206);
			tx1="¿¿El prota??";
			tx2="¿Qué clase de nombre es ese?";
			esc=2;
			est_c=123;
		END
		
		IF (est_c==124)
			pr30=cabeza_conv(201);
			tx1="...Bueno.. Es el nombre de mi proceso";
			tx2="en el código fuente..";
			tx3="Mi creador no se molestó en bautizarme.";
			esc=3;
			est_c=125;
		END
		
		IF (est_c==126)
			pr30=cabeza_conv(206);
			tx1="Bah.. o sea que no eres más que un";
			tx2="bastardo. Un bastardo jodiéndome el";
			tx3="sueño tan cojonudo que tenía.";
			esc=3;
			est_c=127;
		END
		
		IF (est_c==128)
			pr30=cabeza_conv(201);
			tx1="Vaya.. Lo siento..";
			tx2="¿Y qué estabas soñando?";
			esc=2;
			est_c=129;
		END
		
		IF (est_c==130)
			pr30=cabeza_conv(206);
			tx1="Nada en especial, pero me hacía feliz.";
			tx2="Un sucio bastardo muy parecido a ti se";
			tx3="tiraba a los coches que pasan por esa";
			tx4="misma carretera. Y el mundo mejoraba.";
			esc=4;
			est_c=131;
		END
		
		IF (est_c==132)
			pr30=cabeza_conv(201);
			tx1="Vale.. lo capto.";
			tx2="No estás de humor para preguntas.";
			esc=2;
			est_c=133;
		END
		
		IF (est_c==134)
			pr30=cabeza_conv(206);
			tx1="Eso es.";
			esc=1;
			est_c=2514;
		END
		
		IF (est_c==135)
			pr30=cabeza_conv(201);
			tx1="Si no es mucha indiscreción...";
			tx2="¿Qué haces durmiendo en el suelo?";
			esc=2;
			est_c=136;
		END
		
		IF (est_c==137)
			pr30=cabeza_conv(206);
			tx1="La es, pero te contestaré para que te";
			tx2="largues y me dejes en paz.";
			esc=2;
			est_c=138;
		END
		
		IF (est_c==139)
			pr30=cabeza_conv(206);
			tx1="Resulta que vine con el tito Lucas a";
			tx2="tomar unas copas, y no veas.. no hay";
			tx3="quien lo atrape. Además pagaba él..";
			esc=3;
			est_c=140;
		END
		
		IF (est_c==141)
			pr30=cabeza_conv(206);
			tx1="Bebimos mucho. Y Lo último que puedo";
			tx2="recordar es que contratamos a un par";
			tx3="de prostitutas disfrazadas de Chewaka";
			tx4="y Ewok.";
			esc=4;
			est_c=142;
		END
		
		IF (est_c==143)
			pr30=cabeza_conv(201);
			tx1="Uggh.. Cuánto pelo, ¿no?";
			esc=1;
			est_c=144;
		END
		
		IF (est_c==145)
			pr30=cabeza_conv(206);
			tx1="Y que lo digas, y más con George dentro";
			tx2="de la ecuación...";
			esc=2;
			est_c=146;
		END
		
		IF (est_c==147)
			pr30=cabeza_conv(206);
			tx1="Bueno, el caso es que no recuerdo mucho,";
			tx2="sencillamente nos pegamos una fiesta";
			tx3="épica y terminé tirado aquí, donde";
			tx4="intento quitarme esta maldita resaca.";
			esc=4;
			est_c=148;
		END
		
		IF (est_c==149)
			pr30=cabeza_conv(201);
			tx1="¿Y no estarías mejor en una cama?";
			esc=1;
			est_c=150;
		END
		
		IF (est_c==151)
			pr30=cabeza_conv(206);
			tx1="Bah, aquí estoy bien. No sabes dónde he";
			tx2="llegado a dormir chaval...";
			esc=2;
			est_c=152;
		END
		
		IF (est_c==153)
			pr30=cabeza_conv(206);
			tx1="He dormido en cementerios indios..";
			esc=1;
			est_c=154;
		END
		
		IF (est_c==155)
			pr30=cabeza_conv(206);
			tx1="..encima de calaveras malditas..";
			esc=1;
			est_c=156;
		END
		
		IF (est_c==157)
			pr30=cabeza_conv(206);
			tx1="..rodeado de lava volcánica..";
			esc=1;
			est_c=158;
		END
		
		IF (est_c==159)
			pr30=cabeza_conv(206);
			tx1="..acechado por salvajes caníbales..";
			esc=1;
			est_c=160;
		END
		
		IF (est_c==161)
			pr30=cabeza_conv(206);
			tx1="..sentado en sillas de tortura..";
			esc=1;
			est_c=162;
		END
		
		IF (est_c==163)
			pr30=cabeza_conv(206);
			tx1="..soportando temperaturas extremas..";
			esc=1;
			est_c=164;
		END
		
		IF (est_c==165)
			pr30=cabeza_conv(206);
			tx1="..dentro de nidos de serpientes..";
			esc=1;
			est_c=166;
		END
		
		IF (est_c==167)
			pr30=cabeza_conv(206);
			tx1="..bajo lluvias de flechas..";
			esc=1;
			est_c=168;
		END
		
		IF (est_c==169)
			pr30=cabeza_conv(206);
			tx1="..durante la huída de una roca gigante..";
			esc=1;
			est_c=170;
		END
		
		IF (est_c==171)
			pr30=cabeza_conv(206);
			tx1="..mientras los nazis me interrogaban..";
			esc=1;
			est_c=172;
		END
		
		IF (est_c==173)
			pr30=cabeza_conv(206);
			tx1="..bajándome de un tren en marcha..";
			esc=1;
			est_c=174;
		END
		
		IF (est_c==175)
			pr30=cabeza_conv(206);
			tx1="..resolviendo un acertijo histórico..";
			esc=1;
			est_c=176;
		END
		
		IF (est_c==177)
			pr30=cabeza_conv(206);
			tx1="..pilotando una avioneta..";
			esc=1;
			est_c=178;
		END
		
		IF (est_c==179)
			pr30=cabeza_conv(206);
			tx1="..atándome los cordones..";
			esc=1;
			est_c=180;
		END
		
		IF (est_c==181)
			pr30=cabeza_conv(206);
			tx1="..colgado del látigo..";
			esc=1;
			est_c=182;
		END
		
		IF (est_c==183)
			pr30=cabeza_conv(206);
			tx1="..en el menú de pausa..";
			esc=1;
			est_c=184;
		END
		
		IF (est_c==185)
			pr30=cabeza_conv(206);
			tx1="..en el suelo tras tropezar..";
			esc=1;
			est_c=186;
		END
		
		IF (est_c==187)
			pr30=cabeza_conv(201);
			tx1="¡Vale, vale!";
			tx2="Que tienes un sueño fácil, vamos..";
			esc=2;
			est_c=188;
		END
		
		IF (est_c==189)
			pr30=cabeza_conv(206);
			tx1="Eso es.";
			esc=1;
			est_c=2514;
		END
		
		IF (est_c==190)
			pr30=cabeza_conv(201);
			tx1="¿Me prestas el látigo?";
			tx2="Te lo devuelvo enseguida, de verdad.";
			esc=2;
			est_c=191;
		END
		
		IF (est_c==192)
			pr30=cabeza_conv(206);
			tx1="Te lo dejaría, pero es que no lo tengo.";
			tx2="Lo debi perder anoche, usándolo para";
			tx3="juegos sexuales en la orgía de pelo..";
			esc=3;
			est_c=193;
		END
		
		IF (est_c==194)
			pr30=cabeza_conv(201);
			tx1="Oh.. qué pena.";
			esc=1;
			est_c=2514;
		END
		
		IF (est_c==999)
			pr30=cabeza_conv(201);
			tx1="";
			tx2="";
			tx3="";
			tx4="";
			esc=4;
			est_c=1000;
		END
		
		// ESCRIBIMOS TEXTOS DE CONVERSACIÓN
		IF (esc>0 AND esc<10)
			SWITCH (esc)
				CASE 1: 
					write(fnt3,70,190,3,tx1);
				END
				CASE 2:
					write(fnt3,70,190,3,tx1);
					write(fnt3,70,207,3,tx2);
				END
				CASE 3:
					write(fnt3,70,173,3,tx1);
					write(fnt3,70,190,3,tx2);
					write(fnt3,70,207,3,tx3);
				END
				CASE 4:
					write(fnt3,70,173,3,tx1);
					write(fnt3,70,190,3,tx2);
					write(fnt3,70,207,3,tx3);
					write(fnt3,70,224,3,tx4);
				END
			END
			esc=0;
		END
		
		// ESCRIBIMOS TEXTOS DE OPCIONES DE CONVERSACIÓN
		IF (esc>10)
			SWITCH (esc)
				CASE 11:
					write(fnt3,30,173,3,tx1);
				END
				CASE 12:
					write(fnt3,30,173,3,tx1);
					write(fnt3,30,190,3,tx2);
				END
				CASE 13:
					write(fnt3,30,173,3,tx1);
					write(fnt3,30,190,3,tx2);
					write(fnt3,30,207,3,tx3);
				END
				CASE 14:
					write(fnt3,30,173,3,tx1);
					write(fnt3,30,190,3,tx2);
					write(fnt3,30,207,3,tx3);
					write(fnt3,30,224,3,tx4);
				END
			END
			esc=0;
		END
		
		// AVANZAMOS DE ESTADO
		IF (keydown(_ENTER) AND t_ENTER==0) 
			IF (est_c>0 AND est_c<5000)
				delete_text(all_text); signal(pr30,s_kill); est_c++;
				IF (audio==0) sound_play(snd62,fxv,200); END
				t_ENTER=1;
			END
		END
		
		// SALIMOS DEL PANEL DE CONVERSACIÓN, YA SEA PORQUE LLEGA AL FINAL
		// O PORQUE SE PULSA LA TECLA ESCAPE
		IF (keydown(_ENTER) AND t_ENTER==0 AND est_c==-1) 
			signal(all_process,s_wakeup);
			delete_text(all_text); t_ENTER=1; signal(id,s_kill_tree); hayconv=0;
			est_c=0;
			IF (audio==0) soundchannel_resume(all_channel); END
		END

		IF (keydown(_ESC) AND tope_ESC==0) tope_ESC=1; 
			IF (est_taxi>0) // En caso de ser una conversación con el taxista..
				IF (loc==4) // Parking
					cont_taxi=0; est_taxi=50;
				END
				IF (loc==5) // Barricada
					transicion=2;
				END
				cont_taxi=0;
			END
			IF (audio==0) sound_play(snd36,fxv,256); END
			signal(all_process,s_wakeup);
			delete_text(all_text); signal(id,s_kill_tree); hayconv=0; est_c=0;
			IF (audio==0) soundchannel_resume(all_channel); END
		END
	
		FRAME;
		
	END
	
END

//**************************************
// CABEZA DE VENTANA DE CONVERSACIÓN (pr30)
//**************************************

PROCESS cabeza_conv(graph);

BEGIN

	x=40; y=198;
	z=-101;
	
	LOOP
	
		FRAME;
		
	END
	
END