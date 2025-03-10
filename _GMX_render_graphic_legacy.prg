/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Render Graphic system
 */

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_render_graphic;
 
private
  render_entity entity_graphic;
  render_entity entity_graphic_scaled;
  render_entity entity_graphic_tiled;

begin
	mode_set(640, 480, 32);
	
  // Loads graphics' file
  fpg_load("assets/test_effects32.fpg");

  // Render background
  ground_put(0, 999);
	   
  // Set entity tiled
  entity_graphic_tiled.asset.source.graph    = 1;
  entity_graphic_tiled.transform.set.tiled   = 1;
  entity_graphic_tiled.fx.alpha              = 128;

  // Set entity scaled
  entity_graphic_scaled.asset.source.graph   = 1;
  entity_graphic_scaled.transform.position.x = 320;
  entity_graphic_scaled.transform.position.y = 125;
  entity_graphic_scaled.transform.scale.x    = 200;
  entity_graphic_scaled.transform.scale.y    = 200;
  entity_graphic_scaled.fx.mode              = fx_blend_rb;  
    
  // Set entity normal  
  entity_graphic.asset.source.graph          = 1;
  entity_graphic.fx.mode                     = fx_blend_add;
  
	repeat
    // Render scroll tiled graphic
    entity_graphic_tiled.transform.position.x += 2;
    render_graphic(&entity_graphic_tiled);

    // Render scaled graphic
    entity_graphic_scaled.transform.set.anchor = transform_anchor_cpoint0;
    render_graphic(&entity_graphic_scaled);
        
    // Render normal graphics with anchor alignment    
    entity_graphic.transform.set.anchor = transform_anchor_topleft;
    entity_graphic.transform.position.x = 0;
    entity_graphic.transform.position.y = 0;
    render_graphic(&entity_graphic);
    
    entity_graphic.transform.set.anchor = transform_anchor_topcenter;
    entity_graphic.transform.position.x = 320;
    entity_graphic.transform.position.y = 0;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_topright;
    entity_graphic.transform.position.x = 639;
    entity_graphic.transform.position.y = 0;
    render_graphic(&entity_graphic);
    
    entity_graphic.transform.set.anchor = transform_anchor_left;
    entity_graphic.transform.position.x = 0;
    entity_graphic.transform.position.y = 240;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_center;
    entity_graphic.transform.position.x = 320;
    entity_graphic.transform.position.y = 240;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_right;
    entity_graphic.transform.position.x = 639;
    entity_graphic.transform.position.y = 240;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_bottomleft;
    entity_graphic.transform.position.x = 0;
    entity_graphic.transform.position.y = 479;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_bottomcenter;
    entity_graphic.transform.position.x = 320;
    entity_graphic.transform.position.y = 479;
    render_graphic(&entity_graphic);

    entity_graphic.transform.set.anchor = transform_anchor_bottomright;
    entity_graphic.transform.position.x = 639;
    entity_graphic.transform.position.y = 479;
    render_graphic(&entity_graphic);
    
		frame;
	until(keydown(_esc));
end
