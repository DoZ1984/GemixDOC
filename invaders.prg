//**************************************
// JUEGO SPACE INVADERS
//**************************************


PROCESS space_invaders();


PRIVATE
  cont;
 
BEGIN
  fase_arcade = 0;
  cong_aliens = 0;
  
  LOOP
    IF (cont == 1)
      fade(0, 0, 0, 2);
    END
    
    cont++;
    
    IF (cont == 35)
      signal(pr1, s_kill_tree);
      pr3 = main_space();
    END
    
    FRAME;
  END
 
END


//**************************************
// MAIN SPACE INVADERS (pr3)
//**************************************


PROCESS main_space();


PRIVATE
  cont;
  cont2;
  cont3;
  nivel = 1;
  y_alien = 130;
  fase_audio; // para la fase del audio y reproducir el movimiento de los aliens
  
  text_id[4];
  
  score_ref;
 
METHODS
  method callback initialize()
  BEGIN
    text_id[0] = write(0, 65, 31, 0, "SCORE");
    text_id[1] = write(0, 100, 31, 0, OFFSET score_aliens);
    
    text_id[2] = write(0, 58, 41, 0, "HI-SCORE");
    text_id[3] = write(0, 110, 41, 0, OFFSET hi_score_aliens);
    
    text_id[4] = write(0, 160, 31, 0, "LIVES");
  
  method callback finalize()
  BEGIN
    IF (text_id[0] != 0) delete_text(text_id[0]); END
    IF (text_id[1] != 0) delete_text(text_id[1]); END
    IF (text_id[2] != 0) delete_text(text_id[2]); END
    IF (text_id[3] != 0) delete_text(text_id[3]); END
    IF (text_id[4] != 0) delete_text(text_id[4]); END
  END


BEGIN
  minijuego = 1;
  
  archivo = fopen("files/saves/hi-score.dat", "r");
  fread(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
  fclose(archivo);
  
  put_screen(fpg1, 350);
  
  mando_arcade();
  dedo_arcade();
  
  vidas_alien = 3;
  x_alien1 = 60;
  x_alien2 = 60;
  x_alien3 = 60;
  x_alien4 = 60;
  x_alien5 = 60;
  dir_alien = 0; // dirección de los aliens
  vel_alien = 3; // velocidad de los aliens
  vel_space = 18; // velocidad del juego space invaders
  linea_aliens = 0;
  score_aliens = 0;
  
  fade(brillo, brillo, brillo, 2);
  loc = 20;
  
  transicion = 0;
  firsthumo = 0;
  humo2();
  
  LOOP
    // Corrección de velocidad en función de var_vel
    IF (vel_space > 15) 
      IF (var_vel == 4)
        vel_space -= 1;
        var_vel = 0;
      END
    ELSE
      IF (var_vel == 3)
        vel_space -= 1;
        var_vel = 0;
      END
    END
    
    cont3++; // contador para el audio del movimiento
    
    IF (cont3 >= vel_space AND audio == 0 AND cong_aliens == 0 AND fase_arcade == 3 AND g_o_a == 0) 
      fase_audio++;
      cont3 = 0;
      IF (fase_audio == 5) fase_audio = 1; END
      SWITCH (fase_audio)
       CASE 1: sound_play(snd3, fxv, 256); END
       CASE 2: sound_play(snd4, fxv, 256); END
       CASE 3: sound_play(snd5, fxv, 256); END
       CASE 4: sound_play(snd6, fxv, 256); END
      END
    END
    
    IF ((score_extra - score_aliens) < -999) 
      IF (vidas_alien < 3) vidas_alien += 1; END
      score_extra = score_extra + 1000;
    END
    
    IF (fase_arcade == 0) 
      t_ENTER = 1;
      previa_arcade();
      fase_arcade = 1;
      vidas_alien = 0;
      score_aliens = 0;
    END
    
    IF (fase_arcade == 2) 
      fase_arcade = 3;
      vidas_alien = 3;
      x_alien1 = 60;
      x_alien2 = 60;
      x_alien3 = 60;
      x_alien4 = 60;
      x_alien5 = 60;
      dir_alien = 0;
      vel_alien = 3;
      vel_space = 18;
      linea_aliens = 0;
      score_aliens = 0;
      lives_alien();
      nave();
      x_alien1 = 60; x_alien2 = 60; x_alien3 = 60; x_alien4 = 60; x_alien5 = 60;
      nivel = 1;
      
      def(331,75,190,0);
      def(331,75,185,0);
      def(335,75,180,0);
      def(331,80,180,0);
      def(331,85,180,0);
      def(331,85,184,0);
      def(331,90,180,0);
      def(335,96,180,1);
      def(331,95,185,0);
      def(331,95,190,0);
      def(339,80,186,0);
      def(339,91,186,1);
      
      def(331,125,190,0);
      def(331,125,185,0);
      def(335,125,180,0);
      def(331,130,180,0);
      def(331,135,180,0);
      def(331,135,184,0);
      def(331,140,180,0);
      def(335,146,180,1);
      def(331,145,185,0);
      def(331,145,190,0);
      def(339,130,186,0);
      def(339,141,186,1);
      
      def(331,175,190,0);
      def(331,175,185,0);
      def(335,175,180,0);
      def(331,180,180,0);
      def(331,185,180,0);
      def(331,185,184,0);
      def(331,190,180,0);
      def(335,196,180,1);
      def(331,195,185,0);
      def(331,195,190,0);
      def(339,180,186,0);
      def(339,191,186,1);
      
      def(331,225,190,0);
      def(331,225,185,0);
      def(335,225,180,0);
      def(331,230,180,0);
      def(331,235,180,0);
      def(331,235,184,0);
      def(331,240,180,0);
      def(335,246,180,1);
      def(331,245,185,0);
      def(331,245,190,0);
      def(339,230,186,0);
      def(339,241,186,1);
    END
    
    SWITCH (nivel)
     CASE 1 AND fase_arcade > 1:
      linea_aliens = 0;
      dir_alien = 0;
      x_alien1 = 60;
      x_alien2 = 60;
      x_alien3 = 60;
      x_alien4 = 60;
      x_alien5 = 60;
      
      REPEAT
        alien1(x_alien1, 120);
        x_alien1 += 15;
      UNTIL (aliens == 11);
      
      REPEAT
        alien1(x_alien2, 108);
        x_alien2 += 15;
      UNTIL (aliens == 22);
      
      REPEAT
        alien2(x_alien3, 96);
        x_alien3 += 15;
      UNTIL (aliens == 33);
      
      REPEAT
        alien2(x_alien4, 84);
        x_alien4 += 15;
      UNTIL (aliens == 44);
      
      REPEAT
        alien3(x_alien5, 72);
        x_alien5 += 15;
      UNTIL (aliens == 55);
      nivel = 0;
     END
    
    IF (saliendo_minijuego == 1) 
      transicion = 1;
      cont2 = 1;
      fase_arcade = 999;
      saliendo_minijuego = 100;
    END
    
    IF (score_aliens > hi_score_aliens) 
      hi_score_aliens = score_aliens;
      archivo = fopen("files/saves/hi-score.dat", "w");
      fwrite(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
      fclose(archivo);
      archivo = fopen("files/saves/hi-score.dat", "r");
      fread(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
      fclose(archivo);
    END
    
    IF (g_o_a == 1) 
      game_over_arcade();
      g_o_a = 2;
    END
    
    IF (salto_linea == 1) 
      cont++;
    END
    
    IF (cont == 2) 
      salto_linea = 0;
      cont = 0;
    END
    
    IF (cambio_dir == 1) 
      IF (dir_alien == 0) 
        dir_alien = 1;
      ELSE
        dir_alien = 0;
      END
      cambio_dir = 0;
    END
    
    IF (cong_aliens == 0 AND rand(0, 650) > 649 AND hayextra == 0 AND g_o_a == 0 AND fase_arcade == 3) 
      alien_extra();
    END
    
    IF (aliens == 0) 
      vel_space = 18;
      nivel = 1;
    END
    
    IF (vidas_alien == 0 AND fase_arcade == 3) 
      g_o_a = 1;
    END
    
    IF (shoot_crash > 1) 
      shoot_crash = 0;
    END
    
    // SALIMOS DEL MINI-JUEGO
    IF (cont2 > 0) 
      cont2++;
    END
    
    IF (cont2 == 35) 
      signal(pr3, s_kill_tree);
      cong_aliens = 0;
      aliens = 0;
      pr1 = bar();
      cont = 0;
      g_o_a = 0;
      fade(brillo, brillo, brillo, 2);
      saliendo_minijuego = 0;
      fase_arcade = 0;
    END
    
    FRAME;
  END
 
END


//**************************************
// PANTALLA PREVIA SPACE INVADERS
//**************************************


PROCESS previa_arcade();


PRIVATE
  t1; t2; t3; t4; t5; t6; t7; t8; t9; t10;
  cont;
 
BEGIN
  archivo = fopen("files/saves/hi-score.dat", "r");
  fread(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
  fclose(archivo);
  
  t1 = write(0, 160, 80, 1, "PLAY SPACE INVADERS");
  
  t2 = write(0, 152, 108, 0, "= MISTERY");
  t3 = write(0, 152, 120, 0, "= 30 PTS");
  t4 = write(0, 152, 132, 0, "= 20 PTS");
  t5 = write(0, 152, 144, 0, "= 10 PTS");
  
  t6 = write(0, 160, 170, 1, "PRESS ENTER TO PLAY");
  
  graph = 314;
  
  x = 135; y = 130;
  
  transicion = 0;
  
  LOOP
    cont++;
    
    IF (cont == 24) delete_text(t6); END
    IF (cont == 48) 
      t6 = write(0, 160, 170, 1, "PRESS ENTER TO PLAY");
      cont = 0;
    END
    
    IF (keydown(_ENTER) AND t_ENTER == 0) 
      t_ENTER = 1;
      IF (cont < 24) 
        delete_text(t6);
        delete_text(t1);
        delete_text(t2);
        delete_text(t3);
        delete_text(t4);
        delete_text(t5);
        fase_arcade = 2;
        BREAK;
      END
    END
    
    FRAME;
  END
 
END


//**************************************
// MANDO SPACE INVADERS
//**************************************


PROCESS mando_arcade();


BEGIN
  graph = 326;
  
  x = 40; y = 230;
  
  LOOP
    IF (transicion == 0) 
      IF (keydown(_left))  x = 30; y = 232; END
      IF (keydown(_right))  x = 50; y = 232; END
      IF (NOT keydown(_left) AND NOT keydown(_right))  x = 40; y = 230; END
    END
    
    FRAME;
  END
 
END


//**************************************
// DEDO SPACE INVADERS
//**************************************


PROCESS dedo_arcade();


BEGIN
  graph = 328;
  
  x = 81; y = 237;
  
  LOOP
    IF (keydown(_space)) 
      graph = 327;
      y = 237;
    ELSE
      graph = 328;
      y = 238;
    END
    
    FRAME;
  END
 
END


//**************************************
// GAME OVER SPACE INVADERS
//**************************************


PROCESS game_over_arcade();


PRIVATE
  t1; // texto 1
  cont;
  cont2;
 
BEGIN
  IF (score_aliens > hi_score_aliens) 
    hi_score_aliens = score_aliens;
    archivo = fopen("files/saves/hi-score.dat", "w");
    fwrite(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
    fclose(archivo);
    archivo = fopen("files/saves/hi-score.dat", "r");
    fread(OFFSET hi_score_aliens, sizeof(hi_score_aliens), archivo);
    fclose(archivo);
  END
  
  write(0, 160, 120, 1, "GAME OVER");
  
  LOOP
    cont++;
    
    IF (cont == 60) 
      fade(0, 0, 0, 2);
      transicion = 1;
      cont2 = 1;
    END
    
    IF (cont2 > 0)  cont2++; END
    
    IF (cont2 == 35) 
      signal(pr3, s_kill_tree);
      volviendo_minijuego = 1;
      aliens = 0;
      pr1 = bar();
      cont = 0;
      g_o_a = 0;
      fade(brillo, brillo, brillo, 2);
      END
    
    FRAME;
  END
 
END


//**************************************
// LIVES SPACE INVADERS
//**************************************


PROCESS lives_alien();


BEGIN
  x = 220; y = 34;
  
  LOOP
    SWITCH (vidas_alien)
      CASE 3: graph = 325; END
      CASE 2: graph = 324; END
      CASE 1: graph = 323; END
      CASE 0: graph = 322; END
    END
    
    IF (fase_arcade != 3)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// NAVE SPACE INVADERS
//**************************************


PROCESS nave();


PRIVATE
  tope;
  death;
  cont; cont2;
  vel;
  run;
 
BEGIN
  graph = 300;
  
  x = 63; y = 206;
  
  LOOP
    IF (transicion == 0 AND death == 0) 
      IF (keydown(_left)) 
        run++;
        x -= vel;
        IF (run < 6)  vel = 3; ELSE vel = 4; END
      END
      IF (keydown(_right)) 
        run++;
        x += vel;
        IF (run < 6)  vel = 3; ELSE vel = 4; END
      END
      IF (NOT keydown(_left) AND NOT keydown(_right))  run = 0; END
      
      IF (keydown(_space) AND tope_laser == 0 AND tope == 0) 
        pr2 = laser(x, y - 5);
        tope_laser = 1;
        tope = 1;
        IF (audio == 0)  sound_play(snd1, fxv, 256); END
      END
      
      IF (NOT keydown(_space) AND tope == 1)  tope = 0; END
      
      IF (collision(TYPE disparo_alien1) OR collision(TYPE disparo_alien2)) 
        death = 1;
        IF (audio == 0)  sound_play(snd2, fxv, 27); END
      END
      
      IF (death == 1) 
        cong_aliens = 1;
        cont++;
      END
      
      IF (cont == 1)  graph = 301; END
      IF (cont == 8)  graph = 302; END
      IF (cont == 15) 
        cont = 0;
        cont2++;
      END
      
      IF (cont2 == 5) 
        x = 63;
        graph = 300;
        tope_laser = 0;
        cont2 = 0;
        cont = 0;
        vidas_alien -= 1;
        death = 0;
        cong_aliens = 0;
      END
      
      IF (x <= 63)  x = 63; END
      IF (x >= 257)  x = 257; END
      
      IF (g_o_a != 0) 
        IF (audio == 0)  stop_sound(all_sound); END
        BREAK;
      END
      
      FRAME;
  END
 
END


//**************************************
// LASER SPACE INVADERS (pr2)
//**************************************


PROCESS laser(x, y);


PRIVATE
  death;
 
BEGIN
  graph = 310;
  
  LOOP
    IF (cong_aliens == 0 AND death == 0 AND NOT collision(TYPE def) AND NOT collision(TYPE def) AND NOT collision(TYPE def)) 
      y -= 7;
    END
    
    IF (y < 50)  tope_laser = 0; BREAK; END
    
    IF (death > 0) 
      death++;
      graph = 311;
    END
    
    IF (death == 3 OR death == -1) 
      tope_laser = 0;
      BREAK;
    END
    
    IF (collision(TYPE disparo_alien1) OR collision(TYPE disparo_alien2)) 
      graph = 311;
      death = 1;
    END
    
    IF (collision(TYPE def) OR collision(TYPE def) OR collision(TYPE def)) 
      death = -1;
    END
    
    IF (g_o_a == 1)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// def
//**************************************


PROCESS def(graph, x, y, flags);


PRIVATE
  tope;
 
BEGIN
  SWITCH (graph)
    CASE 331: tope = 334; END
    CASE 335: tope = 338; END
    CASE 339: tope = 342; END
  END
  
  size = 105;
  
  LOOP
    IF (collision(TYPE laser)) 
      tope_laser = 0;
      graph++;
      IF (graph > tope)  BREAK; END
    END
    
    IF (collision(TYPE disparo_alien1) OR collision(TYPE disparo_alien2)) 
      graph++;
    END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// ALIEN 1
//**************************************


PROCESS alien1(x, y);


PRIVATE
  cont;
  cont2;
  death;
  tope_linea;
  cont_s;
 
BEGIN
  graph = 303;
  
  z = 1;
  
  aliens++;
  
  LOOP
    IF (cong_aliens == 0)  cont++; END
    
    IF (salto_linea == 1 AND tope_linea == 0) 
      y += 12;
      tope_linea = 1;
    END
    IF (salto_linea == 0)  tope_linea = 0; END
    
    IF (cont >= vel_space) 
      IF (dir_alien == 0) 
        IF (death == 0) 
          graph++;
          x += vel_alien;
          cont = 0;
        END
        IF (x >= 260) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
      IF (dir_alien == 1) 
        IF (death == 0) 
          graph++;
          x -= vel_alien;
          cont = 0;
        END
        IF (x <= 60) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
    END
    
    IF (graph > 304 AND graph != 311)  graph = 303; END
    
    // COLISION CON LASER DE LA NAVE
    IF (collision(TYPE laser) AND graph != 311) 
      signal(pr2, s_kill);
      tope_laser = 0;
      death = 1;
      graph = 311;
      aliens--;
      score_aliens += 10;
      var_vel++;
      suma_exp(80, 245, 10, fnt6, 0);
      suma_gscore(80, 235, 100, fnt7, 0);
      IF (audio == 0)  sound_play(snd2, fxv, 80); END
    END
    
    IF (death == 1)  cont2++; END
    IF (cont2 == 6)  BREAK; END
    
    IF (cont_s == 0) 
      IF (rand(0, 200) > 199 AND cong_aliens == 0) 
        cont_s = 1;
        disparo_fake(x, y + 8);
      END
    END
    
    IF (canshoot == 1) 
      disparo_alien1(x, y);
      cont_s = 1;
      canshoot = 0;
    END
    
    IF (cont_s > 0)  cont_s++; END
    IF (cont_s == 48)  cont_s = 0; END
    
    IF (y == 120 AND linea_aliens < 1)  linea_aliens = 1; END
    IF (y == 132 AND linea_aliens < 2)  linea_aliens = 2; END
    IF (y == 144 AND linea_aliens < 3)  linea_aliens = 3; END
    IF (y == 156 AND linea_aliens < 4)  linea_aliens = 4; END
    IF (y == 168 AND linea_aliens < 5)  linea_aliens = 5; END
    IF (y == 180 AND linea_aliens < 6)  linea_aliens = 6; END
    IF (y == 192 AND linea_aliens < 7)  linea_aliens = 7; END
    IF (y == 204 AND linea_aliens < 8) 
      linea_aliens = 8;
      g_o_a = 1;
      BREAK;
    END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// ALIEN 2
//**************************************


PROCESS alien2(x, y);


PRIVATE
  cont;
  cont2;
  death;
  tope_linea;
  cont_s;
 
BEGIN
  graph = 305;
  
  z = 1;
  
  aliens++;
  
  LOOP
    IF (cong_aliens == 0)  cont++; END
    
    IF (salto_linea == 1 AND tope_linea == 0) 
      y += 12;
      tope_linea = 1;
    END
    IF (salto_linea == 0)  tope_linea = 0; END
    
    IF (cont >= vel_space) 
      IF (dir_alien == 0) 
        IF (death == 0) 
          graph++;
          x += vel_alien;
          cont = 0;
        END
        IF (x >= 260) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
      IF (dir_alien == 1) 
        IF (death == 0) 
          graph++;
          x -= vel_alien;
          cont = 0;
        END
        IF (x <= 60) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
    END
    
    IF (graph > 306 AND graph != 311)  graph = 305; END
    
    IF (collision(TYPE laser) AND graph != 311) 
      signal(pr2, s_kill);
      tope_laser = 0;
      death = 1;
      graph = 311;
      aliens--;
      score_aliens += 20;
      var_vel++;
      suma_exp(80, 245, 20, fnt6, 0);
      suma_gscore(80, 235, 200, fnt7, 0);
      IF (audio == 0)  sound_play(snd2, fxv, 85); END
    END
    
    IF (death == 1)  cont2++; END
    IF (cont2 == 6)  BREAK; END
    
    IF (cont_s == 0) 
      IF (rand(0, 200) > 199 AND cong_aliens == 0) 
        cont_s = 1;
        disparo_fake(x, y + 8);
      END
    END
    
    IF (canshoot == 1) 
      disparo_alien2(x, y);
      cont_s = 1;
      canshoot = 0;
    END
    
    IF (cont_s > 0)  cont_s++; END
    IF (cont_s == 48)  cont_s = 0; END
    
    IF (y == 120 AND linea_aliens < 1)  linea_aliens = 1; END
    IF (y == 132 AND linea_aliens < 2)  linea_aliens = 2; END
    IF (y == 144 AND linea_aliens < 3)  linea_aliens = 3; END
    IF (y == 156 AND linea_aliens < 4)  linea_aliens = 4; END
    IF (y == 168 AND linea_aliens < 5)  linea_aliens = 5; END
    IF (y == 180 AND linea_aliens < 6)  linea_aliens = 6; END
    IF (y == 192 AND linea_aliens < 7)  linea_aliens = 7; END
    IF (y == 204 AND linea_aliens < 8) 
      linea_aliens = 8;
      g_o_a = 1;
      BREAK;
    END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// ALIEN 3
//**************************************


PROCESS alien3(x, y);


PRIVATE
  cont;
  cont2;
  death;
  tope_linea;
  cont_s;
 
BEGIN
  graph = 307;
  
  z = 1;
  
  aliens++;
  
  LOOP
    IF (cong_aliens == 0)  cont++; END
    
    IF (salto_linea == 1 AND tope_linea == 0) 
      y += 12;
      tope_linea = 1;
    END
    IF (salto_linea == 0)  tope_linea = 0; END
    
    IF (cont >= vel_space) 
      IF (dir_alien == 0) 
        IF (death == 0) 
          graph++;
          x += vel_alien;
          cont = 0;
        END
        IF (x >= 260) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
      IF (dir_alien == 1) 
        IF (death == 0) 
          graph++;
          x -= vel_alien;
          cont = 0;
        END
        IF (x <= 60) 
         cambio_dir = 1;
         salto_linea = 1;
        END
      END
    END
    
    IF (graph > 308 AND graph != 311)  graph = 307; END
    
    IF (collision(TYPE laser) AND graph != 311) 
      signal(pr2, s_kill);
      tope_laser = 0;
      death = 1;
      graph = 311;
      aliens--;
      score_aliens += 30;
      var_vel++;
      suma_exp(80, 245, 30, fnt6, 0);
      suma_gscore(80, 235, 300, fnt7, 0);
      IF (audio == 0)  sound_play(snd2, fxv, 90); END
    END
    
    IF (death == 1)  cont2++; END
    IF (cont2 == 6)  BREAK; END
    
    IF (cont_s == 0) 
      IF (rand(0, 200) > 199 AND cong_aliens == 0) 
        cont_s = 1;
        disparo_fake(x, y + 8);
      END
    END
    
    IF (canshoot == 1) 
      disparo_alien2(x, y);
      cont_s = 1;
      canshoot = 0;
    END
    
    IF (cont_s > 0)  cont_s++; END
    IF (cont_s == 48)  cont_s = 0; END
    
    IF (y == 120 AND linea_aliens < 1)  linea_aliens = 1; END
    IF (y == 132 AND linea_aliens < 2)  linea_aliens = 2; END
    IF (y == 144 AND linea_aliens < 3)  linea_aliens = 3; END
    IF (y == 156 AND linea_aliens < 4)  linea_aliens = 4; END
    IF (y == 168 AND linea_aliens < 5)  linea_aliens = 5; END
    IF (y == 180 AND linea_aliens < 6)  linea_aliens = 6; END
    IF (y == 192 AND linea_aliens < 7)  linea_aliens = 7; END
    IF (y == 204 AND linea_aliens < 8) 
      linea_aliens = 8;
      g_o_a = 1;
      BREAK;
    END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// DISPARO ALIEN FAKE
//**************************************


PROCESS disparo_fake(x, y);


BEGIN
  graph = 22;
  
  visible = 0;
  
  z = 100;
  
  LOOP
    y += 8;
    
    IF (y > 195) 
      father.canshoot = 1;
      BREAK;
    END
    
    IF (collision(TYPE alien1) OR collision(TYPE alien2) OR collision(TYPE alien3))  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// DISPARO ALIEN 1
//**************************************


PROCESS disparo_alien1(x, y);


PRIVATE
  cont;
  cont2;
  death;
 
BEGIN
  y += 2;
  
  graph = 313;
  
  LOOP
    IF (cong_aliens == 0) 
      cont++;
      cont2++;
    END
    
    IF (cong_aliens == 0 AND death == 0)  y += 3; END
    
    IF (cont == 2)  graph = 329; END
    
    IF (cont2 == 4)  flags = 2; END
    IF (cont2 == 8)  flags = 0; cont2 = 0; END
    
    IF (death == 1)  BREAK; END
    
    IF (collision(TYPE nave))  death = 1; END
    
    IF (collision(TYPE alien1))  BREAK; END
    
    IF (collision(TYPE def) OR collision(TYPE def) OR collision(TYPE def))  death = 1; END
    
    IF (collision(TYPE laser)) 
      death = 1;
      BREAK;
    END
    
    IF (y > 210)  BREAK; END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// DISPARO ALIEN 2
//**************************************


PROCESS disparo_alien2(x, y);


PRIVATE
  cont;
  cont2;
  death;
 
BEGIN
  y += 2;
  
  graph = 313;
  
  LOOP
    IF (cong_aliens == 0) 
      cont++;
      cont2++;
    END
    
    IF (cong_aliens == 0 AND death == 0)  y += 4; END
    
    IF (cont2 == 2)  graph = 330; END
    
    IF (cont == 3)  flags = 1; END
    IF (cont == 6)  flags = 0; cont = 0; END
    
    IF (death == 1)  BREAK; END
    
    IF (collision(TYPE nave))  death = 1; END
    
    IF (collision(TYPE alien1) OR collision(TYPE alien2))  BREAK; END
    
    IF (collision(TYPE def) OR collision(TYPE def) OR collision(TYPE def))  death = 1; END
    
    IF (collision(TYPE laser))  shoot_crash += 1; END
    
    IF (shoot_crash > 0)  shoot_crash++; BREAK; END
    
    IF (y > 210)  BREAK; END
    
    IF (g_o_a != 0)  BREAK; END
    
    FRAME;
  END
 
END


//**************************************
// ALIEN EXTRA
//**************************************


PROCESS alien_extra();


PRIVATE
  death;
  text;
  cont;
  cont2;
  premio_extra;
 
BEGIN
  hayextra = 1;
  
  premio_extra = rand(1, 3);
  
  SWITCH (premio_extra)
    CASE 1: premio_extra = 100; END
    CASE 2: premio_extra = 200; END
    CASE 3: premio_extra = 300; END
  END
  
  graph = 309;
  
  y = 59;
  
  IF (lado_extra == 0)  x = 60; ELSE x = 260; END
  
  IF (audio == 0)  sound_play(snd7, fxv, 230); END
  
  LOOP
    IF (cong_aliens == 0)  cont++; END
    
    IF (lado_extra == 0) 
      IF (death == 0)  x += 2; END;
      cont = 0;
    ELSE
      IF (death == 0)  x -= 2; END;
      cont = 0;
    END
    
    IF (x < 52)  lado_extra = 0; hayextra = 0; BREAK; END
    IF (x > 268)  lado_extra = 1; hayextra = 0; BREAK; END
    
    IF (collision(TYPE laser) AND death == 0) 
      IF (x < 55)  x = 55; END
      IF (x > 265)  x = 265; END
      death = 1;
      score_aliens += premio_extra;
      suma_exp(x, y, 50, fnt6, 0);
      suma_gscore(x, y - 10, 500, fnt7, 0);
      IF (audio == 0) 
        stop_sound(all_sound);
        sound_play(snd2, fxv, 100);
      END
    END
    
    IF (death > 0 AND cong_aliens == 0)  death++; END
    
    IF (death >= 1 AND death < 10)  graph = 315; END
    
    IF (death == 10) 
      graph = 22;
      text = write_int(0, x - 8, y - 4, 0, OFFSET premio_extra);
    END
    
    IF (death == 34)  hayextra = 0; delete_text(text); BREAK; END
    
    IF (g_o_a != 0)  hayextra = 0; BREAK; END
    
    IF (cong_aliens == 0)  cont2++; END  // contador para el fx
    
    IF (cont2 == 52 AND audio == 0)  sound_play(snd7, fxv, 230); END
    
    FRAME;
  END
 
END