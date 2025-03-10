/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Block system
 */

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_process_blocks;
 
private
  render_transform_block t_block;
 
begin
	mode_set(640, 480, 32);
	
  // Loads graphics' file
  fpg_load("assets/test_effects32.fpg");

  // Render background
  ground_put(0, 999);
  
  // Set render block common options  
  t_block.used     = 1;
  t_block.width    = 20;
  t_block.height   = 20;
  
  // Render gem block's at different position and anchor
  // NOTE: when use a block (used = 1), LOCAL X and Y (position) are ignored, use block target x/y instead 
  t_block.target.x = 320;
  t_block.target.y = 100;
  t_block.source.x = 15;
  t_block.source.y = 10;
  proc_gem(transform_anchor_cpoint0, t_block);
 
  t_block.target.x = 0;
  t_block.target.y = 0;
  t_block.source.x = 0;
  t_block.source.y = 0;
  proc_gem(transform_anchor_topleft, t_block);    
  t_block.target.x = 320;
  t_block.target.y = 0;
  t_block.source.x = 15;
  t_block.source.y = 0;
  proc_gem(transform_anchor_topcenter, t_block);
  t_block.target.x = 639;
  t_block.target.y = 0;
  t_block.source.x = 30;
  t_block.source.y = 0;  
  proc_gem(transform_anchor_topright, t_block);

  t_block.target.x = 0;
  t_block.target.y = 240;
  t_block.source.x = 0;
  t_block.source.y = 10;    
  proc_gem(transform_anchor_left, t_block);  
  t_block.target.x = 320;
  t_block.target.y = 240;
  t_block.source.x = 15;
  t_block.source.y = 10;    
  proc_gem(transform_anchor_center, t_block);  
  t_block.target.x = 639;
  t_block.target.y = 240;
  t_block.source.x = 30;
  t_block.source.y = 10;    
  proc_gem(transform_anchor_right, t_block);

  t_block.target.x = 0;
  t_block.target.y = 479;
  t_block.source.x = 0;
  t_block.source.y = 20;    
  proc_gem(transform_anchor_bottomleft, t_block);  
  t_block.target.x = 320;
  t_block.target.y = 479;
  t_block.source.x = 15;
  t_block.source.y = 20;    
  proc_gem(transform_anchor_bottomcenter, t_block);  
  t_block.target.x = 639;
  t_block.target.y = 479;
  t_block.source.x = 30;
  t_block.source.y = 20;      
  proc_gem(transform_anchor_bottomright, t_block);

	repeat
		frame;
	until(keydown(_esc));
  let_me_alone();
end

process proc_gem(anchor, block)
begin
	graph = 1;
  
	loop
		frame;
	end
end
