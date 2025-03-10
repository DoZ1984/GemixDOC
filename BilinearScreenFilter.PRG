program BilinearScreenFilter;

const
    normal_   = 0;
    bilinear_ = 1;    
    
global
    int renderSurface_;
    int filteredRenderSurface_;
    int renderSurface_z_ = 1024;
    int f_main;
    
begin
    mode_set(320,200,32);set_fps(60,0);
	
    renderSurface_ = new_map(480,320,0,0,0);
    filteredRenderSurface_ = new_map(480,320,0,0,0);
    f_main = fpg_load("FPG/main.fpg");
    
    main();
    write(0,160,10,4,"PUSH F1 to Bilinear filter.");
    write(0,10,10,3,&fps);
    loop
        if(key(_F1))
            render( bilinear_ );
        else
            render( normal_ );
        end
        frame;
    end
end
//-----------------------------------------------
process MAIN();
begin
    DUMP();
    file = f_main;
    graph = 1;
    x = 160;
    y = 100;
    
    loop
        frame;
    end
end
//-----------------------------------------------
function DUMP();
begin
    father.destination_file = 0;
    father.destination_graph = renderSurface_;
    return(0);
end
//-----------------------------------------------
function render( render_mode_ );
private
    int r[4];
    int g[4];
    int b[4];
    int ancho;
    int alto;
    
begin
    if(render_mode_ == normal_)
        screen_draw_graphic(0, renderSurface_,0,0,renderSurface_z_,0);
    end
    
    if(render_mode_ == bilinear_)
        ancho = mode_get_width() - 2;
        alto = mode_get_height() - 2;
        
        for(y=1; y<alto; y++)
            for(x=1; x<ancho; x++)
                map_get_RGB( 0, renderSurface_, x, y-1, &r[0], &g[0], &b[0] );
                map_get_RGB( 0, renderSurface_, x, y+1, &r[1], &g[1], &b[1] );
                map_get_RGB( 0, renderSurface_, x-1, y, &r[2], &g[2], &b[2] );
                map_get_RGB( 0, renderSurface_, x+1, y, &r[3], &g[3], &b[3] );
                r[4] = (r[0] + r[1] + r[2] + r[3]) / 4;
                g[4] = (g[0] + g[1] + g[2] + g[3]) / 4;
                b[4] = (b[0] + b[1] + b[2] + b[3]) / 4;
                map_put_pixel(0, filteredRenderSurface_, x, y, rgb( r[4], g[4], b[4] ));
            end
        end
        screen_draw_graphic(0, filteredRenderSurface_,0,0,renderSurface_z_,0);
    end
    
    
    
    return(0);
end
//-----------------------------------------------
