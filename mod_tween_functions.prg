int new_tween(<tipo> * target, <tipo> start_value, <tipo> end_value, int duration, int tween_type, int easing_mode, int autoplay, int repeat)

- DESCRIPCION:
	Crea una tween que interpola los valores de un valor inicial a uno final en los milisegundos
	indicados y usando el tipo de interpolacion y de suavizado indicados. Tambien se puede indicar
	si la animacion tiene que reproducirse o no de inmediato (en caso negativo siempre se podra usar
	'play_tween' cuando sea necesario para reproducirla) y cuantas repeticiones realizar.
	
- PARAMETROS:
	- <tipo> * target	puntero a tipo de dato simple (byte, int, float, etc.) que servira de contenedor
				para el valor interpolado de la tween
	- <tipo> start_value	valor de inicio para la tween del mismo tipo que target
	- <tipo> end_value	valor final para la tween del mismo tipo que target
	- int    duration	tiempo en milisegundos que durara la animacion
	- int    tween_type	tipo de interpolacion (usar las siguientes constantes)

		- tween_type_linear	0
		- tween_type_quad	1
		- tween_type_cubic	2
		- tween_type_quart	3
		- tween_type_quint	4
		- tween_type_sine	5
		- tween_type_exp	6
		- tween_type_circ	7
		- tween_type_back	8
		- tween_type_bounce	9
		- tween_type_elastic	10

	- int    easing_mode	tipo de suavizado (usar las siguientes constantes)

		- tween_ease_none	0
		- tween_ease_in		1
		- tween_ease_out	2
		- tween_ease_inout	3
		- tween_ease_outin	4

		Nota: Si no se desea suavizado (tween_ease_none) el tipo de interpolacion usado
		sera siempre 'tween_type_linear'

	- int    autoplay	auto reproducir la tween (1 == auto reproducir, otro == no autoreproducir)
	- int    repeat		numero de repeticiones de la animacion (se pueden usar las siguientes constantes)

		- tween_repeat_none		0
		- tween_repeat_infinite		-1

- RETORNO:
	El identificador de la tween creada, para ser usado con otras funciones

--------------------------------------------------------------------------------------------------------------------------

int delete_tween(int tween_id)

- DESCRIPCION:
	Elimina una tween creada con 'new_tween' o obtenida con 'tweengroup_detach_tween'
	
- PARAMETROS:
	- int tween_id		identificador de la tween a eliminar (para eliminar todas las tweens
				usar la siguiente constante)
		
		- all_tween	0

- RETORNO:
	'1' si la tween fue eliminada correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int play_tween(int tween_id)

- DESCRIPCION:
	Reproduce una tween creada con 'new_tween' o obtenida con 'tweengroup_detach_tween'
	
- PARAMETROS:
	- int tween_id		identificador de la tween a reproducir (para reproducir todas las tweens
				usar la siguiente constante)
		
		- all_tween	0

- RETORNO:
	'1' si la tween se ha empezado a reproducir correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int stop_tween(int tween_id)

- DESCRIPCION:
	Detiene la reproduccion de una tween creada con 'new_tween' o obtenida con
	'tweengroup_detach_tween' y pone el punto de reproduccion al inicio
	
- PARAMETROS:
	- int tween_id		identificador de la tween a parar (para parar todas las tweens
				usar la siguiente constante)
		
		- all_tween	0

- RETORNO:
	'1' si la tween se ha parado correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int pause_tween(int tween_id)

- DESCRIPCION:
	Detiene la reproduccion de una tween creada con 'new_tween' o obtenida con
	'tweengroup_detach_tween'. El punto de reproduccion no se modifica, con lo
	cual la tween continuara en este punto la proxima vez que se llame a 'play_tween'
	
- PARAMETROS:
	- int tween_id		identificador de la tween a pausar (para pausar todas las tweens
				usar la siguiente constante)
		
		- all_tween	0

- RETORNO:
	'1' si la tween se ha pausado correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int tween_exists(int tween_id)

- DESCRIPCION:
	Comprueba si un determinado id se corresponde con una tween existente
	
- PARAMETROS:
	- int tween_id		identificador de la tween

- RETORNO:
	'true' si la tween existe o 'false' en caso contrario
	
--------------------------------------------------------------------------------------------------------------------------

int is_playing_tween(int tween_id)

- DESCRIPCION:
	Comprueba si la tween indicada por 'tween_id' esta siendo reproducida
	
- PARAMETROS:
	- int tween_id		identificador de la tween

- RETORNO:
	'true' si la tween esta siendo reproducida o 'false' en caso contrario
	
--------------------------------------------------------------------------------------------------------------------------

int new_tweengroup(int tweengroup_type)

- DESCRIPCION:
	Crea un nuevo grupo de tweens del tipo especificado en 'tweengroup_type'. El grupo
	es creado vacio, esto es, sin ninguna tween. Para adjuntar tweens al grupo se usa
	la funcion 'tweengroup_attach_tween'. El grupo puede ser de tipo paralelo o de
	tipo secuencial. Los grupos de tipo paralelo animan todas las tweens adjuntas al
	mismo tiempo mientras que los grupos de tipo secuencial las animan en orden y nunca
	mas de una a la vez.
	
- PARAMETROS:
	- int tweengroup_type	tipo de grupo (usar las siguientes constantes)

		- tweengroup_type_parallel	0
		- tweengroup_type_sequential	1

- RETORNO:
	el identificador del grupo de tweens creado, para ser usado con otras funciones
	
--------------------------------------------------------------------------------------------------------------------------

int delete_tweengroup(int tweengroup_id)

- DESCRIPCION:
	Elimina un grupo de tweens creado con 'new_tweengroup' y todas las tweens
	que este tenga adjuntadas
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens a eliminar (para eliminar
				todos los grupos de tweens usar la siguiente constante)
		
		- all_tweengroup	0

- RETORNO:
	'1' si el grupo de tweens ha sido eliminado correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_attach_tween(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Adjunta una tween, creada con 'new_tween' o obtenida con 'tweengroup_detach_tween' y
	referenciada por 'tween_id', al grupo referenciado por 'tweengroup_id'. Dicha tween
	ya no sera mas accesible de forma individual, sino unicamente como parte del grupo
	indicado. Si se quiere disponer de nuevo de la tween de forma individual se debe usar
	la funcion 'tweengroup_detach_tween'
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens al que se va a
				adjuntar la tween referenciada por 'tween_id'
	- int tween_id		identificador de la tween individual que se va a
				adjuntar al grupo referenciado por 'tweengroup_id'
		

- RETORNO:
	el identificador de tween de grupo asignado a la tween adjuntada.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3,
	4, ..., max_tweens. El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	Este orden puede ser cambiado en cualquier momento con la funcion 'tweengroup_move_tween'
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_attach_tween(int tweengroup_id, <tipo> * target, <tipo> start_value, <tipo> end_value, int duration, int tween_type, int easing_mode)

- DESCRIPCION:
	Adjunta una tween, creada basandose en los parametros indicados, al grupo referenciado
	por 'tweengroup_id'. Dicha tween no es accesible de forma individual, sino
	unicamente como parte del grupo indicado. Si se quiere disponer en el futuro de la tween
	de forma individual se debe usar la funcion 'tweengroup_detach_tween'.
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens al que se va a
				adjuntar la tween referenciada por 'tween_id'
	- <tipo> * target	puntero a tipo de dato simple (byte, int, float, etc.) q servira de contenedor
				para el valor interpolado de la tween
	- <tipo> start_value	valor de inicio para la tween del mismo tipo que target
	- <tipo> end_value	valor final para la tween del mismo tipo que target
	- int    duration	tiempo en milisegundos que durara la animacion
	- int    tween_type	tipo de interpolacion (usar las siguientes constantes)

		- tween_type_linear	0
		- tween_type_quad	1
		- tween_type_cubic	2
		- tween_type_quart	3
		- tween_type_quint	4
		- tween_type_sine	5
		- tween_type_exp	6
		- tween_type_circ	7
		- tween_type_back	8
		- tween_type_bounce	9
		- tween_type_elastic	10

	- int    easing_mode	tipo de suavizado (usar las siguientes constantes)

		- tween_ease_none	0
		- tween_ease_in		1
		- tween_ease_out	2
		- tween_ease_inout	3
		- tween_ease_outin	4
		
		Nota: Si no se desea suavizado (tween_ease_none) el tipo de interpolacion usado
		sera siempre 'tween_type_linear'

- RETORNO:
	el identificador de tween de grupo asignado a la tween adjuntada.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3,
	4, ..., max_tweens. El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	Este orden puede ser cambiado en cualquier momento con la funcion 'tweengroup_move_tween'
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_detach_tween(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Separa la tween referenciada por 'tween_id' del grupo refererenciado por 'tweengroup_id'.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3,
	4, ..., max_tweens. El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	Este orden puede ser cambiado en cualquier momento con la funcion 'tweengroup_move_tween'
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens del que se va a
				separar la tween referenciada por 'tween_id'
	- int tween_id		identificador de la tween de grupo que se va a
				separar del grupo referenciado por 'tweengroup_id'
		

- RETORNO:
	el identificador de tween individual asignado a la tween separada del grupo
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_move_tween(int tweengroup_id, int tween_id, int new_position)

- DESCRIPCION:
	Mueve la tween referenciada por 'tween_id' en el grupo refererenciado por 'tweengroup_id' a la
	posicion indicada por 'new_position'
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens en el que se va a
				mover la tween referenciada por 'tween_id'
	- int tween_id		identificador de la tween de grupo que se va a
				mover en el grupo referenciado por 'tweengroup_id'
	- int new_position	la nueva posicion dentro del grupo a la que se va a mover
				la tween referenciada por 'tween_id' (puede ser un numero de 1 a 'max_tweens'
				o las siguientes constantes)
		
		- tween_move_first	-1
		- tween_move_last	-2
		- tween_move_backward	-3
		- tween_move_forward	-4

- RETORNO:
	'1' si la tween ha sido movida correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_delete_tween(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Elimina la tween referenciada por 'tween_id' del grupo refererenciado por 'tweengroup_id'.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id	identificador del grupo de tweens del que se va a
				eliminar la tween referenciada por 'tween_id'
	- int tween_id		identificador de la tween de grupo que se va a
				eliminar del grupo referenciado por 'tweengroup_id'

- RETORNO:
	'1' si la tween ha sido eliminada correctamente

--------------------------------------------------------------------------------------------------------------------------

int play_tweengroup(int tweengroup_id)

- DESCRIPCION:
	Reproduce un grupo de tweens creado con 'new_tweengroup'
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens a reproducir (para reproducir
					todos los grupos de tweens usar la siguiente constante)
		
		- all_tweengroup	0

- RETORNO:
	'1' si el grupo de tweens se ha empezado a reproducir correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int pause_tweengroup(int tweengroup_id)

- DESCRIPCION:
	Detiene la reproduccion de un grupo de tweens creado con 'new_tweengroup'
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens a pausar (para pausar
					todos los grupos de tweens usar la siguiente constante)
		
		- all_tweengroup	0

- RETORNO:
	'1' si el grupo de tweens se ha pausado correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int stop_tweengroup(int tweengroup_id)

- DESCRIPCION:
	Detiene la reproduccion de un grupo de tweens creado con 'new_tweengroup'
	y pone su punto de reproduccion al inicio
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens a parar (para parar
					todos los grupos de tweens usar la siguiente constante)
		
		- all_tweengroup	0

- RETORNO:
	'1' si el grupo de tweens se ha parado correctamente
	
--------------------------------------------------------------------------------------------------------------------------

int is_playing_tweengroup(int tweengroup_id)

- DESCRIPCION:
	Obtiene si el grupo de tweens referenciado por 'tweengroup_id'
	esta siendo reproducido actualmente
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	'true' si el grupo de tweens esta siendo reproducido o 'false' en caso contrario
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_exists(int tweengroup_id)

- DESCRIPCION:
	Obtiene si el grupo de tweens referenciado por 'tweengroup_id' existe
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	'true' si el grupo de tweens existe o 'false' en caso contrario
	
--------------------------------------------------------------------------------------------------------------------------

int tweengroup_tween_exists(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene si la tween de grupo referenciada por 'tween_id' existe
	dentro del grupo de tweens referenciado por 'tweengroup_id'.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween de grupo

- RETORNO:
	'true' si la tween existe en el grupo de tweens o 'false' en caso contrario
	
--------------------------------------------------------------------------------------------------------------------------

float get_tween_start(int tween_id)
float get_tween_start(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene el valor de inicio de la tween referenciada con 'tween_id'. Si se
	especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	el valor de inicio de la tween especificada
	
--------------------------------------------------------------------------------------------------------------------------

float get_tween_end(int tween_id)
float get_tween_end(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene el valor final de la tween referenciada con 'tween_id'. Si se
	especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	el valor final de la tween especificada
	
--------------------------------------------------------------------------------------------------------------------------

int get_tween_duration(int tween_id)
int get_tween_duration(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene la duracion de la tween referenciada con 'tween_id'. Si se
	especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	la duracion de la tween especificada
	
--------------------------------------------------------------------------------------------------------------------------

int get_tween_type(int tween_id)
int get_tween_type(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene el tipo de interpolacion de la tween referenciada con 'tween_id'. Si se
	especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	el tipo de interpolacion de la tween especificada (puede ser uno de los siguientes valores constantes)

		- tween_type_linear	0
		- tween_type_quad	1
		- tween_type_cubic	2
		- tween_type_quart	3
		- tween_type_quint	4
		- tween_type_sine	5
		- tween_type_exp	6
		- tween_type_circ	7
		- tween_type_back	8
		- tween_type_bounce	9
		- tween_type_elastic	10
	
--------------------------------------------------------------------------------------------------------------------------

int get_tween_easing(int tween_id)
int get_tween_easing(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene el tipo de suavizado de la tween referenciada con 'tween_id'. Si se
	especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	el tipo de suavizado de la tween especificada (puede ser uno de los siguientes valores constantes)

		- tween_ease_none	0
		- tween_ease_in		1
		- tween_ease_out	2
		- tween_ease_inout	3
		- tween_ease_outin	4
	
--------------------------------------------------------------------------------------------------------------------------

float get_tween_overshoot(int tween_id)
float get_tween_evershoot(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene la cantidad de rebasamiento de la tween referenciada con 'tween_id' cuando se usa
	el tipo de interpolacion 'tween_type_back'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	la cantidad de rebasamiento de la tween especificada
	Nota: El valor predeterminado de rebasamiento es 1.70158, que produce un rebasamiento del 10%
	
--------------------------------------------------------------------------------------------------------------------------

float get_tween_amplitude(int tween_id)
float get_tween_amplitude(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene la amplitud de la tween referenciada con 'tween_id' cuando se usa
	el tipo de interpolacion 'tween_type_elastic'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	la amplitud de la tween especificada
	Nota: La amplitud minima es igual a la diferencia entre el valor final y el de inicio
	
--------------------------------------------------------------------------------------------------------------------------

float get_tween_period(int tween_id)
float get_tween_period(int tweengroup_id, int tween_id)

- DESCRIPCION:
	Obtiene el periodo de la tween referenciada con 'tween_id' cuando se usa
	el tipo de interpolacion 'tween_type_elastic'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int tween_id			identificador de la tween individual o de grupo

- RETORNO:
	el periodo de la tween especificada
	
--------------------------------------------------------------------------------------------------------------------------
 
float set_tween_start(int tween_id, float start_value)
float set_tween_start(int tweengroup_id, int tween_id, float start_value)

- DESCRIPCION:
	Establece el valor de inicio de la tween referenciada con 'tween_id' a 'start_value'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float start_value		nuevo valor para el inicio de la tween

- RETORNO:
	el valor anterior de inicio de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
float set_tween_end(int tween_id, float end_value)
float set_tween_end(int tweengroup_id, int tween_id, float end_value)

- DESCRIPCION:
	Establece el valor final de la tween referenciada con 'tween_id' a 'end_value'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float end_value		nuevo valor para el final de la tween

- RETORNO:
	el valor anterior final de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
int set_tween_duration(int tween_id, int duration)
int set_tween_duration(int tweengroup_id, int tween_id, int duration)

- DESCRIPCION:
	Establece la duracion en milisegundos de la tween referenciada con 'tween_id' a 'duration'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float duration		nuevo duracion de la tween

- RETORNO:
	la duracion anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
int set_tween_type(int tween_id, int type)
int set_tween_type(int tweengroup_id, int tween_id, int type)

- DESCRIPCION:
	Establece el tipo de interpolacion de la tween referenciada con 'tween_id' a 'type'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float type			nuevo tipo de interpolacion de la tween (usar las siguientes constantes)

		- tween_type_linear	0
		- tween_type_quad	1
		- tween_type_cubic	2
		- tween_type_quart	3
		- tween_type_quint	4
		- tween_type_sine	5
		- tween_type_exp	6
		- tween_type_circ	7
		- tween_type_back	8
		- tween_type_bounce	9
		- tween_type_elastic	10

- RETORNO:
	el tipo de interpolacion anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
int set_tween_easing(int tween_id, int easing_mode)
int set_tween_easing(int tweengroup_id, int tween_id, int easing_mode)

- DESCRIPCION:
	Establece el tipo de suavizado de la tween referenciada con 'tween_id' a 'easing_mode'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float easing_mode		nuevo tipo de suavizado de la tween (usar las siguientes constantes)

		- tween_ease_none	0
		- tween_ease_in		1
		- tween_ease_out	2
		- tween_ease_inout	3
		- tween_ease_outin	4

- RETORNO:
	el tipo de suavizado anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
float set_tween_overshoot(int tween_id, float overshoot)
float set_tween_overshoot(int tweengroup_id, int tween_id, float overshoot)

- DESCRIPCION:
	Establece la cantidad de rebasamiento de la tween referenciada con 'tween_id' a 'overshoot'.
	Este valor solo sera usado cuando el tipo de interpolacion sea 'tween_type_back'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float overshoot		nueva cantidad de desbordamiento de la tween
					Nota: El valor predeterminado de rebasamiento es 1.70158,
					que produce un rebasamiento del 10%

- RETORNO:
	la cantidad de rebasamiento anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
float set_tween_amplitude(int tween_id, float amplitude)
float set_tween_amplitude(int tweengroup_id, int tween_id, float amplitude)

- DESCRIPCION:
	Establece la amplitud de la tween referenciada con 'tween_id' a 'amplitude'.
	Este valor solo sera usado cuando el tipo de interpolacion sea 'tween_type_elastic'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float amplitude		nueva cantidad de amplitud de la tween
					Nota: La amplitud minima es igual a la diferencia
					entre el valor final y el de inicio

- RETORNO:
	la amplitud anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
float set_tween_period(int tween_id, float period)
float set_tween_period(int tweengroup_id, int tween_id, float period)

- DESCRIPCION:
	Establece el periodo de la tween referenciada con 'tween_id' a 'period'.
	Este valor solo sera usado cuando el tipo de interpolacion sea 'tween_type_elastic'.
	Si se especifica un grupo de tweens determinado, 'tween_id' referencia a la tween
	de grupo dentro del grupo referenciado con 'tweengroup_id'. En caso contrario,
	'tween_id' hace referencia a una tween individual.
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3, 4, ..., max_tweens.
	El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	
- PARAMETROS:
	- int   tweengroup_id		identificador del grupo de tweens
	- int   tween_id		identificador de la tween individual o de grupo
	- float period			nuevo periodo de la tween

- RETORNO:
	el periodo anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------
 
int get_tween_repeat(int tween_id)

- DESCRIPCION:
	Obtiene el numero de repeticiones de la tween individual referenciada con 'tween_id'
	
- PARAMETROS:
	- int tween_id			identificador de la tween individual

- RETORNO:
	el numero de repeticiones de la tween especificada (puede ser uno de los siguientes valores constantes)

		- tween_repeat_none		0
		- tween_repeat_infinite		-1
	
--------------------------------------------------------------------------------------------------------------------------

int get_tween_repeatcount(int tween_id)

- DESCRIPCION:
	Obtiene el numero de la repeticion actual de la tween individual referenciada con 'tween_id'. 
	Este numero es puesto a 0 siempre que se usa la funcion 'stop_tween' o cuando la
	tween ha terminado de reproducirse.
	
- PARAMETROS:
	- int tween_id			identificador de la tween individual

- RETORNO:
	el numero de la repeticion actual de la tween especificada
	
--------------------------------------------------------------------------------------------------------------------------

int get_tweengroup_repeat(int tweengroup_id)

- DESCRIPCION:
	Obtiene el numero de repeticiones de tweens referenciado con 'tweengroup_id'
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	el numero de repeticiones del grupo de tweens especificado (puede ser uno de los siguientes valores constantes)

		- tween_repeat_none		0
		- tween_repeat_infinite		-1
	
--------------------------------------------------------------------------------------------------------------------------

int get_tweengroup_repeatcount(int tweengroup_id)

- DESCRIPCION:
	Obtiene el numero de la repeticion actual del grupo de tweens referenciado con 'tweengroup_id'. 
	Este numero es puesto a 0 siempre que se usa la funcion 'stop_tweengroup' o cuando el grupo
	de tweens ha terminado de reproducirse.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	el numero de la repeticion actual del grupo de tweens especificado
	
--------------------------------------------------------------------------------------------------------------------------

int set_tween_repeat(int tween_id, int repeat)

- DESCRIPCION:
	Establece el numero de repeticiones de la tween individual referenciada con 'tween_id' a 'repeat'.
	
- PARAMETROS:
	- int tween_id			identificador de la tween individual
	- int repeat			numero de repeticiones (puede ser uno de los siguientes valores constantes)
		
		- tween_repeat_none		0
		- tween_repeat_infinite		-1

- RETORNO:
	el numero de repeticiones anterior de la tween
	
--------------------------------------------------------------------------------------------------------------------------

int set_tweengroup_repeat(int tweengroup_id, int repeat)

- DESCRIPCION:
	Establece el numero de repeticiones de grupo de tweens referenciado con 'tweengroup_id' a 'repeat'.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens
	- int repeat			numero de repeticiones (puede ser uno de los siguientes valores constantes)
		
		- tween_repeat_none		0
		- tween_repeat_infinite		-1

- RETORNO:
	el numero de repeticiones anterior del grupo de tweens
	
--------------------------------------------------------------------------------------------------------------------------

int get_tweengroup_type(int tweengroup_id)

- DESCRIPCION:
	Obtiene el tipo del grupo de tweens referenciado con 'tweengroup_id'.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	el tipo del grupo de tweens especificado (uno de los siguientes valores constantes)

		- tweengroup_type_parallel	0
		- tweengroup_type_sequential	1
	
--------------------------------------------------------------------------------------------------------------------------

int get_tweengroup_tweenplaying(int tweengroup_id)

- DESCRIPCION:
	Obtiene el identificador de la tween actualmente en reproduccion en el grupo de
	tweens referenciado con 'tweengroup_id'. Esta funcion es solo valida para
	grupos de tipo 'tweengroup_type_sequential'
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	el identificador de la tween actualmente en reproduccion
	Los identificadores de las tweens de grupo son un valor tal que [0 < tween_id <= max_tweens], siendo
	'max_tweens' el numero total de tweens que contiene el grupo (que puede ser obtenido con
	'get_tweengroup_numtweens'). Asi el identificador puede ser 1, 2, 3,
	4, ..., max_tweens. El identificador marca al mismo tiempo el orden en que se situan las tweens en el
	grupo, asi en un grupo de tipo secuencial, la tween 4 sera reproducida antes que la 5 y despues que la 3.
	Este orden puede ser cambiado en cualquier momento con la funcion 'tweengroup_move_tween'

--------------------------------------------------------------------------------------------------------------------------

int get_tweengroup_numtweens(int tweengroup_id)

- DESCRIPCION:
	Obtiene el numero total de tweens adjuntadas al grupo de tweens
	referenciado con 'tweengroup_id'.
	
- PARAMETROS:
	- int tweengroup_id		identificador del grupo de tweens

- RETORNO:
	el numero total de tweens adjuntadas al grupo de tweens
	
--------------------------------------------------------------------------------------------------------------------------

float tween_interpolate(float start_value, float end_value, float duration, float time, int tween_type, int easing_mode)
float tween_interpolate(float start_value, float end_value, float duration, float time, int tween_type, int easing_mode, float overshoot, float amplitude, float period)

- DESCRIPCION:
	Interpola los valores de 'start_value' y 'end_value' en funcion de 'duration' y 'time'
	y usando el tipo de interpolacion y suavizado indicados
	
- PARAMETROS:
	- float start_value	valor de inicio para la interpolacion
	- float end_value	valor final para la interpolacion
	- float duration	medida lineal en funcion de la que se hara la interpolacion
	- float time		punto en 'duration' en funcion del que se hara la interpolacion
	- int   tween_type	tipo de interpolacion (usar las siguientes constantes)

		- tween_type_linear	0
		- tween_type_quad	1
		- tween_type_cubic	2
		- tween_type_quart	3
		- tween_type_quint	4
		- tween_type_sine	5
		- tween_type_exp	6
		- tween_type_circ	7
		- tween_type_back	8
		- tween_type_bounce	9
		- tween_type_elastic	10

	- int   easing_mode	tipo de suavizado (usar las siguientes constantes)

		- tween_ease_none	0
		- tween_ease_in		1
		- tween_ease_out	2
		- tween_ease_inout	3
		- tween_ease_outin	4

		Nota: Si no se desea suavizado (tween_ease_none) el tipo de interpolacion usado
		sera siempre 'tween_type_linear'

	- float overshoot	cantidad de rebasamiento usado en las interpolaciones de tipo 'tween_type_back'
	- float amplitude	amplitud usada en las interpolaciones de tipo 'tween_type_elastic'
	- float period		periodo usado en las interpolaciones de tipo 'tween_type_elastic'

- RETORNO:
	El valor interpolado
