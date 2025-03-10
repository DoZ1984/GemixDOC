			*** DOC STRINGS.DLL de funciones nuevas en Gemix ***

* ASCCODE(byte ascii)
  CHR(byte ascii)
	Devuelve el carácter del ASCII pasado.
	ej:
	asccode(65) <- devuelve "A"
	chr(65)     <- devuelve "A"
	asccode(32) <- devuelve " "
	chr(32)     <- devuelve " "

* ATOI(string str)
	Convierte una cadena en un número entero.
	NOTA: si la cadena contiene caracteres que no son números devuelve 0
	ej:
	atoi("100")   <- devuelve 100
	atoi("-100")  <- devuelve -100
	atoi("-100a") <- devuelve 0

* BTOI(string str)
	Convierte una cadena en un número binario.
	NOTA: si la cadena tiene caracteres no numéricos o diferentes de 0 o 1 devuelve 0	      
        ej:
	btoi("100")   <- devuelve 1100100
	btoi("-100")  <- devuelve 111111111111111110011100
	btoi("-100a") <- devuelve 0

* CALCULATE()
	Ver la DOC de DIV2

* CHAR(string str)
* ASC(string str)
	Devuelve el código ASCII del carácter pasado.
	ej:
	char("A") <- devuelve 65
	asc("A")  <- devuelve 65
	char(" ") <- devuelve 32
	asc(" ")  <- devuelve 32

* ISALNUM(string char)
	Devuelve 1 si char es un carácter del alfabeto o un número (0 to 9 o a to z o A to Z) 
	0 si no.
	ej:
	isalnum("3") <- devuelve 1
	isalnum("g") <- devuelve 1
	isalnum("G") <- devuelve 1
	isalnum(",") <- devuelve 0

* ISALPHA(string char)
	Devuelve 1 si char es un carácter del alfabeto (a to z o A to Z) 0 si no.
	ej:
	isalpha("1") <- devuelve 0
	isalpha(".") <- devuelve 0
	isalpha("b") <- devuelve 1
	isalpha("C") <- devuelve 1

* ISBINDIGIT(string char)
	Devuelve 1 si char es un carácter binario (0 o 1) 0 si no.
	ej:
	isbindigit("A") <- devuelve 0
	isbindigit("1") <- devuelve 1

* ISDIGIT(string char)
	Devuelve 1 si char es un carácter numérico (0 to 9) 0 si no.
	ej:
	isdigit("A") <- devuelve 0
	isdigit("1") <- devuelve 1

* ISLOWER(string char)
	Devuelve 1 si char está en minúsculas o 0 si no.
	ej:
	islower("G") <- devuelve 0
	islower("g") <- devuelve 1

* ISNUMDIGIT(int num)
	Devuelve 1 si num es un valor ASCII entre 48 y 57 ("0" to "9"), 0 si no.
	ej:
	isnumdigit(65) <- devuelve 0
	isnumdigit(55) <- devuelve 1

* ISOCTDIGIT(string char)
	Devuelve 1 si char es un carácter octal (0 to 7), 0 si no.
	ej:
	isoctdigit("8") <- devuelve 0
	isoctdigit("7") <- devuelve 1

* ISSTRALNUM(string str)
	Devuelve 1 si str contiene caracteres del alfabeto o números (0 to 9 o a to z o A to Z)
	0 si no.
	ej:
	isstralnum("Gemix")    <- devuelve 1
	isstralnum("gemix")    <- devuelve 1
	isstralnum("gemix01")  <- devuelve 1
	isstralnum("gemix 01") <- devuelve 0

* ISSTRALNUMSPACE(string str)
	Devuelve 1 si str contiene caracteres del alfabeto, números o espacios 
	(" " o 0 to 9 o a to z o A to Z) 0 si no.
	ej:
	isstralnumspace("Gemix")     <- devuelve 1
	isstralnumspace("gemix")     <- devuelve 1
	isstralnumspace("gemix 01")  <- devuelve 1
	isstralnumspace("gemix 0.1") <- devuelve 0

* ISSTRALPHA(string str)
	Devuelve 1 si str contiene caracteres del alfabeto (a to z o A to Z), 0 si no.
	ej:
	isstralpha("100%")     <- devuelve 0
	isstralpha("Gemix.")   <- devuelve 0
	isstralpha("gemix")    <- devuelve 1
	isstralpha("Compiler") <- devuelve 1

* ISSTRBINDIGIT(string str)
	Devuelve 1 si str contiene un número binario, 0 si no.
	ej:
	isstrbindigit("100%")    <- devuelve 0
	isstrbindigit("100.0.0") <- devuelve 0
	isstrbindigit(".100")    <- devuelve 0
	isstrbindigit("1001100") <- devuelve 1
	isstrbindigit("100")     <- devuelve 1

* ISSTRDIGIT(string str)
	Devuelve 1 si str contiene un número (int, float o double), 0 si no.
	ej:
	isstrdigit("100%")    <- devuelve 0
	isstrdigit("100.0.0") <- devuelve 0
	isstrdigit(".100")    <- devuelve 0
	isstrdigit("100.0")   <- devuelve 1
	isstrdigit("100")     <- devuelve 1

* ISSTRLOWER(string str)
	Devuelve 1 si str contiene SOLO letras minúsculas, 0 si no.
	ej:
	isstrlower("Gemix")  <- devuelve 0
	isstrlower("gemix.") <- devuelve 0
	isstrlower("gemix")  <- devuelve 1

* ISSPACE(string char)
	Devuelve 1 si char es un espacio (" "), 0 si no.
	ej:
	isspace("g") <- devuelve 0
	isspace(".") <- devuelve 0
	isspace(" ") <- devuelve 1

* ISSTROCTDIGIT(string str)
	Devuelve 1 si str contiene un número octal, 0 si no.
	ej:
	isstroctdigit("100%")    <- devuelve 0
	isstroctdigit("100.0.0") <- devuelve 0
	isstroctdigit(".100")    <- devuelve 0
	isstroctdigit("1301160") <- devuelve 1
	isstroctdigit("1007")    <- devuelve 1

* ISSTRHEXDIGIT(string str)
	Devuelve 1 si str contiene un número hexadecimal, 0 si no.
	ej:
	isstrhexdigit("100%")    <- devuelve 0
	isstrhexdigit("100.0.0") <- devuelve 0
	isstrhexdigit(".100")    <- devuelve 0
	isstrhexdigit("1001100") <- devuelve 1
	isstrhexdigit("0xFF")    <- devuelve 1

* ISSIMB(string char)
	Devuelve 1 si char es uno de los siguientes caracteres: 
	( !"#$%&'()*+,-.:;<=>?@[\]^_`{|}¿¡ )" 0 si no.
	ej:
	issimb("g") <- devuelve 0
	issimb("3") <- devuelve 0
	issimb("@") <- devuelve 1

* ISSTRSIMB(string str)
	Devuelve 1 si str contiene al menos uno de los siguientes caracteres: 
	( !"#$%&'()*+,-.:;<=>?@[\]^_`{|}~¿¡ )," 0 si no.
	ej:
	isstrsimb("Gemix Compiler") <- devuelve 0
	isstrsimb("3emix Compiler") <- devuelve 0
	isstrsimb("Gemix C@mpiler") <- devuelve 1

* ISSTRSPACE(string str)
	Devuelve 1 si str contiene al menos un espacio (" "), 0 si no.
	ej:
	isstrpace("Gemix")          <- devuelve 0
	isstrpace("Compiler")       <- devuelve 0
	isstrpace("Gemix Compiler") <- devuelve 1

* ISSTRUPPER(string str)
	Devuelve 1 si str contiene SOLO letras mayúsculas, 0 si no.
	ej:
	isstrupper("Gemix")  <- devuelve 0
	isstrupper("GEMIX.") <- devuelve 0
	isstrupper("GEMIX")  <- devuelve 1

* ISUPPER(string char)
	Devuelve 1 si char está en mayusculas, 0 si no.
	ej:
	isupper("g") <- devuelve 0
	isupper("G") <- devuelve 1

* ISHEXDIGIT(string char)
	Devuelve 1 si char es un carácter hexadecimal (0 to 9,A to F,a to f), 0 si no.
	ej:
	ishexdigit("G") <- devuelve 0
	ishexdigit("F") <- devuelve 1

* ISHEXLOWER(string char)
	Devuelve 1 si char es un carácter hexadecimal MAYÚSCULA (A to F), 0 si no.
	ej:
	ishexlower("f") <- devuelve 0
	ishexlower("F") <- devuelve 1

* ISHEXUPPER(string char)
	Devuelve 1 si char es un carácter hexadecimal MINÚSCULA (a to f), 0 si no.
	ej:
	ishexupper("F") <- devuelve 0
	ishexupper("f") <- devuelve 1

* ITOA(int num)
	Convierte el int en una cadena.
	ej:
	itoa(100)  <- devuelve "100"
	itoa(-300) <- devuelve "-300"

* ITOB(int num)
	Convierte el int en una cadena de numeros binarios.
	ej:
	itob(100)  <- devuelve "1100100"
	itob(-300) <- devuelve "11111111111111111111111011010100"

* LOWER()
	Ver la DOC de DIV2

* STRCAT(string dst, string src)
	Ver la DOC de DIV2
	
* STRCATNUMS(string dst, int num1, int num2, int mode1, int mode2)
	Concatena los dos num1 y num2 en la cadena dst y devuelve la cadena dst
	NOTA:
	si mode1 es 0 y num1 es negativo la cadena tendrá un número positivo
	si mode1 es 1 y num1 es negativo la cadena tendrá un número negativo
	si mode2 es 0 y num2 es negativo la cadena tendrá un número positivo
	si mode2 es 1 y num2 es negativo la cadena tendrá un número negativo
	ej:
	strcatnums(txt,  10,  24, 0, 0) <- devuelve "1024"
	strcatnums(txt, -10,  24, 0, 0) <- devuelve "1024"
	strcatnums(txt, -10,  24, 1, 0) <- devuelve "-1024"
	strcatnums(txt,  10, -24, 0, 0) <- devuelve "1024"
	strcatnums(txt, -10,  24, 1, 0) <- devuelve "-1024"
	strcatnums(txt,  10, -24, 1, 0) <- devuelve "1024"
	strcatnums(txt, -10,  24, 0, 1) <- devuelve "1024"
	strcatnums(txt,  10, -24, 0, 1) <- devuelve "-1024"
	strcatnums(txt, -10, -24, 0, 0) <- devuelve "1024"
	strcatnums(txt, -10, -24, 1, 0) <- devuelve "-1024"
	strcatnums(txt, -10, -24, 0, 1) <- devuelve "-1024"
	strcatnums(txt, -10, -24, 1, 1) <- devuelve "-1024"
	strcatnums(txt,   0,   0, 0, 0) <- devuelve "00"

* STRCATREV(string dst, string src)
	Concatena la cadena src al revés en la cadena dst y devuelve la nueva cadena,
	ej:
	strcatrev("Gemix ", "relipmoC") <- devuelve "Gemix Compiler"

* STRCHR(string str, string char)
	Ver la DOC de DIV2

* STRCHRCOUNT(string str, string chr)
	Devuelve el número de chr presentes en str, 0 si no hay.
	ej:
	strchrcount("Gemix Compiler", "e") <- devuelve 2

* STRCMP(string str1, string str2)
	Ver la DOC de DIV2

* STRCPY(string dst, string src)
	Ver la DOC de DIV2

* STRCPYREV(string dst, string src)
	Copia la cadena src al revés en la cadena dst y devuelve dst
	ej:
	strcpyrev("Gemix", "relipmoC ") <- devuelve "Gemix Compiler"

* STRCHRTOCHR(string str, string char, string charNEW)
	Sustituye los char presentes en str con los charNEW y devuelve str
	ej:
	strchrtochr("Gamix Compilar", "a", "e") <- devuelve "Gemix Compiler"

* STRCHRSTR(string str1, string str2, string char)
	Escribe en str1 en la misma posición de los caracteres iguales a char presentes en str2
	y devuelve el número de caracteres escritos, 0 sino
	NOTA: -si str1 es más pequeña que str2 y aun quedan caracteres char por escribir, 
	       no seran escritos. 	
	      -si str1 no es una variable string, sino una cadena, la función no escribe nada y
               devuelve 0.
	      -si str2 es NULL ("") no viene escrito nada en la cadena str1 y la función devuelve 0
	      -si char es NULL ("") no viene escrito nada en la cadena str1 y la función devuelve 0
	ej:
	string txt="-------------";
	string txt2[4]="-----";	
	strchrstr(txt , "Gemix Compiler", "e") <- devuelve 2 y txt  = "-e---------e-"
	strchrstr(txt2, "Gemix Compiler", "e") <- devuelve 1 y txt2 = "-e---"
	strchrstr(txt , "Gemix Compiler", "a") <- devuelve 0 y txt  = "-------------"
	strchrstr(""  , "Gemix Compiler", "e") <- devuelve 0
	strchrstr(txt , "Gemix Compiler", "" ) <- devuelve 0

* STRNEQCHRS(string str1, string str2)
	Devuelve el número de caracteres diferentes entre str1 y str2
	ej:
	strneqchrs("Gemix", "Gemix")          <- devuelve 0
	strneqchrs("Gemix Compiler", "Gemix") <- devuelve 9
	strneqchrs("Gemix", "Compiler")       <- devuelve 7
	strneqchrs("Gemix", "DIVCompiler")    <- devuelve 11

* STRDEL()
	Ver la DOC de DIV2

* STRDELCHR(string str, string strchar)
	Devuelve:
	-1 si las cadenas str o strchar están vacias
	 0 si no encuentra caracteres strchar en la cadena str
	+N si encuentra N caracteres strchar en la cadena str
	Esta función modifica la cadena original quitando todos los strchar que encuentra.
	ej:
	strdelchr("", "g")                 <- devuelve -1
	strdelchr("Gemix Compiler", "")    <- devuelve -1
	strdelchr("Gemix Compiler", "a")   <- devuelve  0 y str = "Gemix Compiler"
	strdelchr("Gemix Compiler", "e")   <- devuelve  2 y str = "Gmix Compilr"
	strdelchr("Gemix Compiler", "eio") <- devuelve  5 y str = "Gmx Cmplr"

* STRNEQLEN(string str1, string str2)
	Devuelve:
	-N si los caracteres de str1 son menores que str2
	 0 si los caracteres de str1 son iguales a str2
	+N si los caracteres de str1 son mayores que str2 
	ej:
	strneqlen("Gemix", "Gemix Compiler")    <- devuelve -9
	strneqlen("Gemix", "Gemix")             <- devuelve  0
	strneqlen("Gemix Compiler", "Compiler") <- devuelve  5

* STRDUP(byte char, int num)
	Devuelve una cadena de num char.
	NOTA: si num es menor o igual a 0, se crea una cadena de 256 caracteres
	      si char es 0 se devuelve una cadena null.
	ej:
	strdup(103, 5)  <- devuelve "ggggg"
	strdup(0, 3)    <- devuelve ""
	strdup(103, -1) <- devuelve "ggggg......."

* STRFMT(string fmt, int num)
	Devuelve una cadena formateada por la cadena fmt y num.
	NOTA: para hacer un format se debe utilizar el caracter "#" y:
	    - si los "#" son menores que los dígitos de num se visualizarán solo los últimos
	      digitos de num
	    - si los "#" son mayores que los dígitos de num se visualizarán 0
	ej:
	strfmt("###%", 10)  			      <- devuelve "010%"
	strfmt("###%", 100) 			      <- devuelve "100%"
	strfmt("Gemix ###% of ###% Language", 100100) <- devuelve "Gemix 100% of 100% Language"  
	strfmt("Score: ###,###,###", 100000000)       <- devuelve "Score: 100,000,000"
	strfmt("Score: #########",10000)	      <- devuelve "Score: 000010000"

* STRLEN(string str)
	Ver la DOC de DIV2

* STRLFT(string str, int num)
	Devuelve una cadena con los primeros num caracteres de str.
	NOTA: si num es 0 la cadena devuelta sera ""
	      si num es menor que 0 la cadena devuelta sera la str intera
	ej:
	strlft("Gemix Compiler",  5) <- devuelve "Gemix"
	strlft("Gemix Compiler",  0) <- devuelve ""
	strlft("Gemix Compiler", -1) <- devuelve "Gemix Compiler"

* STRLTRM(string str)
	Devuelve una copia de str sin espacios iniciales.
	ej:
	strltrm("  Gemix Compiler") <- devuelve "Gemix Compiler"

* STRMID(string str, int start, int length)
	Devuelve una cadena de length caracters de str a partir de start.
	NOTA: si start es igual o menor que 0 la copia se hará desde el primer caracter de str 
	      si length es igual a 0 la cadena str y devuelta será ""
	      si length es menor que 0 se copiará todo str	      
	ej:
	strmid("Gemix Compiler",  1,  7) <- devuelve "Gemix C"
	strmid("Gemix Compiler",  3,  3) <- devuelve "mix"	
	strmid("Gemix Compiler",  7, -3) <- devuelve "Compiler"	
	strmid("Gemix Compiler", -3,  0) <- devuelve ""	
	strmid("Gemix Compiler", -3,  1) <- devuelve "G"	
	strmid("Gemix Compiler",  1, -3) <- devuelve "Gemix Compiler"	
	strmid("Gemix Compiler", -1, -3) <- devuelve "Gemix Compiler"	
	strmid("Gemix Compiler",  0, -3) <- devuelve "Gemix Compiler"	

* STRNCAT(string dst, string src, int num)
	Concatena los primeros num caracteres de src en dst y devuelve dst.
	NOTA: si num es menor que 0 se concatena toda src
	ej:
	strncat("Gemix ", "Compiler",  4) <- devuelve "Gemix Comp"
	strncat("Gemix ", "Compiler",  0) <- devuelve "Gemix "
	strncat("Gemix ", "Compiler", -1) <- devuelve "Gemix Compiler"
	
* STRNCHR(string str, string char, int num)
	Busca un char en los primeros num de str y devuelve la posición del char en la cadena o 
	-1 si no esta.
	NOTA: si num es menor que 0 se busca en toda str
	ej:
	strnchr("Gemix Compiler", "C",  7) <- devuelve 6
	strnchr("Gemix Compiler", "C",  4) <- devuelve -1
	strnchr("Gemix Compiler", "a", -1) <- devuelve -1

* STRNCMP(string str1, string str2, int num)
	Devuelve:
	-1 si los primeros num caracteres de str1 son menores que str2
	 0 si los primeros num caracteres de str1 son iguales que str2
	 1 si los primeros num caracteres de str1 son mayores que str2
	NOTA: si num es menor que 0 se confrontan todos los caracteres de str1
	ej:
	strncmp("GEMIX", "gEMIX",  3) <- devuelve -1
	strncmp("Gemix", "Gemix", -1) <- devuelve  0
	strncmp("gEMIX", "gEMIX",  4) <- devuelve  0
	strncmp("gEMIX", "GEMIX",  4) <- devuelve  1

* STRNCPY(string dst, string src, int num)
	Copia los primeros num caracteres de src en dst y devuelve dst.
	NOTA: si num es menor que 0 se copiará toda src
	ej:
	strncpy("Gemix", "Compiler",  3) <- devuelve "Com"
	strncpy("Gemix", "Compiler",  0) <- devuelve ""
	strncpy("Gemix", "Compiler", -1) <- devuelve "Compiler"

* STRNSET(string str, string char, int num)
	Cambia num caracteres de str con char y devuelve str
	NOTA: si num es menor que 0 se cambia toda str
	ej:
	strnset("Gemix Compiler", "*",  5) <- devuelve "***** Compiler"
	strnset("Gemix Compiler", "*",  0) <- devuelve ""
	strnset("Gemix Compiler", "*", -1) <- devuelve "**************"
 	
* STRNSTR(string str, string substr, int num)
	Busca una substr en los primeros num caracteres de str y devuelve la posición si 
	la encuentra o -1 si no.
	NOTA: si num es menor que 0 se buscará en toda la str
	ej:
	strnstr("Gemix Compiler", "ix",  5) <- devuelve  3
	strnstr("Gemix Compiler", "ix",  3) <- devuelve -1
	strnstr("Gemix Compiler", "ix",  0) <- devuelve  3
	strnstr("Gemix Compiler", "ix", -1) <- devuelve -1
	strnstr("Gemix Compiler", "ix",  4) <- devuelve -1

* STRTOKCOUNT(string str)
	Devuelve el número de palabras en la str
	ej:
	strtokcount("Gemix")          <- devuelve 1
	strtokcount("Gemix Compiler") <- devuelve 2

* STRRHT(string str, int num)
	Devuelve una cadena con los últimos num caracteres de str.
	NOTA: si num es 0 la cadena devuelta será ""
	      si num es menor que 0 la cadena devuelta será tada la str
	ej:
	strrht("Gemix Compiler",  4) <- devuelve "iler"
	strrht("Gemix Compiler",  0) <- devuelve ""
	strrht("Gemix Compiler", -1) <- devuelve "Gemix Compiler"

* STRRTRM(string str)
	Devuelve una copia de str sin espacios finales.
	ej:
	strrtrm("Gemix Compiler  ") <- devuelve "Gemix Compiler"

* STRREV(string str)
	Invierte los caracteres de str y la devuelve.
	ej:
	strrev("relipmoC ximeG") <- devuelve "Gemix Compiler"

* STRDUPCOUNT(string str, int num)
	Devuelve una cadena de num str.
	NOTA: si num es menor o igual que 0 se creará una cadena de 256 caracteres
	      si str es "" se devuelve una cadena null.
	ej:
	strdupcount("Gemix",  5) <- devuelve "GemixGemixGemixGemixGemix"
	strdupcount(""     ,  3) <- devuelve ""
	strdupcount("Gemix", -1) <- devuelve "GemixGemixGemixGemixGemix......."

* STRSET(string str, string char)
	Cambia todos los caracteres de str con char y devuelve str
	ej:
	strset("Gemix Compiler", "*") <- devuelve "*************" 

* STRNEQSPN(string str1, string str2)
	Busca el primero caracter de str1 diverso da cualquier caracter de str2 y devuelve
	su posición, 0 si no.
	ej:
	strspn("Gemix", "Gbofgh") <- devuelve 1
	strspn("Gemix", "Gemix")  <- devuelve -1

* STRSTR(string str, string substr)
* STRSTR(string str, string substr, int start) -> (Overload 1)
	Busca una substr en la str empezando de 0 o start y devuelve la posición si la contiene o -1 si no.
	ej:
	strstr("Gemix Compiler", "ix") <- devuelve  3
	strstr("Gemix Compiler", "mx") <- devuelve -1

* STRTRM(string str)
	Devuelve una copia de str sin espacios iniciales y finales.
	ej:
	strtrm("  Gemix Compiler  ") <- devuelve "Gemix Compiler"

* STRTTRM(string str)
	Devuelve una copia de str sin espacios.
	ej:
	strttrm(" * * * G e m i x * * * ") <- devuelve "***Gemix***"

* STRUNIQUE(string str)
	Devuelve una copia de str sin duplicados.
	ej:
	strunique("GemixGemixGemix") <- devuelve "Gemix"

* STRUNIQUECHR(string str, string char)
	Devuelve una copia de str sin caracteres char duplicados.
	ej:
	struniquechr("GemixGemixGemix", "e") <- devuelve "GemixGmixGmix"
	struniquechr("Gemix Compiler", "e")  <- devuelve "Gemix compilr"	

* STRXFMT(string str, string char, int size, int num, int mode)
	Formatea str con size char y num en un mode y devuelve str (que juego de palabras xD).	
	NOTA: si str es "" no se copiará la cadena formateada en str
	      si size es 0 la cadena será ""
	      si size es menor que 0 la cadena será entera
	      si mode es 0 o menor se formatea a izquierda
	      si mode es 1 o mayor se formatea a derecha 
	ej:
	strxfmt(txt, "#", 20,   100, 0) <- devuelve "100#################"
	strxfmt(txt, "#", 20, -2500, 0) <- devuelve "-2500###############"	
	strxfmt(txt, "0", 20,  3000, 0) <- devuelve "30000000000000000000"	
	strxfmt(txt, "0",  3,  3000, 0) <- devuelve "3000"	 
	strxfmt(txt, "#", 20,   100, 1) <- devuelve "#################100"	
	strxfmt(txt, "#", 20, -2500, 1) <- devuelve "###############-2500"	
	strxfmt(txt, "0", 20,  3000, 1) <- devuelve "00000000000000003000"	
	strxfmt(txt, "0",  3,  3000, 1) <- devuelve "3000"

* UPPER()
	Ver la DOC de DIV2