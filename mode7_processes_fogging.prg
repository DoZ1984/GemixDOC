program mode7_processes_fogging;

global
  gfx_island;
  gfx_sea;
  gfx_clouds;
  gfx_world;
  gfx_tree;

private
  vel = 0;
  ang = 0;
  
  cont;
  
begin
  set_mode(640, 360, 32);
  //set_fps(0, 0);
  write_int(0, 10, 10, 0, &fps);
  
  gfx_island = load_map("images/island.map");
  gfx_sea = load_map("images/sea.map");
  gfx_clouds = load_map("images/clouds.map");
  gfx_tree = load_map("images/tree.map");
  gfx_world = new_map(680, 440, 0);
  
  define_region(1, 0, 0, 680, 440);
  start_mode7(0, 0, gfx_island, gfx_sea, 1, 220);
  set_mode7_destination(0, 0, gfx_world, 1);
  m7.distance = 0;
  m7.height = 100;
  m7.camera = id;
  m7.fog = 0;
  m7.fogcolor = 0;
  m7.fogdensity = 0.15;
  
  write_float(0, 10, 20, 0, &m7.fogdensity);
  
  start_mode7(1, 0, gfx_clouds, gfx_clouds, 1, 221);
  set_mode7_destination(1, 0, gfx_world, 1);
  m7[1].camera = id;
  
  
  ctype      = c_m7;
  resolution = 10;
  
  for(cont = 0; cont < 100; cont++)
    tree();
  end

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
      if(m7.fog > 8) m7.fog = 0; end
    end
    
    if(key(_i))
      repeat frame; until(!key(_i))
      m7.fog = true;
    elseif(key(_k))
      repeat frame; until(!key(_k))
      m7.fog = false;
    end
    
    if(key(_o))
      m7.focus++;
    elseif(key(_l))
      m7.focus--;
    end
    
    if(key(_space))
      vel++;
      if(vel > 60) vel = 60; end
    else
      vel--;
      if(vel < 0) vel = 0; end
    end
    
    if(key(_enter))
      repeat frame; until(!key(_enter))
      m7.fogcolor = rgb(rand(0, 255), rand(0, 255), rand(0, 255));
    end
    
    m7[1].fog        = m7.fog;
    m7[1].fogcolor   = m7.fogcolor;
    m7[1].fogdensity = m7.fogdensity;
    m7[1].height     = -800 + m7.height;
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
    if(key(_a))
      ang += 200;
      if(ang > 6000) ang = 6000; end
    elseif(key(_d))
      ang -= 200;
      if(ang < -6000) ang = -6000; end
    else
      if(ang > 0)
        ang -= 200;
        if(ang < 0) ang = 0; end
      elseif(ang < 0)
        ang += 200;
        if(ang > 0) ang = 0; end
      end
    end
    
    angle = ang;

    frame;
  end
end

process tree()
begin
  graph   = gfx_tree;
  x       = rand(0, 4096);
  y       = rand(0, 4096);
  height  = 0;
  m7_fog  = 1;
  ctype   = c_m7;
  cnumber = 1;

  loop
    frame;
  end
end