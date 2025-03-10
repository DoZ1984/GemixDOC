//------------------------------------------------------------------------------------------------------------------------------------------------
/*			Simulador de Física realistica 1.0
			Por Luis lopez martinez.
			
			- Ejemplo de scroll vectorizado por puntos de control y procesado por segmentos mediante el motor Physics Motion LIB.
			- Ejemplo didactico, completamente libre de ser modificado y/o reutilizado.
			
*/
//------------------------------------------------------------------------------------------------------------------------------------------------
program ScrollPhysicsExample;
include "PhysicsMotion/PhysicsMotion.prg";
//------------------------------------------------------------------------------------------------------------------------------------------------
global
	IDpersonaje;

//------------------------------------------------------------------------------------------------------------------------------------------------

PRIVATE
	distx,disty;
	ID_TEMP;
begin
    visible=joy_status=mouse_status=false;
	set_mode(257,240,32,1,2,0);set_fps(60,0);
	restore_type=-1;
	
	load_fpg("pinball.fpg");
	
	
	// preparar datos del personaje..
	bolas[0].radius_ = 15;
	bolas[0].mass_ = (88.0 / 21.0) * (bolas[0].radius_ * bolas[0].radius_ * bolas[0].radius_);
	bolas[0].x_ = 80;
	bolas[0].y_ = 40;
    bolas[0].eFactor  = 0.95;	// factor de rozamiento global del entorno..
		
	  
	TOP_MAXBALLS=7;
	for(x=1;x<TOP_MAXBALLS;x++);
	  CLONES(X,rand(80,190),40*X);
	end
	
	
	// vectorizar escenario..
	y=rgb(0,255,0);//color rgb map_put_line
	
	TOP_MAXLINES=45;
	for(x=1;x<=TOP_MAXLINES;x++);
		MAP_GET_CPOINT(0, 3, x, &lineas[x].x0_, &lineas[x].y0_ );
		MAP_GET_CPOINT(0, 3, x, &lineas[x+1].x1_, &lineas[x+1].y1_ );
		MAP_PUT_LINE(0, 3, lineas[x].x0_,lineas[x].y0_,lineas[x].x1_, lineas[x].y1_, y);
	end
	start_scroll(0, 0, 3, 0, 0, 0);
	
	
	IDpersonaje = Personaje();	
	
	PhysicsMotion();
	
	scroll.camera = id;
    X=IDpersonaje.X;
	Y=IDpersonaje.Y;
	WRITE(0,0,0,0,"Balls:"+itoa(TOP_MAXBALLS)+" Lines:"+ITOA(TOP_MAXLINES));
	WRITE(0,257,240,8,&FPS);
	
	
	loop

		distx = abs(IDpersonaje.x - x);
		disty = abs(IDpersonaje.y - y);
		if(IDpersonaje.x > x)
			x+=distx/4;
		end
		if(IDpersonaje.x < x)
			x-=distx/4;
		end
			
		if(IDpersonaje.y > y)
			y+=disty/4;
		end
		if(IDpersonaje.y < y)
			y-=disty/4;
		end
		
		frame;
	end
end
//------------------------------------------------------------------------------------------------------------------------------------------------
// este proceso simulará en el futúro el control de gravedad con acelerómetros o puede servir para manipular un escenario de una forma interesante..
process Personaje();
private
colb,colp;
float vel;
begin	
	ctype = c_scroll;
	graph = 2;size=55;
	write(0,0,240,6,&colb);
	write(0,20,240,6,&colp);
	loop
		// mover al personaje..
		if(key(_left))
			angle+=2500;
		end
		// mover al personaje..
		if(key(_right))
			angle-=2500;
		end	
			
		if(key(_up)and not key(_down))
		 vel+=0.0025;if(vel>5);vel=5;end
		elseif(key(_down)and not key(_up))
		 vel-=0.005;if(vel>0.4);vel=0.4;end
		else
		 if(vel>0);
		  vel-=0.0025;
		  if(vel<0);vel=0;end
		 elseif(vel<0);
		  vel+=0.0025;
		  if(vel>0);vel=0;end
		 end
		end
		
		 bolas.vx_+=cos((float)angle)*vel;
		 bolas.vy_+=-(sin((float)angle)*vel);
		
		 if(bolas.vx_>2.5);bolas.vx_=2.5;elseif(bolas.vx_<-2.5);bolas.vx_=-2.5;end
		 if(bolas.vy_>2.5);bolas.vy_=2.5;elseif(bolas.vy_<-2.5);bolas.vy_=-2.5;end
		
		x = bolas.x_;
		y = bolas.y_;
		
		colb=bolas.collisonb-1;colp=bolas.collisonp-1;
		
		/*fxmode=0;size=50;
	    if(bolas.collisonb>0);fxmode=fx_invert;bolas.collisonb=0;end
		if(bolas.collisonp>0);size=60;bolas.collisonp=0;end*/
		frame;
	end
end


process CLONES(num_bol,x,y);
private
x1;//,FXMODE_s;
begin	
	ctype = c_scroll;
	graph = 2;
	bolas[num_bol].radius_=15;
	bolas[num_bol].mass_=bolas[0].mass_;
	bolas[num_bol].x_=x;
	bolas[num_bol].y_=y;
	bolas[num_bol].eFactor  = 0.95;	// factor de rozamiento global del entorno..
	FLAGS=RAND(0,1);size=55;
	FXMODE=RAND(1002,1014);
	loop
	x1=bolas[num_bol].x_;
	if(x1>x);flags=0;end
	if(x1<x);flags=1;end
	x=x1;y=bolas[num_bol].y_;
	/*fxmode=FXMODE_s;size=50;
	if(bolas[num_bol].collisonb>0);fxmode=fx_invert;bolas[num_bol].collisonb=0;end
	if(bolas[num_bol].collisonp>0);size=60;bolas[num_bol].collisonp=0;end*/
	frame;
	end
end
//------------------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------