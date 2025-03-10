const
	maxBalls = 20;
	maxLines = 50;

typedef
	type defineBall;
		double x_;//cordenadas actualizadas por el motor de fisicas
		double y_;
		double radius_;//radio de colision de la bola
		double mass_;//peso de masa
		double vx_;//futuras cordenadas de posicoin
		double vy_;
		float eFactor;// factor de rozamiento global del entorno.. 1.00=nunca para., 0.97 es mas lento/frena.
		collisonb;//devlevle el numero de bola que colisiona.
		collisonp;//devlevle el numero de pared que colisiona.
	end
	type defineLine;
		int x0_;
		int y0_;
		int x1_;
		int y1_;
	end

Global
	timeSteep=1;		// pasos intermedios para el motor, son sub_frames de un frame, para ganar precisión en las soluciones de colisión..
    
	TOP_MAXBALLS;
	TOP_MAXLINES;
	
	defineBall bolas[maxBalls];
	defineLine lineas[maxLines];
	
	
process PhysicsMotion();
private
	double collisionDistance;	// distancia de colisión teórica..
	double actualDistance;		// distancia de colisión real..
	double normal;				// angulo entre bolas que colisionan..
	double movedist1;			// corrección espacial para la primera bola..
	double movedist2;			// corrección espacial para la segunda bola..
	double nx;					// coseno de la normal..
	double ny;					// seno de la normal..
	double a1;					// tangente de la bola 1 con la normal..
	double a2;					// tangente de la bola 2 con la normal..
	double opt;					// momento de inercia..
	defineBall puntoPared;	    // obZeto que representa un punto con masa que tiene a infinito..
	double ix0, iy0;			// media aritmética de la secante entre los 2 puntos de intersección entre linea y bola..
	double ix1, iy1;			// punto 1 de la secante..
	double ix2, iy2;			// punto 2 de la secante..
	onSegment;	                // indica si el circulo colisiona "dentro del segmento" de la linea.. si se anula las lineas tienden al infinito en el espacio..
	timeSteep_;			        // el paso intermedio actual..
begin
    visible = false;
	priority = max_int;
	
	// preparar los datos del puntoPared..
	puntoPared.radius_ = 0.002;
	puntoPared.mass_ = 9999999999999999999999999999.9;	
	
	loop
		
		// recorrer la lista de obZetos..
		for (Y=0; Y<TOP_MAXBALLS; Y++)
		    if(bolas[Y].eFactor<1);
			// aplico la gravedad por separado en el eZe X y en el eZe Y a la bola..
			 bolas[Y].vx_ = bolas[Y].vx_ * bolas[Y].eFactor;
			 bolas[Y].vy_ = bolas[Y].vy_ * bolas[Y].eFactor;
			end
			for(timeSteep_=0; timeSteep_<timeSteep; timeSteep_++)
				// aplicar nueva posición al obZeto.. va determinado por el timeSteep..
				bolas[Y].x_ += bolas[Y].vx_;
				bolas[Y].y_ += bolas[Y].vy_;		
				
				// detectar colisión con los otros obZetos de la lista..
				for (Z=0; Z<TOP_MAXBALLS; Z++)	// recorro la lista de obZetos..
					if(Z <> Y)					// compruebo colisión con todos menos conmigo mismo..  
						if( (bolas[Y].radius_ + bolas[Z].radius_) > GetDistance(bolas[Y].x_, bolas[Y].y_, bolas[Z].x_, bolas[Z].y_) )
							bolas[Y].collisonb=Z+1;
							bolas[Z].collisonb=Y+1;
							// se ha producido una colisión..						
							collisiondistance = ( bolas[Y].radius_ + bolas[Z].radius_ );
							actualdistance = GetDistance(bolas[Y].x_, bolas[Y].y_, bolas[Z].x_, bolas[Z].y_);
							normal = atan2( (bolas[Z].y_ - bolas[Y].y_), (bolas[Z].x_ - bolas[Y].x_) );
							movedist1 = ( (collisiondistance - actualdistance) * (bolas[Z].mass_ / (bolas[Y].mass_ + bolas[Z].mass_)) );
							movedist2 = ( (collisiondistance - actualdistance) * (bolas[Y].mass_ / (bolas[Y].mass_ + bolas[Z].mass_)) );
							
							
							bolas[Y].x_  = ( bolas[Y].x_ + (movedist1 * (double)cos(normal + 180000.0)) );
							bolas[Y].y_  = ( bolas[Y].y_ + (movedist1 * (double)sin(normal + 180000.0)) );
							bolas[Z].x_ = ( bolas[Z].x_ + (movedist2 * (double)cos(normal)) );
							bolas[Z].y_ = ( bolas[Z].y_ + (movedist2 * (double)sin(normal)) );
							
							nx = (double)cos(normal);
							ny = (double)sin(normal);
							
							a1 = ( (bolas[Y].vx_ * nx) + (bolas[Y].vy_ * ny) );
							a2 = ( (bolas[Z].vx_ * nx) + (bolas[Z].vy_ * ny) );
							
							opt = ( (2.0 * (a1 - a2)) / (bolas[Y].mass_ + bolas[Z].mass_) );
							
							bolas[Y].vx_ = (bolas[Y].vx_ - (opt * bolas[Z].mass_ * nx) );
							bolas[Y].vy_ = (bolas[Y].vy_ - (opt * bolas[Z].mass_ * ny) );
							bolas[Z].vx_ = (bolas[Z].vx_ + (opt * bolas[Y].mass_ * nx) );
							bolas[Z].vy_ = (bolas[Z].vy_ + (opt * bolas[Y].mass_ * ny) );
						end
					end
				end	
				
				
				// detectar colisión con las lineas..
				for (Z=0; Z<=TOP_MAXLINES; Z++)	// recorro la lista de lineas..
					X = BallVsLine(	bolas[Y].x_,
									bolas[Y].y_, 
									bolas[Y].radius_, 
									lineas[Z].x0_, 
									lineas[Z].y0_, 
									lineas[Z].x1_, 
									lineas[Z].y1_, 
									offset ix1, 
									offset iy1, 
									offset ix2, 
									offset iy2,
									offset onSegment);
					if(onSegment)	
						if(X == 2)
						    bolas[Y].collisonp=Z+1;
							ix0 = (ix1 + ix2) / 2.0;
							iy0 = (iy1 + iy2) / 2.0;
							
							collisiondistance = ( bolas[Y].radius_ + puntoPared.radius_ );
							actualdistance = GetDistance(bolas[Y].x_, bolas[Y].y_, ix0, iy0);
							normal = atan2( (iy0 - bolas[Y].y_), (ix0 - bolas[Y].x_) );
							movedist1 = ( (collisiondistance - actualdistance)  * (puntoPared.mass_ / (double)(bolas[Y].mass_ + puntoPared.mass_)) ); 
								
							bolas[Y].x_  = ( bolas[Y].x_ + (movedist1 * (double)cos(normal + 180000.0)) );
							bolas[Y].y_  = ( bolas[Y].y_ + (movedist1 * (double)sin(normal + 180000.0)) );
								
							nx = (double)cos(normal);
							ny = (double)sin(normal);
								
							a1 = ( (bolas[Y].vx_ * nx) + (bolas[Y].vy_ * ny) );
							a2 = ( (puntoPared.vx_ * nx) + (puntoPared.vy_ * ny) );
								
							opt = ( (2.0 * (a1 - a2)) / (bolas[Y].mass_ + puntoPared.mass_) );
								
							bolas[Y].vx_ = (bolas[Y].vx_ - (opt * puntoPared.mass_ * nx) );
							bolas[Y].vy_ = (bolas[Y].vy_ - (opt * puntoPared.mass_ * ny) );
						end
					end
				end	
			end
			
		end
		frame;
	end
end



Function double GetDistance(double x1, double y1, double x2, double y2)
begin
	return( (double)sqrt( ((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)) ) );
End

//------------------------------------------------------------------------------------------------------------------------------------------------
/*
The FindLineCircleIntersections function calculates the points of intersection between a line and a circle.
It takes as parameters a circle's center point and radius, and two points on the line. It uses ByRef parameters to return the coordinates of the points of intersection.
The function returns the number of points of intersection (0, 1, or 2).
To fund the points of intersection, the code considers the line as generated by the equations:
 
    X(t) = x1 + (x2 - x1) * t
    Y(t) = y1 + (y2 - y1) * t
Where t ranges from 0 to 1 to draw the line segment.
 
The code plugs these equations into the equation for a circle:
 
    (X - Cx)^2 + (Y - Cy)^2 = radius^2
It then solves for t by using the quadratic formula. The result is 0, 1, or 2 values for t. It plugs those values back into the equations for the line to get the points of intersection.
*/


function BallVsLine(double cx, double cy, double radius, double x1, double y1, double x2, double y2, double * ix1, double * iy1, double * ix2, double * iy2, int * onSegment); // los 4 ultimos parametros deben ser por referencia.. arreglarlo.. guardan los puntos de intersección..
private
        double dx;
        double dy;
        double A;
        double B;
        double C;
        double det;
        double t;
		double U;
begin
        dx = x2 - x1;
        dy = y2 - y1;
        A = dx * dx + dy * dy;
        B = 2.0 * (dx * (x1 - cx) + dy * (y1 - cy));
        C = (x1 - cx) * (x1 - cx) + (y1 - cy) * (y1 - cy) - radius * radius;
        det = B * B - 4.0 * A * C;
        
		//U = ( (Cx-X1)*(X2-X1) + (Cy-Y1)*(Y2-Y1) ) / ( (X2-X1)*(X2-X1) + (Y2-Y1)*(Y2-Y1) );
		U = ( (Cx-X1)*(dx) + (Cy-Y1)*(dy) ) / ( (dx)*(dx) + (dy)*(dy) );
		if(U=>0.0 && U<1)
			*onSegment = true;
		else
			*onSegment = false;
		end
		
		
		If ( (A <= 0.0000001) Or (det < 0.0) )
                Return (0);
        end
        
    If (det == 0)
        t = -B / (2.0 * A);
        *ix1 = x1 + t * dx;
        *iy1 = y1 + t * dy;
        Return (1);
    else
                        t = (-B + Sqrt(det)) / (2.0 * A);
                        *ix1 = x1 + t * dx;
                        *iy1 = y1 + t * dy;
                        t = (-B - Sqrt(det)) / (2.0 * A);
                        *ix2 = x1 + t * dx;
                        *iy2 = y1 + t * dy;
                        Return (2);
        End
end

