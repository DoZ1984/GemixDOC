//----------------------------------
* INT HIPER3D_START(INT file, INT graph);
//Inicia el modulo3D, para plasmar la vision de la camara 3D.
	
* INT HIPER3D_STOP();
//Para el Hiper3D

* INT HIPER3D_SET_CLEARCOLOR(INT r, INT g, INT b);
//color de fondo, auto pintado (si no se usa, sera fondo transparente)

* INT HIPER3D_ENABLE_RENDER3D(INT enable);
//Enciende el renderizado y lo pausa (no borra objetos,sigue en memoria)
* INT HIPER3D_ENABLE_CULLING(INT enable);
//activa el renderizado tras los objetos 3D (poligonos no visibles)


//----------------------------------

* INT HIPER3D_LOAD_TEXTURE(INT file, INT graph);
//copia,devuelve el id de textura para objeto 3D, id_tex

* INT HIPER3D_UNLOAD_TEXTURE(INT texture_id);
//Descarga la textura

//---------------------------------------------

* INT HIPER3D_LOAD_MESH(STRING filename);
 //carga,devuelve el id de mesh MD2, para crearlo en 3D, id_mesh

* INT HIPER3D_DELETE_MESH(INT id_mesh);
//descargar un mesh en memoria.

* INT HIPER3D_DELETE_ALLMESH();
//descargar todas las mesh en memoria.

//---------------------------------------------


* INT HIPER3DCAMERA_SET_POSITION(FLOAT x, FLOAT y, FLOAT z);
 //cambia la posicion 3D
* INT HIPER3DCAMERA_SET_ROTATION(FLOAT x, FLOAT y, FLOAT z);
 //cambia la rotacion 3D

 
* INT HIPER3DCAMERA_SET_PROJECTION(DOUBLE fovy, DOUBLE aspect, DOUBLE zNear, DOUBLE zFar);
//gluPerspective(45,640.0/480.0,1.0,500.0);
* INT HIPER3DCAMERA_SET_VIEWPORT(INT x0, INT y0, INT x1, INT y1);
// area de vision de salida, region


//---------------------------------------------


* INT HIPER3D_NEW_OBJECT(INT type, FLOAT x, FLOAT y, FLOAT z, FLOAT size_x, FLOAT size_y, FLOAT size_z);
//type: 0=cuadrado 2D | 1=Cubo 3D | 2=Mesh MD2
//devuelve el numero de objeto: id_obj

* INT HIPER3D_DELETE_OBJECT(INT id_obj);
//borra un objeto 3D
* INT HIPER3DDELETE_ALLOBJECT();
//borra todos los objetos 3D

* INT HIPER3D_GET_OBJECT(FLOAT x, FLOAT y);
//Devuelve el numero de Objeto 3D de la pantalla 2D.

* INT HIPER3DOBJECT_SET_MESH(INT id_obj, INT id_mesh);
//aplica la mesh a un objeto 3D(type = 2)

* INT HIPER3DOBJECT_SET_COLOR(INT id_obj, INT r, INT g, INT b);
//Aplica un color a un obj3D(no debe tener asignado una textura)

* INT HIPER3DOBJECT_SET_TEXTURE(INT id_obj, INT id_tex);
//aplica una textura al objetos 3D
* INT HIPER3DOBJECT_SET_TEXTUREWRAP(INT id_obj, FLOAT x, FLOAT y, FLOAT min, FLOAT max);
//mover la textura posicion y escala %
 
 
* INT HIPER3DOBJECT_SET_POSITION(INT id_obj, FLOAT x, FLOAT y, FLOAT z);
//cambia la posicion 3D
* INT HIPER3DOBJECT_SET_ROTATION(INT id_obj, FLOAT x, FLOAT y, FLOAT z);
//cambia la rotacion 3D
* INT HIPER3DOBJECT_SET_SIZE(INT id_obj, FLOAT size_x, FLOAT size_y, FLOAT size_z);
//cambia el tamaño 3D
 

* INT HIPER3DOBJECT_SET_ANIMATION(INT id_obj, INT animation);
//aplica una animacion (si existe) al objetos 3D
* INT HIPER3DOBJECT_GET_ANIMATION(INT id_obj);
//Devuelve el numero de animacion que tiene actualmente ese Objeto 3D
