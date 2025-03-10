Program test_mouse2;
Begin
set_fps(60,0);
 Loop
 HIDE_WINDOW();
 //como que el raton PUEDE salirse de la ventana(de las cordenadas del set_mode)
 //puedes mover el raton mas alla de la pantalla de juego, saliendose de la ventana o pantalla....
 mouse.x=rand(-640,1245);// aki podemos manipular la posicion del cursor, hasta del windows!!!
 mouse.y=rand(-340,945);//  Aun que lo pongas en segundo plano, No tienes control del raton!!!
 Frame;
 End
End