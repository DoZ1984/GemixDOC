program example_energy_bars;

const
  ebar_gfx_bg        = 1;
  ebar_gfx_barbg     = 2;
  ebar_gfx_bar       = 3;
  ebar_gfx_barleft   = 4;
  ebar_gfx_barcenter = 5;
  ebar_gfx_barright  = 6;
  ebar_gfx_barflash  = 7;
  
  global_ebar_increment = 0.001;
  
global
  int ebar_fpg_id;
  
  float global_ebar_value = 0.0f;
  int global_ebar_direction = 0;
  
begin
  set_mode(480, 320, 32);
  set_fps(60, 0);
  
  ebar_fpg_id = load_fpg("example_energy_bars.fpg");
  put_screen(ebar_fpg_id, ebar_gfx_bg);
  
  energy_bar1(50, 20);
  energy_bar2(50, 100);
  energy_bar3(50, 180);
  energy_bar4(50, 260);
  
  loop
    if (key(_esc))
      let_me_alone();
      break;
    end
    
    if (global_ebar_direction == 0)
      global_ebar_value += global_ebar_increment;
      if (global_ebar_value >= 1.0f)
        global_ebar_value = 1.0f;
        global_ebar_direction = 1;
      end
    else
      global_ebar_value -= global_ebar_increment;
      if (global_ebar_value <= 0.0f)
        global_ebar_value = 0.0f;
        global_ebar_direction = 0;
      end
    end
    
    frame;
  end
  
end

process energy_bar1(x, y)
private
  int dummy_id;
begin
  file = ebar_fpg_id;
  graph = ebar_gfx_barbg;
  
  loop
    define_region(10, x + 10, y + 8, 366 * global_ebar_value, 20);
    draw_graphic(ebar_fpg_id, ebar_gfx_bar, x + 10, y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0, 0, 10);
    frame;
  end
end

process energy_bar2(x, y)
private
  int dummy_id;
begin
  file = ebar_fpg_id;
  graph = ebar_gfx_barbg;
  
  loop
    draw_graphic(ebar_fpg_id, ebar_gfx_bar, x + 10, y + 8, z - 1, 0, 0, global_ebar_value * 100, 100, 0, 0, 0);
    frame;
  end
end

process energy_bar3(x, y)
begin
  file = ebar_fpg_id;
  graph = ebar_gfx_barbg;
  
  loop
    define_region(30, x + 18, y + 8, 350 * global_ebar_value, 20);
    
    draw_graphic(ebar_fpg_id, ebar_gfx_barleft, x + 10, y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0);
    draw_tile(ebar_fpg_id, ebar_gfx_barcenter, 0, 0, z - 1, 0, 30);
    draw_graphic(ebar_fpg_id, ebar_gfx_barright, x + 18 + GET_REGION_WIDTH(30), y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0);
    frame;
  end
end

process energy_bar4(x, y)
private
  int flash_x = -120;
  int flashing = 0;
  int ebar_flashincrement = 4;
  int ebar_flashwait = 80;
  
begin
  file = ebar_fpg_id;
  graph = ebar_gfx_barbg;
  
  loop
    define_region(40, x + 18, y + 8, 350 * global_ebar_value, 20);
    define_region(41, x + 12, y + 8, GET_REGION_WIDTH(40) + 13, 20);
    
    draw_graphic(ebar_fpg_id, ebar_gfx_barleft, x + 10, y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0);
    draw_tile(ebar_fpg_id, ebar_gfx_barcenter, 0, 0, z - 1, 0, 40);
    draw_graphic(ebar_fpg_id, ebar_gfx_barright, x + 18 + GET_REGION_WIDTH(40), y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0);
    
    if (flashing == 0)
      if (timer[0] > ebar_flashwait)
        flashing = 1;
      end
    else
      draw_graphic(ebar_fpg_id, ebar_gfx_barflash, x + flash_x, y + 8, z - 1, 0, 0, 100, 100, 0, 0, 0, 0, 41);
    
      flash_x += ebar_flashincrement;
      if (flash_x > GET_REGION_WIDTH(41))
        flash_x = -120;
        flashing = 0;
        timer[0] = 0;
      end
    end
    
    frame;
  end
end