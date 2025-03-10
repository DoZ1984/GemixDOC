/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Render Text system
 */

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_render_text;

global
	map, map_w, map_h;
  fnt_id;
	
	txt_id;
	string txt;
  
private
  render_entity entity_glyph;
  render_entity entity_text;

begin
	mode_set(800, 600, 32);

	fnt_id = fnt_load("FntGemix32.fnt");

  
	screen_set_color(rgb(128, 128, 128));
  
	txt_id = write(fnt_id, 400,  70, 4, txt);    
	
	txt = "Gemix Studio";
	frame(3000);
	txt = "The next DIV generation";
	frame(3000);
	txt = "Press space to continue...";	
	while(!keydown(_space))
		frame;
	end
	text_delete(txt_id);
	
  write(0, 400, 10, 4, &entity_glyph.asset.source.fnt);
  write(0, 400, 20, 4, &entity_text.asset.source.fnt);
   
  entity_glyph.asset.source.fnt     = 0;
  entity_glyph.asset.source.file    = 0;  // IMPORTANT: file must be 0 to work with FNT
  entity_glyph.asset.source.graph   = 73; // glyph char 73
  entity_glyph.transform.set.tiled  = 1;
  entity_glyph.transform.position.x = -1;
  entity_glyph.transform.position.y = 0;
  entity_glyph.fx.mode              = fx_blend_add;
  
  entity_text.asset.source.fnt     = fnt_id;
  entity_text.asset.source.file    = 0;   // IMPORTANT: file must be 0 to work with FNT
  entity_text.transform.position.x = 400;
   
	repeat  
    // render scroll tiled glyph  
    entity_glyph.transform.position.x += 1; 
    render_text(&entity_glyph);
  	
    // render text's
    entity_text.transform.set.anchor = transform_anchor_center;
    entity_text.transform.position.y = 210;
    entity_text.transform.rotation.z = 0;
    render_text(&entity_text, "Gemix Studio");
    
    entity_text.transform.set.anchor = transform_anchor_topleft;
    entity_text.transform.position.y = 300;
    entity_text.transform.rotation.z = 45000;
    render_text(&entity_text, "The next DIV generation");

		frame;
	until(keydown(_esc));
end
