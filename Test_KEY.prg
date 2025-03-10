//-------------------------------------------------
//- Testing Funciones Fenix                       -
//- Autor: Francesco Amato (CicTec)               -
//- Grupo: Xam Soft                               -
//-------------------------------------------------
// OK ;) 
program Test_KEY;
global
  keys[128];
  tipo=1;
  STRING CADENA,ESPECIAL;
begin
SET_MODE(320,200,16,1,2,0);set_fps(60,0);
mouse.graph=new_map(1,1,rgb(255,0,0));
  write(0,10,10,3,"Test KEY...");
  write(0,0,30,0,"Codigos de teclas pulsados:");
  from x=0 to 127;
    write_int(0,(x%16)*20,(x/16)*10+40,0,&keys[x]);
  end
  write(0,0,130,0,"1 & F1) NO cKEY - 2 & F1) SI cKEY, USO actual:");
  write_int(0,320,130,2,&tipo);
  write(0,0,150,0,"Codigo de ultimo tecla pulsado (scan_code):");
  write_int(0,320,150,2,&scan_code);
  write(0,0,160,0,"Codigo ASCII de ultimo tecla (ascii):");
  write_int(0,320,160,2,&ascii);
  write(0,0,0,0,CADENA);
  write(0,0,170,0,"Estado de los teclas especiales (shift_status):");
  write_int(0,320,170,2,&shift_status);
  write(0,160,190,4,"Pulsa ESC & F1 para Salir...");
  //ignore_error(101);
  write(0,320,0,2,ESPECIAL);
  repeat
  CADENA=ascii;
    if(key(_1) && key(_F1)) tipo=1; end
    if(key(_2) && key(_F1)) tipo=2; end
    switch(Tipo)
      case 1:
        from x=1 to 127;
          if(key(x)) keys[x]=x; else keys[x]=0; end
        end
      end
      case 2:
      	while(key(_ESC))         keys[1]=1;   frame; end keys[1]=0;
	while(key(_1))	         keys[2]=2;   frame; end keys[2]=0;
	while(key(_2))	         keys[3]=3;   frame; end keys[3]=0;
	while(key(_3))	         keys[4]=4;   frame; end keys[4]=0;
	while(key(_4))	         keys[5]=5;   frame; end keys[5]=0;
	while(key(_5))	         keys[6]=6;   frame; end keys[6]=0;
	while(key(_6))	         keys[7]=7;   frame; end keys[7]=0;
	while(key(_7))	         keys[8]=8;   frame; end keys[8]=0;
	while(key(_8))	         keys[9]=9;   frame; end keys[9]=0;
	while(key(_9))	         keys[10]=10; frame; end keys[10]=0;
	while(key(_0))	         keys[11]=11; frame; end keys[11]=0;
	while(key(_MINUS))       keys[12]=12; frame; end keys[12]=0;
	while(key(_PLUS))        keys[13]=13; frame; end keys[13]=0;
	while(key(_BACKSPACE))   keys[14]=14; frame; end keys[14]=0;
	while(key(_TAB))         keys[15]=15; frame; end keys[15]=0;
	while(key(_Q))	         keys[16]=16; frame; end keys[16]=0;
	while(key(_W))	         keys[17]=17; frame; end keys[17]=0;
	while(key(_E))	         keys[18]=18; frame; end keys[18]=0;
	while(key(_R))	         keys[19]=19; frame; end keys[19]=0;
	while(key(_T))	         keys[20]=20; frame; end keys[20]=0;
	while(key(_Y))	         keys[21]=21; frame; end keys[21]=0;
	while(key(_U))	         keys[22]=22; frame; end keys[22]=0;
	while(key(_I))	         keys[23]=23; frame; end keys[23]=0;
	while(key(_O))	         keys[24]=24; frame; end keys[24]=0;
	while(key(_P))	         keys[25]=25; frame; end keys[25]=0;
//	while(key(_L_BRACHET))   keys[26]=26; frame; end keys[26]=0;
//	while(key(_R_BRACHET))   keys[27]=27; frame; end keys[27]=0;
	while(key(_ENTER))       keys[28]=28; frame; end keys[28]=0;
	while(key(_C_ENTER))     keys[28]=28; frame; end keys[28]=0;
	while(key(_CONTROL))     keys[29]=29; frame; end keys[29]=0;
	while(key(_A))	         keys[30]=30; frame; end keys[30]=0;
	while(key(_S))	         keys[31]=31; frame; end keys[31]=0;
	while(key(_D))           keys[32]=32; frame; end keys[32]=0;
	while(key(_F))	         keys[33]=33; frame; end keys[33]=0;
	while(key(_G))	         keys[34]=34; frame; end keys[34]=0;
	while(key(_H))	         keys[35]=35; frame; end keys[35]=0;
	while(key(_J))	         keys[36]=36; frame; end keys[36]=0;
	while(key(_K))	         keys[37]=37; frame; end keys[37]=0;
	while(key(_L))	         keys[38]=38; frame; end keys[38]=0;
	while(key(_SEMICOLON))   keys[39]=39; frame; end keys[39]=0;
	while(key(_APOSTROPHE))  keys[40]=40; frame; end keys[40]=0;
	while(key(_WAVE))	 keys[41]=41; frame; end keys[41]=0;
	while(key(_L_SHIFT))     keys[42]=42; frame; end keys[42]=0;
	while(key(_BACKSLASH))   keys[43]=43; frame; end keys[43]=0;
	while(key(_Z))	         keys[44]=44; frame; end keys[44]=0;
	while(key(_X))	         keys[45]=45; frame; end keys[45]=0;
	while(key(_C))	         keys[46]=46; frame; end keys[46]=0;
	while(key(_V))	         keys[47]=47; frame; end keys[47]=0;
	while(key(_B))	         keys[48]=48; frame; end keys[48]=0;
	while(key(_N))	         keys[49]=49; frame; end keys[49]=0;
	while(key(_M))	         keys[50]=50; frame; end keys[50]=0;
	while(key(_COMMA))	 keys[51]=51; frame; end keys[51]=0;
	while(key(_POINT))	 keys[52]=52; frame; end keys[52]=0;
	while(key(_SLASH))	 keys[53]=53; frame; end keys[53]=0;
	while(key(_C_BACKSLASH)) keys[53]=53; frame; end keys[53]=0;
	while(key(_R_SHIFT))     keys[54]=54; frame; end keys[54]=0;
	while(key(_PRN_SCR))     keys[55]=55; frame; end keys[55]=0;
	while(key(_C_ASTERISK))  keys[55]=55; frame; end keys[55]=0;
	while(key(_ALT))	 keys[56]=56; frame; end keys[56]=0;
	while(key(_SPACE))       keys[57]=57; frame; end keys[57]=0;
	while(key(_CAPS_LOCK))   keys[58]=58; frame; end keys[58]=0;
	while(key(_F1))	         keys[59]=59; frame; end keys[59]=0;
	while(key(_F2))	         keys[60]=60; frame; end keys[60]=0;
	while(key(_F3))	         keys[61]=61; frame; end keys[61]=0;
	while(key(_F4))	         keys[62]=62; frame; end keys[62]=0;
	while(key(_F5))	         keys[63]=63; frame; end keys[63]=0;
	while(key(_F6))	         keys[64]=64; frame; end keys[64]=0;
	while(key(_F7))	         keys[65]=65; frame; end keys[65]=0;
	while(key(_F8))	         keys[66]=66; frame; end keys[66]=0;
	while(key(_F9))	         keys[67]=67; frame; end keys[67]=0;
	while(key(_F10))	 keys[68]=68; frame; end keys[68]=0;
	while(key(_NUM_LOCK))    keys[69]=69; frame; end keys[69]=0;
	while(key(_SCROLL_LOCK)) keys[70]=70; frame; end keys[70]=0;
	while(key(_HOME))	 keys[71]=71; frame; end keys[71]=0;
	while(key(_C_HOME))      keys[71]=71; frame; end keys[71]=0;
	while(key(_UP))	         keys[72]=72; frame; end keys[72]=0;
	while(key(_C_UP))	 keys[72]=72; frame; end keys[72]=0;
	while(key(_PGUP))	 keys[73]=73; frame; end keys[73]=0;
	while(key(_C_PGUP))      keys[73]=73; frame; end keys[73]=0;
	while(key(_C_MINUS))     keys[74]=74; frame; end keys[74]=0;
	while(key(_LEFT))	 keys[75]=75; frame; end keys[75]=0;
	while(key(_C_LEFT))      keys[75]=75; frame; end keys[75]=0;
	while(key(_C_CENTER))    keys[76]=76; frame; end keys[76]=0;
	while(key(_RIGHT))	 keys[77]=77; frame; end keys[77]=0;
	while(key(_C_RIGHT))     keys[77]=77; frame; end keys[77]=0;
	while(key(_C_PLUS))      keys[78]=78; frame; end keys[78]=0;
	while(key(_END))	 keys[79]=79; frame; end keys[79]=0;
	while(key(_C_END))       keys[79]=79; frame; end keys[79]=0;
	while(key(_DOWN))	 keys[80]=80; frame; end keys[80]=0;
	while(key(_C_DOWN))      keys[80]=80; frame; end keys[80]=0;
	while(key(_PGDN))	 keys[81]=81; frame; end keys[81]=0;
	while(key(_C_PGDN))      keys[81]=81; frame; end keys[81]=0;
	while(key(_INS))	 keys[82]=82; frame; end keys[82]=0;
	while(key(_C_INS))       keys[82]=82; frame; end keys[82]=0;
	while(key(_DEL))	 keys[83]=83; frame; end keys[83]=0;
	while(key(_C_DEL))       keys[83]=83; frame; end keys[83]=0;
	while(key(_F11))	 keys[87]=87; frame; end keys[87]=0;
	while(key(_F12))	 keys[88]=88; frame; end keys[88]=0;
      end
    end

    ESPECIAL="mouse.xy:"+itoa(mouse.x)+","+itoa(mouse.y)+" b.L:"+itoa(mouse.left)+" W:"+itoa(mouse.middle)+" R:"+itoa(mouse.right)+" rl."+itoa(mouse.wheelroll);
    frame;
  until(key(_esc) && key(_F1))
end
