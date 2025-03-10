/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Render Process Glyph system
 */

 
// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_FNT_glyph_process;

global
	map, map_w, map_h;
  fnt_id;
	
	txt_id;
	string txt;
  
private
  render_entity entity_glyph;
  render_entity entity_text;

begin
	mode_set(640, 480, 32);
	//mode_set(640, 480);
	
  // Loads graphics' file
  fpg_load("assets/test_effects32.fpg");	
  
  // Load FNT resource
	fnt_id = fnt_load("assets/FntGemix32.fnt");
  
  // Render background
  ground_put(0, 999);  
   
  // Render process scroll glyph tiled
  proc_glyph_tiled(); // X
  
  // Render process glyph's
  proc_glyph(320,  30, 71); // G
  proc_glyph(320,  90, 69); // E
  proc_glyph(320, 150, 77); // M
  proc_glyph(320, 210, 73); // I
  proc_glyph(320, 270, 88); // X
  
	repeat
		frame;
	until(keydown(_esc));
  let_me_alone();
end

process proc_glyph_tiled()
begin
  fnt    = 0; // FNT system (0)
  file   = 0; // IMPORTANT: file must be 0 to work with FNT
  graph  = 88; // X
  
  anchor = transform_anchor_topleft; 
  tiled  = 1;  
  //fx.mode = fx_blend_add;
  
  loop
    x += 5;
  
    frame;
  end
end

process proc_glyph(x, y, graph)
begin
  fnt     = fnt_id; 
  file    = 0; // IMPORTANT: file must be 0 to work with FNT
  
  anchor  = transform_anchor_center;   
  fx.mode = fx_blend_multiply; 
  
	loop
    rotation.z -= 11250;
    
		frame;
	end
end
