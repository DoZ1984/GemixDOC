/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Pathfind system
 */


// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_pathfinds;

global
  num_points;
  struct points[100]
    x, y;
  end
  index;
  dir = 1;
	float x1, y1;
    
  id_proc;

begin
  mode_set(320, 200, 32);
  
	map_load("assets/pathfind_mask.map");
	map_load("assets/pathfind_map.map");
	map_load("assets/pathfind_cursor.map");
    
  // Render background
  ground_put(0, 1001);
  
  write(0, 160, 10, 4, &num_points);
  write(0, 160, 20, 4, &fps);
  
  graph = 1002;
  mouse.graph = 1002;

  repeat
    num_points = path_find(1, 0, 1000, 2, mouse.x, mouse.y, &points, sizeof(points)); // default
    if(num_points > 0)
      for(index = 0; index < num_points - 1; index++)
        draw_new(1, 0x00FF0000, 255, 0, points[index].x, points[index].y, points[index + 1].x, points[index + 1].y);
      end
      if(fget_dist(x, y, points[0].x, points[0].y) > 4)
        xadvance(fget_angle(x, y, points[0].x, points[0].y), 4);
      else
        x = points[0].x;
        y = points[0].y;
      end
      draw_new(1, 0x00FF0000, 255, 0, x, y, points[0].x, points[0].y);           
    end

    /* if(x == x1 && y == y1)
      if(dir == 1)
        dir = 2;
        x1  = 0;
        y1  = 5;
      else
        dir = 1;
        x1  = 318;
        y1  = 166;
      end
    end
    if(x == id_proc.x && y == id_proc.y)
      if(dir == 1)
        dir = 2;
        id_proc.x  = 0;
        id_proc.y  = 5;
      else
        dir = 1;
        id_proc.x  = 318;
        id_proc.y  = 166;
      end
    end */
        
    frame;
    draw_delete(all_drawing);
  until(keydown(_esc));
  let_me_alone();
end

process proc(x, y)
begin
  loop
    frame;
  end
end
