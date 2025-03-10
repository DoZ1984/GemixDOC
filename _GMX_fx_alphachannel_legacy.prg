/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: FX system
 */

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_FX_alphachannel_legacy;

const
  mode_w = 640, mode_h = 480;
  mode_lenght = 6400;

global
  struct gfx[38]
    string name[24];
    int value;
  end = "SOLID"                   , fx_solid,
        "ALPHA COMPOSITE SRC"     , fx_alphacomposite_src,
        "ALPHA COMPOSITE DST"     , fx_alphacomposite_dst,
        "ALPHA COMPOSITE SRC OVER", fx_alphacomposite_srcover,
        "ALPHA COMPOSITE DST OVER", fx_alphacomposite_dstover,
        "ALPHA COMPOSITE SRC IN"  , fx_alphacomposite_srcin,
        "ALPHA COMPOSITE DST IN"  , fx_alphacomposite_dstin,
        "ALPHA COMPOSITE SRC OUT" , fx_alphacomposite_srcout,
        "ALPHA COMPOSITE DST OUT" , fx_alphacomposite_dstout,
        "ALPHA COMPOSITE SRC ATOP", fx_alphacomposite_srcatop,
        "ALPHA COMPOSITE DST ATOP", fx_alphacomposite_dstatop,
        "ALPHA COMPOSITE CLEAR"   , fx_alphacomposite_clear,
        "ALPHA COMPOSITE XOR"     , fx_alphacomposite_xor,
        "BLEND ADD"               , fx_blend_add,
        "BLEND SUBTRACT"          , fx_blend_subtract,
        "BLEND MULTIPLY"          , fx_blend_multiply,
        "BLEND AVERAGE"           , fx_blend_average,
        "BLEND SCREEN"            , fx_blend_screen,
        "BLEND R"                 , fx_blend_r,
        "BLEND G"                 , fx_blend_g,
        "BLEND B"                 , fx_blend_b,
        "BLEND RG"                , fx_blend_rg,
        "BLEND RB"                , fx_blend_rb,
        "BLEND GB"                , fx_blend_gb,
        "INVERT"                  , fx_invert,
				"INVERT R"                , fx_invert_r,
        "INVERT G"                , fx_invert_g,
        "INVERT B"                , fx_invert_b,
        "INVERT RG"               , fx_invert_rg,
        "INVERT RB"               , fx_invert_rb,
        "INVERT GB"               , fx_invert_gb,
        "GRAYSCALE"               , fx_grayscale,
        "SCALE R"                 , fx_scale_r,
        "SCALE G"                 , fx_scale_g,
        "SCALE B"                 , fx_scale_b,
        "SCALE RG"                , fx_scale_rg,
        "SCALE RB"                , fx_scale_rb,
        "SCALE GB"                , fx_scale_gb,
				"TINT"                    , fx_advanced;
  fx_count;

  string renderer;
  string fxmode      = "SOLID";
  string fxcolor     = "RGBCHANNEL";
  string fxintensity = "128";

  alpha_value  = 255;
  fx_value     = 0;
  fx_color     = 0;
  fx_rgb       = 0;
  fx_r         = 128;
  fx_g         = 128;
  fx_b         = 128;
  fx_intensity = 128;
  flags_value  = 0;
	
begin
  mode_set(640, 480, 32);

  map_load("background32.map");
  map_load("Gem-GemixStudio.map");

  ground_put(0, 1000);

  fnt_set_color(0, rgb(255, 255, 255), rgb(4, 4, 4), 0);
  
  write(0, 5,  20, 3, "RENDERER...: "); write(0, 78, 20, 3, renderer);
  write(0, 5,  30, 3, "FXMODE.....: "); write(0, 78, 30, 3, fxmode);

  write(0, 5,  40, 3, "FXCOLOR....: "); write(0, 78,  40, 3, fxcolor);
  write(0, 5,  50, 3, "FXINTENSITY: "); write(0, 78,  50, 3, fxintensity);
  write(0, 5,  60, 3, "FX R.......: "); write(0, 78,  60, 3, &fx_r);
  write(0, 5,  70, 3, "FX G.......: "); write(0, 78,  70, 3, &fx_g);
  write(0, 5,  80, 3, "FX B.......: "); write(0, 78,  80, 3, &fx_b);
  write(0, 5,  90, 3, "ALPHA......: "); write(0, 78,  90, 3, &alpha_value);
  write(0, 5, 100, 3, "FLAGS......: "); write(0, 78, 100, 3, &flags_value);
  write(0, 5, 115, 3, "FPS........: "); write(0, 78, 115, 3, &fps);

  if(mode_get_renderer(renderer_driver) == renderer_driver_software)
    renderer = "SOFTWARE";
  else
    renderer = "SIMD";
  end

  Gem(1001);
        				 					 
  repeat
    if(keydown(_n)) set_fps(24, 0); end
    if(keydown(_m)) set_fps( 0, 0); end

    if(keydown(_r)) mode_set_renderer(renderer_driver_software);                renderer = "SOFTARE";    end
    if(keydown(_a)) mode_set_renderer(renderer_driver_simd, renderer_simd_mmx); renderer = "SIMD (MMX)"; end

    if(keydown(_f)) mode_change(mode_fullscreen); end
    if(keydown(_w)) mode_change(mode_window);     end
	
    if(keydown(_f1))  flags_value = 0;  end
    if(keydown(_f2))  flags_value = 1;  end
    if(keydown(_f3))  flags_value = 2;  end
    if(keydown(_f4))  flags_value = 3;  end

		if(keydown(_f5))  flags_value = 4;  end
    if(keydown(_f6))  flags_value = 5;  end
    if(keydown(_f7))  flags_value = 6;  end
    if(keydown(_f8))  flags_value = 7;  end

		if(keydown(_f9))  flags_value = 8;  end
    if(keydown(_f10)) flags_value = 9;  end
    if(keydown(_f11)) flags_value = 10; end
    if(keydown(_f12)) flags_value = 11; end

		if(keydown(_c_plus)  && alpha_value < 255) alpha_value++; end
    if(keydown(_c_minus) && alpha_value >   0) alpha_value--; end
		
		if(keydown(_pgup) && fx_count < 38)
			fx_count++;
			fxmode   = gfx[fx_count].name;
			fx_value = gfx[fx_count].value;
			frame;
		end
		if(keydown(_pgdn) && fx_count > 0)
			fx_count--;
			fxmode   = gfx[fx_count].name;
			fx_value = gfx[fx_count].value;
			frame;
		end

		if(fx_count == 38)
			if(keydown(_l_shift) && key(_r) && fx_r >   0) fx_r--; end
			if(keydown(_r_shift) && key(_r) && fx_r < 255) fx_r++; end
			if(keydown(_l_shift) && key(_g) && fx_g >   0) fx_g--; end
			if(keydown(_r_shift) && key(_g) && fx_g < 255) fx_g++; end
			if(keydown(_l_shift) && key(_b) && fx_b >   0) fx_b--; end
			if(keydown(_r_shift) && key(_b) && fx_b < 255) fx_b++; end

			if(keydown(_l_control) && fx_intensity >   0) fx_intensity--; end
			if(keydown(_r_control) && fx_intensity < 255) fx_intensity++; end

	    fx_color    = rgb(fx_r, fx_g, fx_b);
  	  fxcolor     = itoa(fx_color);
	    fxintensity = itoa(fx_intensity);
		else
			fxcolor    = "0";
		end
	
    frame;
  until(keydown(_esc));
  let_me_alone();
end

process Gem(graph)
private
  fx_advancedtype_tint fxtint;
  
begin
  x = 320;
  y = 240;

  fx.fxref = &fxtint;
  
  loop
		flags       = flags_value;
		fx.mode     = fx_value;
    if(fx.mode == fx_advanced)
      fxtint.color     = fx_color;
      fxtint.intensity = fx_intensity;
    end
		fx.alpha    = alpha_value;
  
    frame;
  end
end
