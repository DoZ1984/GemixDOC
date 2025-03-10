PROGRAM PNG_A_MAP;
BEGIN
SET_MODE(640,480,32);SET_FPS(60,0);
MKDIR("Origen_PNG");//creamos el directorio, por si decaso
CHDIR("Origen_PNG");//entramos en la carpeta
IF(GET_DIRINFO("*.png",_normal)>0);//escaneamos cuantos PNG hay en la carpeta
	CHDIR("..");//salimos de la carpeta
	MKDIR("Destino_MAP");//creamos el directorio, por si decaso
	X=320;Y=240;//cordenadas de centrado para ver la imagen
	WRITE(0,0,0,0,"TOTAL de PNG:"+ITOA(DIRINFO.FILES));//ver el numero de imagen que esta contando...
	REPEAT;//repito...
	    DRAW_TEXT(0,"Salvando MAP:"+ITOA(Z+1),0,0,10,-1);
		DRAW_TEXT(0,DIRINFO.NAME[Z],0,0,20,-1);
		GRAPH=LOAD_IMAGE("Origen_PNG/"+DIRINFO.NAME[Z]);//cargamos PNG
		FRAME;//mostramos en pantalla la imagen,centrada
		SAVE_MAP(0,GRAPH,"Destino_MAP/"+DIRINFO.NAME[Z]+".map");//salvamos la imagen como .map
		UNLOAD_IMAGE(GRAPH);//descargamos en la memoria la imagen
		Z++;
	UNTIL(Z==DIRINFO.FILES);//...si llegamos al final salimos
	EXIT(ITOA(Z)+" GRAFICOS PNG => CONVERTIDAS A .MAP  =)",0);//salimos con mensaje de completado
ELSE
	EXIT("NO HAY PNG PARA CONVERTIR =(",0);//salimos con mensaje de fallido
END
END
