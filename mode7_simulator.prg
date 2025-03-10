program mode7_simulator;

global
  gfx_island;
  gfx_sea;
  gfx_clouds;
  gfx_world;

private
  vel = 0;
  ang = 0;
  
  wid;
  
begin
  set_mode(640, 360, 32);
  set_fps(30, 0);

  write_int(0, 10, 10, 0, &fps);
//  write_int(0, 10, 30, 0, &m7.focus);
  
  gfx_island = load_map("images/island.map");
  gfx_sea    = load_map("images/sea.map");
  gfx_clouds = load_map("images/clouds.map");
  gfx_world  = new_map(680, 440, 0);
  
  define_region(1, 0, 0, 680, 440);
  start_mode7(0, 0, gfx_island, gfx_sea, 1, 220);
  set_mode7_destination(0, 0, gfx_world, 1);
  m7.distance   = 50;
  m7.height     = 100;
  m7.camera     = id;
  m7.fog        = m7fog_cubic;
  m7.fogcolor   = rgb(255, 255, 255);
  m7.fogdensity = 0.15;
  
  start_mode7(1, 0, gfx_clouds, gfx_clouds, 1, 221);
  set_mode7_destination(1, 0, gfx_world, 1);
  m7[1].camera = id;
   
  ctype      = c_m7;
  resolution = 10;

  world();
    
  repeat
    if(key(_a))
      ang += 200;
      if(ang > 2000) ang = 2000; end
    elseif(key(_d))
      ang -= 200;
      if(ang < -2000) ang = -2000; end
    else
      if(ang > 0)
        ang -= 200;
        if(ang < 0) ang = 0; end
      elseif(ang < 0)
        ang += 200;
        if(ang > 0) ang = 0; end
      end
    end
    
    if(key(_w))
      m7.height += 2;
    elseif(key(_s))
      m7.height -= 2;
    end
    
    if(key(_y))
      m7.fogdensity += 0.01;
    elseif(key(_h))
      m7.fogdensity -= 0.01;
    end
    
    if(key(_u))
      repeat frame; until(!key(_u))
      m7.fog++;
      if(m7.fog > m7fog_circ) m7.fog = m7fog_none; end
    end
    
    if(key(_i))
      repeat frame; until(!key(_i))
      m7.fog = m7fog_none;
    elseif(key(_k))
      repeat frame; until(!key(_k))
      m7.fog = m7fog_cubic;
    end
    
    if(key(_o))
      m7.focus++;
    elseif(key(_l))
      m7.focus--;
    end
    
    //if(key(_space))
      vel++;
      if(vel > 60) vel = 60; end
    //else
    //  vel--;
    //  if(vel < 0) vel = 0; end
    //end
    
    if(key(_enter))
      repeat frame; until(!key(_enter))
      m7.fogcolor = rgb(rand(0, 255), rand(0, 255), rand(0, 255));
    end
    
    m7[1].fog        = m7.fog;
    m7[1].fogcolor   = m7.fogcolor;
    m7[1].fogdensity = m7.fogdensity;
    m7[1].height     = m7.height + -800;
    m7[1].distance   = m7.distance;
    m7[1].focus      = m7.focus;
   
    advance(vel);
    angle += ang;
    
    frame;
  until(key(_esc))
  
  let_me_alone(); 
end

process world()
private
  ang;
  
begin
  x     = 320;
  y     = 180;
  graph = gfx_world;
  
  loop
    if(key(_d))
      ang += 500;
      if(ang > 12000) ang = 12000; end
    elseif(key(_a))
      ang -= 500;
      if(ang < -12000) ang = -12000; end
    else
      if(ang > 0)
        ang -= 250;
        if(ang < 0) ang = 0; end
      elseif(ang < 0)
        ang += 250;
        if(ang > 0) ang = 0; end
      end
    end
    
    angle = ang;
    
    frame;
  end
end