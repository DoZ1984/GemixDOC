Program test_region;
Global
grafico_jug[3];
id_jug[3];
grafico_fondo;
grafico_cosa;
string text,text1,text2,text3,text4;
valido;
Begin
set_mode(640,480,32);

grafico_jug[0]=load_map("001.map");
grafico_jug[1]=load_map("002.map");
grafico_jug[2]=load_map("003.map");
grafico_jug[3]=load_map("004.map");

grafico_cosa=load_map("005.map");

grafico_fondo=load_map("sidemetal512_512x512_8.map");

define_region(1,0,0,319,239);
define_region(2,321,0,319,239);
define_region(3,0,241,319,239);
define_region(4,321,241,319,239);

start_scroll(0,0,grafico_fondo,0,1,15);
start_scroll(1,0,grafico_fondo,0,2,15);
start_scroll(2,0,grafico_fondo,0,3,15);
start_scroll(3,0,grafico_fondo,0,4,15);

jugador(1,160,120);
jugador(2,160*3,120);
jugador(3,160,120*3);
jugador(4,160*3,120*3);

write(0,0,0,0,text1);
write(0,320,0,0,text2);
write(0,0,240,0,text3);
write(0,320,240,0,text4);

draw(3,0,190,0,100,470,640-100,480);
write(0,320,480,7,text);

ctype=c_scroll;
graph=grafico_cosa;
x=70;y=267;

repeat
angle+=2000;
if(collision(type jugador));
size=200;
else
size=100;
end

 if(key(_1));z=0;end
 if(key(_2));z=1;end
 if(key(_3));z=2;end
 if(key(_4));z=3;end
 
 if(key(_up))id_jug[z].y-=5;end
  if(key(_down))id_jug[z].y+=5;end
   if(key(_left))id_jug[z].x-=5;end
    if(key(_right))id_jug[z].x+=5;end
    
text1="Jug1:X:"+itoa(id_jug[0].x)+" Y:"+itoa(id_jug[0].y);
text2="Jug2:X:"+itoa(id_jug[1].x)+" Y:"+itoa(id_jug[1].y);
text3="Jug3:X:"+itoa(id_jug[2].x)+" Y:"+itoa(id_jug[2].y);
text4="Jug4:X:"+itoa(id_jug[3].x)+" Y:"+itoa(id_jug[3].y);

 valido=false;
if ((x > scroll[0].x0 and x < scroll[0].x0 + 320 and y > scroll[0].y0 and y < scroll[0].y0 + 240) or
    (x > scroll[1].x0 and x < scroll[1].x0 + 320 and y > scroll[1].y0 and y < scroll[1].y0 + 240) or
    (x > scroll[2].x0 and x < scroll[2].x0 + 320 and y > scroll[2].y0 and y < scroll[2].y0 + 240) or
    (x > scroll[3].x0 and x < scroll[3].x0 + 320 and y > scroll[3].y0 and y < scroll[3].y0 + 240))
  valido=true;
end

text="Jugador Selecionado:[[ "+itoa(z+1)+" ]] >>>>[[[ Region Valida: "+itoa(valido)+" ]]]<<<<<<<<";
 Frame;
 until(key(_esc));
 exit("",0);
End

process jugador(num_j,x,y);
begin
ctype=c_scroll;
graph=grafico_jug[num_j-1];
scroll[num_j-1].camera=id;
id_jug[num_j-1]=id;
loop
frame;
end
end