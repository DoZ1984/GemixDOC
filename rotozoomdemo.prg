Program Prueba_RotoZoom;
global
Rend_map;
private
tam=735;
begin

    set_mode(640,400,32);set_fps(60,0); 
    restore_type=-1;

    load_fpg("rotozoomdemo.fpg");

    define_region(1,0,0,tam,tam);
    
x=320;y=200; 
graph=new_map(tam,tam);
Rend_map=id;
    set_scroll_destination(0,file,graph,0);

    start_scroll(0,file,1,0,1,15);
     
    player();
    
    write_int(0,640,400,8,&fps);

signal(id,S_freeze);
frame;
end

process camara();
begin
  ctype=c_scroll;
  scroll.camera=id;
signal(id,S_freeze);
frame;
end

process player();
private
float vel;      //velocidad del jugador      
begin
camara();
  ctype=c_scroll;
  graph=2;size=40; 
  write_int(0,0,0,0,&angle);
  loop
       
   if(key(_up)    || joy.up)    vel+=0.25; end 
   if(key(_left)  || joy.left)  angle+=1500; end
   if(key(_right) || joy.right) angle-=1500; end
   
     if(vel>10.00);vel=10.00;end
     advance(vel);
     
     vel*=0.99;
     Rend_map.angle=90000-angle;
     scroll.camera.x=x;scroll.camera.y=y;
     xadvance(scroll.camera,angle,vel*10);
     frame;
  end
end 