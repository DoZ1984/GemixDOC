/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Anchor system
 */

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
compiler_options _gmxsystem_graphics = gmxgraphics_legacy;
program Gemix_anchors;
 
begin
	mode_set(640, 480, 32);
	
  // Loads graphics' file
  fpg_load("assets/test_effects32.fpg");

  // Render background
  ground_put(0, 999);
  
  // render gem's with anchor position's
  proc_gem(320, 100, transform_anchor_cpoint0);
  
  proc_gem(  0,   0, transform_anchor_topleft);
  proc_gem(320,   0, transform_anchor_topcenter);
  proc_gem(639,   0, transform_anchor_topright);

  proc_gem(  0, 240, transform_anchor_left);
  proc_gem(320, 240, transform_anchor_center);
  proc_gem(639, 240, transform_anchor_right);

  proc_gem(  0, 479, transform_anchor_bottomleft);
  proc_gem(320, 479, transform_anchor_bottomcenter);
  proc_gem(639, 479, transform_anchor_bottomright);
  
	repeat
		frame;
	until(keydown(_esc));
  let_me_alone();
end

process proc_gem(x, y, anchor)
begin
	graph = 1;

	loop
		frame;
	end
end
