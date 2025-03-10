PROGRAM TEST_REST;
CONST
TOP_RES=8;
GLOBAL

RES_X[TOP_RES]=480,
			640,
			800,
			854,
			800,
			960,
			960,
			1024,
			1024;
			
RES_Y[TOP_RES]=320,
			480,
			480,
			480,
			600,
			540,
			640,
			600,
			768;
PRIVATE
C;			
BEGIN
SET_MODE(640,480,16);

GRAPH=NEW_MAP(RES_X[TOP_RES],RES_Y[TOP_RES]);

FROM C=TOP_RES TO 0;
 MAP_PUT_RECT(0,GRAPH,0,0,RES_X[C],RES_Y[C],rgb(rand(0,255),rand(0,255),rand(0,255)),true);
 
 MAP_PUT_TEXT_B(0,itoa(RES_X[C])+","+itoa(RES_Y[C]),7,0,GRAPH,RES_X[C]/2,RES_Y[C],0,200,200,0,0,0,0,255,fx_xorblend);
 MAP_PUT_TEXT_B(0,itoa(RES_X[C])+","+itoa(RES_Y[C]),7,0,GRAPH,RES_X[C],RES_Y[C]/2,90000,200,200,0,0,0,0,255,fx_xorblend);
END

SAVE_IMAGE(0,GRAPH,"res.png",img_format_png);
EXIT("OK",0);
END


FUNCTION MAP_PUT_TEXT_B(INT nfnt, STRING text, INT align,file_dst,graph_dst,x,y,angle=0,size_x=100,size_y=100,shear_x=0,shear_y=0,tfmorder=0,flags=0,alpha=255,fxmode=0,fxcolor=0,fxintensity=0);
BEGIN
GRAPH=WRITE_IN_MAP(nfnt,text,align);
MAP_XXPUT(file_dst,graph_dst,0,graph,x,y,angle,size_x,size_y,shear_x,shear_y,tfmorder,flags,alpha,fxmode,fxcolor,fxintensity);			
UNLOAD_MAP(GRAPH);
END
