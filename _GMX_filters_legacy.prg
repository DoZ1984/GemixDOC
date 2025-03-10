/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Filter's system
 */


// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_filters;

global
  string s_filter_scale, s_filter_scanline, s_filter_fx;
  string renderer;
  int old_scalecount           = 0 , scalecount           = 0;
  int old_scanlinecount        = 0 , scanlinecount        = 0;
  int old_scanlinepercentcount = 25, scanlinepercentcount = 25;
  int old_fxcount              = 2 , fxcount              = 0;

  int scanlineflags;
  n;

  rw, rh;

begin
  mode_set(320, 240, 32, mode_window);
 
  // Load resource
  map_load("Assets/menu3.map");

  // Render background
  ground_put(0, 1000);

  write(0, 160, 10, 4, "Test Filters");
  write(0, 5, 30, 3, "RENDERER.......: "); write(0, 107, 30, 3, renderer);
  write(0, 5, 40, 3, "FILTER.SCALE...: "); write(0, 107, 40, 3, s_filter_scale);
  write(0, 5, 50, 3, "FILTER.SCANLINE: "); write(0, 107, 50, 3, s_filter_scanline);
  write(0, 5, 60, 3, "FILTER.FX......: "); write(0, 107, 60, 3, s_filter_fx);
  write(0, 5, 70, 3, "FPS............: "); write(0, 107, 70, 3, &fps);
  write(0, 5, 80, 3, "DUMP...........: "); write(0, 107, 80, 3, &dump_type);
  write(0, 5, 90, 3, "RESTORE........: "); write(0, 107, 90, 3, &restore_type);

  rw = mode_get_width();
  rh = mode_get_height();

  write(0, 160, 100, 4, &rw);
  write(0, 160, 110, 4, &rh);

  if(mode_get_renderer(renderer_driver) == renderer_driver_software)
    renderer = "SOFTWARE";
  else
    renderer = "SIMD";
  end

  switch(mode_get_filter(filter_scaletype))
    case filter_scale_noscale:  s_filter_scale = "NOSCALE";  end
    case filter_scale_normal2x: s_filter_scale = "NORMAL2X"; end
    case filter_scale_scale2x:  s_filter_scale = "SCALE2X";  end
  end

  switch(mode_get_filter(filter_scanlinetype))
    case filter_scanline_noscanline:
      s_filter_scanline = "NOSCANLINE";
    end
    case filter_scanline_1x:
      switch(mode_get_filter(filter_scanlinepercent))
        case filter_scanline_25percent:  s_filter_scanline = "SCANLINE 1X 25%";  end
        case filter_scanline_50percent:  s_filter_scanline = "SCANLINE 1X 50%";  end
        case filter_scanline_75percent:  s_filter_scanline = "SCANLINE 1X 75%";  end
        case filter_scanline_100percent: s_filter_scanline = "SCANLINE 1X 100%"; end
      end
    end
  end

  repeat
    if(keydown(_f1) && !fading)
      screen_fade(0, 0, 0, 1);
    end
    if(keydown(_f2) && !fading)
      screen_fade(100, 100, 100, 1);
    end
		
    if(keydown(_1)) dump_type    = partial_dump;     end
    if(keydown(_2)) dump_type    = complete_dump;    end
    if(keydown(_3)) restore_type = partial_restore;  end
    if(keydown(_4)) restore_type = complete_restore; end

    if(keydown(_n)) set_fps(24, 0); end
    if(keydown(_m)) set_fps( 0, 0); end

    if(keydown(_v)) vsync = 1; end
    if(keydown(_b)) vsync = 0; end

    if(keydown(_r)) mode_set_renderer(renderer_driver_software);                renderer = "SOFTARE";    end
    if(keydown(_a)) mode_set_renderer(renderer_driver_simd, renderer_simd_mmx); renderer = "SIMD (MMX)"; end

    if(keydown(_f)) mode_change(mode_fullscreen); end
    if(keydown(_w)) mode_change(mode_window);     end

    if(keydown(_pgup)  && scalecount           < filter_scale_scale2x)       scalecount++;               frame; end
    if(keydown(_pgdn)  && scalecount           > filter_scale_noscale)       scalecount--;               frame; end
    if(keydown(_up)    && scanlinecount        < filter_scanline_1x)         scanlinecount++;            frame; end
    if(keydown(_down)  && scanlinecount        > filter_scanline_noscanline) scanlinecount--;            frame; end
    if(keydown(_left)  && scanlinepercentcount > 25)                         scanlinepercentcount -= 25; frame; end
    if(keydown(_right) && scanlinepercentcount < 100)                        scanlinepercentcount += 25; frame; end

    if(scalecount           != old_scalecount    ||
       scanlinecount        != old_scanlinecount ||
       scanlinepercentcount != old_scanlinepercentcount)
      switch(scalecount)
        case filter_scale_noscale: // NOSCALE
          s_filter_scale = "NOSCALE";

          switch(scanlinecount)
            case filter_scanline_noscanline: // NOSCANLINE
              s_filter_scanline = "NOSCANLINE";

              scanlineflags = filter_scanline_noscanline;

              mode_set_filter(scalecount, scanlineflags, fxcount);
            end
            case filter_scanline_1x:         // SCANLINE 1X
              scanlineflags = filter_scanline_1x;

              switch(scanlinepercentcount)
                case 25:  s_filter_scanline = "SCANLINE 1X 25%";  scanlineflags |= filter_scanline_25percent;  end
                case 50:  s_filter_scanline = "SCANLINE 1X 50%";  scanlineflags |= filter_scanline_50percent;  end
                case 75:  s_filter_scanline = "SCANLINE 1X 75%";  scanlineflags |= filter_scanline_75percent;  end
                case 100: s_filter_scanline = "SCANLINE 1X 100%"; scanlineflags |= filter_scanline_100percent; end
              end

              mode_set_filter(scalecount, scanlineflags, fxcount);
            end
          end
        end
        case filter_scale_normal2x..filter_scale_scale2x: // NORMAL2X, SCALE2X
          if(scalecount == filter_scale_normal2x)
            s_filter_scale = "NORMAL2X";
          else
            s_filter_scale = "SCALE2X";
          end
          switch(scanlinecount)
            case filter_scanline_noscanline: // NOSCANLINE
              s_filter_scanline = "NOSCANLINE";

              scanlineflags = filter_scanline_noscanline;

              mode_set_filter(scalecount, scanlineflags, fxcount);
            end
            case filter_scanline_1x:         // SCANLINE 1X
              scanlineflags = filter_scanline_1x;

              switch(scanlinepercentcount)
                case 25:  s_filter_scanline = "SCANLINE 1X 25%";  scanlineflags |= filter_scanline_25percent;  end
                case 50:  s_filter_scanline = "SCANLINE 1X 50%";  scanlineflags |= filter_scanline_50percent;  end
                case 75:  s_filter_scanline = "SCANLINE 1X 75%";  scanlineflags |= filter_scanline_75percent;  end
                case 100: s_filter_scanline = "SCANLINE 1X 100%"; scanlineflags |= filter_scanline_100percent; end
              end

              mode_set_filter(scalecount, scanlineflags, fxcount);
            end
          end
        end
      end

      old_scalecount           = scalecount;
      old_scanlinecount        = scanlinecount;
      old_scanlinepercentcount = scanlinepercentcount;
      old_fxcount              = fxcount;
    end

    frame;
  until(keydown(_esc));
end