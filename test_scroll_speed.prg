PROGRAM TEST_SCROLL_SPEED;
GLOBAL
VEL=1;
FONDO_SCROLL;
string tx;
BEGIN
MODE_set(320,254,32,1,1,0);

FONDO_SCROLL=IMAGE_LOAD("scroll.png");

DEFINE_REGION(25,152,254-32,16,64);

START_SCROLL(0,0,FONDO_SCROLL,0,0,1);
GRAPH=IMAGE_LOAD("sonic.png");CTYPE=C_SCROLL;y=150;
SCROLL.CAMERA=ID;
SCROLL.REGION1=25;
SCROLL.REGION2=0;
SCROLL.speed=5;//bug, no funciona :(

WRITE(0,160,y+32,4,tx);
LOOP

IF(KEY(_right));VEL++;END
IF(KEY(_left));VEL--;END

IF(KEY(_a));SCROLL.speed++;END
IF(KEY(_d));SCROLL.speed--;END

tx="Camera:"+itoa(vel)+"/Scroll:"+itoa(SCROLL.speed);

X+=VEL;
FRAME;
END
END
