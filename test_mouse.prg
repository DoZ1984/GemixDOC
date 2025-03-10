Program test_mouse;
global
string txt;
Begin
set_mode(640,480,32);set_fps(0,0);
change_mode(mode_fullscreen);
mouse.graph=load_map("arrow2b.map");
mouse.cursor=true;
write(0,0,0,0,txt);
 Loop
txt="mouse.x:"+itoa(mouse.x)+" y:"+itoa(mouse.y);
 Frame;
 End
End