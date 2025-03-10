******* Gemix Studio (C) Skygem Software. All rights reserved *******

=== GEMIX CORE VER. 0.7.5

---------------------------
--- CORE
---------------------------

	/* *** CONSTANTS *** */

	* _max_process		                (0)
	* _extended_conditions	                (1)
	* _simple_conditions	                (2)
	* _case_sensitive	                (3)
	* _ignore_errors	                (4)
	* _free_sintax		                (5)
	* _no_check		                (6)
	* _no_strfix		                (7)
	* _no_optimization	                (8)
	* _no_range_check	                (9)
	* _no_id_check		                (10)
	* _no_null_check	                (11)
	* _use_cstyle_matrix                    (12)
	* _use_cstyle_conditions                (13)
	* _use_cstyle_operators                 (14)
	* _use_cstyle_sizeof                    (15)
	* _use_cstyle                           (16)
	* _use_always_int2string_conversions    (17)
	* _gmxsystem_core			(18)
	* _gmxsystem_audio			(19)
	* _gmxsystem_graphics			(20)

	* gmxcore_legacy			(1)
	* gmxcore_modern			(2)
	* gmxaudio_legacy			(1)
	* gmxaudio_modern			(2)
	* gmxgraphics_legacy			(1)
	* gmxgraphics_modern			(2)



=== GEMIX MODULES VER. 0.7.5 ===

---------------------------
--- ALGORITHM
---------------------------
	/* *** FUNCTIONS *** */

	* INT QSORT(INT struct_name, INT field_name, INT mode)
		- MODE values:
		  0 = A to Z
		  1 = Z to A
		  2 = random



---------------------------
--- DBMS
---------------------------
	/* *** CONSTANTS *** */

	* dbms_sqlite	(1)

	* db_create	(1)
	* db_readonly	(2)
	* db_readwrite	(3)

	* dbquery_type_int	(1)
	* dbquery_type_double	(2)
	* dbquery_type_string	(3)

	* all_db	(0)


	/* *** FUNCTIONS *** */

// --- DB MANAGEMENT ---

	* INT DB_OPEN(STRING dbname, INT db_manager, INT mode)
		- DB_MANAGER values:
		  dbms_sqlite	(1)
		- MODE values:
		  db_create	(1)
		  db_readonly	(2)
		  db_readwrite	(3)

	* INT DB_QUERY(INT db_id, STRING query, INT evaluate)
		- DB_ID values:
		  value returned by DB_OPEN
		- EVALUATE values:
		  0 (false) = do not evaluate now (requiere call DBQUERY_EVALUATE manually, required for some queries)
		  1 (true)  = evaluate now (execute te evaluation of the query inmediately, useful for some queries)

	* INT DB_CLOSE(INT db_id)
		- DB_ID values:
		  all_db (0)
		  or value returned by DB_OPEN


// --- DB TABLE MANAGEMENT ---

	* INT DBTABLE_NEW(INT db_id, STRING table_name)
		- DB_ID values:
		  value returned by DB_OPEN

	* INT DBTABLE_ADD_FIELD(INT db_it, STRING table_name, STRING field_name, STRING field_type, STRING default_value, INT not_null)
		- DB_ID values:
		  value returned by DB_OPEN
		- NOT_NULL values:
		  0 = could be null
		  1 = must be not null

	* INT DBTABLE_INSERT_RECORD(INT db_id, STRING table_name, STRING fields, STRING field_values)
		- DB_ID values:
		  value returned by DB_OPEN
		- FIELDS values:
                  list of field_names separated by comma (i.e: "Name, Surname") or ""
		- FIELD_VALUES values:
		  list of field_values enclosed on '' and separated by comma (i.e: "'Gemix', 'Studio', '1.0'"), if fields is "" the list must be equal to number of fields in table 

	* INT DBTABLE_DELETE_RECORD(INT db_id, STRING table_name, DWORD record)
		- DB_ID values:
		  value returned by DB_OPEN
		- RECORD values:
		  all_table_record (0)
                  or 1 to value returned by DBTABLE_GET_NUMRECORDS

	* INT DBTABLE_GET_NUMRECORDS(INT db_id, STRING table_name)
		- DB_ID values:
		  value returned by DB_OPEN

	* INT DBTABLE_GET_QUERY(INT db_id, STRING table_name)
		- DB_ID values:
		  value returned by DB_OPEN
		- QUERY_ID values:
		  value returned by DB_QUERY

	* INT DBTABLE_DELETE(INT db_id, STRING table_name)
		- DB_ID values:		  
		  value returned by DB_OPEN


// --- DB QUERY MANAGEMENT ---

	* INT DBQUERY_EVALUATE(INT query_id)
		- QUERY_ID values:
		  value returned by DB_QUERY or DBTABLE_GET_QUERY

	* INT DBQUERY_GET_NUMFIELDS(INT query_id)
		- QUERY_ID values:
		  value returned by DB_QUERY or DBTABLE_GET_QUERY

	* INT DBQUERY_GET_TYPE(INT query_id, INT column)
		- QUERY_ID values:
		  value returned by DB_QUERY or DBTABLE_GET_QUERY
		- COLUMN values:
		  0 to value returned by DBQUERY_GET_NUMFIELDS - 1

	* INT DBQUERY_GET_VALUE(INT query_id, INT column, INT    *value)
	  INT DBQUERY_GET_VALUE(INT query_id, INT column, DOUBLE *value) -> (overload 1)
	  INT DBQUERY_GET_VALUE(INT query_id, INT column, STRING *value) -> (overload 2)
		- QUERY_ID values:
		  value returned by DB_QUERY or DBTABLE_GET_QUERY
		- COLUMN values:
		  0 to value returned by DBQUERY_GET_NUMFIELDS - 1



---------------------------
--- DYNMEM
---------------------------
	/* *** CONSTANTS *** */
	
	* all_free	(0)


	/* *** FUNCTIONS *** */

	* INT ENCODE(VOID *data, INT length, STRING key)

	* INT FREE(VOID *memory_handle)
		- MEMORY_HANDLE values:
		  all_free	(0)
		  or memory_handle returned by MALLOC function

	* VOID *MALLOC(INT elements)

	* INT MEMORY_FREE()

	* INT MEMORY_SYSTEM()



---------------------------
--- FILE
---------------------------
	/* *** CONSTANTS *** */

	* _normal	(0)
        * _rdonly       (1)
	* _hidden	(2)
	* _system	(4)
	* _volid	(8)  // OBSOLETE, not work
	* _subdir	(16)
        * _arch         (32)
	* all_free	(0)
	* byte_unit	(1)
	* int_unit	(4)
	* seek_cur	(1)
	* seek_set	(0)
	* seek_end	(2)


	/* *** VARIABLES *** */

	* INT unit_size		(= 4)
		- values:
		  byte_unit	(1)
		  int_unit	(4)
	* STRUCT dirinfo
	    INT files		(= 0)
	    VOID *name   	(= NULL)
	  END
	* STRUCT fileinfo
	    STRING fullpath[1024]	(= NULL)
	    INT drive			(= 0)
	    STRING dir[255]		(= NULL)
	    STRING name[255]		(= NULL)
	    STRING ext[255]		(= NULL)
	    INT size			(= 0)
	    INT day			(= 0)
	    INT month			(= 0)
	    INT year			(= 0)
	    INT hour			(= 0)
	    INT min			(= 0)
	    INT sec			(= 0)
	    INT attrib			(= 0)
	  END


	/* *** FUNCTIONS *** */

// --- FILE HANDLE MANAGEMENT ---

	* INT FCLOSE(INT file_handle)
		- FILE_HANDLE values:
		  all_file	(0)
		  or file_handle returned by FOPEN function

	* INT FEOF(INT file_handle)

	* INT FLENGTH(INT file_handle)
	  INT FILELENGTH(INT file_handle) -> (alias of FLENGTH)

	* INT FLUSH()

	* INT FOPEN(STRING fname, STRING mode)
	  INT FOPEN(STRING fname, STRING mode, STRING openmode) -> (overload 1)
	  INT FOPEN(STRING fname, STRING mode, STRING openmode, STRING password) -> (overload 2)
		- MODE values:
		  "a"   = open for append write 
		  "a+"  = open for append read/write
                  "az"  = open for append compressed read/write
                  "a+z" = open for append compressed read/write
		  "r"   = open for read
		  "rz"  = open for compressed read
		  "r+"  = open for read/write
		  "r+z" = open for compressed read/write
		  "w"   = open for write
		  "wz"  = open for compressed write
		  "w+"  = open for write/read
		  "w+z" = open for compressed write/read
		- OPENMODE values:
		  "t"   = open in text mode
		  "b"   = open in binary mode (default)

	* INT FREAD(VOID *data, INT length, INT file_handle)

	* INT FSEEK(INT file_handle, INT position, INT mode)
		- MODE values:
		  seek_set	(0)
		  seek_cur	(1)
		  seek_end	(2)

  	* INT FTELL(INT file_handle)

	* INT FWRITE(VOID *data, INT length, INT file_handle)

	* INT FGETC(INT file_handle)

	* INT FGETHANDLE(INT file_handle)
	
	* STRING FGETS(STRING text, INT file_handle)

	* INT FPUTC(INT character, INT file_handle)

	* STRING FPUTS(STRING text, INT file_handle)


// --- FILE LOADING/SAVING MANAGEMENT ---

	* INT LOAD(STRING fname, VOID *data)

	* INT SAVE(STRING fname, VOID *data, INT SIZEOF(size))


// --- DIRECTORY, PATH AND DRIVE MANAGEMENT ---

	* INT CHDIR(STRING name)

	* INT GETDRIVE() (Work only on Windows)

	* STRING GETCWD(STRING *path)

	* STRING GETWPATH()

	* INT MKDIR(STRING name)

	* INT REMOVE(STRING name)

	* INT RMDIR(STRING name)

	* INT SETDRIVE(INT drive) (Work only on Windows)
		- DRIVE values
		  1 = A:, 2 = B:, 3 = C: ...


// --- DISK INFORMATION ---

	* INT DISK_FREE(INT drive) (Work only on Windows)
		- DRIVE values
		  1 = A:, 2 = B:, 3 = C: ...

	* INT DISK_SIZE(INT drive) (Work only on Windows)
		- DRIVE values
		  1 = A:, 2 = B:, 3 = C: ...


// --- FILE MANAGMENT ---

	* INT FILE_COMPRESS(STRING fname)
	  INT COMPRESS_FILE(STRING fname) -> (alias of FILE_COMPRESS)

	* INT FILE_DECODE(STRING fname, STRING key)
	  INT DECODE_FILE(STRING fname, STRING key) -> (alias of FILE_DECODE)

	* INT FILE_ENCODE(STRING fname, STRING key)
	  INT ENCODE_FILE(STRING fname, STRING key) -> (alias of FILE_ENCODE)

	* INT FILE_EXISTS(STRING fname)

	* INT FILE_UNCOMPRESS(STRING fname)
	  INT UNCOMPRESS_FILE(STRING fname) -> (alias of FILE_UNCOMPRESS)


// --- FILE AND DIRECTORY INFORMATION ---

	* INT GET_DIRINFO(STRING dirmask, INT flags) -> (CALL this function for UPDATING the STRUCT dirinfo)
		- FLAGS following values:
		  _normal	(0)
		  _hidden	(2)
		  _system	(4)
		  _volid	(8)
		  _subdir	(16)

	* INT GET_FILEINFO(STRING fname) -> (CALL this function for UPDATING the STRUCT fileinfo)



---------------------------
--- FLIC
---------------------------
	/* *** FUNCTIONS *** */

	* INT FLI_END() (LEGACY mode only)
	  INT END_FLI() -> (alias of FLI_END, LEGACY mode only)

	* INT FLI_FRAME() (LEGACY mode only)
	* INT FRAME_FLI() -> (alias of FLI_FRAME, LEGACY mode only)

	* INT FLI_RESET() (LEGACY mode only)
	  INT RESET_FLI() -> (alias of FLI_RESET, LEGACY mode only)

	* INT FLI_START(STRING fname, INT x, INT y) (LEGACY mode only)
	  INT START_FLI(STRING fname, INT x, INT y) -> (alias of FLI_START, LEGACY mode only)



---------------------------
--- GRAPHICS2D
---------------------------
	/* *** CONSTANTS *** */

	* all_drawing				(-1)
	* all_fpg				(-1)
	* all_image				(-1)
	* all_map				(-1)
	* c_screen				(0)
	* img_format_map			(1)
	* img_format_bmp			(2)
	* img_format_jpeg			(3)
	* img_format_pcx			(4)
	* img_format_png			(5)
	* img_format_tga			(6)
	* m320x200				(320200)(LEGACY mode only)
	* m320x240				(320240)(LEGACY mode only)
	* m320x400				(320400)(LEGACY mode only)
	* m360x240				(360240)(LEGACY mode only)
	* m360x360				(360360)(LEGACY mode only)
	* m376x282				(376282)(LEGACY mode only)
	* m400x300				(400300)(LEGACY mode only)
	* m512x384				(512384)(LEGACY mode only)
	* m640x400				(640400)(LEGACY mode only)
	* m640x480				(640480)(LEGACY mode only)
	* m800x600				(800600)(LEGACY mode only)
	* m848x480				(848480)(LEGACY mode only)
	* m960x600				(960600)(LEGACY mode only)
	* m1024x768				(1024768)(LEGACY mode only)
	* m1152x864				(1152864)(LEGACY mode only)
	* m1280x720				(1280720)(LEGACY mode only)
	* m1280x768				(1280768)(LEGACY mode only)
	* m1280x800				(1280800)(LEGACY mode only)
	* m1280x960				(1280960)(LEGACY mode only)
	* m1280x1024				(12801024)(LEGACY mode only)
	* mode_8bits				(8)(LEGACY mode only)
	* mode_16bits				(16)(LEGACY mode only)
	* mode_32bits				(32)(LEGACY mode only)
	* mode_window				(1)
	* mode_fullscreen			(2)
	* mode_donotcenterwindow        	(4)
	* mode_centerwindow             	(8)
	* mode_donotcentermouse         	(16)
	* mode_centermouse             		(32)
	* mode_donotfade               		(64)
	* mode_fade                   		(128)
	* mode_buffercopy			(1024)
	* mode_bufferflip			(2048)
	* mode_donotwaitvsync			(4096)
	* mode_waitvsync			(8192)
	* mode_rate_default			(0)
	* mode_rate_60				(60)
	* mode_rate_70				(70)
	* mode_rate_75				(75)
	* mode_rate_100				(100)
	* mode_rate_150				(150)
	* mode_rate_200				(200)
	* renderer_driver 			(0)
	* renderer_simd 			(1)
	* renderer_driver_autodetect		(-1)
	* renderer_driver_software		( 1) (LEGACY mode only)
	* renderer_driver_simd			( 2) (LEGACY mode only)
	* renderer_driver_opengl		( 1) (MODERN mode only)
	* renderer_driver_opengl_with_simd	( 2) (MODERN mode only)
	* renderer_simd_autodetect		(-1)
	* renderer_simd_none			( 0)
	* renderer_simd_mmx			( 1)
	* render_framebuffer_ground		(-1)
	* render_framebuffer_screen		(0)
	* render_target_ground			(-1)
	* render_target_screen			(0)
	* filter_scaletype			(0)
	* filter_scanlinetype			(1)
	* filter_scanlinepercent		(2)
	* filter_scale_noscale			(0)
	* filter_scale_normal2x			(1)
	* filter_scale_scale2x			(2)
	* filter_scanline_noscanline		(0)
	* filter_scanline_1x			(1)
	* filter_scanline_25percent		(16)
	* filter_scanline_50percent		(32)
	* filter_scanline_75percent		(64)
	* filter_scanline_100percent		(128)
	* min_fps				(1)
	* default_fps				(24)
	* max_fps				(0)
	* no_jump				(0)
	* min_jump				(1)
	* max_jump				(100)
	* partial_dump				(0)
	* complete_dump				(1)
	* no_restore				(-1)
	* partial_restore			(0)
	* complete_restore			(1)
	* g_wide				(0)(LEGACY mode only)
	* g_width				(0)
	* g_height				(1)
	* g_x_center				(2)
	* g_y_center				(3)
	* g_numcpoints				(4)
	* g_alphachannel			(5)
	* transform_anchor_cpoint0		(-1)
	* transform_anchor_topleft		(0)
    * transform_anchor_topcenter		(1)
	* transform_anchor_topright 		(2)
    * transform_anchor_left			(3)
	* transform_anchor_center		(4)
	* transform_anchor_right		(5)
	* transform_anchor_bottomleft		(6)
    * transform_anchor_bottomcenter		(7)
	* transform_anchor_bottomright		(8)
	* transform_flags_normal                (0)
	* transform_flags_normal_hmirror        (1)
	* transform_flags_normal_vmirror        (2)
	* transform_flags_normal_hvmirror       (3)
	* transform_flags_transparency          (4)
	* transform_flags_transparency_hmirror  (5)
	* transform_flags_transparency_vmirror  (6)
	* transform_flags_transparency_hvmirror (7)
	* transform_flags_nokey                 (8)
	* transform_flags_nokey_hmirror         (9)
	* transform_flags_nokey_vmirror         (10)
	* transform_flags_nokey_hvmirror        (11)
	* transform_order_hsr          		(0)
	* transform_order_hrs          		(1)
	* transform_order_shr          		(2)
	* transform_order_srh          		(3)
	* transform_order_rhs        		(4)
	* transform_order_rsh			(5)
	* fx_solid				(0)
	* fx_alphacomposite_src			(1)
	* fx_alphacomposite_dst			(2)
	* fx_alphacomposite_srcover		(3)
	* fx_alphacomposite_dstover		(4)
	* fx_alphacomposite_srcin		(5)
	* fx_alphacomposite_dstin		(6)
	* fx_alphacomposite_srcout		(7)
	* fx_alphacomposite_dstout		(8)
	* fx_alphacomposite_srcatop		(9)
	* fx_alphacomposite_dstatop		(10)
	* fx_alphacomposite_clear		(11)
	* fx_alphacomposite_xor 		(12)
	* fx_blend_add				(13)(work only on 16/32bits)
	* fx_blend_subtract			(14)(work only on 16/32bits)
	* fx_blend_multiply			(15)(work only on 16/32bits)
	* fx_blend_average			(16)(work only on 16/32bits)
	* fx_blend_screen			(17)(work only on 16/32bits)
	* fx_blend_r				(18)(work only on 16/32bits)
	* fx_blend_g				(19)(work only on 16/32bits)
	* fx_blend_b				(20)(work only on 16/32bits)
	* fx_blend_rg				(21)(work only on 16/32bits)
	* fx_blend_rb				(22)(work only on 16/32bits)
	* fx_blend_gb				(23)(work only on 16/32bits)
	* fx_blend_lighten			(24)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_darken			(25)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_lightercolor			(26)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_darkercolor			(27)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_colordodge			(28)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_colorburn			(29)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_overlay			(30)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_softlight			(31)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_hardlight			(32)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_linearlight			(33)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_vividlight			(34)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_pinlight			(35)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_hardmix			(36)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_difference			(37)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_negation			(38)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_exclusion			(39)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_reflect			(40)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_glow				(41)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_phoenix			(42)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_hue				(43)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_saturation			(44)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_color			(45)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_blend_luminosity			(46)(work only on 16/32bits, MODERN mode only at the moment)
	* fx_invert				(1001)(work only on 16/32bits)
	* fx_invert_r				(1002)(work only on 16/32bits)
	* fx_invert_g				(1003)(work only on 16/32bits)
	* fx_invert_b				(1004)(work only on 16/32bits)
	* fx_invert_rg				(1005)(work only on 16/32bits)
	* fx_invert_rb				(1006)(work only on 16/32bits)
	* fx_invert_gb				(1007)(work only on 16/32bits)
	* fx_grayscale				(1008)(work only on 16/32bits)
	* fx_greyscale				(1008)(work only on 16/32bits)(UK name)
	* fx_scale_r				(1009)(work only on 16/32bits)
	* fx_scale_g				(1010)(work only on 16/32bits)
	* fx_scale_b				(1011)(work only on 16/32bits)
	* fx_scale_rg				(1012)(work only on 16/32bits)
	* fx_scale_rb				(1013)(work only on 16/32bits)
	* fx_scale_gb				(1014)(work only on 16/32bits)
	* fx_advanced				(0x3FFFFFFF)(work only on 16/32bits)
	* fx_advanced_tint			(0)(work only on 16/32bits)

	
	/* *** TYPEDEFS *** */

	* TYPE fx_advancedtype_tint
	    INT    mode      = fx_advanced_tint;
	    DWORD  color     = 0;
	    INT    intensity = 128;
	  END

	* TYPE render_surface
	    INT fnt   = -1;
	    INT file  = 0;
	    INT graph = render_framebuffer_screen;
	  END

	* TYPE render_asset
	    INT            *xgraph = null;
	    RENDER_SURFACE source;
	    RENDER_SURFACE target;
	  END

	* TYPE render_visibility
	    INT ctype   = c_screen;
	    INT cnumber = 0;
	    INT region  = 0;
	    INT visible = 1;
	  END

	* TYPE render_transform_set
	    INT anchor     = transform_anchor_cpoint0;
	    INT flags      = transform_flags_normal;
	    INT order      = transform_order_hsr;
	    INT resolution = 0;
	    INT tiled      = 0;
	  END

	* TYPE render_transform_block
	    INT  used   = 0;
	    VEC2 source = 0, 0; (IVEC2 on LEGACY mode)
	    VEC2 target = 0, 0; (IVEC2 on LEGACY mode)
	    INT  width  = 0;
	    INT  height = 0;
	  END

	* TYPE render_transform
	    RENDER_TRANSFORM_SET   set;
	    RENDER_TRANSFORM_BLOCK block;
	    VEC3                   position = 0, 0, 0;  (IVEC3 on LEGACY mode)
	    VEC3                   rotation = 0, 0, 0;  (IVEC3 on LEGACY mode)
	    VEC2                   scale    = 100, 100; (IVEC2 on LEGACY mode)
	    VEC2                   shear    = 0, 0;     (IVEC2 on LEGACY mode)
 	  END

	* TYPE render_fx
	    INT   mode   = fx_solid;
	    VOID *fxref  = null;
	    INT   alpha  = 255;
	    INT   filter = 0;
	  END

	* TYPE render_entity
	    RENDER_ASSET     asset;
	    RENDER_VISIBILITY visibility;
	    RENDER_TRANSFORM transform;
	    RENDER_FX        fx;
	  END


	/* *** VARIABLES *** */

	* INT dump_type			(= 1)
	* INT restore_type		(= 1)
	* INT fading			(= 0)
	* INT fps			(= 0)
	* INT num_video_modes		(= 0)
	* INT num_video_bits		(= 0)
	* INT num_video_rates		(= 0)
	* INT vsync			(= 0)
	* INT draw_z			(= -255)
	* INT draw_target_file  	(= 0)
	* INT draw_target_graph   	(= 0)
	* STRUCT video_modes[64]
	    INT wide	(= 0)(LEGACY mode only)
	    INT width	(= 0)
	    INT height	(= 0)
	    INT mode	(= 0)
	  END
	* STRUCT video_bits[3](LEGACY mode only)
	    INT bpp	(= 0)
	  END
	* STRUCT video_rates[32]
	    INT rate	(= 0)
	  END
	* RENDER_ENTITY render (LOCAL, FX.MODE: on 8bits work only from fx_solid to fx_alphacomposite_xor, FX.ALPHA: work only on 16/32bits, FX.FILTER: work only on 32bits MODERN mode at the moment)
	* INT ctype	(= 0)		-> (field of "render.visibility", LOCAL)
	* INT cnumber	(= 0)		-> (field of "render.visibility", LOCAL)


	/* *** FUNCTIONS *** */

// --- FPG RESOURCE MANAGEMENT ---

	* INT FPG_ADD_MAP(INT fpg_id_dst, INT graph_dst, INT fpg_id_src, INT graph_src)

	* INT FPG_CLONE(INT fpg_id)

	* INT FPG_EXISTS(INT fpg_id)

	* INT FPG_GET_MEMORYUSAGE(INT fpg_id)

	* INT FPG_GET_NUMMAPS(INT fpg_id)

	* INT FPG_IS_EMPTY(INT fpg_id)

	* INT FPG_IS_FULL(INT fpg_id)

	* INT FPG_LOAD(STRING fname)
	  INT FPG_LOAD(STRING fname, STRING password) -> (overload 1)
	  INT LOAD_FPG(STRING fname) -> (alias of FPG_LOAD, LEGACY mode only)

	* INT FPG_LOAD_MAP(STRING fname, INT fpg_id, INT graph)
	  INT FPG_LOAD_MAP(STRING fname, STRING password, INT fpg_id, INT graph) -> (overload 1)

	* INT FPG_NEW()

	* INT FPG_NEW_MAP(INT fpg_id, INT graph_code, INT width, INT height)
	  INT FPG_NEW_MAP(INT fpg_id, INT graph_code, INT width, INT height,
			  INT color) 		 			        	-> (overload 1)
	  INT FPG_NEW_MAP(INT fpg_id, INT graph_code, INT width, INT height,
			  INT color, INT alphachannel) 			       		-> (overload 2)
	  INT FPG_NEW_MAP(INT fpg_id, INT graph_code, INT width, INT height,
			  INT cpoint0_x, INT cpoint0_y, INT color)			-> (overload 3)
	  INT FPG_NEW_MAP(INT fpg_id, INT graph_code, INT width, INT height,
			  INT cpoint0_x, INT cpoint0_y, INT color, INT alphachannel)	-> (overload 4)
		- WIDTH & HEIGHT values:
		  1 to MAX_INT
		- CPOINT0_X & CPOINT0_Y values:
		  0 to WIDTH/HEIGHT - 1
		- ALPHACHANNEL values:
		  0 = MAP without alpha channel
		  1 = MAP with alpha channel

	* INT FPG_SAVE(INT fpg_id, STRING fname)
	  INT FPG_SAVE(INT fpg_id, STRING fname, INT compress, STRING password) -> (overload 1)
		- COMPRESS values:
		  0 = save without compression
		  1 = save with compression

	* INT FPG_UNLOAD(INT fpg_id)
	  INT UNLOAD_FPG(INT fpg_id) -> (alias of FPG_UNLOAD, LEGACY mode only)
		- FPG_ID values:
		  all_fpg (-1)
		  or value returned by FPG_LOAD function

	* INT FPG_UNLOAD_MAP(INT fpg_id, INT graph)


// --- IMAGE RESOURCE MANAGEMENT (MAP/BMP/JPEG/PCX/PNG/TGA) ---

	* INT IMAGE_LOAD(STRING fname)
	  INT IMAGE_LOAD(STRING fname, STRING password) -> (overload 1)
	
	* INT IMAGE_SAVE(INT fpg_id, INT graph, STRING fname, INT image_format)
	  INT IMAGE_SAVE(INT fpg_id, INT graph, STRING fname, INT image_format, INT compress)                  -> (overload 1)
	  INT IMAGE_SAVE(INT fpg_id, INT graph, STRING fname, INT image_format, INT compress, STRING password) -> (overload 2)
		- IMAGE_FORMAT values:
		  img_format_map	(1)
		  img_format_bmp	(2)
		  img_format_jpeg	(3)
		  img_format_pcx	(4)
		  img_format_png	(5)
		  img_format_tga	(6)
		- COMPRESS values:
		  0 = save without compression
		  1 = save with compression

	* INT IMAGE_UNLOAD(INT image_id)
		- IMAGE_ID values:
		  all_image (-1)
		  or value returned by IMAGE_LOAD function


// --- MAP RESOURCE MANAGEMENT ---

	* INT GRAPHIC_INFO(INT fpg_id, INT graph, INT info) -> (new parameters INFO)
		- INFO values:
	 	  g_wide		(0)
		  g_width		(0)
		  g_height		(1)
		  g_x_center		(2)
		  g_y_center		(3)
		  g_numcpoints		(4)
		  g_alphachannel	(5)

	* INT LOAD_PCX(STRING fname)(LEGACY mode only)

	* INT MAP_CLONE(INT fpg_id, INT graph) 	  

	* INT MAP_EXISTS(INT fpg_id, INT graph)	

	* STRING MAP_GET_DESC(INT fpg_id, INT graph)

	* INT MAP_GET_HEIGHT(INT fpg_id, INT graph)	

	* INT MAP_GET_MEMORYUSAGE(INT fpg_id, INT graph)

	* STRING MAP_GET_NAME(INT fpg_id, INT graph)

	* INT MAP_GET_NUMCPOINTS(INT fpg_id, INT graph)	

	* INT MAP_GET_WIDTH(INT fpg_id, INT graph)	

	* INT MAP_HAS_ALPHACHANNEL(INT fpg_id, INT graph)

	* INT MAP_LOAD(STRING fname)
	  INT MAP_LOAD(STRING fname, STRING password) -> (overload 1)
	  INT LOAD_MAP(STRING fname) -> (alias of MAP_LOAD, LEGACY mode only)

	* INT MAP_NEW(INT w, INT h)
	  INT MAP_NEW(INT w, INT h, INT color)				                       -> (overload 1)
	  INT MAP_NEW(INT w, INT h, INT color, INT alphachannel)	                       -> (overload 2)
	  INT MAP_NEW(INT w, INT h, INT cpoint0_x, INT cpoint0_y, INT color)                   -> (overload 3)
	  INT MAP_NEW(INT w, INT h, INT cpoint0_x, INT cpoint0_y, INT color, INT alphachannel) -> (overload 4)
	  INT NEW_MAP(INT w, INT h, INT cpoint0_x, INT cpoint0_y, INT color)                   -> (alias of MAP_NEW, LEGACY mode only)
		- WIDTH & HEIGHT values:
		  1 to MAX_INT
		- CPOINT0_X & CPOINT0_Y values:
		  0 to WIDTH/HEIGHT - 1
		- ALPHACHANNEL values:
		  0 = MAP without alpha channel
		  1 = MAP with alpha channel

	* INT MAP_SAVE(INT fpg_id, INT graph, STRING fname)
	  INT MAP_SAVE(INT fpg_id, INT graph, STRING fname, INT compress, STRING password) -> (overload 1)
	  INT SAVE_MAP(INT fpg_id, INT graph, STRING fname) -> (alias of MAP_SAVE, LEGACY mode only)
		- COMPRESS values:
		  0 = save without compression
		  1 = save with compression

	* INT MAP_SET_DESC(INT fpg_id, INT graph, STRING desc)

	* INT MAP_SET_NAME(INT fpg_id, INT graph, STRING name)

	* INT MAP_UNLOAD(INT map_id)
	  INT UNLOAD_MAP(INT map_id) -> (alias of MAP_UNLOAD, LEGACY mode only)
		- MAP_ID values:
		  all_map (-1)
		  or value returned by MAP_LOAD function

	* INT SAVE_PCX(INT fpg_id, INT graph, STRING fname)(LEGACY mode only)

	* INT UNLOAD_PCX(INT pcx_id)
		- PCX_ID values:
		  all_pcx (-1)
		  or value returned by LOAD_PCX function (LEGACY mode only)


// --- GRAPHICS OPERATIONS ---

	* INT GROUND_COPY(INT region, INT fpg_id, INT graph, INT x, INT y, INT width, INT height)
		- REGION values:
		  0 to 65536

	* INT GROUND_GET(INT fpg_id, INT graph)

	* INT GROUND_GET_PIXEL(INT x, INT y)(LEGACY mode only)
	  INT GET_PIXEL(INT x, INT y)  -> (alias of GROUND_GET_PIXEL, LEGACY mode only)

	* INT GROUND_PUT(INT fpg_id, INT graph, INT x, INT y)
	  INT GROUND_PUT(INT fpg_id, INT graph) -> (overload 1)
	  INT PUT(INT fpg_id, INT graph, INT x, INT y) -> (alias of GROUND_PUT, LEGACY mode only)

	* INT GROUND_PUT_CIRCLE(INT x, INT y, INT radius, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT GROUND_PUT_CSELLIPSE(INT x, INT y, INT radius_x, INT radius_y, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT GROUND_PUT_CSRECT(INT x, INT y, INT width, INT height, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT GROUND_PUT_ELLIPSE(INT x0, INT y0, INT x1, INT y1, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT GROUND_PUT_LINE(INT x0, INT y0, INT x1, INT y1, DWORD color)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits

	* INT GROUND_PUT_PIXEL(INT x, INT y, DWORD color)(LEGACY mode only)
	  INT GROUND_PUT_PIXEL(INT x, INT y, DWORD color, INT unchange_alphachannel) -> (overload 1, LEGACY mode only)
	  INT PUT_PIXEL(INT x, INT y, INT color) -> (alias of GROUND_PUT_PIXEL, LEGACY mode only)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits

	* INT GROUND_PUT_RECT(INT x0, INT y0, INT x1, INT y1, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT PUT_SCREEN(INT fpg_id, INT graph) -> (alias of GROUND_PUT_SCREEN, LEGACY mode only)

	* INT GROUND_PUT_SRECT(INT x, INT y, INT width, INT height, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT GROUND_XPUT(INT fpg_id, INT graph, INT x, INT y,
		          INT angle, INT size, INT flags, INT region) -> (LEGACY mode only)
	  INT XPUT(INT fpg_id, INT graph, INT x, INT y,
		   INT angle, INT size, INT flags, INT region) -> (alias of GROUND_XPUT, LEGACY mode only)
		- ANGLE values:
		  min_int to max_int
		- SIZE values:
		  min_int to max_int
		- FLAGS values:
                  flg_normal		(0)
                  flg_hmirror		(1)
                  flg_vmirror		(2)
                  flg_hvmirror		(3)
                  flg_ghost		(4)
                  flg_ghost_hmirror	(5)
                  flg_ghost_vmirror	(6)
                  flg_ghost_hvmirror	(7)
                  flg_nokey		(8)
                  flg_nokey_hmirror	(9)
                  flg_nokey_vmirror	(10)
                  flg_nokey_hvmirror	(11)
		- REGION values:
		  0 to 65536

	* INT MAP_BLOCK_COPY(INT fpg_id   , INT graph_dst, INT dst_x, INT dst_y,
			     INT graph_src, INT src_x    , INT src_y, INT width,
                             INT height)
	  INT MAP_BLOCK_COPY(INT fpg_id_dst, INT graph_dst, INT dst_x, INT dst_y,
			     INT fpg_id_src, INT graph_src, INT src_x, INT src_y,
			     INT width,      INT height)				-> (overload 1)
		- WIDTH & HEIGHT values:
		  1 to MAX_INT

	* INT MAP_CLEAR(INT fpg_id, INT graph, INT color)
	  INT MAP_CLEAR(INT fpg_id, INT graph, INT color, INT unchange_alphachannel) -> (overload 1)

	* INT MAP_CONVERT_PALETTE(INT fpg_id, INT graph, INT *palette_data) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT CONVERT_PALETTE(INT fpg_id, INT graph, INT *palette_data) -> (alias of MAP_CONVERT_PALETTE, NOTE: works only on 8bits, LEGACY mode only)

	* INT MAP_CPOINT_EXISTS(INT fpg_id, INT graph, INT cpoint)
		- CPOINT values:
		  0 to max value returned by GRAPHIC_INFO(fpg, graph, g_points) - 1 or MAP_GET_NUMCPOINTS(fpg, graph, point) - 1

	* INT MAP_DELETE_CPOINT(INT fpg_id, INT graph, INT cpoint)
		- CPOINT values:
		  1 to 999

	* INT MAP_GET_BUFFER(INT fpg_id, INT graph)

	* INT MAP_GET_CPOINT(INT fpg_id, INT graph_id, INT num, INT *x, INT *y)
	  INT GET_POINT(INT fpg_id, INT graph_id, INT num, INT *x, INT *y) -> (alias of MAP_GET_CPOINT)
		- NUM values:
		  0 to 999

	* INT MAP_GET_PIXEL(INT fpg_id, INT graph, INT x, INT y)

	* INT MAP_GET_REALCPOINT(INT num, INT *x, INT *y)
          INT MAP_GET_REALCPOINT(INT process_id, INT num, INT *x, INT *y)
          INT GET_REAL_POINT(INT num, INT *x, INT *y) -> (alias of MAP_GET_REALCPOINT)	  
		- NUM values:
		  0 to 999

	* INT MAP_GET_RGB(INT fpg_id, INT graph, INT x, INT y, INT *r, INT *g, INT *b)

	* INT MAP_GET_RGBA(INT fpg_id, INT graph, INT x, INT y, INT *r, INT *g, INT *b, INT *alpha)

	* INT MAP_GET_XCENTER(INT fpg_id, INT graph)	

	* INT MAP_GET_YCENTER(INT fpg_id, INT graph)	

	* INT MAP_NEW_CPOINT(INT fpg_id, INT graph, INT cpoint, INT x, INT y)
		- CPOINT values:
		  1 to 999

	* INT MAP_PUT(INT fpg_id, INT graph_dst, INT graph_src, INT x, INT y)
          INT MAP_PUT(INT fpg_id_dst, INT graph_dst, INT fpg_id_src, INT graph_src, INT x, INT y)	-> (overload)

	* INT MAP_PUT_CIRCLE(INT fpg_id, INT graph, INT x, INT y, INT radius, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT MAP_PUT_CSELLIPSE(INT fpg_id, INT graph, INT x, INT y, INT radius_x, INT radius_y, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT MAP_PUT_CSRECT(INT fpg_id, INT graph, INT x, INT y, INT width, INT height, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT MAP_PUT_ELLIPSE(INT fpg_id, INT graph, INT x0, INT y0, INT x1, INT y1, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the circle
		  1 = fill the circle

	* INT MAP_PUT_LINE(INT fpg_id, INT graph, INT x0, INT y0, INT x1, INT y1, INT color)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits

	* INT MAP_PUT_PIXEL(INT fpg_id, INT graph, INT x, INT y, DWORD color)
	  INT MAP_PUT_PIXEL(INT fpg_id, INT graph, INT x, INT y, DWORD color, INT unchange_alphachannel) -> (overload 1)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits

	* INT MAP_PUT_RECT(INT fpg_id, INT graph, INT x0, INT y0, INT x1, INT y1, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT MAP_PUT_SRECT(INT fpg_id, INT graph, INT x, INT y, INT width, INT height, DWORD color, INT fill)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- FILL values:
		  0 = not fill the rectangle
		  1 = fill the rectangle

	* INT MAP_SET_CENTER(INT fpg_id, INT graph, INT x, INT y)

	* INT MAP_SET_COLOR/COLOUR(INT fpg_id, INT graph, DWORD old_color, DWORD new_color)
		- OLD_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- NEW_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits

	* INT MAP_SET_CPOINT(INT fpg_id, INT graph, INT cpoint, INT x, INT y)
		- CPOINT values:
		  0 to 999

	* INT MAP_XPUT(INT fpg_id, INT graph_dst, INT graph_src,
		       INT x,          INT y
		       INT angle,      INT size,     INT flags) (LEGACY mode only)
	  INT MAP_XPUT(INT fpg_id_dst, INT graph_dst,
		       INT fpg_id_src, INT graph_src,
		       INT x,          INT y
		       INT angle,      INT size,     INT flags)		-> (overload 1)(LEGACY mode only)
		- ANGLE values:
		  min_int to max_int
		- SIZE values:
		  min_int to max_int
		- FLAGS values:
                  flg_normal		(0)
                  flg_hmirror		(1)
                  flg_vmirror		(2)
                  flg_hvmirror		(3)
                  flg_ghost		(4)
                  flg_ghost_hmirror	(5)
                  flg_ghost_vmirror	(6)
                  flg_ghost_hvmirror	(7)
                  flg_nokey		(8)
                  flg_nokey_hmirror	(9)
                  flg_nokey_vmirror	(10)
                  flg_nokey_hvmirror	(11)

	* INT SCREEN_CLEAR()
	  INT CLEAR_SCREEN() -> (alias of SCREEN_CLEAR, LEGACY mode only)

	* INT SCREEN_COPY(INT region, INT fpg_id, INT graph, INT x, INT y, INT width, INT height)
		- REGION values:
		  0 to 65536

	* INT SCREEN_FADE(INT %R, INT %G, INT %B, INT speed)
	  INT FADE(INT %R, INT %G, INT %B, INT speed) -> (alias of SCREEN_FADE, LEGACY mode only)
		- %R G B values:
		  0 to 200
		- SPEED values:
		  1 to 63, >= 64 FADE inmediately

	* INT SCREEN_FADE_IN()
	  INT FADE_ON() -> (alias of SCREEN_FADE_IN, LEGACY mode only)

	* INT SCREEN_FADE_OUT()
	  INT FADE_OFF() -> (alias of SCREEN_FADE_OUT, LEGACY mode only)

	* INT SCREEN_GET(INT fpg_id, INT graph)

	* INT SCREEN_GET_COLOR/COLOUR()(LEGACY mode only)
	  INT SCREEN_GET_COLOR/COLOUR(INT *r, INT *g, INT *b) -> (overload 1, LEGACY mode only) 

	* INT SCREEN_GET_PIXEL(INT x, INT y)(LEGACY mode only)

	* INT SCREEN_LOAD(STRING fname)
	  INT SCREEN_LOAD(STRING fname, STRING password) -> (overload 1)
	* INT LOAD_SCREEN(STRING fname) -> (alias of SCREEN_LOAD, LEGACY mode only)

	* INT SCREEN_SET_COLOR/COLOUR(DWORD color)
	  INT SCREEN_SET_COLOR/COLOUR(INT r, INT g, INT b)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- R G B values:
		  0 to 63 on 8bits
		  0 to 255 on 16/32bbits

	* INT RENDER_TEXT(RENDER_ENTITY entity_text)
	  INT RENDER_TEXT(RENDER_ENTITY entity_text, STRING text) -> (overload 1)


// --- COLOR SPACE AND PALETTE ---
	
	* INT GET_RGB(DWORD color, INT *r, INT *g, INT *b) -> (NOTE: works only on 16/32bits)

	* INT GET_RGBA(DWORD color, INT *r, INT *g, INT *b, INT *alpha) -> (NOTE: works only on 16/32bits)

	* INT PALETTE_FIND_COLOR/COLOUR(INT r, INT g, INT b) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT FIND_COLOR/COLOUR(INT r, INT g, INT b) -> (alias of PALETTE_FIND_COLOR/COLOUR, NOTE: works only on 8bits, LEGACY mode only)
		- R G B values:
		  0 to 63

	* INT PALETTE_FORCE(STRING fname) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT FORCE_PAL(STRING fname) -> (alias of PALETTE_FORCE, (NOTE: works only on 8bits, LEGACY mode only)

	* INT PALETTE_LOAD(STRING fname) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT LOAD_PAL(STRING fname) -> (alias of LOAD_PAL, (NOTE: works only on 8bits, LEGACY mode only)

	* INT PALETTE_ROLL(INT initial_color, INT ncolors, INT increment) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT ROLL_PALETTE(INT initial_color, INT ncolors, INT increment) -> (alias of PALETTE_ROLL, NOTE: works only on 8bits, LEGACY mode only)

	* INT PALETTE_SAVE(STRING fname) -> (NOTE: works only on 8bits, LEGACY mode only)

	* INT PALETTE_SET_COLOR/COLOUR(INT color, INT r, INT g, INT b) -> (NOTE: works only on 8bits, LEGACY mode only)
	  INT SET_COLOR(INT color, INT r, INT g, INT b) -> (alias of PALETTE_SET_COLOR/COLOUR, NOTE: works only on 8bits, LEGACY mode only)
		- COLOR values:
		  0 to 255
		- R G B values:
		  0 to 63

	* INT PALETTE_SET_COLORS/COLOURS(INT color, INT colors, INT *palette) -> (NOTE: works only on 8bits, LEGACY mode only)
		- COLOR values:
		  0 to 255
		- COLORS values:
		  1 to 256

	* DWORD RGB(INT r, INT g, INT b) -> (NOTE: works only on 16/32bits)

	* DWORD RGBA(INT r, INT g, INT b, INT alpha) -> (NOTE: works only on 16/32bits)

	* DWORD RGBX(INT r, INT g, INT b) -> (with alpha channel = 255, NOTE: works only on 16/32bits)


// --- PRIMITIVE DRAW ---

	* INT DRAW_DELETE(INT draw_id)
	  INT DELETE_DRAW(INT draw_id) -> (alias of DRAW_DELETE, LEGACY mode only)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function

	* INT DRAW_EXISTS(INT draw_id)

	* INT DRAW_FIX(INT draw_id, INT fix)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- FIX values:
		  0 = unfix the drawing
		  1 = fix the drawing

	* INT DRAW_GET_ALPHA(INT draw_id)

	* INT DRAW_GET_BOX(INT draw_id, INT *x0, INT *y0, INT *x1, INT *y1)

	* INT DRAW_GET_COLOR(INT draw_id)

	* INT DRAW_GET_HEIGHT(INT draw_id)

	* INT DRAW_GET_REGION(INT draw_id)

	* INT DRAW_GET_TYPE(INT draw_id)

	* INT DRAW_GET_VISIBLE(INT draw_id)

	* INT DRAW_GET_WIDTH(INT draw_id)

	* INT DRAW_GET_X0(INT draw_id)

	* INT DRAW_GET_X1(INT draw_id)

	* INT DRAW_GET_Y0(INT draw_id)

	* INT DRAW_GET_Y1(INT draw_id)

	* INT DRAW_GET_Z(INT draw_id)

	* INT DRAW_IS_FIXED(INT draw_id)

	* INT DRAW_IS_LOCKED(INT draw_id)

	* INT DRAW_LOCK(INT draw_id)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- call this before any DRAW_SET_XXX function

	* INT DRAW_MOVE(INT draw_id, DWORD color, INT alpha
			INT x0, INT y0, INT x1, INT y1)
	  INT MOVE_DRAW(INT draw_id, DWORD color, INT alpha
			INT x0, INT y0, INT x1, INT y1) -> (alias of DRAW_MOVE, LEGACY mode only)
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65536 or value returned by RGB function on 16bits (LEGACY mode only)
		  value returned by RGB or RGBA functions on 32bits
		- ALPHA values:
		  0 to 15 on 8bits
		  0 to 255 on 16/32bits

	* INT DRAW_NEW(INT type, DWORD color, INT alpha, INT region
		       INT x0, INT y0, INT x1, INT y1)
	  INT DRAW(INT type, DWORD color, INT alpha, INT region
		   INT x0, INT y0, INT x1, INT y1) -> (alias of DRAW_NEW, LEGACY mode only)
		- TYPE values:
		  1 = line
		  2 = rectangle
		  3 = rectangle fill
		  4 = ellipse
		  5 = ellipse fill
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function
		- ALPHA values:
		  0 to 15 on 8bits
		  0 to 255 on 16/32bits
		- REGION values:
		  0 to 65536

	* INT DRAW_SET_ALPHA(INT draw_id, INT alpha)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- ALPHA values:
		  0 to 15  on 8 bits
		  0 to 255 on 16/32 bits

	* INT DRAW_SET_COLOR(INT draw_id, DWORD color)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function

	* INT DRAW_SET_TARGET(INT draw_id, INT target_file, INT target_graph)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function

	* INT DRAW_SET_REGION(INT draw_id, INT region)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- REGION values:
		  0 to 65536

	* INT DRAW_SET_VISIBLE(INT draw_id, INT visible)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- VISIBLE values:
		  0 = not visible
                  1 = visible

	* INT DRAW_SET_Z(INT draw_id, INT z)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW function
		- Z values:
		  INT 32 range

	* INT DRAW_UNLOCK(INT draw_id)
		- DRAW_ID values:
		  all_drawing (-1)
		  or value returned by DRAW_NEW/DRAW function
		- call this if do not want lock


// --- REGIONS ---

	* INT REGION_DEFINE(INT region, INT x, INT y, INT w, INT h)
	  INT DEFINE_REGION(INT region, INT x, INT y, INT w, INT h) -> (alias of REGION_DEFINE, LEGACY mode only)
		- REGION values:
		  0 TO 65536

	* INT REGION_GET_BOX(INT region, INT *x0, INT *y0, INT *x1, INT *y1)

	* INT REGION_GET_HEIGHT(INT region)

	* INT REGION_GET_WIDTH(INT region)

	* INT REGION_GET_X0(INT region)

	* INT REGION_GET_X1(INT region)

	* INT REGION_GET_Y0(INT region)

	* INT REGION_GET_Y1(INT region)

	* INT REGION_IS_DEFINED(INT region)

	* INT REGION_IS_OUT(INT process_id, INT region)
	  INT REGION_IS_OUT(INT process_id, INT x, INT y, INT width, INT height) -> (overload 1)
	  INT OUT_REGION(INT process_id, INT region) -> (alias of REGION_IS_OUT, LEGACY mode only)
		- REGION values:
		  0 to 65536

	* FLOAT REGION_IS_XOUT(INT process_id, INT region)
	  FLOAT REGION_IS_XOUT(INT process_id, INT x, INT y, INT width, INT height) -> (overload 1)
		- REGION values:
		  0 to 65536

	* INT REGION_UNDEFINE(INT region)
		- REGION values:
		  0 to 65536


// --- PROCESS INTERACTION ---

	* INT ADVANCE(INT distance)
	  INT ADVANCE(FLOAT distance) -> (overload 1)
	  INT ADVANCE(INT process_id, INT distance) -> (overload 2)
	  INT ADVANCE(INT process_id, FLOAT distance) -> (overload 3)
		
	* INT COLLISION(INT process_id)
	  INT COLLISION(TYPE process)
	  INT COLLISION(INT process_id, INT process_id_collision) -> (overload 1)
	  INT COLLISION(INT process_id, TYPE process_collision)
	  INT COLLISION(INT x, INT y, TYPE process)               -> (overload 2)
	  INT COLLISION(INT x, INT y, INT process_id)

	* INT COLLISION_GET_ALPHATHRESHOLD()

	* INT COLLISION_SET_ALPHATHRESHOLD(INT threshold)
	- TRHESHOLD values:
	  0 to 254

	* INT GET_ANGLE(INT process_id)
	  INT GET_ANGLE(INT process_id1, INT process_id2) -> (overload 1)

	* INT GET_DIST(INT process_id)
	  INT GET_DIST(INT process_id1, INT process_id2) -> (overload 1)

	* INT OVERLAP(INT process_id)
	  INT OVERLAP(TYPE process)
	  INT OVERLAP(INT process_id, INT process_id_overlap) -> (overload 1)
	  INT OVERLAP(INT process_id, TYPE process_overlap)
	  INT OVERLAP(INT x, INT y, TYPE process)             -> (overload 2)
	  INT OVERLAP(INT x, INT y, INT process_id)

	* INT XADVANCE(INT angle, INT distance)
	  INT XADVANCE(INT angle, FLOAT distance) -> (overload 1)
	  INT XADVANCE(INT process_id, INT angle, INT distance) -> (overload 2)
	  INT XADVANCE(INT process_id, INT angle, FLOAT distance) -> (overload 3)


// --- INIT ---

	* INT MODE_CHANGE(INT flagsmode)
	  INT MODE_CHANGE(INT flagsmode, INT framerate)	-> (overload 1)
		- FLAGSMODE combination of following values:
		  mode_window			(1)
		  mode_fullscreen		(2)
		  mode_donotcenterwindow	(4)
		  mode_centerwindow             (8)
		  mode_donotcentermouse         (16)
		  mode_centermouse              (32)
		  mode_donotfade                (64)
		  mode_fade                     (128)
		  mode_buffercopy		(1024)
		  mode_bufferflip		(2048)
		  mode_donotwaitvsync		(4096)
		  mode_waitvsync		(8192)
		- FRAMERATE values:
		  mode_rate_default	(0)
		  mode_rate_60		(60)
		  mode_rate_70		(70)
		  mode_rate_75		(75)
		  mode_rate_100		(100)
		  mode_rate_150		(150)
		  mode_rate_200		(200)
		  or other frame_rate returned by struct VIDEO_RATES.RATE and supported
		  by screen resolution

	* INT MODE_EXISTS(INT width, INT height)
	  INT MODE_EXISTS(INT width, INT height, INT framerate) -> (overload)
	* INT MODE_EXISTS(INT width, INT height, INT bpp) -> (LEGACY mode only)
	  INT MODE_EXISTS(INT width, INT height, INT bpp, INT framerate) -> (overload, LEGACY mode only)
		- BPP values: (LEGACY mode only)
		  8, 16 or 32
		- FRAME_RATE values:
		  mode_rate_default	(0)
		  mode_rate_60		(60)
		  mode_rate_70		(70)
		  mode_rate_75		(75)
		  mode_rate_100		(100)
		  mode_rate_150		(150)
		  mode_rate_200		(200)
		  or other frame_rate returned by struct VIDEO_RATES.RATE and supported
		  by screen resolution

	* INT MODE_GET_BPP()(LEGACY mode only)

	* INT MODE_GET_BUFFERBEHAVIOUR()

	* INT MODE_GET_FILTER(INT filtertype)
		- FILTERTYOE values:
		  filter_scaletype		(0)
		  filter_scanlinetype		(1)
		  filter_scanlinepercent	(2)

	* INT MODE_GET_HEIGHT()

	* INT MODE_GET_RATE()

	* INT MODE_GET_REALHEIGHT()

	* INT MODE_GET_REALWIDTH()

	* INT MODE_GET_RENDERER(INT renderer_type)
		- RENDERER_TYPE values:
		  renderer_driver	(0)
		  renderer_simd		(1)

	* INT MODE_GET_TYPE()

	* INT MODE_GET_VSYNC()

	* INT MODE_GET_WIDTH()

	* INT MODE_IS_EMULATED()

	* INT MODE_SET(INT width, INT height)
	  INT MODE_SET(INT width, INT height, INT flagsmode)	-> (overload 1)
	  INT MODE_SET(INT width, INT height, INT flagsmode
                       INT framerate)				-> (overload 2)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode
                       INT scaletype, INT scanlineflags)		-> (overload 5)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode
                       INT framerate, INT scaletype, INT scanlineflags)	-> (overload 6)
	* INT MODE_SET(INT mode) (LEGACY mode only)
	  INT MODE_SET(INT width, INT height)				-> (overload 1, LEGACY mode only)
	  INT MODE_SET(INT width, INT height, INT bpp)			-> (overload 2, LEGACY mode only)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode)	-> (overload 3, LEGACY mode only)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode
                       INT framerate)					-> (overload 4, LEGACY mode only)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode
                       INT scaletype, INT scanlineflags)		-> (overload 5, LEGACY mode only)
	  INT MODE_SET(INT width, INT height, INT bpp, INT flagsmode
                       INT framerate, INT scaletype, INT scanlineflags)	-> (overload 6, LEGACY mode only)
	  INT SET_MODE(INT mode)                                        -> (alias of MODE_SET, LEGACY mode only)
		- MODE values: (LEGACY mode only)
		  m320x200		(320200)
		  m320x240		(320240)
		  m320x400		(320400)
		  m360x240		(360240)
		  m360x360		(360360)
		  m376x282		(376282)
		  m400x300		(400300)
		  m512x384		(512384)
		  m640x400		(640400)
		  m640x480		(640480)
		  m800x600		(800600)
		  m848x480		(848480)
		  m960x600		(960600)
		  m1024x768		(1024768)
		  m1152x864		(1152864)
		  m1280x720		(1280720)
		  m1280x768		(1280768)
		  m1280x800		(1280800)
		  m1280x960		(1280960)
		  m1280x1024		(12801024)
		- BPP values: (LEGACY mode only)
		  8, 16 or 32
		- FLAGSMODE combination of following values:
		  mode_window			(1)
		  mode_fullscreen		(2)
		  mode_donotcenterwindow	(4)
		  mode_centerwindow             (8)
		  mode_donotcentermouse         (16)
		  mode_centermouse              (32)
		  mode_donotfade                (64)
		  mode_fade                     (128)
		  mode_buffercopy		(1024)
		  mode_bufferflip		(2048)
		  mode_donotwaitvsync		(4096)
		  mode_waitvsync		(8192)
		- FRAMERATE values:
		  mode_rate_default	(0)
		  mode_rate_60		(60)
		  mode_rate_70		(70)
		  mode_rate_75		(75)
		  mode_rate_100		(100)
		  mode_rate_150		(150)
		  mode_rate_200		(200)
		  or other frame_rate returned by struct VIDEO_RATES.RATE and supported
		  by screen resolution
		- SCALETYPE values:
		  filter_scale_noscale		(0)
		  filter_scale_normal2x		(1)
		  filter_scale_scale2x		(2)
		- SCANLINEFLAGS combination of following values:
		  filter_scanline_noscanline	(0)
		  filter_scanline_1x		(1)
                  filter_scanline_25percent	(16)
                  filter_scanline_50percent	(32)
                  filter_scanline_75percent	(64)
                  filter_scanline_100percent	(128)

        * INT MODE_SET_FILTER(INT scaletype)
	  INT MODE_SET_FILTER(INT scaletype, scanlineflags) -> (overload 1)
		- SCALETYPE values:
		  filter_scale_noscale		(0)
		  filter_scale_normal2x		(1)
		  filter_scale_scale2x		(2)
		- SCANLINEFLAGS combination of following values:
		  filter_scanline_noscanline	(0)
		  filter_scanline_1x		(1)
          filter_scanline_25percent	(16)	-> (work only on 16/32bits)
          filter_scanline_50percent	(32)	-> (work only on 16/32bits)
          filter_scanline_75percent	(64)	-> (work only on 16/32bits)
          filter_scanline_100percent	(128)

	* INT MODE_SET_RENDERER(INT renderer_driver)
	  INT MODE_SET_RENDERER(INT renderer_driver, INT renderer_simd)	-> (overload 1)
		- RENDERER_DRIVER values:
		  renderer_driver_autodetect		(-1)
	  	  renderer_driver_software		( 1) (LEGACY mode only)
	  	  renderer_driver_simd			( 2) (LEGACY mode only)
	  	  renderer_driver_opengl		( 1) (MODERN mode only)
	  	  renderer_driver_opengl_with_simd	( 2) (MODERN mode only)
		- RENDERER_SIMD values:
		  renderer_simd_autodetect		(-1)
		  renderer_simd_none			( 0)
		  renderer_simd_mmx			( 1)

	* INT VIRTUALRESOLUTION_GET_ASPECTRATIO()

	* INT VIRTUALRESOLUTION_GET_HEIGHT()

	* INT VIRTUALRESOLUTION_GET_RATIOHEIGHT()

	* INT VIRTUALRESOLUTION_GET_RATIOWIDTH()

	* INT VIRTUALRESOLUTION_GET_WIDTH()

	* INT VIRTUALRESOLUTION_GET_XOFFSET()

	* INT VIRTUALRESOLUTION_GET_YOFFSET()

	* INT VIRTUALRESOLUTION_IS_EMULATED()

	* INT VIRTUALRESOLUTION_SET(INT virtual_width, INT virtual_height,
                                    INT correction_aspectratio, INT activemode)
		- CORRECTION_ASPECTRATIO values:
		  0 = aspect ratio off
                  1 = aspect ratio on
		- ACTIVEMODE values:
		  0 = set the virtual resolution on the next MODE_SET call
		  1 = set the virtual resolution immediately (using the previous MODE_SET)

	* INT SET_FPS(INT nfps, INT jumpers)
		- NFPS values:
		  max_fps	(0)
		  min_fps	(1)
		  default_fps	(24)
		  or 0 to 1000
		- JUMPERS values:
		  no_jump	(0)
		  min_jump	(1)
		  max_jump	(100)
		  or 0 to 100


// --- GRAPHICS LIBRARY INFORMATION ---

	* INT GRAPHICLIB_GET_DRAWSFIXED()

	* INT GRAPHICLIB_GET_DRAWSLOCKED()

	* INT GRAPHICLIB_GET_DRAWSPAINTED()

	* INT GRAPHICLIB_GET_FPGSLOADED()

	* INT GRAPHICLIB_GET_MAPSLOADED()

	* INT GRAPHICLIB_GET_REGIONSDEFINED()



---------------------------
--- INPUT
---------------------------
	/* *** CONSTANTS *** */

	* _esc			(1)
	* _f1			(59)
	* _f2			(60)
	* _f3			(61)
	* _f4			(62)
	* _f5			(63)
	* _f6			(64)
	* _f7			(65)
	* _f8			(66)
	* _f9			(67)
	* _f10			(68)
	* _f11			(87)
	* _f12			(88)
	* _prn_scr		(55)
	* _scroll_lock		(70)
	* _wave			(41)
	* _1			(2)
	* _2			(3)
	* _3			(4)
	* _4			(5)
	* _5			(6)
	* _6			(7)
	* _7			(8)
	* _8			(9)
	* _9			(10)
	* _0			(11)
	* _minus		(12)
	* _plus			(13)
	* _backspace		(14)
	* _tab			(15)
	* _q			(16)
	* _w			(17)
	* _e			(18)
	* _r			(19)
	* _t			(20)
	* _y			(21)
	* _u			(22)
	* _i			(23)
	* _o			(24)
	* _p			(25)
	* _l_bracket		(26)
	* _r_bracket		(27)
	* _enter		(28)
	* _caps_lock		(58)
	* _a			(30)
	* _s			(31)
	* _d			(32)
	* _f			(33)
	* _g			(34)
	* _h			(35)
	* _j			(36)
	* _k			(37)
	* _l			(38)
	* _semicolon		(39)
	* _apostrophe		(40)
	* _backslash		(43)
	* _l_shift		(42)
	* _z			(44)
	* _x			(45)
	* _c			(46)
	* _v			(47)
	* _b			(48)
	* _n			(49)
	* _m			(50)
	* _comma		(51)
	* _point		(52)
	* _slash		(53)
	* _r_shift		(54)
	* _control		(29)
	* _alt			(56)
	* _space		(57)
	* _ins			(82)
	* _home			(71)
	* _pgup			(73)
	* _del			(83)
	* _end			(79)
	* _pgdn			(81)
	* _up			(72)
	* _down			(80)
	* _left			(75)
	* _right		(77)
	* _num_lock		(69)
	* _c_backslash		(53)
	* _c_asterisk		(55)
	* _c_minus		(74)
	* _c_home		(71)
	* _c_up			(72)
	* _c_pgup		(73)
	* _c_left		(75)
	* _c_center		(76)
	* _c_right		(77)
	* _c_end		(79)
	* _c_down		(80)
	* _c_pgdn		(81)
	* _c_ins		(82)
	* _c_del		(83)
	* _c_plus		(78)
	* _c_enter		(28)
	* _less			(86)
	* _shift		(190)
	* _l_alt		(193)
	* _r_alt		(184)
	* _l_control		(192)
	* _r_control		(157)
	* _oem_102		(86)
	* _pause		(197)
	* _meta			(218)
	* _l_meta		(219)
	* _r_meta		(220)
	* _alt_x		(1000)
	* _command_q		(1001)
	* mouse_status_off	(0)
	* mouse_status_on	(1)
	* joy_button1		(0)
	* joy_button2		(1)
	* joy_button3		(2)
	* joy_button4		(3)
	* joy_button5		(4)
	* joy_button6		(5)
	* joy_button7		(6)
	* joy_button8		(7)
	* joy_button9		(8)
	* joy_button10		(9)
	* joy_button11		(10)
	* joy_button12		(11)
	* joy_button13		(12)
	* joy_button14		(13)
	* joy_button15		(14)
	* joy_button16		(15)
	* joy_button17		(16)
	* joy_button18		(17)
	* joy_button19		(18)
	* joy_button20		(19)
	* joy_button21		(20)
	* joy_button22		(21)
	* joy_button23		(22)
	* joy_button24		(23)
	* joy_button25		(24)
	* joy_button26		(25)
	* joy_button27		(26)
	* joy_button28		(27)
	* joy_button29		(28)
	* joy_button30		(29)
	* joy_button31		(30)
	* joy_button32		(31)
	* joy_axis_x		(0)
	* joy_axis_y		(1)
	* joy_axis_z   	        (2)
	* joy_axis_r		(3)
	* joy_axis_u		(4)
	* joy_axis_v		(5)
	* joy_hat1		(0)
	* joy_hat2		(1)
	* joy_hat3		(2)
	* joy_hat4		(3)
	* joy_hat_notavailable	(-1)
	* joy_hat_centered	( 0)
	* joy_hat_up		( 1)
	* joy_hat_right		( 2)
	* joy_hat_down		( 4)
	* joy_hat_left		( 8)
	* joy_hat_rightup	( 3)
	* joy_hat_rightdown	( 6)
	* joy_hat_leftdown	(12)
	* joy_hat_leftup	( 9)
	* joy_status_off	(0)
	* joy_status_on		(1)
	* joy_status_forced	(2)


	/* *** VARIABLES *** */

	* INT ascii		(= 0)
	* INT scan_code		(= 0)
	* INT shift_status	(= 0)
	* INT mouse_status	(= 1)
		- values:
		  mouse_status_off	(0)
		  mouse_status_on	(1)
	* INT joy_filter	(= 10)
	* INT joy_status	(= 1)
		- values:
		  joy_status_off	(0)
		  joy_status_on		(1)
		  joy_status_forced	(2)
	* STRUCT mouse
	    INT x		(= 0)
	    INT y		(= 0)
	    INT graph		(= 0)
	    INT file		(= 0)
	    INT z		(= -512)
	    INT angle		(= 0)
	    INT size		(= 100)
	    INT flags		(= 0)
	    INT region		(= 0)
	    INT left		(= 0)
	    INT middle		(= 0)
	    INT right		(= 0)
	    INT cursor		(= 0)
	    INT speed		(= 2)
	    INT wheelup		(= 0)
	    INT wheeldown	(= 0)
	    INT wheelroll	(= 0)
	    INT fxmode		(= 0)	-> (work only on 16/32bits)
	    INT fxcolor		(= 0)	-> (work only on 16/32bits)
	    INT fxintensity	(= 0)	-> (work only on 16/32bits)
	    INT alpha		(= 255)	-> (work only on 16/32bits)
        INT tfmorder        (= 0)
        INT shear_x         (= 0)
        INT shear_y         (= 0)
	  END

	* STRUCT joy[8]
	    INT left		(= 0)
	    INT right		(= 0)
	    INT up		(= 0)
	    INT down		(= 0)
 	    INT button1		(= 0)
 	    INT button2		(= 0)
 	    INT button3		(= 0)
 	    INT button4		(= 0)
 	    INT button5		(= 0)
 	    INT button6		(= 0)
 	    INT button7		(= 0)
 	    INT button8		(= 0)
 	    INT button9		(= 0)
 	    INT button10	(= 0)
 	    INT button11	(= 0)
 	    INT button12	(= 0)
 	    INT button13	(= 0)
 	    INT button14	(= 0)
 	    INT button15	(= 0)
 	    INT button16	(= 0)
 	    INT button17	(= 0)
 	    INT button18	(= 0)
 	    INT button19	(= 0)
 	    INT button20	(= 0)
 	    INT button21	(= 0)
 	    INT button22	(= 0)
 	    INT button23	(= 0)
 	    INT button24	(= 0)
 	    INT button25	(= 0)
 	    INT button26	(= 0)
 	    INT button27	(= 0)
 	    INT button28	(= 0)
 	    INT button29	(= 0)
 	    INT button30	(= 0)
 	    INT button31	(= 0)
 	    INT button32	(= 0)
	  END


	/* *** FUNCTIONS *** */


// --- KEYBOARD MANAGEMENT ---

	* INT KEY_DISABLE_SHORTCUT(INT shortcut)
		-shortcut values:
		_pause, _alt_x, _command_q

	* INT KEY_ENABLE_SHORTCUT(INT shortcut)
		-shortcut values:
		_pause, _alt_x, _command_q+
		
	* INT KEYDOWN(INT keycode)
	  INT KEY(INT keycode) (alias of KEYDOWN) (LEGACY mode only)
		- KEYCODE values:
		  key constants


// --- SYSTEM MOUSE MANAGEMENT ---

	* INT SYSTEMMOUSE_HIDE()

	* INT SYSTEMMOUSE_IS_VISIBLE()

	* INT SYSTEMMOUSE_SHOW()


// --- JOYSTICK MANAGEMENT ---

	* INT JOY_AXIS_EXISTS(INT joy, INT axis)
		- AXIS values:
		  joy_axis_x           (0)
		  joy_axis_y           (1)
		  joy_axis_z           (2)
		  joy_axis_r           (3)
		  joy_axis_u           (4)
		  joy_axis_v           (5)

	* INT JOY_GET_BUTTON(INT button)
	  INT JOY_GET_BUTTON(INT joy, INT button) -> (overload 1)
	  INT GET_JOY_BUTTON(INT button) -> (alias of JOY_GET_BUTTON)

	* INT JOY_GET_FORCEFEEDBACK(INT joy)

	* INT JOY_GET_HAT(INT joy, INT hat)
		- HAT values:
		  joy_hat1             (0)
		  joy_hat2             (1)
		  joy_hat3             (2)
		  joy_hat4             (3)

	* STRING JOY_GET_MODEL(INT joy)

	* STRING JOY_GET_NAME(INT joy)

	* INT JOY_GET_NUMAXES(INT joy)

	* INT JOY_GET_NUMBUTTONS(INT joy)

	* INT JOY_GET_NUMHATS(INT joy)

	* INT JOY_GET_POSITION(INT axis)
	  INT JOY_GET_POSITION(INT joy, INT axis) -> (overload 1)
	  INT GET_JOY_POSITION(INT axis) -> (alias of JOY_GET_POSITION)
		- AXIS values:
		  joy_axis_x           (0)
		  joy_axis_y           (1)
		  joy_axis_z           (2)
		  joy_axis_r           (3)
		  joy_axis_u           (4)
		  joy_axis_v           (5)


// --- INPUT LIBRARY INFORMATION ---

	* INT INPUTLIB_GET_MOUSEAVAILABLE()

	* INT INPUTLIB_GET_JOYSCONNECTED()



---------------------------
--- MATH
---------------------------
	/* *** CONSTANTS *** */

	* PI			(180000)
	* M_E_F	      		(2.718281f)
	* M_E 	 	   	(2.71828182845904523536)
	* M_PI_F	      	(3.141592f)
	* M_PI	 	    	(3.14159265358979323846)
	* INFINITY              (infinity value)
	* FIX_8			(8)
	* FIX_16		(16)
	* FIX_24		(24)
	* math_degree_unit	(0)
	* math_radian_unit	(1)


	/* *** TYPEDEFS *** */

// --- BOUNDING BOX ---

	* TYPE bbox
	    FLOAT l; // left
	    FLOAT b; // bottom
 	    FLOAT r; // right
	    FLOAT t; // top
	  END

	* TYPE ibbox
	    INT l; // left
	    INT b; // bottom
 	    INT r; // right
	    INT t; // top
	  END

	* TYPE dbbox
	    DOUBLE l; // left
	    DOUBLE b; // bottom
 	    DOUBLE r; // right
	    DOUBLE t; // top
	  END

// --- MATRIX ---

	* TYPE mat2
	    FLOAT m[4];	
	  END

	* TYPE mat2x3
	    FLOAT m[6];	
	  END

	* TYPE mat2x4
	    FLOAT m[8];	
	  END

	* TYPE mat3x2
	    FLOAT m[6];	
	  END

	* TYPE mat3
	    FLOAT m[9];	
	  END

	* TYPE mat3x4
	    FLOAT m[12];
	  END

	* TYPE mat4x2
	    FLOAT m[8];	
	  END

	* TYPE mat4x3
	    FLOAT m[12];
	  END

	* TYPE mat4
	    FLOAT m[16];
	  END

	* TYPE imat2
	    INT m[4];	
	  END

	* TYPE imat2x3
	    INT m[6];	
	  END

	* TYPE imat2x4
	    INT m[8];	
	  END

	* TYPE imat3x2
	    INT m[6];	
	  END

	* TYPE imat3
	    INT m[9];	
	  END

	* TYPE imat3x4
	    INT m[12];
	  END

	* TYPE imat4x2
	    INT m[8];	
	  END

	* TYPE imat4x3
	    INT m[12];
	  END

	* TYPE imat4
	    INT m[16];
	  END

	* TYPE dmat2
	    DOUBLE m[4];	
	  END

	* TYPE dmat2x3
	    DOUBLE m[6];	
	  END

	* TYPE dmat2x4
	    DOUBLE m[8];	
	  END

	* TYPE dmat3x2
	    DOUBLE m[6];	
	  END

	* TYPE dmat3
	    DOUBLE m[9];	
	  END

	* TYPE dmat3x4
	    DOUBLE m[12];
	  END

	* TYPE dmat4x2
	    DOUBLE m[8];	
	  END

	* TYPE dmat4x3
	    DOUBLE m[12];
	  END

	* TYPE dmat4
	    DOUBLE m[16];
	  END

// --- VECTOR ---

	* TYPE vec2
	    FLOAT x;
	    FLOAT y;
	  END

	* TYPE vec3
	    FLOAT x;
	    FLOAT y;
	    FLOAT z;
	  END

	* TYPE vec4
	    FLOAT x;
	    FLOAT y;
	    FLOAT z;
	    FLOAT w;
	  END

	* TYPE ivec2
	    INT x;
	    INT y;
	  END

	* TYPE ivec3
	    INT x;
	    INT y;
	    INT z;
	  END

	* TYPE ivec4
	    INT x;
	    INT y;
	    INT z;
	    INT w;
	  END

	* TYPE dvec2
	    DOUBLE x;
	    DOUBLE y;
	  END

	* TYPE dvec3
	    DOUBLE x;
	    DOUBLE y;
	    DOUBLE z;
	  END

	* TYPE dvec4
	    DOUBLE x;
	    DOUBLE y;
	    DOUBLE z;
	    DOUBLE w;
	  END

	
	/* *** FUNCTIONS *** */

// --- COMMON FUNCTIONS ---

	* INT    ABS(INT    x)
	  IVEC2  ABS(IVEC2  x) -> (overload 1)
	  IVEC3  ABS(IVEC3  x) -> (overload 2)
	  IVEC4  ABS(IVEC4  x) -> (overload 3)
          FLOAT  ABS(FLOAT  x) -> (overload 4)
	  VEC2   ABS(VEC2   x) -> (overload 5)
	  VEC3   ABS(VEC3   x) -> (overload 6)
	  VEC4   ABS(VEC4   x) -> (overload 7)
          DOUBLE ABS(DOUBLE x) -> (overload 8)
	  DVEC2  ABS(DVEC2  x) -> (overload 9)
	  DVEC3  ABS(DVEC3  x) -> (overload 10)
	  DVEC4  ABS(DVEC4  x) -> (overload 11)

	* FLOAT  CEIL(FLOAT  x)
	  VEC2   CEIL(VEC2   x) -> (overload 1)
	  VEC3   CEIL(VEC3   x) -> (overload 2)
	  VEC4   CEIL(VEC4   x) -> (overload 3)
	  DOUBLE CEIL(DOUBLE x) -> (overload 4)
	  DVEC2  CEIL(DVEC2  x) -> (overload 5)
	  DVEC3  CEIL(DVEC3  x) -> (overload 6)
	  DVEC4  CEIL(DVEC4  x) -> (overload 7)

	* VEC2   CLAMP(VEC2   x, FLOAT  len)             -> (overload 1)
	  VEC2   CLAMP(VEC2   x, BBOX   bb)              -> (overload 2)
	  IVEC2  CLAMP(IVEC2  x, IBBOX  bb)              -> (overload 3)
	  DVEC2  CLAMP(DVEC2  x, DOUBLE len)             -> (overload 4)
	  DVEC2  CLAMP(DVEC2  x, DBBOX  bb)              -> (overload 5)
	  FLOAT  CLAMP(FLOAT  x, FLOAT  min, FLOAT  max) -> (overload 6)
	  VEC2   CLAMP(VEC2   x, VEC2   min, VEC2   max) -> (overload 7)
	  VEC3   CLAMP(VEC3   x, VEC3   min, VEC3   max) -> (overload 8)
	  VEC4   CLAMP(VEC4   x, VEC4   min, VEC4   max) -> (overload 9)
	  INT    CLAMP(INT    x, INT    min, INT    max) -> (overload 10)
	  IVEC2  CLAMP(IVEC2  x, IVEC2  min, IVEC2  max) -> (overload 11)
	  IVEC3  CLAMP(IVEC3  x, IVEC3  min, IVEC3  max) -> (overload 12)
	  IVEC4  CLAMP(IVEC4  x, IVEC4  min, IVEC4  max) -> (overload 13)
	  DOUBLE CLAMP(DOUBLE x, DOUBLE min, DOUBLE max) -> (overload 14)
	  DVEC2  CLAMP(DVEC2  x, DVEC2  min, DVEC2  max) -> (overload 15)
	  DVEC3  CLAMP(DVEC3  x, DVEC3  min, DVEC3  max) -> (overload 16)
	  DVEC4  CLAMP(DVEC4  x, DVEC4  min, DVEC4  max) -> (overload 17)

	* INT    COPYSIGN(INT    x, INT    y)
	  FLOAT  COPYSIGN(FLOAT  x, FLOAT  y) -> (overload 1)
	  DOUBLE COPYSIGN(DOUBLE x, DOUBLE y) -> (overload 2)

	* INT    DTOFIX(DOUBLE number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* DOUBLE FIXTOD(INT number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* FLOAT  FIXTOF(INT number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* INT    FIXTOI(INT number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* FLOAT  FLOOR(FLOAT  x)
	  VEC2   FLOOR(VEC2   x) -> (overload 1)
	  VEC3   FLOOR(VEC3   x) -> (overload 2)
	  VEC4   FLOOR(VEC4   x) -> (overload 3)
	  DOUBLE FLOOR(DOUBLE x) -> (overload 4)
	  DVEC2  FLOOR(DVEC2  x) -> (overload 5)
	  DVEC3  FLOOR(DVEC3  x) -> (overload 6)
	  DVEC4  FLOOR(DVEC4  x) -> (overload 7)

	* FLOAT  FMOD(FLOAT  numerator, FLOAT  denominator)
	  DOUBLE FMOD(DOUBLE numerator, DOUBLE denominator) -> (overload 1)

	* FLOAT  FRACT(FLOAT  x)
	  VEC2   FRACT(VEC2   x) -> (overload 1)
	  VEC3   FRACT(VEC3   x) -> (overload 2)
	  VEC4   FRACT(VEC4   x) -> (overload 3)
	  DOUBLE FRACT(DOUBLE x) -> (overload 4)
	  DVEC2  FRACT(DVEC2  x) -> (overload 5)
	  DVEC3  FRACT(DVEC3  x) -> (overload 6)
	  DVEC4  FRACT(DVEC4  x) -> (overload 7)

	* FLOAT  FREXP(FLOAT  x, INT *exp)
	  DOUBLE FREXP(DOUBLE x, INT *exp) -> (overload 1)

	* INT    FTOFIX(FLOAT number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* INT    ISFINITE(FLOAT  x)		
	  INT    ISFINITE(DOUBLE x) -> (overload 1)

	* INT    ISINFINITE(FLOAT  x)
	  INT    ISINFINITE(DOUBLE x) -> (overload 1)

	* INT    ISNAN(FLOAT  x)
	  INT    ISNAN(DOUBLE x) -> (overload 1)

	* INT    IMOD(INT numerator, INT denominator)

	* INT    ITOFIX(INT number, INT fixer)
		 - FIXER values:
		   fix_8                (8)
		   fix_16               (16)
		   fix_24               (24)

	* FLOAT  LDEXP(FLOAT  x, INT exp)
	  DOUBLE LDEXP(DOUBLE x, INT exp) -> (overload 1)

	* FLOAT  LERP(FLOAT  x, FLOAT  y, FLOAT  t)
	  VEC2   LERP(VEC2   x, VEC2   y, FLOAT  t) -> (overload 1)
	  VEC3   LERP(VEC3   x, VEC3   y, FLOAT  t) -> (overload 2)
	  VEC4   LERP(VEC4   x, VEC4   y, FLOAT  t) -> (overload 3)
	  DOUBLE LERP(DOUBLE x, DOUBLE y, DOUBLE t) -> (overload 4)
	  DVEC2  LERP(DVEC2  x, DVEC2  y, DOUBLE t) -> (overload 5)
	  DVEC3  LERP(DVEC3  x, DVEC3  y, DOUBLE t) -> (overload 6)
	  DVEC4  LERP(DVEC4  x, DVEC4  y, DOUBLE t) -> (overload 7)

	* FLOAT  LERPCONST(FLOAT  x, FLOAT  y, FLOAT  t)
	  VEC2   LERPCONST(VEC2   x, VEC2   y, FLOAT  t) -> (overload 1)
	  DOUBLE LERPCONST(DOUBLE x, DOUBLE y, DOUBLE t) -> (overload 2)
	  DVEC2  LERPCONST(DVEC2  x, DVEC2  y, DOUBLE t) -> (overload 3)

	* INT    MAX(INT    x, INT    y)
	  IVEC2  MAX(IVEC2  x, INT    y)           -> (overload 1)
	  IVEC3  MAX(IVEC3  x, INT    y)           -> (overload 2)
	  IVEC4  MAX(IVEC4  x, INT    y)           -> (overload 3)
	  IVEC2  MAX(IVEC2  x, IVEC2  y)           -> (overload 4)
	  IVEC3  MAX(IVEC3  x, IVEC3  y)           -> (overload 5)
	  IVEC4  MAX(IVEC4  x, IVEC4  y)           -> (overload 6)
	  FLOAT  MAX(FLOAT  x, FLOAT  y)           -> (overload 7)
	  VEC2   MAX(VEC2   x, FLOAT  y)           -> (overload 8)
	  VEC3   MAX(VEC3   x, FLOAT  y)           -> (overload 9)
	  VEC4   MAX(VEC4   x, FLOAT  y)           -> (overload 10)
	  VEC2   MAX(VEC2   x, VEC2   y)           -> (overload 11)
	  VEC3   MAX(VEC3   x, VEC3   y)           -> (overload 12)
	  VEC4   MAX(VEC4   x, VEC4   y)           -> (overload 13)
	  DOUBLE MAX(DOUBLE x, DOUBLE y)           -> (overload 14)
	  DVEC2  MAX(DVEC2  x, DOUBLE y)           -> (overload 15)
	  DVEC3  MAX(DVEC3  x, DOUBLE y)           -> (overload 16)
	  DVEC4  MAX(DVEC4  x, DOUBLE y)           -> (overload 17)
	  DVEC2  MAX(DVEC2  x, DVEC2  y)           -> (overload 18)
	  DVEC3  MAX(DVEC3  x, DVEC3  y)           -> (overload 19)
	  DVEC4  MAX(DVEC4  x, DVEC4  y)           -> (overload 20)
	  INT    MAX(INT    x, INT    y, INT    z) -> (overload 21)
	  IVEC2  MAX(IVEC2  x, IVEC2  y, IVEC2  z) -> (overload 22)
	  IVEC3  MAX(IVEC3  x, IVEC3  y, IVEC3  z) -> (overload 23)
	  IVEC4  MAX(IVEC4  x, IVEC4  y, IVEC4  z) -> (overload 24)
	  FLOAT  MAX(FLOAT  x, FLOAT  y, FLOAT  z) -> (overload 25)
	  VEC2   MAX(VEC2   x, VEC2   y, VEC2   z) -> (overload 26)
	  VEC3   MAX(VEC3   x, VEC3   y, VEC3   z) -> (overload 27)
	  VEC4   MAX(VEC4   x, VEC4   y, VEC4   z) -> (overload 28)
	  DOUBLE MAX(DOUBLE x, DOUBLE y, DOUBLE z) -> (overload 29)
	  DVEC2  MAX(DVEC2  x, DVEC2  y, DVEC2  z) -> (overload 30)
	  DVEC3  MAX(DVEC3  x, DVEC3  y, DVEC3  z) -> (overload 31)
	  DVEC4  MAX(DVEC4  x, dVEC4  y, DVEC4  z) -> (overload 32)

	* INT    MID(INT    x, INT    y, INT    z)
	  IVEC2  MID(IVEC2  x, IVEC2  y, IVEC2  z) -> (overload 1)
	  IVEC3  MID(IVEC3  x, IVEC3  y, IVEC3  z) -> (overload 2)
	  IVEC4  MID(IVEC4  x, IVEC4  y, IVEC4  z) -> (overload 3)
	  FLOAT  MID(FLOAT  x, FLOAT  y, FLOAT  z) -> (overload 4)
	  VEC2   MID(VEC2   x, VEC2   y, VEC2   z) -> (overload 5)
	  VEC3   MID(VEC3   x, VEC3   y, VEC3   z) -> (overload 6)
	  VEC4   MID(VEC4   x, VEC4   y, VEC4   z) -> (overload 7)
	  DOUBLE MID(DOUBLE x, DOUBLE y, DOUBLE z) -> (overload 8)
	  DVEC2  MID(DVEC2  x, DVEC2  y, DVEC2  z) -> (overload 9)
	  DVEC3  MID(DVEC3  x, DVEC3  y, DVEC3  z) -> (overload 10)
	  DVEC4  MID(DVEC4  x, DVEC4  y, DVEC4  z) -> (overload 11)

	* INT    MIN(INT    x, INT    y)
	  IVEC2  MIN(IVEC2  x, INT    y)           -> (overload 1)
	  IVEC3  MIN(IVEC3  x, INT    y)           -> (overload 2)
	  IVEC4  MIN(IVEC4  x, INT    y)           -> (overload 3)
	  IVEC2  MIN(IVEC2  x, IVEC2  y)           -> (overload 4)
	  IVEC3  MIN(IVEC3  x, IVEC3  y)           -> (overload 5)
	  IVEC4  MIN(IVEC4  x, IVEC4  y)           -> (overload 6)
	  FLOAT  MIN(FLOAT  x, FLOAT  y)           -> (overload 7)
	  VEC2   MIN(VEC2   x, FLOAT  y)           -> (overload 8)
	  VEC3   MIN(VEC3   x, FLOAT  y)           -> (overload 9)
	  VEC4   MIN(VEC4   x, FLOAT  y)           -> (overload 10)
	  VEC2   MIN(VEC2   x, VEC2   y)           -> (overload 11)
	  VEC3   MIN(VEC3   x, VEC3   y)           -> (overload 12)
	  VEC4   MIN(VEC4   x, VEC4   y)           -> (overload 13)
	  DOUBLE MIN(DOUBLE x, DOUBLE y)           -> (overload 14)
	  DVEC2  MIN(DVEC2  x, DOUBLE y)           -> (overload 15)
	  DVEC3  MIN(DVEC3  x, DOUBLE y)           -> (overload 16)
	  DVEC4  MIN(DVEC4  x, DOUBLE y)           -> (overload 17)
	  DVEC2  MIN(DVEC2  x, DVEC2  y)           -> (overload 18)
	  DVEC3  MIN(DVEC3  x, DVEC3  y)           -> (overload 19)
	  DVEC4  MIN(DVEC4  x, DVEC4  y)           -> (overload 20)
	  INT    MIN(INT    x, INT    y, INT    z) -> (overload 21)
	  IVEC2  MIN(IVEC2  x, IVEC2  y, IVEC2  z) -> (overload 22)
	  IVEC3  MIN(IVEC3  x, IVEC3  y, IVEC3  z) -> (overload 23)
	  IVEC4  MIN(IVEC4  x, IVEC4  y, IVEC4  z) -> (overload 24)
	  FLOAT  MIN(FLOAT  x, FLOAT  y, FLOAT  z) -> (overload 25)
	  VEC2   MIN(VEC2   x, VEC2   y, VEC2   z) -> (overload 26)
	  VEC3   MIN(VEC3   x, VEC3   y, VEC3   z) -> (overload 27)
	  VEC4   MIN(VEC4   x, VEC4   y, VEC4   z) -> (overload 28)
	  DOUBLE MIN(DOUBLE x, DOUBLE y, DOUBLE z) -> (overload 29)
	  DVEC2  MIN(DVEC2  x, DVEC2  y, DVEC2  z) -> (overload 30)
	  DVEC3  MIN(DVEC3  x, DVEC3  y, DVEC3  z) -> (overload 31)
	  DVEC4  MIN(DVEC4  x, dVEC4  y, DVEC4  z) -> (overload 32)

	* FLOAT  MODF(FLOAT  x, FLOAT  *intpart)
	  DOUBLE MODF(DOUBLE x, DOUBLE *intpart) -> (overload 1)

	* INT    NEAR_VALUE(INT    start_value, INT    final_value, INT    increment)
	  FLOAT  NEAR_VALUE(FLOAT  start_value, FLOAT  final_value, FLOAT  increment) -> (overload 1)
	  DOUBLE NEAR_VALUE(DOUBLE start_value, DOUBLE final_value, DOUBLE increment) -> (overload 2)

	* FLOAT  NORMALSTEP(FLOAT  x, FLOAT  y)
	  VEC2   NORMALSTEP(FLOAT  x, VEC2   y) -> (overload 1)
	  VEC3   NORMALSTEP(FLOAT  x, VEC3   y) -> (overload 2)
	  VEC4   NORMALSTEP(FLOAT  x, VEC4   y) -> (overload 3)
	  VEC2   NORMALSTEP(VEC2   x, VEC2   y) -> (overload 4)
	  VEC3   NORMALSTEP(VEC3   x, VEC3   y) -> (overload 5)
	  VEC4   NORMALSTEP(VEC4   x, VEC4   y) -> (overload 6)
	* DOUBLE NORMALSTEP(DOUBLE x, DOUBLE y) -> (overload 7)
	  DVEC2  NORMALSTEP(DOUBLE x, DVEC2  y) -> (overload 8)
	  DVEC3  NORMALSTEP(DOUBLE x, DVEC3  y) -> (overload 9)
	  DVEC4  NORMALSTEP(DOUBLE x, DVEC4  y) -> (overload 10)
	  DVEC2  NORMALSTEP(DVEC2  x, DVEC2  y) -> (overload 11)
	  DVEC3  NORMALSTEP(DVEC3  x, DVEC3  y) -> (overload 12)
	  DVEC4  NORMALSTEP(DVEC4  x, DVEC4  y) -> (overload 13)

	* INT    RAND(INT    min_value, INT    max_value)
	  FLOAT  RAND(FLOAT  min_value, FLOAT  max_value) -> (overload 1)
	  DOUBLE RAND(DOUBLE min_value, DOUBLE max_value) -> (overload 2)

	* INT    RAND_SEED(INT seed_value)

	* FLOAT  ROUND(FLOAT  x)
	  VEC2   ROUND(VEC2   x) -> (overload 1)
	  VEC3   ROUND(VEC3   x) -> (overload 2)
	  VEC4   ROUND(VEC4   x) -> (overload 3)
	  DOUBLE ROUND(DOUBLE x) -> (overload 4)
	  DVEC2  ROUND(DVEC2  x) -> (overload 5)
	  DVEC3  ROUND(DVEC3  x) -> (overload 6)
	  DVEC4  ROUND(DVEC4  x) -> (overload 7)

	* FLOAT  ROUNDEVEN(FLOAT  x)
	  VEC2   ROUNDEVEN(VEC2   x) -> (overload 1)
	  VEC3   ROUNDEVEN(VEC3   x) -> (overload 2)
	  VEC4   ROUNDEVEN(VEC4   x) -> (overload 3)
	  DOUBLE ROUNDEVEN(DOUBLE x) -> (overload 4)
	  DVEC2  ROUNDEVEN(DVEC2  x) -> (overload 5)
	  DVEC3  ROUNDEVEN(DVEC3  x) -> (overload 6)
	  DVEC4  ROUNDEVEN(DVEC4  x) -> (overload 7)

	* VEC2   SLERP(VEC2  x, VEC2  y, FLOAT  t)
	  DVEC2  SLERP(DVEC2 x, DVEC2 y, DOUBLE t) -> (overload 1)

	* VEC2   SLERPCONST(VEC2  x, VEC2  y, FLOAT  a)
	  DVEC2  SLERPCONST(DVEC2 x, DVEC2 y, DOUBLE a) -> (overload 1)

	* FLOAT  SMOOTHSTEP(FLOAT  x, FLOAT  y, FLOAT  z)
	  VEC2   SMOOTHSTEP(FLOAT  x, FLOAT  y, VEC2   z) -> (overload 1)
	  VEC3   SMOOTHSTEP(FLOAT  x, FLOAT  y, VEC3   z) -> (overload 2)
	  VEC4   SMOOTHSTEP(FLOAT  x, FLOAT  y, VEC4   z) -> (overload 3)
	  VEC2   SMOOTHSTEP(VEC2   x, VEC2   y, VEC2   z) -> (overload 4)
	  VEC3   SMOOTHSTEP(VEC3   x, VEC3   y, VEC3   z) -> (overload 5)
	  VEC4   SMOOTHSTEP(VEC4   x, VEC4   y, VEC4   z) -> (overload 6)
	* DOUBLE SMOOTHSTEP(DOUBLE x, DOUBLE y, DOUBLE z) -> (overload 7)
	  DVEC2  SMOOTHSTEP(DOUBLE x, DOUBLE y, DVEC2  z) -> (overload 8)
	  DVEC3  SMOOTHSTEP(DOUBLE x, DOUBLE y, DVEC3  z) -> (overload 9)
	  DVEC4  SMOOTHSTEP(DOUBLE x, DOUBLE y, DVEC4  z) -> (overload 10)
	  DVEC2  SMOOTHSTEP(DVEC2  x, DVEC2  y, DVEC2  z) -> (overload 11)
	  DVEC3  SMOOTHSTEP(DVEC3  x, DVEC3  y, DVEC3  z) -> (overload 12)
	  DVEC4  SMOOTHSTEP(DVEC4  x, DVEC4  y, DVEC4  z) -> (overload 13)

	* FLOAT  TRUNC(FLOAT  x)
	  VEC2   TRUNC(VEC2   x) -> (overload 1)
	  VEC3   TRUNC(VEC3   x) -> (overload 2)
	  VEC4   TRUNC(VEC4   x) -> (overload 3)
	  DOUBLE TRUNC(DOUBLE x) -> (overload 4)
	  DVEC2  TRUNC(DVEC2  x) -> (overload 5)
	  DVEC3  TRUNC(DVEC3  x) -> (overload 6)
	  DVEC4  TRUNC(DVEC4  x) -> (overload 7)


// --- EXPONENTIAL FUNCTIONS ---

	* FLOAT  EXP(FLOAT  x)     
	  VEC2   EXP(VEC2   x) -> (overload 1)   
	  VEC3   EXP(VEC3   x) -> (overload 2)   
	  VEC4   EXP(VEC4   x) -> (overload 3)   
	  DOUBLE EXP(DOUBLE x) -> (overload 4)   
	  DVEC2  EXP(DVEC2  x) -> (overload 5)   
	  DVEC3  EXP(DVEC3  x) -> (overload 6)   
	  DVEC4  EXP(DVEC4  x) -> (overload 7)   

	* FLOAT  EXP2(FLOAT  x)     
	  VEC2   EXP2(VEC2   x) -> (overload 1)   
	  VEC3   EXP2(VEC3   x) -> (overload 2)   
	  VEC4   EXP2(VEC4   x) -> (overload 3)   
	  DOUBLE EXP2(DOUBLE x) -> (overload 4)   
	  DVEC2  EXP2(DVEC2  x) -> (overload 5)   
	  DVEC3  EXP2(DVEC3  x) -> (overload 6)   
	  DVEC4  EXP2(DVEC4  x) -> (overload 7)   

	* FLOAT  INVERSESQRT(FLOAT  x)
	  VEC2   INVERSESQRT(VEC2   x) -> (overload 1)
	  VEC3   INVERSESQRT(VEC3   x) -> (overload 2)
	  VEC4   INVERSESQRT(VEC4   x) -> (overload 3)
	  DOUBLE INVERSESQRT(DOUBLE x) -> (overload 4)
	  DVEC2  INVERSESQRT(DVEC2  x) -> (overload 5)
	  DVEC3  INVERSESQRT(DVEC3  x) -> (overload 6)
	  DVEC4  INVERSESQRT(DVEC4  x) -> (overload 7)

	* FLOAT  LOG(FLOAT  x)
	  VEC2   LOG(VEC2   x)           -> (overload 1)
	  VEC3   LOG(VEC3   x)           -> (overload 2)
	  VEC4   LOG(VEC4   x)           -> (overload 3)
	  DOUBLE LOG(DOUBLE x)           -> (overload 4)
	  DVEC2  LOG(DVEC2  x)           -> (overload 5)
	  DVEC3  LOG(DVEC3  x)           -> (overload 6)
	  DVEC4  LOG(DVEC4  x)           -> (overload 7)
	  FLOAT  LOG(FLOAT  x, FLOAT  b) -> (overload 8)
	  VEC2   LOG(VEC2   x, FLOAT  b) -> (overload 9)
	  VEC3   LOG(VEC3   x, FLOAT  b) -> (overload 10)
	  VEC4   LOG(VEC4   x, FLOAT  b) -> (overload 11)
	  VEC2   LOG(VEC2   x, VEC2   b) -> (overload 12)
	  VEC3   LOG(VEC3   x, VEC3   b) -> (overload 13)
	  VEC4   LOG(VEC4   x, VEC4   b) -> (overload 14)
	  DOUBLE LOG(DOUBLE x, DOUBLE b) -> (overload 15)
	  DVEC2  LOG(DVEC2  x, DOUBLE b) -> (overload 16)
	  DVEC3  LOG(DVEC3  x, DOUBLE b) -> (overload 17)
	  DVEC4  LOG(DVEC4  x, DOUBLE b) -> (overload 18)
	  DVEC2  LOG(DVEC2  x, DVEC2  b) -> (overload 19)
	  DVEC3  LOG(DVEC3  x, DVEC3  b) -> (overload 20)
	  DVEC4  LOG(DVEC4  x, DVEC4  b) -> (overload 21)

	* FLOAT  LOG2(FLOAT  x)
	  VEC2   LOG2(VEC2   x) -> (overload 1)
	  VEC3   LOG2(VEC3   x) -> (overload 2)
	  VEC4   LOG2(VEC4   x) -> (overload 3)
	  DOUBLE LOG2(DOUBLE x) -> (overload 4)
	  DVEC2  LOG2(DVEC2  x) -> (overload 5)
	  DVEC3  LOG2(DVEC3  x) -> (overload 6)
	  DVEC4  LOG2(DVEC4  x) -> (overload 7)

	* FLOAT  LOG10(FLOAT  x)
	  VEC2   LOG10(VEC2   x) -> (overload 1)
	  VEC3   LOG10(VEC3   x) -> (overload 2)
	  VEC4   LOG10(VEC4   x) -> (overload 3)
	  DOUBLE LOG10(DOUBLE x) -> (overload 4)
	  DVEC2  LOG10(DVEC2  x) -> (overload 5)
	  DVEC3  LOG10(DVEC3  x) -> (overload 6)
	  DVEC4  LOG10(DVEC4  x) -> (overload 7)

	* INT    POW(INT    x, INT    power)
          FLOAT  POW(FLOAT  x, FLOAT  power) -> (overload 1)
	  VEC2   POW(VEC2   x, FLOAT  power) -> (overload 2)   
	  VEC3   POW(VEC3   x, FLOAT  power) -> (overload 3)   
	  VEC4   POW(VEC4   x, FLOAT  power) -> (overload 4)   
	  VEC2   POW(VEC2   x, VEC2   power) -> (overload 5)   
	  VEC3   POW(VEC3   x, VEC3   power) -> (overload 6)   
	  VEC4   POW(VEC4   x, VEC4   power) -> (overload 7)   
          DOUBLE POW(DOUBLE x, INT    power) -> (overload 8)
          DOUBLE POW(DOUBLE x, DOUBLE power) -> (overload 9)
	  DVEC2  POW(DVEC2  x, DOUBLE power) -> (overload 10)   
	  DVEC3  POW(DVEC3  x, DOUBLE power) -> (overload 11)   
	  DVEC4  POW(DVEC4  x, DOUBLE power) -> (overload 12)   
	  DVEC2  POW(DVEC2  x, DVEC2  power) -> (overload 13)   
	  DVEC3  POW(DVEC3  x, DVEC3  power) -> (overload 14)   
	  DVEC4  POW(DVEC4  x, DVEC4  power) -> (overload 15)   

	* INT    SQRT(INT    x)
	  FLOAT  SQRT(FLOAT  x) -> (overload 1)
	  VEC2   SQRT(VEC2   x) -> (overload 2)
	  VEC3   SQRT(VEC3   x) -> (overload 3)
	  VEC4   SQRT(VEC4   x) -> (overload 4)
	  DOUBLE SQRT(DOUBLE x) -> (overload 5)
	  DVEC2  SQRT(DVEC2  x) -> (overload 6)
	  DVEC3  SQRT(DVEC3  x) -> (overload 7)
	  DVEC4  SQRT(DVEC4  x) -> (overload 8)


// --- GEOMETRIC FUNCTIONS ---

	* FLOAT  CROSS(VEC2   x, VEC2   y)
	  VEC2   CROSS(VEC2   x, FLOAT  y) -> (overload 1)
	  VEC2   CROSS(FLOAT  x, VEC2   y) -> (overload 2)
	  VEC3   CROSS(VEC3   x, VEC3   y) -> (overload 3)
	  INT    CROSS(IVEC2  x, IVEC2  y) -> (overload 4)
	  IVEC2  CROSS(IVEC2  x, INT    y) -> (overload 5)
	  IVEC2  CROSS(INT    x, IVEC2  y) -> (overload 6)
	  IVEC3  CROSS(IVEC3  x, IVEC3  y) -> (overload 7)
	  DOUBLE CROSS(DVEC2  x, DVEC2  y) -> (overload 8)
	  DVEC2  CROSS(DVEC2  x, DOUBLE y) -> (overload 9)
	  DVEC2  CROSS(DOUBLE x, DVEC2  y) -> (overload 10)
	  DVEC3  CROSS(DVEC3  x, DVEC3  y) -> (overload 11)

	* FLOAT  DISTANCE(FLOAT  x, FLOAT  y)
	  FLOAT  DISTANCE(VEC2   x, VEC2   y) -> (overload 1)
	  FLOAT  DISTANCE(VEC3   x, VEC3   y) -> (overload 2)
	  FLOAT  DISTANCE(VEC4   x, VEC4   y) -> (overload 3)
	  DOUBLE DISTANCE(DOUBLE x, DOUBLE y) -> (overload 4)
	  DOUBLE DISTANCE(DVEC2  x, DVEC2  y) -> (overload 5)
	  DOUBLE DISTANCE(DVEC3  x, DVEC3  y) -> (overload 6)
	  DOUBLE DISTANCE(DVEC4  x, DVEC4  y) -> (overload 7)

	* FLOAT  DISTANCESQ(FLOAT  x, FLOAT  y)
	  FLOAT  DISTANCESQ(VEC2   x, VEC2   y) -> (overload 1)
	  FLOAT  DISTANCESQ(VEC3   x, VEC3   y) -> (overload 2)
	  FLOAT  DISTANCESQ(VEC4   x, VEC4   y) -> (overload 3)
	  DOUBLE DISTANCESQ(DOUBLE x, DOUBLE y) -> (overload 4)
	  DOUBLE DISTANCESQ(DVEC2  x, DVEC2  y) -> (overload 5)
	  DOUBLE DISTANCESQ(DVEC3  x, DVEC3  y) -> (overload 6)
	  DOUBLE DISTANCESQ(DVEC4  x, DVEC4  y) -> (overload 7)

	* FLOAT  DOT(FLOAT  x, FLOAT  y)
	  FLOAT  DOT(VEC2   x, VEC2   y) -> (overload 1)
	  FLOAT  DOT(VEC3   x, VEC3   y) -> (overload 2)
	  FLOAT  DOT(VEC4   x, VEC4   y) -> (overload 3)
	  INT    DOT(INT    x, INT    y) -> (overload 4)
	  INT    DOT(IVEC2  x, IVEC2  y) -> (overload 5)
	  INT    DOT(IVEC3  x, IVEC3  y) -> (overload 6)
	  INT    DOT(IVEC4  x, IVEC4  y) -> (overload 7)
	  DOUBLE DOT(DOUBLE x, DOUBLE y) -> (overload 8)
	  DOUBLE DOT(DVEC2  x, DVEC2  y) -> (overload 9)
	  DOUBLE DOT(DVEC3  x, DVEC3  y) -> (overload 10)
	  DOUBLE DOT(DVEC4  x, DVEC4  y) -> (overload 11)

	* FLOAT  FACEFORWARD(FLOAT  n, FLOAT  i, FLOAT  nref)
	  VEC2   FACEFORWARD(VEC2   n, VEC2   i, VEC2   nref) -> (overload 1)
	  VEC3   FACEFORWARD(VEC3   n, VEC3   i, VEC3   nref) -> (overload 2)
	  VEC4   FACEFORWARD(VEC4   n, VEC4   i, VEC4   nref) -> (overload 3)
	  INT    FACEFORWARD(INT    n, INT    i, INT    nref) -> (overload 4)
	  IVEC2  FACEFORWARD(IVEC2  n, IVEC2  i, IVEC2  nref) -> (overload 5)
	  IVEC3  FACEFORWARD(IVEC3  n, IVEC3  i, IVEC3  nref) -> (overload 6)
	  IVEC4  FACEFORWARD(IVEC4  n, IVEC4  i, IVEC4  nref) -> (overload 7)
	  DOUBLE FACEFORWARD(DOUBLE n, DOUBLE i, DOUBLE nref) -> (overload 8)
	  DVEC2  FACEFORWARD(DVEC2  n, DVEC2  i, VEC2   nref) -> (overload 9)
	  DVEC3  FACEFORWARD(DVEC3  n, DVEC3  i, VEC3   nref) -> (overload 10)
	  DVEC4  FACEFORWARD(DVEC4  n, DVEC4  i, VEC4   nref) -> (overload 11)

	* INT    FGET_ANGLE(INT x0, INT y0, INT x1, INT y1)

	* INT    FGET_DIST(INT x0, INT y0, INT x1, INT y1)

	* INT    GET_DISTX(INT angle, INT distance)

	* INT    GET_DISTY(INT angle, INT distance)

	* FLOAT  LENGTH(FLOAT  x)
	  FLOAT  LENGTH(VEC2   x) -> (overload 1)
	  FLOAT  LENGTH(VEC3   x) -> (overload 2)
	  FLOAT  LENGTH(VEC4   x) -> (overload 3)
	  DOUBLE LENGTH(DOUBLE x) -> (overload 4)
	  DOUBLE LENGTH(DVEC2  x) -> (overload 5)
	  DOUBLE LENGTH(DVEC3  x) -> (overload 6)
	  DOUBLE LENGTH(DVEC4  x) -> (overload 7)

	* FLOAT  LENGTHSQ(FLOAT  x)
	  FLOAT  LENGTHSQ(VEC2   x) -> (overload 1)
	  FLOAT  LENGTHSQ(VEC3   x) -> (overload 2)
	  FLOAT  LENGTHSQ(VEC4   x) -> (overload 3)
	  DOUBLE LENGTHSQ(DOUBLE x) -> (overload 4)
	  DOUBLE LENGTHSQ(DVEC2  x) -> (overload 5)
	  DOUBLE LENGTHSQ(DVEC3  x) -> (overload 6)
	  DOUBLE LENGTHSQ(DVEC4  x) -> (overload 7)

	* FLOAT  NORMALIZE(FLOAT  x)
	  VEC2   NORMALIZE(VEC2   x) -> (overload 1)
	  VEC3   NORMALIZE(VEC3   x) -> (overload 2)
	  VEC4   NORMALIZE(VEC4   x) -> (overload 3)
	  DOUBLE NORMALIZE(DOUBLE x) -> (overload 4)
	  DVEC2  NORMALIZE(DVEC2  x) -> (overload 5)
	  DVEC3  NORMALIZE(DVEC3  x) -> (overload 6)
	  DVEC4  NORMALIZE(DVEC4  x) -> (overload 7)

	* INT    NEAR_ANGLE(INT start_angle, INT final_angle, INT increment)

	* FLOAT  REFLECT(FLOAT  incident, FLOAT  normal)
	  VEC2   REFLECT(VEC2   incident, VEC2   normal) -> (overload 1)
	  VEC3   REFLECT(VEC3   incident, VEC3   normal) -> (overload 2)
	  VEC4   REFLECT(VEC4   incident, VEC4   normal) -> (overload 3)
	  DOUBLE REFLECT(DOUBLE incident, DOUBLE normal) -> (overload 4)
	  DVEC2  REFLECT(DVEC2  incident, DVEC2  normal) -> (overload 5)
	  DVEC3  REFLECT(DVEC3  incident, DVEC3  normal) -> (overload 6)
	  DVEC4  REFLECT(DVEC4  incident, DVEC4  normal) -> (overload 7)

	* FLOAT  REFRACT(FLOAT  incident, FLOAT  normal, FLOAT  eta)
	  VEC2   REFRACT(VEC2   incident, VEC2   normal, FLOAT  eta) -> (overload 1)
	  VEC3   REFRACT(VEC3   incident, VEC3   normal, FLOAT  eta) -> (overload 2)
	  VEC4   REFRACT(VEC4   incident, VEC4   normal, FLOAT  eta) -> (overload 3)
	  DOUBLE REFRACT(DOUBLE incident, DOUBLE normal, DOUBLE eta) -> (overload 4)
	  DVEC2  REFRACT(DVEC2  incident, DVEC2  normal, DOUBLE eta) -> (overload 5)
	  DVEC3  REFRACT(DVEC3  incident, DVEC3  normal, DOUBLE eta) -> (overload 6)
	  DVEC4  REFRACT(DVEC4  incident, DVEC4  normal, DOUBLE eta) -> (overload 7)


// --- ANGLE AND TRIGONOMETRY FUNCTIONS ---

	* INT    ACOS(INT    x)
	  IVEC2  ACOS(IVEC2  x) -> (overload 1)
	  IVEC3  ACOS(IVEC3  x) -> (overload 2)
	  IVEC4  ACOS(IVEC4  x) -> (overload 3)
          FLOAT  ACOS(FLOAT  x) -> (overload 4)
	  VEC2   ACOS(VEC2   x) -> (overload 5)
	  VEC3   ACOS(VEC3   x) -> (overload 6)
	  VEC4   ACOS(VEC4   x) -> (overload 7)
          DOUBLE ACOS(DOUBLE x) -> (overload 8)
	  DVEC2  ACOS(DVEC2  x) -> (overload 9)
	  DVEC3  ACOS(DVEC3  x) -> (overload 10)
	  DVEC4  ACOS(DVEC4  x) -> (overload 11)
		- X values (for INT/IVEC version):
		  -1000 to 1000

	* INT    ASIN(INT    x)
	  IVEC2  ASIN(IVEC2  x) -> (overload 1)
	  IVEC3  ASIN(IVEC3  x) -> (overload 2)
	  IVEC4  ASIN(IVEC4  x) -> (overload 3)
          FLOAT  ASIN(FLOAT  x) -> (overload 4)
	  VEC2   ASIN(VEC2   x) -> (overload 5)
	  VEC3   ASIN(VEC3   x) -> (overload 6)
	  VEC4   ASIN(VEC4   x) -> (overload 7)
          DOUBLE ASIN(DOUBLE x) -> (overload 8)
	  DVEC2  ASIN(DVEC2  x) -> (overload 9)
	  DVEC3  ASIN(DVEC3  x) -> (overload 10)
	  DVEC4  ASIN(DVEC4  x) -> (overload 11)
		- X values (for INT/IVEC version):
		  -1000 to 1000

	* INT    ATAN(INT    x)
	  IVEC2  ATAN(IVEC2  x) -> (overload 1)
	  IVEC3  ATAN(IVEC3  x) -> (overload 2)
	  IVEC4  ATAN(IVEC4  x) -> (overload 3)
          FLOAT  ATAN(FLOAT  x) -> (overload 4)
	  VEC2   ATAN(VEC2   x) -> (overload 5)
	  VEC3   ATAN(VEC3   x) -> (overload 6)
	  VEC4   ATAN(VEC4   x) -> (overload 7)
          DOUBLE ATAN(DOUBLE x) -> (overload 8)
	  DVEC2  ATAN(DVEC2  x) -> (overload 9)
	  DVEC3  ATAN(DVEC3  x) -> (overload 10)
	  DVEC4  ATAN(DVEC4  x) -> (overload 11)
		- X values (for INT/IVEC version):
		  -90000 to 90000

	* INT    ATAN2(INT    y, INT    x)
	  IVEC2  ATAN2(IVEC2  y, IVEC2  x) -> (overload 1)
	  IVEC3  ATAN2(IVEC3  y, IVEC3  x) -> (overload 2)
	  IVEC4  ATAN2(IVEC4  y, IVEC4  x) -> (overload 3)
          FLOAT  ATAN2(FLOAT  y, FLOAT  x) -> (overload 4)
	  VEC2   ATAN2(VEC2   y, VEC2   x) -> (overload 5)
	  VEC3   ATAN2(VEC3   y, VEC3   x) -> (overload 6)
	  VEC4   ATAN2(VEC4   y, VEC4   x) -> (overload 7)
          DOUBLE ATAN2(DOUBLE y, DOUBLE x) -> (overload 8)
	  DVEC2  ATAN2(DVEC2  y, DVEC2  x) -> (overload 9)
	  DVEC3  ATAN2(DVEC3  y, DVEC3  x) -> (overload 10)
	  DVEC4  ATAN2(DVEC4  y, DVEC4  x) -> (overload 11)

	* INT    COS(INT    x)
	  IVEC2  COS(IVEC2  x) -> (overload 1)
	  IVEC3  COS(IVEC3  x) -> (overload 2)
	  IVEC4  COS(IVEC4  x) -> (overload 3)
          FLOAT  COS(FLOAT  x) -> (overload 4)
	  VEC2   COS(VEC2   x) -> (overload 5)
	  VEC3   COS(VEC3   x) -> (overload 6)
	  VEC4   COS(VEC4   x) -> (overload 7)
          DOUBLE COS(DOUBLE x) -> (overload 8)
	  DVEC2  COS(DVEC2  x) -> (overload 9)
	  DVEC3  COS(DVEC3  x) -> (overload 10)
	  DVEC4  COS(DVEC4  x) -> (overload 11)

        * FLOAT  COSH(FLOAT  x)
	  VEC2   COSH(VEC2   x) -> (overload 1)
	  VEC3   COSH(VEC3   x) -> (overload 2)
	  VEC4   COSH(VEC4   x) -> (overload 3)
          DOUBLE COSH(DOUBLE x) -> (overload 4)
	  DVEC2  COSH(DVEC2  x) -> (overload 5)
	  DVEC3  COSH(DVEC3  x) -> (overload 6)
	  DVEC4  COSH(DVEC4  x) -> (overload 7)
	
	* INT    DEGTOMIL(INT    degree)
	  IVEC2  DEGTOMIL(IVEC2  degree) -> (overload 1)
	  IVEC3  DEGTOMIL(IVEC3  degree) -> (overload 2)
	  IVEC4  DEGTOMIL(IVEC4  degree) -> (overload 3)
	  FLOAT  DEGTOMIL(FLOAT  degree) -> (overload 4)
	  VEC2   DEGTOMIL(VEC2   degree) -> (overload 5)
	  VEC3   DEGTOMIL(VEC3   degree) -> (overload 6)
	  VEC4   DEGTOMIL(VEC4   degree) -> (overload 7)
	  DOUBLE DEGTOMIL(DOUBLE degree) -> (overload 8)
	  DVEC2  DEGTOMIL(DVEC2  degree) -> (overload 9)
	  DVEC3  DEGTOMIL(DVEC3  degree) -> (overload 10)
	  DVEC4  DEGTOMIL(DVEC4  degree) -> (overload 11)

	* FLOAT  DEGTORAD(FLOAT  degree)
	  VEC2   DEGTORAD(VEC2   degree) -> (overload 1)
	  VEC3   DEGTORAD(VEC3   degree) -> (overload 2)
	  VEC4   DEGTORAD(VEC4   degree) -> (overload 3)
	  DOUBLE DEGTORAD(DOUBLE degree) -> (overload 4)
	  DVEC2  DEGTORAD(DVEC2  degree) -> (overload 5)
	  DVEC3  DEGTORAD(DVEC3  degree) -> (overload 6)
	  DVEC4  DEGTORAD(DVEC4  degree) -> (overload 7)

	* FLOAT  HYPOT(FLOAT  x, FLOAT  y)
	  VEC2   HYPOT(VEC2   x, FLOAT  y) -> (overload 1)
	  VEC3   HYPOT(VEC3   x, FLOAT  y) -> (overload 2)
	  VEC4   HYPOT(VEC4   x, FLOAT  y) -> (overload 3)
	  VEC2   HYPOT(VEC2   x, VEC2   y) -> (overload 4)
	  VEC3   HYPOT(VEC3   x, VEC2   y) -> (overload 5)
	  VEC4   HYPOT(VEC4   x, VEC2   y) -> (overload 6)
	  DOUBLE HYPOT(DOUBLE x, DOUBLE y) -> (overload 7)
	  DVEC2  HYPOT(DVEC2  x, DOUBLE y) -> (overload 8)
	  DVEC3  HYPOT(DVEC3  x, DOUBLE y) -> (overload 9)
	  DVEC4  HYPOT(DVEC4  x, DOUBLE y) -> (overload 10)
	  DVEC2  HYPOT(DVEC2  x, DVEC2  y) -> (overload 11)
	  DVEC3  HYPOT(DVEC3  x, DVEC2  y) -> (overload 12)
	  DVEC4  HYPOT(DVEC4  x, DVEC2  y) -> (overload 13)

	* INT    MILTODEG(INT    mil)
	  IVEC2  MILTODEG(IVEC2  mil) -> (overload 1)
	  IVEC3  MILTODEG(IVEC3  mil) -> (overload 2)
	  IVEC4  MILTODEG(IVEC4  mil) -> (overload 3)
	  FLOAT  MILTODEG(FLOAT  mil) -> (overload 4)
	  VEC2   MILTODEG(VEC2   mil) -> (overload 5)
	  VEC3   MILTODEG(VEC3   mil) -> (overload 6)
	  VEC4   MILTODEG(VEC4   mil) -> (overload 7)
	  DOUBLE MILTODEG(DOUBLE mil) -> (overload 8)
	  DVEC2  MILTODEG(DVEC2  mil) -> (overload 9)
	  DVEC3  MILTODEG(DVEC3  mil) -> (overload 10)
	  DVEC4  MILTODEG(DVEC4  mil) -> (overload 11)

	* FLOAT  RADTODEG(FLOAT  radian)
	  VEC2   RADTODEG(VEC2   radian) -> (overload 1)
	  VEC3   RADTODEG(VEC3   radian) -> (overload 2)
	  VEC4   RADTODEG(VEC4   radian) -> (overload 3)
	  DOUBLE RADTODEG(DOUBLE radian) -> (overload 4)
	  DVEC2  RADTODEG(DVEC2  radian) -> (overload 5)
	  DVEC3  RADTODEG(DVEC3  radian) -> (overload 6)
	  DVEC4  RADTODEG(DVEC4  radian) -> (overload 7)

	* INT    SIN(INT    x)
	  IVEC2  SIN(IVEC2  x) -> (overload 1)
	  IVEC3  SIN(IVEC3  x) -> (overload 2)
	  IVEC4  SIN(IVEC4  x) -> (overload 3)
          FLOAT  SIN(FLOAT  x) -> (overload 4)
	  VEC2   SIN(VEC2   x) -> (overload 5)
	  VEC3   SIN(VEC3   x) -> (overload 6)
	  VEC4   SIN(VEC4   x) -> (overload 7)
          DOUBLE SIN(DOUBLE x) -> (overload 8)
	  DVEC2  SIN(DVEC2  x) -> (overload 9)
	  DVEC3  SIN(DVEC3  x) -> (overload 10)
	  DVEC4  SIN(DVEC4  x) -> (overload 11)

        * FLOAT  SINH(FLOAT  x)
	  VEC2   SINH(VEC2   x) -> (overload 1)
	  VEC3   SINH(VEC3   x) -> (overload 2)
	  VEC4   SINH(VEC4   x) -> (overload 3)
          DOUBLE SINH(DOUBLE x) -> (overload 4)
	  DVEC2  SINH(DVEC2  x) -> (overload 5)
	  DVEC3  SINH(DVEC3  x) -> (overload 6)
	  DVEC4  SINH(DVEC4  x) -> (overload 7)

	* INT    TAN(INT    x)
	  IVEC2  TAN(IVEC2  x) -> (overload 1)
	  IVEC3  TAN(IVEC3  x) -> (overload 2)
	  IVEC4  TAN(IVEC4  x) -> (overload 3)
          FLOAT  TAN(FLOAT  x) -> (overload 4)
	  VEC2   TAN(VEC2   x) -> (overload 5)
	  VEC3   TAN(VEC3   x) -> (overload 6)
	  VEC4   TAN(VEC4   x) -> (overload 7)
          DOUBLE TAN(DOUBLE x) -> (overload 8)
	  DVEC2  TAN(DVEC2  x) -> (overload 9)
	  DVEC3  TAN(DVEC3  x) -> (overload 10)
	  DVEC4  TAN(DVEC4  x) -> (overload 11)

        * FLOAT  TANH(FLOAT  x)
	  VEC2   TANH(VEC2   x) -> (overload 1)
	  VEC3   TANH(VEC3   x) -> (overload 2)
	  VEC4   TANH(VEC4   x) -> (overload 3)
          DOUBLE TANH(DOUBLE x) -> (overload 4)
	  DVEC2  TANH(DVEC2  x) -> (overload 5)
	  DVEC3  TANH(DVEC3  x) -> (overload 6)
	  DVEC4  TANH(DVEC4  x) -> (overload 7)


// --- BOUNDING BOX OPERATION FUNCTIONS ---

	* INT    BBOX_CONTAINS(BBOX  x, VEC2  y)
	  INT    BBOX_CONTAINS(BBOX  x, BBOX  y) -> (overload 1)
	  INT    BBOX_CONTAINS(IBBOX x, IVEC2 y) -> (overload 2)
	  INT    BBOX_CONTAINS(IBBOX x, IBBOX y) -> (overload 3)
	  INT    BBOX_CONTAINS(DBBOX x, DVEC2 y) -> (overload 4)
	  INT    BBOX_CONTAINS(DBBOX x, DBBOX y) -> (overload 5)

	* BBOX   BBOX_EXPAND(BBOX  x, BBOX  y)
	  IBBOX  BBOX_EXPAND(IBBOX x, IBBOX y) -> (overload 1)
	  DBBOX  BBOX_EXPAND(DBBOX x, DBBOX y) -> (overload 2)

	* FLOAT  BBOX_GET_AREA(BBOX  x)
	  FLOAT  BBOX_GET_AREA(BBOX  x, BBOX  y) -> (overload 1, area of merged bboxes)
	  INT    BBOX_GET_AREA(IBBOX x)          -> (overload 2)
	  INT    BBOX_GET_AREA(IBBOX x, IBBOX y) -> (overload 3, area of merged bboxes)
	  DOUBLE BBOX_GET_AREA(DBBOX x)          -> (overload 4)
	  DOUBLE BBOX_GET_AREA(DBBOX x, DBBOX y) -> (overload 5, area of merged bboxes)

	* FLOAT  BBOX_GET_FRACTION(BBOX  x, VEC2  a, VEC2  b)
	  DOUBLE BBOX_GET_FRACTION(DBBOX x, DVEC2 a, DVEC2 b) -> (overload 1)

	* INT    BBOX_INTERSECTS(BBOX  x, BBOX  y)
	  INT    BBOX_INTERSECTS(BBOX  x, VEC2  a, VEC2  b) -> (overload 1, intersects along segment AB)
	  INT    BBOX_INTERSECTS(IBBOX x, IBBOX y)          -> (overload 2)
	  INT    BBOX_INTERSECTS(DBBOX x, DBBOX y)          -> (overload 3)
	  INT    BBOX_INTERSECTS(DBBOX x, DVEC2 a, DVEC2 b) -> (overload 4, intersects along segment AB)

	* BBOX   BBOX_MERGE(BBOX  x, BBOX  y)
	  IBBOX  BBOX_MERGE(IBBOX x, IBBOX y) -> (overload 1)
	  DBBOX  BBOX_MERGE(DBBOX x, DBBOX y) -> (overload 2)

	* BBOX   BBOX_NEW(FLOAT  l, FLOAT  b, FLOAT  r, FLOAT  t)
	  BBOX   BBOX_NEW(VEC2   x, VEC2 y)                       -> (overload 1)
	  BBOX   BBOX_NEW(FLOAT  x, FLOAT  y, FLOAT  radius)      -> (overload 2, bbox for circle)
	  BBOX   BBOX_NEW(VEC2   x, FLOAT radius)                 -> (overload 3, bbox for circle)
	  IBBOX  BBOX_NEW(INT    l, INT    b, INT    r, INT    t) -> (overload 4)
	  IBBOX  BBOX_NEW(IVEC2  x, IVEC2 y)                      -> (overload 5)
	  IBBOX  BBOX_NEW(INT    x, INT    y, INT    radius)      -> (overload 6, bbox for circle)
	  IBBOX  BBOX_NEW(IVEC2  x, INT   radius)                 -> (overload 7, bbox for circle)
	  DBBOX  BBOX_NEW(DOUBLE l, DOUBLE b, DOUBLE r, DOUBLE t) -> (overload 8)
	  DBBOX  BBOX_NEW(DVEC2  x, DVEC2 y)                      -> (overload 9)
	  DBBOX  BBOX_NEW(DOUBLE x, DOUBLE y, DOUBLE radius)      -> (overload 10, bbox for circle)
	  DBBOX  BBOX_NEW(DVEC2  x, DOUBLE radius)                -> (overload 11, bbox for circle)


// --- MATRIX OPERATION FUNCTIONS ---

	* MAT2    MAT_ADD(MAT2    *x, MAT2    *y)
	  MAT2x3  MAT_ADD(MAT2x3  *x, MAT2x3  *y) -> (overload 1)
	  MAT2x4  MAT_ADD(MAT2x3  *x, MAT2x3  *y) -> (overload 2)
	  MAT3x2  MAT_ADD(MAT3x2  *x, MAT3x2  *y) -> (overload 3)
	  MAT3    MAT_ADD(MAT3    *x, MAT3    *y) -> (overload 4)
	  MAT3x4  MAT_ADD(MAT3x4  *x, MAT3x4  *y) -> (overload 5)
	  MAT4x2  MAT_ADD(MAT4x2  *x, MAT4x2  *y) -> (overload 6)
	  MAT4x3  MAT_ADD(MAT4x3  *x, MAT4x3  *y) -> (overload 7)
	  MAT4    MAT_ADD(MAT4    *x, MAT4    *y) -> (overload 8)
	  IMAT2   MAT_ADD(IMAT2   *x, IMAT2   *y) -> (overload 9)
	  IMAT2x3 MAT_ADD(IMAT2x3 *x, IMAT2x3 *y) -> (overload 10)
	  IMAT2x4 MAT_ADD(IMAT2x3 *x, IMAT2x3 *y) -> (overload 11)
	  IMAT3x2 MAT_ADD(IMAT3x2 *x, IMAT3x2 *y) -> (overload 12)
	  IMAT3   MAT_ADD(IMAT3   *x, IMAT3   *y) -> (overload 13)
	  IMAT3x4 MAT_ADD(IMAT3x4 *x, IMAT3x4 *y) -> (overload 14)
	  IMAT4x2 MAT_ADD(IMAT4x2 *x, IMAT4x2 *y) -> (overload 15)
	  IMAT4x3 MAT_ADD(IMAT4x3 *x, IMAT4x3 *y) -> (overload 16)
	  IMAT4   MAT_ADD(IMAT4   *x, IMAT4   *y) -> (overload 17)
	  DMAT2   MAT_ADD(DMAT2   *x, DMAT2   *y) -> (overload 18)
	  DMAT2x3 MAT_ADD(DMAT2x3 *x, DMAT2x3 *y) -> (overload 19)
	  DMAT2x4 MAT_ADD(DMAT2x3 *x, DMAT2x3 *y) -> (overload 20)
	  DMAT3x2 MAT_ADD(DMAT3x2 *x, DMAT3x2 *y) -> (overload 21)
	  DMAT3   MAT_ADD(DMAT3   *x, DMAT3   *y) -> (overload 22)
	  DMAT3x4 MAT_ADD(DMAT3x4 *x, DMAT3x4 *y) -> (overload 23)
	  DMAT4x2 MAT_ADD(DMAT4x2 *x, DMAT4x2 *y) -> (overload 24)
	  DMAT4x3 MAT_ADD(DMAT4x3 *x, DMAT4x3 *y) -> (overload 25)
	  DMAT4   MAT_ADD(DMAT4   *x, DMAT4   *y) -> (overload 26)

	* MAT2    MAT_COMPMULT(MAT2    *x, MAT2    *y)
	  MAT2x3  MAT_COMPMULT(MAT2x3  *x, MAT2x3  *y) -> (overload 1)
	  MAT2x4  MAT_COMPMULT(MAT2x3  *x, MAT2x3  *y) -> (overload 2)
	  MAT3x2  MAT_COMPMULT(MAT3x2  *x, MAT3x2  *y) -> (overload 3)
	  MAT3    MAT_COMPMULT(MAT3    *x, MAT3    *y) -> (overload 4)
	  MAT3x4  MAT_COMPMULT(MAT3x4  *x, MAT3x4  *y) -> (overload 5)
	  MAT4x2  MAT_COMPMULT(MAT4x2  *x, MAT4x2  *y) -> (overload 6)
	  MAT4x3  MAT_COMPMULT(MAT4x3  *x, MAT4x3  *y) -> (overload 7)
	  MAT4    MAT_COMPMULT(MAT4    *x, MAT4    *y) -> (overload 8)
	  IMAT2   MAT_COMPMULT(IMAT2   *x, IMAT2   *y) -> (overload 9)
	  IMAT2x3 MAT_COMPMULT(IMAT2x3 *x, IMAT2x3 *y) -> (overload 10)
	  IMAT2x4 MAT_COMPMULT(IMAT2x3 *x, IMAT2x3 *y) -> (overload 11)
	  IMAT3x2 MAT_COMPMULT(IMAT3x2 *x, IMAT3x2 *y) -> (overload 12)
	  IMAT3   MAT_COMPMULT(IMAT3   *x, IMAT3   *y) -> (overload 13)
	  IMAT3x4 MAT_COMPMULT(IMAT3x4 *x, IMAT3x4 *y) -> (overload 14)
	  IMAT4x2 MAT_COMPMULT(IMAT4x2 *x, IMAT4x2 *y) -> (overload 15)
	  IMAT4x3 MAT_COMPMULT(IMAT4x3 *x, IMAT4x3 *y) -> (overload 16)
	  IMAT4   MAT_COMPMULT(IMAT4   *x, IMAT4   *y) -> (overload 17)
	  DMAT2   MAT_COMPMULT(DMAT2   *x, DMAT2   *y) -> (overload 18)
	  DMAT2x3 MAT_COMPMULT(DMAT2x3 *x, DMAT2x3 *y) -> (overload 19)
	  DMAT2x4 MAT_COMPMULT(DMAT2x3 *x, DMAT2x3 *y) -> (overload 20)
	  DMAT3x2 MAT_COMPMULT(DMAT3x2 *x, DMAT3x2 *y) -> (overload 21)
	  DMAT3   MAT_COMPMULT(DMAT3   *x, DMAT3   *y) -> (overload 22)
	  DMAT3x4 MAT_COMPMULT(DMAT3x4 *x, DMAT3x4 *y) -> (overload 23)
	  DMAT4x2 MAT_COMPMULT(DMAT4x2 *x, DMAT4x2 *y) -> (overload 24)
	  DMAT4x3 MAT_COMPMULT(DMAT4x3 *x, DMAT4x3 *y) -> (overload 25)
	  DMAT4   MAT_COMPMULT(DMAT4   *x, DMAT4   *y) -> (overload 26)

	* MAT2    MAT_EQ(MAT2    *x, MAT2    *y)
	  MAT2x3  MAT_EQ(MAT2x3  *x, MAT2x3  *y) -> (overload 1)
	  MAT2x4  MAT_EQ(MAT2x4  *x, MAT2x4  *y) -> (overload 2)
	  MAT3x2  MAT_EQ(MAT3x2  *x, MAT3x2  *y) -> (overload 3)
	  MAT3    MAT_EQ(MAT3    *x, MAT3    *y) -> (overload 4)
	  MAT3x4  MAT_EQ(MAT3x4  *x, MAT3x4  *y) -> (overload 5)
	  MAT4x2  MAT_EQ(MAT4x2  *x, MAT4x2  *y) -> (overload 6)
	  MAT4x3  MAT_EQ(MAT4x3  *x, MAT4x3  *y) -> (overload 7)
	  MAT4    MAT_EQ(MAT4    *x, MAT4    *y) -> (overload 8)
	  IMAT2   MAT_EQ(IMAT2   *x, IMAT2   *y) -> (overload 9)
	  IMAT2x3 MAT_EQ(IMAT2x3 *x, IMAT2x3 *y) -> (overload 10)
	  IMAT2x4 MAT_EQ(IMAT2x4 *x, IMAT2x4 *y) -> (overload 11)
	  IMAT3x2 MAT_EQ(IMAT3x2 *x, IMAT3x2 *y) -> (overload 12)
	  IMAT3   MAT_EQ(IMAT3   *x, IMAT3   *y) -> (overload 13)
	  IMAT3x4 MAT_EQ(IMAT3x4 *x, IMAT3x4 *y) -> (overload 14)
	  IMAT4x2 MAT_EQ(IMAT4x2 *x, IMAT4x2 *y) -> (overload 15)
	  IMAT4x3 MAT_EQ(IMAT4x3 *x, IMAT4x3 *y) -> (overload 16)
	  IMAT4   MAT_EQ(IMAT4   *x, IMAT4   *y) -> (overload 17)
	  DMAT2   MAT_EQ(DMAT2   *x, DMAT2   *y) -> (overload 18)
	  DMAT2x3 MAT_EQ(DMAT2x3 *x, DMAT2x3 *y) -> (overload 19)
	  DMAT2x4 MAT_EQ(DMAT2x4 *x, DMAT2x4 *y) -> (overload 20)
	  DMAT3x2 MAT_EQ(DMAT3x2 *x, DMAT3x2 *y) -> (overload 21)
	  DMAT3   MAT_EQ(DMAT3   *x, DMAT3   *y) -> (overload 22)
	  DMAT3x4 MAT_EQ(DMAT3x4 *x, DMAT3x4 *y) -> (overload 23)
	  DMAT4x2 MAT_EQ(DMAT4x2 *x, DMAT4x2 *y) -> (overload 24)
	  DMAT4x3 MAT_EQ(DMAT4x3 *x, DMAT4x3 *y) -> (overload 25)
	  DMAT4   MAT_EQ(DMAT4   *x, DMAT4   *y) -> (overload 26)

	* INT     MAT_IDENTITY(MAT2  *x)
	  INT     MAT_IDENTITY(MAT3  *x) -> (overload 1)
	  INT     MAT_IDENTITY(MAT4  *x) -> (overload 2)
	  INT     MAT_IDENTITY(IMAT2 *x) -> (overload 3)
	  INT     MAT_IDENTITY(IMAT3 *x) -> (overload 4)
	  INT     MAT_IDENTITY(IMAT4 *x) -> (overload 5)
	  INT     MAT_IDENTITY(DMAT2 *x) -> (overload 6)
	  INT     MAT_IDENTITY(DMAT3 *x) -> (overload 7)
	  INT     MAT_IDENTITY(DMAT4 *x) -> (overload 8)

	* MAT2    MAT_MUL(MAT2    *x, FLOAT    s)
	  MAT2    MAT_MUL(MAT2    *x, MAT2    *y) -> (overload 1)
	  MAT2x3  MAT_MUL(MAT2    *x, MAT2x3  *y) -> (overload 2)
	  MAT2x4  MAT_MUL(MAT2    *x, MAT2x4  *y) -> (overload 3)
	  MAT2x3  MAT_MUL(MAT2x3  *x, FLOAT    s) -> (overload 4)
	  MAT2    MAT_MUL(MAT2x3  *x, MAT3x2  *y) -> (overload 5)
	  MAT2x3  MAT_MUL(MAT2x3  *x, MAT3    *y) -> (overload 6)
	  MAT2x4  MAT_MUL(MAT2x3  *x, MAT3x4  *y) -> (overload 7)
	  MAT2x4  MAT_MUL(MAT2x4  *x, FLOAT    s) -> (overload 8)
	  MAT2    MAT_MUL(MAT2x4  *x, MAT4x2  *y) -> (overload 9)
	  MAT2x3  MAT_MUL(MAT2x4  *x, MAT4x3  *y) -> (overload 10)
	  MAT2x4  MAT_MUL(MAT2x4  *x, MAT4    *y) -> (overload 11)
	  MAT3x2  MAT_MUL(MAT3x2  *x, FLOAT    s) -> (overload 12)
	  MAT2x2  MAT_MUL(MAT3x2  *x, MAT2    *y) -> (overload 13)
	  MAT3    MAT_MUL(MAT3x2  *x, MAT2x3  *y) -> (overload 14)
	  MAT3x4  MAT_MUL(MAT3x2  *x, MAT2x4  *y) -> (overload 15)
	  MAT3    MAT_MUL(MAT3    *x, FLOAT    s) -> (overload 16)
	  MAT3x2  MAT_MUL(MAT3    *x, MAT3x2  *y) -> (overload 17)
	  MAT3    MAT_MUL(MAT3    *x, MAT3    *y) -> (overload 18)
	  MAT3x4  MAT_MUL(MAT3    *x, MAT3x4  *y) -> (overload 19)
	  MAT3x4  MAT_MUL(MAT3x4  *x, FLOAT    s) -> (overload 20)
	  MAT3x2  MAT_MUL(MAT3x4  *x, MAT4x2  *y) -> (overload 21)
	  MAT3    MAT_MUL(MAT3x4  *x, MAT4x3  *y) -> (overload 22)
	  MAT3x4  MAT_MUL(MAT3x4  *x, MAT4    *y) -> (overload 23)
	  MAT4x2  MAT_MUL(MAT4x2  *x, FLOAT    s) -> (overload 24)
	  MAT4x2  MAT_MUL(MAT4x2  *x, MAT2    *y) -> (overload 25)
	  MAT4x3  MAT_MUL(MAT4x2  *x, MAT2x3  *y) -> (overload 26)
	  MAT4    MAT_MUL(MAT4x2  *x, MAT2x4  *y) -> (overload 27)
	  MAT4x3  MAT_MUL(MAT4x3  *x, FLOAT    s) -> (overload 28)
	  MAT4x2  MAT_MUL(MAT4x3  *x, MAT3x2  *y) -> (overload 29)
	  MAT4x3  MAT_MUL(MAT4x3  *x, MAT3    *y) -> (overload 30)
	  MAT4    MAT_MUL(MAT4x3  *x, MAT3x4  *y) -> (overload 31)
	  MAT4    MAT_MUL(MAT4    *x, FLOAT    s) -> (overload 32)
	  MAT4x2  MAT_MUL(MAT4    *x, MAT4x2  *y) -> (overload 33)
	  MAT4x3  MAT_MUL(MAT4    *x, MAT4x3  *y) -> (overload 34)
	  MAT4    MAT_MUL(MAT4    *x, MAT4    *y) -> (overload 35)
	  IMAT2   MAT_MUL(IMAT2   *x, INT      s) -> (overload 36)
	  IMAT2   MAT_MUL(IMAT2   *x, IMAT2   *y) -> (overload 37)
	  IMAT2x3 MAT_MUL(IMAT2   *x, IMAT2x3 *y) -> (overload 38)
	  IMAT2x4 MAT_MUL(IMAT2   *x, IMAT2x4 *y) -> (overload 39)
	  IMAT2x3 MAT_MUL(IMAT2x3 *x, INT      s) -> (overload 40)
	  IMAT2   MAT_MUL(IMAT2x3 *x, IMAT3x2 *y) -> (overload 41)
	  IMAT2x3 MAT_MUL(IMAT2x3 *x, IMAT3   *y) -> (overload 42)
	  IMAT2x4 MAT_MUL(IMAT2x3 *x, IMAT3x4 *y) -> (overload 43)
	  IMAT2x4 MAT_MUL(IMAT2x4 *x, INT      s) -> (overload 44)
	  IMAT2   MAT_MUL(IMAT2x4 *x, IMAT4x2 *y) -> (overload 45)
	  IMAT2x3 MAT_MUL(IMAT2x4 *x, IMAT4x3 *y) -> (overload 46)
	  IMAT2x4 MAT_MUL(IMAT2x4 *x, IMAT4   *y) -> (overload 47)
	  IMAT3x2 MAT_MUL(IMAT3x2 *x, INT      s) -> (overload 48)
	  IMAT2x2 MAT_MUL(IMAT3x2 *x, IMAT2   *y) -> (overload 49)
	  IMAT3   MAT_MUL(IMAT3x2 *x, IMAT2x3 *y) -> (overload 50)
	  IMAT3x4 MAT_MUL(IMAT3x2 *x, IMAT2x4 *y) -> (overload 51)
	  IMAT3   MAT_MUL(IMAT3   *x, INT      s) -> (overload 52)
	  IMAT3x2 MAT_MUL(IMAT3   *x, IMAT3x2 *y) -> (overload 53)
	  IMAT3   MAT_MUL(IMAT3   *x, IMAT3   *y) -> (overload 54)
	  IMAT3x4 MAT_MUL(IMAT3   *x, IMAT3x4 *y) -> (overload 55)
	  IMAT3x4 MAT_MUL(IMAT3x4 *x, INT      s) -> (overload 56)
	  IMAT3x2 MAT_MUL(IMAT3x4 *x, IMAT4x2 *y) -> (overload 57)
	  IMAT3   MAT_MUL(IMAT3x4 *x, IMAT4x3 *y) -> (overload 58)
	  IMAT3x4 MAT_MUL(IMAT3x4 *x, IMAT4   *y) -> (overload 59)
	  IMAT4x2 MAT_MUL(IMAT4x2 *x, INT      s) -> (overload 60)
	  IMAT4x2 MAT_MUL(IMAT4x2 *x, IMAT2   *y) -> (overload 61)
	  IMAT4x3 MAT_MUL(IMAT4x2 *x, IMAT2x3 *y) -> (overload 62)
	  IMAT4   MAT_MUL(IMAT4x2 *x, IMAT2x4 *y) -> (overload 63)
	  IMAT4x3 MAT_MUL(IMAT4x3 *x, INT      s) -> (overload 64)
	  IMAT4x2 MAT_MUL(IMAT4x3 *x, IMAT3x2 *y) -> (overload 65)
	  IMAT4x3 MAT_MUL(IMAT4x3 *x, IMAT3   *y) -> (overload 66)
	  IMAT4   MAT_MUL(IMAT4x3 *x, IMAT3x4 *y) -> (overload 67)
	  IMAT4   MAT_MUL(IMAT4   *x, INT      s) -> (overload 68)
	  IMAT4x2 MAT_MUL(IMAT4   *x, IMAT4x2 *y) -> (overload 69)
	  IMAT4x3 MAT_MUL(IMAT4   *x, IMAT4x3 *y) -> (overload 70)
	  IMAT4   MAT_MUL(IMAT4   *x, IMAT4   *y) -> (overload 71)
	  DMAT2   MAT_MUL(DMAT2   *x, DOUBLE   s) -> (overload 72)
	  DMAT2   MAT_MUL(DMAT2   *x, DMAT2   *y) -> (overload 73)
	  DMAT2x3 MAT_MUL(DMAT2   *x, DMAT2x3 *y) -> (overload 74)
	  DMAT2x4 MAT_MUL(DMAT2   *x, DMAT2x4 *y) -> (overload 75)
	  DMAT2x3 MAT_MUL(DMAT2x3 *x, DOUBLE   s) -> (overload 76)
	  DMAT2   MAT_MUL(DMAT2x3 *x, DMAT3x2 *y) -> (overload 77)
	  DMAT2x3 MAT_MUL(DMAT2x3 *x, DMAT3   *y) -> (overload 78)
	  DMAT2x4 MAT_MUL(DMAT2x3 *x, DMAT3x4 *y) -> (overload 79)
	  DMAT2x4 MAT_MUL(DMAT2x4 *x, DOUBLE   s) -> (overload 80)
	  DMAT2   MAT_MUL(DMAT2x4 *x, DMAT4x2 *y) -> (overload 81)
	  DMAT2x3 MAT_MUL(DMAT2x4 *x, DMAT4x3 *y) -> (overload 82)
	  DMAT2x4 MAT_MUL(DMAT2x4 *x, DMAT4   *y) -> (overload 83)
	  DMAT3x2 MAT_MUL(DMAT3x2 *x, DOUBLE   s) -> (overload 84)
	  DMAT2x2 MAT_MUL(DMAT3x2 *x, DMAT2   *y) -> (overload 85)
	  DMAT3   MAT_MUL(DMAT3x2 *x, DMAT2x3 *y) -> (overload 86)
	  DMAT3x4 MAT_MUL(DMAT3x2 *x, DMAT2x4 *y) -> (overload 87)
	  DMAT3   MAT_MUL(DMAT3   *x, DOUBLE   s) -> (overload 88)
	  DMAT3x2 MAT_MUL(DMAT3   *x, DMAT3x2 *y) -> (overload 89)
	  DMAT3   MAT_MUL(DMAT3   *x, DMAT3   *y) -> (overload 90)
	  DMAT3x4 MAT_MUL(DMAT3   *x, DMAT3x4 *y) -> (overload 91)
	  DMAT3x4 MAT_MUL(DMAT3x4 *x, DOUBLE   s) -> (overload 92)
	  DMAT3x2 MAT_MUL(DMAT3x4 *x, DMAT4x2 *y) -> (overload 93)
	  DMAT3   MAT_MUL(DMAT3x4 *x, DMAT4x3 *y) -> (overload 94)
	  DMAT3x4 MAT_MUL(DMAT3x4 *x, DMAT4   *y) -> (overload 95)
	  DMAT4x2 MAT_MUL(DMAT4x2 *x, DOUBLE   s) -> (overload 96)
	  DMAT4x2 MAT_MUL(DMAT4x2 *x, DMAT2   *y) -> (overload 97)
	  DMAT4x3 MAT_MUL(DMAT4x2 *x, DMAT2x3 *y) -> (overload 98)
	  DMAT4   MAT_MUL(DMAT4x2 *x, DMAT2x4 *y) -> (overload 99)
	  DMAT4x3 MAT_MUL(DMAT4x3 *x, DOUBLE   s) -> (overload 100)
	  DMAT4x2 MAT_MUL(DMAT4x3 *x, DMAT3x2 *y) -> (overload 101)
	  DMAT4x3 MAT_MUL(DMAT4x3 *x, DMAT3   *y) -> (overload 102)
	  DMAT4   MAT_MUL(DMAT4x3 *x, DMAT3x4 *y) -> (overload 103)
	  DMAT4   MAT_MUL(DMAT4   *x, DOUBLE   s) -> (overload 104)
	  DMAT4x2 MAT_MUL(DMAT4   *x, DMAT4x2 *y) -> (overload 105)
	  DMAT4x3 MAT_MUL(DMAT4   *x, DMAT4x3 *y) -> (overload 106)
	  DMAT4   MAT_MUL(DMAT4   *x, DMAT4   *y) -> (overload 107)

	* MAT2    MAT_NE(MAT2    *x, MAT2    *y)
	  MAT2x3  MAT_NE(MAT2x3  *x, MAT2x3  *y) -> (overload 1)
	  MAT2x4  MAT_NE(MAT2x4  *x, MAT2x4  *y) -> (overload 2)
	  MAT3x2  MAT_NE(MAT3x2  *x, MAT3x2  *y) -> (overload 3)
	  MAT3    MAT_NE(MAT3    *x, MAT3    *y) -> (overload 4)
	  MAT3x4  MAT_NE(MAT3x4  *x, MAT3x4  *y) -> (overload 5)
	  MAT4x2  MAT_NE(MAT4x2  *x, MAT4x2  *y) -> (overload 6)
	  MAT4x3  MAT_NE(MAT4x3  *x, MAT4x3  *y) -> (overload 7)
	  MAT4    MAT_NE(MAT4    *x, MAT4    *y) -> (overload 8)
	  IMAT2   MAT_NE(IMAT2   *x, IMAT2   *y) -> (overload 9)
	  IMAT2x3 MAT_NE(IMAT2x3 *x, IMAT2x3 *y) -> (overload 10)
	  IMAT2x4 MAT_NE(IMAT2x4 *x, IMAT2x4 *y) -> (overload 11)
	  IMAT3x2 MAT_NE(IMAT3x2 *x, IMAT3x2 *y) -> (overload 12)
	  IMAT3   MAT_NE(IMAT3   *x, IMAT3   *y) -> (overload 13)
	  IMAT3x4 MAT_NE(IMAT3x4 *x, IMAT3x4 *y) -> (overload 14)
	  IMAT4x2 MAT_NE(IMAT4x2 *x, IMAT4x2 *y) -> (overload 15)
	  IMAT4x3 MAT_NE(IMAT4x3 *x, IMAT4x3 *y) -> (overload 16)
	  IMAT4   MAT_NE(IMAT4   *x, IMAT4   *y) -> (overload 17)
	  DMAT2   MAT_NE(DMAT2   *x, DMAT2   *y) -> (overload 18)
	  DMAT2x3 MAT_NE(DMAT2x3 *x, DMAT2x3 *y) -> (overload 19)
	  DMAT2x4 MAT_NE(DMAT2x4 *x, DMAT2x4 *y) -> (overload 20)
	  DMAT3x2 MAT_NE(DMAT3x2 *x, DMAT3x2 *y) -> (overload 21)
	  DMAT3   MAT_NE(DMAT3   *x, DMAT3   *y) -> (overload 22)
	  DMAT3x4 MAT_NE(DMAT3x4 *x, DMAT3x4 *y) -> (overload 23)
	  DMAT4x2 MAT_NE(DMAT4x2 *x, DMAT4x2 *y) -> (overload 24)
	  DMAT4x3 MAT_NE(DMAT4x3 *x, DMAT4x3 *y) -> (overload 25)
	  DMAT4   MAT_NE(DMAT4   *x, DMAT4   *y) -> (overload 26)

	* MAT2    MAT_NEG(MAT2    *x)
	  MAT2x3  MAT_NEG(MAT2x3  *x) -> (overload 1)
	  MAT2x4  MAT_NEG(MAT2x4  *x) -> (overload 2)
	  MAT3x2  MAT_NEG(MAT3x2  *x) -> (overload 3)
	  MAT3    MAT_NEG(MAT3    *x) -> (overload 4)
	  MAT3x4  MAT_NEG(MAT3x4  *x) -> (overload 5)
	  MAT4x2  MAT_NEG(MAT4x2  *x) -> (overload 6)
	  MAT4x3  MAT_NEG(MAT4x3  *x) -> (overload 7)
	  MAT4    MAT_NEG(MAT4    *x) -> (overload 8)
	  IMAT2   MAT_NEG(IMAT2   *x) -> (overload 9)
	  IMAT2x3 MAT_NEG(IMAT2x3 *x) -> (overload 10)
	  IMAT2x4 MAT_NEG(IMAT2x4 *x) -> (overload 11)
	  IMAT3x2 MAT_NEG(IMAT3x2 *x) -> (overload 12)
	  IMAT3   MAT_NEG(IMAT3   *x) -> (overload 13)
	  IMAT3x4 MAT_NEG(IMAT3x4 *x) -> (overload 14)
	  IMAT4x2 MAT_NEG(IMAT4x2 *x) -> (overload 15)
	  IMAT4x3 MAT_NEG(IMAT4x3 *x) -> (overload 16)
	  IMAT4   MAT_NEG(IMAT4   *x) -> (overload 17)
	  DMAT2   MAT_NEG(DMAT2   *x) -> (overload 18)
	  DMAT2x3 MAT_NEG(DMAT2x3 *x) -> (overload 19)
	  DMAT2x4 MAT_NEG(DMAT2x4 *x) -> (overload 20)
	  DMAT3x2 MAT_NEG(DMAT3x2 *x) -> (overload 21)
	  DMAT3   MAT_NEG(DMAT3   *x) -> (overload 22)
	  DMAT3x4 MAT_NEG(DMAT3x4 *x) -> (overload 23)
	  DMAT4x2 MAT_NEG(DMAT4x2 *x) -> (overload 24)
	  DMAT4x3 MAT_NEG(DMAT4x3 *x) -> (overload 25)
	  DMAT4   MAT_NEG(DMAT4   *x) -> (overload 26)

	* MAT2    MAT2_NEW()                                               -> (overload 1)
	  MAT2    MAT2_NEW(FLOAT v)                                        -> (overload 2)
	  MAT2    MAT2_NEW(FLOAT e00, FLOAT e01, FLOAT e02, FLOAT e03)     -> (overload 3)
	  MAT2    MAT2_NEW(VEC2 c01, VEC2 c02)                             -> (overload 4)
	  MAT2    MAT2_NEW(MAT2 *x)                                        -> (overload 5)
	  IMAT2   MAT2_NEW()                                               -> (overload 6)
	  IMAT2   MAT2_NEW(INT  v)                                         -> (overload 7)
	  IMAT2   MAT2_NEW(INT e00, INT e01, INT e02, INT e03)             -> (overload 8)
	  IMAT2   MAT2_NEW(IVEC2 c01, IVEC2 c02)                           -> (overload 9)
	  IMAT2   MAT2_NEW(IMAT2 *x)                                       -> (overload 10)
	  DMAT2   MAT2_NEW()                                               -> (overload 11)
	  DMAT2   MAT2_NEW(DOUBLE v)                                       -> (overload 12)
	  DMAT2   MAT2_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02, DOUBLE e03) -> (overload 13)
	  DMAT2   MAT2_NEW(DVEC2 c01, DVEC2 c02)                           -> (overload 14)
	  DMAT2   MAT2_NEW(DMAT2 *x)                                       -> (overload 15)
	  MAT2x3  MAT2x3_NEW()                                   -> (overload 1)
	  MAT2x3  MAT2x3_NEW(FLOAT v)                            -> (overload 2)
	  MAT2x3  MAT2x3_NEW(FLOAT e00, FLOAT e01, FLOAT e02,
	                     FLOAT e03, FLOAT e04, FLOAT e05)    -> (overload 3)
	  MAT2x3  MAT2x3_NEW(VEC2 c01, VEC2 c02, VEC2 c03)       -> (overload 4)
	  MAT2x3  MAT2x3_NEW(MAT2x3 *x)                          -> (overload 5)
	  IMAT2x3 MAT2x3_NEW()                                   -> (overload 6)
	  IMAT2x3 MAT2x3_NEW(INT v)                              -> (overload 7)
	  IMAT2x3 MAT2x3_NEW(INT e00, INT e01, INT e02,
	                     INT e03, INT e04, INT e05)          -> (overload 8)
	  IMAT2x3 MAT2x3_NEW(IVEC2 c01, IVEC2 c02, IVEC2 c03)    -> (overload 9)
	  IMAT2x3 MAT2x3_NEW(IMAT2x3 *x)                         -> (overload 10)
	  DMAT2x3 MAT2x3_NEW()                                   -> (overload 11)
	  DMAT2x3 MAT2x3_NEW(DOUBLE v)                           -> (overload 12)
	  DMAT2x3 MAT2x3_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02,
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05) -> (overload 13)
	  DMAT2x3 MAT2x3_NEW(DVEC2 c01, DVEC2 c02, DVEC2 c03)    -> (overload 14)
	  DMAT2x3 MAT2x3_NEW(DMAT2x3 *x)                         -> (overload 15)
	  MAT2x4  MAT2x4_NEW()                                               -> (overload 1)
	  MAT2x4  MAT2x4_NEW(FLOAT v)                                        -> (overload 2)
	  MAT2x4  MAT2x4_NEW(FLOAT e00, FLOAT e01, FLOAT e02, FLOAT e03,
	                     FLOAT e04, FLOAT e05, FLOAT e06, FLOAT e07)     -> (overload 3)
	  MAT2x4  MAT2x4_NEW(VEC2 c01, VEC2 c02,
                             VEC2 c03, VEC2 c04)                             -> (overload 4)
	  MAT2x4  MAT2x4_NEW(MAT2x4 *x)                                      -> (overload 5)
	  IMAT2x4 MAT2x4_NEW()                                               -> (overload 6)
	  IMAT2x4 MAT2x4_NEW(INT v)                                          -> (overload 7)
	  IMAT2x4 MAT2x4_NEW(INT e00, INT e01, INT e02, INT e03,
	                     INT e04, INT e05, INT e06, INT e07)             -> (overload 8)
	  IMAT2x4 MAT2x4_NEW(IVEC2 c01, IVEC2 c02,
                             IVEC2 c03, IVEC2 c04)                           -> (overload 9)
	  IMAT2x4 MAT2x4_NEW(IMAT2x4 *x)                                     -> (overload 10)
	  DMAT2x4 MAT2x4_NEW()                                               -> (overload 11)
	  DMAT2x4 MAT2x4_NEW(DOUBLE v)                                       -> (overload 12)
	  DMAT2x4 MAT2x4_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02, DOUBLE e03
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05, DOUBLE e07) -> (overload 13)
	  DMAT2x4 MAT2x4_NEW(DVEC2 c01, DVEC2 c02,
                             DVEC2 c03, DVEC2 c04)                           -> (overload 14)
	  DMAT2x4 MAT2x4_NEW(DMAT2x4 *x)                                     -> (overload 15)
	  MAT3x2  MAT3x2_NEW()                                   -> (overload 1)
	  MAT3x2  MAT3x2_NEW(FLOAT v)                            -> (overload 2)
	  MAT3x2  MAT3x2_NEW(FLOAT e00, FLOAT e01, FLOAT e02,
	                     FLOAT e03, FLOAT e04, FLOAT e05)    -> (overload 3)
	  MAT3x2  MAT3x2_NEW(VEC3 c01, VEC3 c02)                 -> (overload 4)
	  MAT3x2  MAT3x2_NEW(MAT3x2 *x)                          -> (overload 5)
	  IMAT3x2 MAT3x2_NEW()                                   -> (overload 6)
	  IMAT3x2 MAT3x2_NEW(INT v)                              -> (overload 7)
	  IMAT3x2 MAT3x2_NEW(INT e00, INT e01, INT e02,
	                     INT e03, INT e04, INT e05)          -> (overload 8)
	  IMAT3x2 MAT3x2_NEW(IVEC3 c01, IVEC3 c02)               -> (overload 9)
	  IMAT3x2 MAT3x2_NEW(IMAT3x2 *x)                         -> (overload 10)
	  DMAT3x2 MAT3x2_NEW()                                   -> (overload 11)
	  DMAT3x2 MAT3x2_NEW(DOUBLE v)                           -> (overload 12)
	  DMAT3x2 MAT3x2_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02,
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05) -> (overload 13)
	  DMAT3x2 MAT3x2_NEW(DVEC3 c01, DVEC3 c02)               -> (overload 14)
	  DMAT3x2 MAT3x2_NEW(DMAT3x2 *x)                         -> (overload 15)
	  MAT3    MAT3_NEW()                                   -> (overload 1)
	  MAT3    MAT3_NEW(FLOAT v)                            -> (overload 2)
	  MAT3    MAT3_NEW(FLOAT e00, FLOAT e01, FLOAT e02,
	                   FLOAT e03, FLOAT e04, FLOAT e05)
	                   FLOAT e06, FLOAT e07, FLOAT e08)    -> (overload 3)
	  MAT3    MAT3_NEW(VEC3 c01, VEC3 c02, VEC3 c03)       -> (overload 4)
	  MAT3    MAT3_NEW(MAT3 *x)                            -> (overload 5)
	  IMAT3   MAT3_NEW()                                   -> (overload 6)
	  IMAT3   MAT3_NEW(INT v)                              -> (overload 7)
	  IMAT3   MAT3_NEW(INT e00, INT e01, INT e02,
	                   INT e03, INT e04, INT e05,
	                   INT e06, INT e07, INT e08)          -> (overload 8)
	  IMAT3   MAT3_NEW(IVEC3 c01, IVEC3 c02, IVEC3 c03)    -> (overload 9)
	  IMAT3   MAT3_NEW(IMAT3 *x)                           -> (overload 10)
	  DMAT3   MAT3_NEW()                                   -> (overload 11)
	  DMAT3   MAT3_NEW(DOUBLE v)                           -> (overload 12)
	  DMAT3   MAT3_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02,
	                   DOUBLE e03, DOUBLE e04, DOUBLE e05,
	                   DOUBLE e06, DOUBLE e07, DOUBLE e08) -> (overload 13)
	  DMAT3   MAT3_NEW(DVEC3 c01, DVEC3 c02, DVEC3 c03)    -> (overload 14)
	  DMAT3   MAT3_NEW(DMAT3 *x)                           -> (overload 15)
	  MAT3x4  MAT3x4_NEW()                                   -> (overload 1)
	  MAT3x4  MAT3x4_NEW(FLOAT v)                            -> (overload 2)
	  MAT3x4  MAT3x4_NEW(FLOAT e00, FLOAT e01, FLOAT e02,
	                     FLOAT e03, FLOAT e04, FLOAT e05,
	                     FLOAT e06, FLOAT e07, FLOAT e08,
	                     FLOAT e07, FLOAT e10, FLOAT e11)    -> (overload 3)
	  MAT3x4  MAT3x4_NEW(VEC3 c01, VEC3 c02,
                             VEC3 c03, VEC3 c04)                 -> (overload 4)
	  MAT3x4  MAT3x4_NEW(MAT3x4 *x)                          -> (overload 5)
	  IMAT3x4 MAT3x4_NEW()                                   -> (overload 6)
	  IMAT3x4 MAT3x4_NEW(INT v)                              -> (overload 7)
	  IMAT3x4 MAT3x4_NEW(INT e00, INT e01, INT e02,
           	             INT e03, INT e04, INT e05,
	                     INT e06, INT e07, INT e02,
	                     INT e07, INT e10, INT e11)          -> (overload 8)
	  IMAT3x4 MAT3x4_NEW(IVEC3 c01, IVEC3 c02,
                             IVEC3 c03, IVEC3 c04)               -> (overload 9)
	  IMAT3x4 MAT3x4_NEW(IMAT3x4 *x)                         -> (overload 10)
	  DMAT3x4 MAT3x4_NEW()                                   -> (overload 11)
	  DMAT3x4 MAT3x4_NEW(DOUBLE v)                           -> (overload 12)
	  DMAT3x4 MAT3x4_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02,
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05,
	                     DOUBLE e06, DOUBLE e07, DOUBLE e08,
	                     DOUBLE e09, DOUBLE e10, DOUBLE e11) -> (overload 13)
	  DMAT3x4 MAT3x4_NEW(DVEC3 c01, DVEC3 c02,
                             DVEC3 c03, DVEC3 c04)               -> (overload 14)
	  DMAT3x4 MAT3x4_NEW(DMAT3x4 *x)                         -> (overload 15)
	  MAT4x2  MAT4x2_NEW()                                               -> (overload 1)
	  MAT4x2  MAT4x2_NEW(FLOAT v)                                        -> (overload 2)
	  MAT4x2  MAT4x2_NEW(FLOAT e00, FLOAT e01, FLOAT e02, FLOAT e03,
	                     FLOAT e04, FLOAT e05, FLOAT e06, FLOAT e07)     -> (overload 3)
	  MAT4x2  MAT4x2_NEW(VEC4 c01, VEC4 c02)                             -> (overload 4)
	  MAT4x2  MAT4x2_NEW(MAT4x2 *x)                                      -> (overload 5)
	  IMAT4x2 MAT4x2_NEW()                                               -> (overload 6)
	  IMAT4x2 MAT4x2_NEW(INT v)                                          -> (overload 7)
	  IMAT4x2 MAT4x2_NEW(INT e00, INT e01, INT e02, INT e03,
	                     INT e04, INT e05, INT e06, INT e07)             -> (overload 8)
	  IMAT4x2 MAT4x2_NEW(IVEC4 c01, IVEC4 c02)                           -> (overload 9)
	  IMAT4x2 MAT4x2_NEW(IMAT4x2 *x)                                     -> (overload 10)
	  DMAT4x2 MAT4x2_NEW()                                               -> (overload 11)
	  DMAT4x2 MAT4x2_NEW(DOUBLE v)                                       -> (overload 12)
	  DMAT4x2 MAT4x2_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02, DOUBLE e03
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05, DOUBLE e07) -> (overload 13)
	  DMAT4x2 MAT4x2_NEW(DVEC4 c01, DVEC4 c02)                           -> (overload 14)
	  DMAT4x2 MAT4x2_NEW(DMAT4x2 *x)                                     -> (overload 15)
	  MAT4x3  MAT4x3_NEW()                                   -> (overload 1)
	  MAT4x3  MAT4x3_NEW(FLOAT v)                            -> (overload 2)
	  MAT4x3  MAT4x3_NEW(FLOAT e00, FLOAT e01, FLOAT e02,
	                     FLOAT e03, FLOAT e04, FLOAT e05,
	                     FLOAT e06, FLOAT e07, FLOAT e08,
	                     FLOAT e07, FLOAT e10, FLOAT e11)    -> (overload 3)
	  MAT4x3  MAT4x3_NEW(VEC4 c01, VEC4 c02, VEC4 c03)       -> (overload 4)
	  MAT4x3  MAT4x3_NEW(MAT4x3 *x)                          -> (overload 5)
	  IMAT4x3 MAT4x3_NEW()                                   -> (overload 6)
	  IMAT4x3 MAT4x3_NEW(INT v)                              -> (overload 7)
	  IMAT4x3 MAT4x3_NEW(INT e00, INT e01, INT e02,
           	             INT e03, INT e04, INT e05,
	                     INT e06, INT e07, INT e02,
	                     INT e07, INT e10, INT e11)          -> (overload 8)
	  IMAT4x3 MAT4x3_NEW(IVEC4 c01, IVEC4 c02, IVEC4 c03)    -> (overload 9)
	  IMAT4x3 MAT4x3_NEW(IMAT4x3 *x)                         -> (overload 10)
	  DMAT4x3 MAT4x3_NEW()                                   -> (overload 11)
	  DMAT4x3 MAT4x3_NEW(DOUBLE v)                           -> (overload 12)
	  DMAT4x3 MAT4x3_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02,
	                     DOUBLE e03, DOUBLE e04, DOUBLE e05,
	                     DOUBLE e06, DOUBLE e07, DOUBLE e08,
	                     DOUBLE e09, DOUBLE e10, DOUBLE e11) -> (overload 13)
	  DMAT4x3 MAT4x3_NEW(DVEC4 c01, DVEC4 c02, DVEC4 c03)    -> (overload 14)
	  DMAT4x3 MAT4x3_NEW(DMAT4x3 *x)                         -> (overload 15)
	  MAT4  MAT4_NEW()                                               -> (overload 1)
	  MAT4  MAT4_NEW(FLOAT v)                                        -> (overload 2)
	  MAT4  MAT4_NEW(FLOAT e00, FLOAT e01, FLOAT e02, FLOAT e03,
	                 FLOAT e04, FLOAT e05, FLOAT e06, FLOAT e07,
	                 FLOAT e08, FLOAT e09, FLOAT e10, FLOAT e11,
	                 FLOAT e12, FLOAT e13, FLOAT e14, FLOAT e15)     -> (overload 3)
	  MAT4  MAT4_NEW(VEC4 c01, VEC4 c02,
                         VEC4 c03, VEC4 c04)                             -> (overload 4)
	  MAT4  MAT4_NEW(MAT4x3 *x)                                      -> (overload 5)
	  IMAT4 MAT4_NEW()                                               -> (overload 6)
	  IMAT4 MAT4_NEW(INT v)                                          -> (overload 7)
	  IMAT4 MAT4_NEW(INT e00, INT e01, INT e02, INT e03,
           	         INT e04, INT e05, INT e06, INT e07,
	                 INT e08, INT e09, INT e10, INT e11,
	                 INT e12, INT e13, INT e14, INT e05)             -> (overload 8)
	  IMAT4 MAT4_NEW(IVEC4 c01, IVEC4 c02,
                         IVEC4 c03, IVEC4 c04)                           -> (overload 9)
	  IMAT4 MAT4_NEW(IMAT4 *x)                                       -> (overload 10)
	  DMAT4 MAT4_NEW()                                               -> (overload 11)
	  DMAT4 MAT4_NEW(DOUBLE v)                                       -> (overload 12)
	  DMAT4 MAT4_NEW(DOUBLE e00, DOUBLE e01, DOUBLE e02, DOUBLE e03, 
	                 DOUBLE e04, DOUBLE e05, DOUBLE e06, DOUBLE e07, 
	                 DOUBLE e08, DOUBLE e09, DOUBLE e10, DOUBLE e11,
	                 DOUBLE e12, DOUBLE e13, DOUBLE e14, DOUBLE e15) -> (overload 13)
	  DMAT4 MAT4_NEW(DVEC4 c01, DVEC4 c02,
                         DVEC4 c03, DVEC4 c04)                           -> (overload 14)
	  DMAT4 MAT4_NEW(DMAT4 *x)                                       -> (overload 15)

	* MAT2    MAT_NULL(MAT2    *x)
	  MAT2x3  MAT_NULL(MAT2x3  *x) -> (overload 1)
	  MAT2x4  MAT_NULL(MAT2x4  *x) -> (overload 2)
	  MAT3x2  MAT_NULL(MAT3x2  *x) -> (overload 3)
	  MAT3    MAT_NULL(MAT3    *x) -> (overload 4)
	  MAT3x4  MAT_NULL(MAT3x4  *x) -> (overload 5)
	  MAT4x2  MAT_NULL(MAT4x2  *x) -> (overload 6)
	  MAT4x3  MAT_NULL(MAT4x3  *x) -> (overload 7)
	  MAT4    MAT_NULL(MAT4    *x) -> (overload 8)
	  IMAT2   MAT_NULL(IMAT2   *x) -> (overload 9)
	  IMAT2x3 MAT_NULL(IMAT2x3 *x) -> (overload 10)
	  IMAT2x4 MAT_NULL(IMAT2x4 *x) -> (overload 11)
	  IMAT3x2 MAT_NULL(IMAT3x2 *x) -> (overload 12)
	  IMAT3   MAT_NULL(IMAT3   *x) -> (overload 13)
	  IMAT3x4 MAT_NULL(IMAT3x4 *x) -> (overload 14)
	  IMAT4x2 MAT_NULL(IMAT4x2 *x) -> (overload 15)
	  IMAT4x3 MAT_NULL(IMAT4x3 *x) -> (overload 16)
	  IMAT4   MAT_NULL(IMAT4   *x) -> (overload 17)
	  DMAT2   MAT_NULL(DMAT2   *x) -> (overload 18)
	  DMAT2x3 MAT_NULL(DMAT2x3 *x) -> (overload 19)
	  DMAT2x4 MAT_NULL(DMAT2x4 *x) -> (overload 20)
	  DMAT3x2 MAT_NULL(DMAT3x2 *x) -> (overload 21)
	  DMAT3   MAT_NULL(DMAT3   *x) -> (overload 22)
	  DMAT3x4 MAT_NULL(DMAT3x4 *x) -> (overload 23)
	  DMAT4x2 MAT_NULL(DMAT4x2 *x) -> (overload 24)
	  DMAT4x3 MAT_NULL(DMAT4x3 *x) -> (overload 25)
	  DMAT4   MAT_NULL(DMAT4   *x) -> (overload 26)

	* MAT2    MAT_OUTERPRODUCT(VEC2  c, VEC2  r)
	  MAT2x3  MAT_OUTERPRODUCT(VEC3  c, VEC2  r) -> (overload 1)
	  MAT2x4  MAT_OUTERPRODUCT(VEC4  c, VEC2  r) -> (overload 2)
	  MAT3x2  MAT_OUTERPRODUCT(VEC2  c, VEC3  r) -> (overload 3)
	  MAT3    MAT_OUTERPRODUCT(VEC3  c, VEC3  r) -> (overload 4)
	  MAT3x4  MAT_OUTERPRODUCT(VEC4  c, VEC3  r) -> (overload 5)
	  MAT4x2  MAT_OUTERPRODUCT(VEC2  c, VEC4  r) -> (overload 6)
	  MAT4x3  MAT_OUTERPRODUCT(VEC3  c, VEC4  r) -> (overload 7)
	  MAT4    MAT_OUTERPRODUCT(VEC4  c, VEC4  r) -> (overload 8)
	  IMAT2   MAT_OUTERPRODUCT(IVEC2 c, IVEC2 r) -> (overload 9)
	  IMAT2x3 MAT_OUTERPRODUCT(IVEC3 c, IVEC2 r) -> (overload 10)
	  IMAT2x4 MAT_OUTERPRODUCT(IVEC4 c, IVEC2 r) -> (overload 11)
	  IMAT3x2 MAT_OUTERPRODUCT(IVEC2 c, IVEC3 r) -> (overload 12)
	  IMAT3   MAT_OUTERPRODUCT(IVEC3 c, IVEC3 r) -> (overload 13)
	  IMAT3x4 MAT_OUTERPRODUCT(IVEC4 c, IVEC3 r) -> (overload 14)
	  IMAT4x2 MAT_OUTERPRODUCT(IVEC2 c, IVEC4 r) -> (overload 15)
	  IMAT4x3 MAT_OUTERPRODUCT(IVEC3 c, IVEC4 r) -> (overload 16)
	  IMAT4   MAT_OUTERPRODUCT(IVEC4 c, IVEC4 r) -> (overload 17)
	  DMAT2   MAT_OUTERPRODUCT(DVEC2 c, DVEC2 r) -> (overload 18)
	  DMAT2x3 MAT_OUTERPRODUCT(DVEC3 c, DVEC2 r) -> (overload 19)
	  DMAT2x4 MAT_OUTERPRODUCT(DVEC4 c, DVEC2 r) -> (overload 20)
	  DMAT3x2 MAT_OUTERPRODUCT(DVEC2 c, DVEC3 r) -> (overload 21)
	  DMAT3   MAT_OUTERPRODUCT(DVEC3 c, DVEC3 r) -> (overload 22)
	  DMAT3x4 MAT_OUTERPRODUCT(DVEC4 c, DVEC3 r) -> (overload 23)
	  DMAT4x2 MAT_OUTERPRODUCT(DVEC2 c, DVEC4 r) -> (overload 24)
	  DMAT4x3 MAT_OUTERPRODUCT(DVEC3 c, DVEC4 r) -> (overload 25)
	  DMAT4   MAT_OUTERPRODUCT(DVEC4 c, DVEC4 r) -> (overload 26)

	* MAT2    MAT_SUB(MAT2    *x, MAT2    *y)
	  MAT2x3  MAT_SUB(MAT2x3  *x, MAT2x3  *y) -> (overload 1)
	  MAT2x4  MAT_SUB(MAT2x3  *x, MAT2x3  *y) -> (overload 2)
	  MAT3x2  MAT_SUB(MAT3x2  *x, MAT3x2  *y) -> (overload 3)
	  MAT3    MAT_SUB(MAT3    *x, MAT3    *y) -> (overload 4)
	  MAT3x4  MAT_SUB(MAT3x4  *x, MAT3x4  *y) -> (overload 5)
	  MAT4x2  MAT_SUB(MAT4x2  *x, MAT4x2  *y) -> (overload 6)
	  MAT4x3  MAT_SUB(MAT4x3  *x, MAT4x3  *y) -> (overload 7)
	  MAT4    MAT_SUB(MAT4    *x, MAT4    *y) -> (overload 8)
	  IMAT2   MAT_SUB(IMAT2   *x, IMAT2   *y) -> (overload 9)
	  IMAT2x3 MAT_SUB(IMAT2x3 *x, IMAT2x3 *y) -> (overload 10)
	  IMAT2x4 MAT_SUB(IMAT2x3 *x, IMAT2x3 *y) -> (overload 11)
	  IMAT3x2 MAT_SUB(IMAT3x2 *x, IMAT3x2 *y) -> (overload 12)
	  IMAT3   MAT_SUB(IMAT3   *x, IMAT3   *y) -> (overload 13)
	  IMAT3x4 MAT_SUB(IMAT3x4 *x, IMAT3x4 *y) -> (overload 14)
	  IMAT4x2 MAT_SUB(IMAT4x2 *x, IMAT4x2 *y) -> (overload 15)
	  IMAT4x3 MAT_SUB(IMAT4x3 *x, IMAT4x3 *y) -> (overload 16)
	  IMAT4   MAT_SUB(IMAT4   *x, IMAT4   *y) -> (overload 17)
	  DMAT2   MAT_SUB(DMAT2   *x, DMAT2   *y) -> (overload 18)
	  DMAT2x3 MAT_SUB(DMAT2x3 *x, DMAT2x3 *y) -> (overload 19)
	  DMAT2x4 MAT_SUB(DMAT2x3 *x, DMAT2x3 *y) -> (overload 20)
	  DMAT3x2 MAT_SUB(DMAT3x2 *x, DMAT3x2 *y) -> (overload 21)
	  DMAT3   MAT_SUB(DMAT3   *x, DMAT3   *y) -> (overload 22)
	  DMAT3x4 MAT_SUB(DMAT3x4 *x, DMAT3x4 *y) -> (overload 23)
	  DMAT4x2 MAT_SUB(DMAT4x2 *x, DMAT4x2 *y) -> (overload 24)
	  DMAT4x3 MAT_SUB(DMAT4x3 *x, DMAT4x3 *y) -> (overload 25)
	  DMAT4   MAT_SUB(DMAT4   *x, DMAT4   *y) -> (overload 26)

	* MAT2    MAT_TRANSPOSE(MAT2    *x)
	  MAT2x3  MAT_TRANSPOSE(MAT2x3  *x) -> (overload 1)
	  MAT2x4  MAT_TRANSPOSE(MAT2x4  *x) -> (overload 2)
	  MAT3x2  MAT_TRANSPOSE(MAT3x2  *x) -> (overload 3)
	  MAT3    MAT_TRANSPOSE(MAT3    *x) -> (overload 4)
	  MAT3x4  MAT_TRANSPOSE(MAT3x4  *x) -> (overload 5)
	  MAT4x2  MAT_TRANSPOSE(MAT4x2  *x) -> (overload 6)
	  MAT4x3  MAT_TRANSPOSE(MAT4x3  *x) -> (overload 7)
	  MAT4    MAT_TRANSPOSE(MAT4    *x) -> (overload 8)
	  IMAT2   MAT_TRANSPOSE(IMAT2   *x) -> (overload 9)
	  IMAT2x3 MAT_TRANSPOSE(IMAT2x3 *x) -> (overload 10)
	  IMAT2x4 MAT_TRANSPOSE(IMAT2x4 *x) -> (overload 11)
	  IMAT3x2 MAT_TRANSPOSE(IMAT3x2 *x) -> (overload 12)
	  IMAT3   MAT_TRANSPOSE(IMAT3   *x) -> (overload 13)
	  IMAT3x4 MAT_TRANSPOSE(IMAT3x4 *x) -> (overload 14)
	  IMAT4x2 MAT_TRANSPOSE(IMAT4x2 *x) -> (overload 15)
	  IMAT4x3 MAT_TRANSPOSE(IMAT4x3 *x) -> (overload 16)
	  IMAT4   MAT_TRANSPOSE(IMAT4   *x) -> (overload 17)
	  DMAT2   MAT_TRANSPOSE(DMAT2   *x) -> (overload 18)
	  DMAT2x3 MAT_TRANSPOSE(DMAT2x3 *x) -> (overload 19)
	  DMAT2x4 MAT_TRANSPOSE(DMAT2x4 *x) -> (overload 20)
	  DMAT3x2 MAT_TRANSPOSE(DMAT3x2 *x) -> (overload 21)
	  DMAT3   MAT_TRANSPOSE(DMAT3   *x) -> (overload 22)
	  DMAT3x4 MAT_TRANSPOSE(DMAT3x4 *x) -> (overload 23)
	  DMAT4x2 MAT_TRANSPOSE(DMAT4x2 *x) -> (overload 24)
	  DMAT4x3 MAT_TRANSPOSE(DMAT4x3 *x) -> (overload 25)
	  DMAT4   MAT_TRANSPOSE(DMAT4   *x) -> (overload 26)


// --- VECTOR OPERATION FUNCTIONS ---

	* VEC2   VEC_ADD(VEC2  x, VEC2  y)
	  VEC3   VEC_ADD(VEC3  x, VEC3  y) -> (overload 1)
	  VEC4   VEC_ADD(VEC4  x, VEC4  y) -> (overload 2)
	  IVEC2  VEC_ADD(IVEC2 x, IVEC2 y) -> (overload 3)
	  IVEC3  VEC_ADD(IVEC3 x, IVEC3 y) -> (overload 4)
	  IVEC4  VEC_ADD(IVEC4 x, IVEC4 y) -> (overload 5)
	  DVEC2  VEC_ADD(DVEC2 x, DVEC2 y) -> (overload 6)
	  DVEC3  VEC_ADD(DVEC3 x, DVEC3 y) -> (overload 7)
	  DVEC4  VEC_ADD(DVEC4 x, DVEC4 y) -> (overload 8)

	* VEC2   VEC_FORANGLE(FLOAT  angle)
	  DVEC2  VEC_FORANGLE(DOUBLE angle) -> (overload 1)

	* INT    VEC_EQ(VEC2  x, VEC2  y)
	  INT    VEC_EQ(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_EQ(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_EQ(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_EQ(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_EQ(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_EQ(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_EQ(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_EQ(DVEC4 x, DVEC4 y) -> (overload 8)

	* INT    VEC_GE(VEC2  x, VEC2  y)
	  INT    VEC_GE(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_GE(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_GE(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_GE(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_GE(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_GE(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_GE(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_GE(DVEC4 x, DVEC4 y) -> (overload 8)
	
	* INT    VEC_GT(VEC2  x, VEC2  y)
	  INT    VEC_GT(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_GT(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_GT(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_GT(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_GT(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_GT(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_GT(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_GT(DVEC4 x, DVEC4 y) -> (overload 8)

	* INT    VEC_LE(VEC2  x, VEC2  y)
	  INT    VEC_LE(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_LE(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_LE(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_LE(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_LE(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_LE(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_LE(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_LE(DVEC4 x, DVEC4 y) -> (overload 8)

	* INT    VEC_LT(VEC2  x, VEC2  y)
	  INT    VEC_LT(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_LT(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_LT(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_LT(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_LT(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_LT(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_LT(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_LT(DVEC4 x, DVEC4 y) -> (overload 8)

	* INT    VEC_NE(VEC2  x, VEC2  y)
	  INT    VEC_NE(VEC3  x, VEC3  y) -> (overload 1)
	  INT    VEC_NE(VEC4  x, VEC4  y) -> (overload 2)
	  INT    VEC_NE(IVEC2 x, IVEC2 y) -> (overload 3)
	  INT    VEC_NE(IVEC3 x, IVEC3 y) -> (overload 4)
	  INT    VEC_NE(IVEC4 x, IVEC4 y) -> (overload 5)
	  INT    VEC_NE(DVEC2 x, DVEC2 y) -> (overload 6)
	  INT    VEC_NE(DVEC3 x, DVEC3 y) -> (overload 7)
	  INT    VEC_NE(DVEC4 x, DVEC4 y) -> (overload 8)

	* INT    VEC_NEAR(VEC2  x, VEC2  y, FLOAT  dist)
	  INT    VEC_NEAR(IVEC2 x, IVEC2 y, INT    dist) -> (overload 1)
	  INT    VEC_NEAR(DVEC2 x, DVEC2 y, DOUBLE dist) -> (overload 2)

	* VEC2   VEC_MUL(VEC2  x, FLOAT  s)
	  VEC3   VEC_MUL(VEC3  x, FLOAT  s) -> (overload 1)
	  VEC4   VEC_MUL(VEC4  x, FLOAT  s) -> (overload 2)
	  IVEC2  VEC_MUL(IVEC2 x, INT    s) -> (overload 3)
	  IVEC3  VEC_MUL(IVEC3 x, INT    s) -> (overload 4)
	  IVEC4  VEC_MUL(IVEC4 x, INT    s) -> (overload 5)
	  DVEC2  VEC_MUL(DVEC2 x, DOUBLE s) -> (overload 6)
	  DVEC3  VEC_MUL(DVEC3 x, DOUBLE s) -> (overload 7)
	  DVEC4  VEC_MUL(DVEC4 x, DOUBLE s) -> (overload 8)

	* VEC2   VEC_NEG(VEC2  x)
	  VEC3   VEC_NEG(VEC3  x) -> (overload 1)
	  VEC4   VEC_NEG(VEC4  x) -> (overload 2)
	  IVEC2  VEC_NEG(IVEC2 x) -> (overload 3)
	  IVEC3  VEC_NEG(IVEC3 x) -> (overload 4)
	  IVEC4  VEC_NEG(IVEC4 x) -> (overload 5)
	  DVEC2  VEC_NEG(DVEC2 x) -> (overload 6)
	  DVEC3  VEC_NEG(DVEC3 x) -> (overload 7)
	  DVEC4  VEC_NEG(DVEC4 x) -> (overload 8)

	* VEC2   VEC_NEW(FLOAT  x, FLOAT  y)
	  VEC3   VEC_NEW(FLOAT  x, FLOAT  y, FLOAT  z)           -> (overload 1)
	  VEC4   VEC_NEW(FLOAT  x, FLOAT  y, FLOAT  z, FLOAT  w) -> (overload 2)
	  IVEC2  VEC_NEW(INT    x, INT    y)                     -> (overload 3)
	  IVEC3  VEC_NEW(INT    x, INT    y, INT    z)           -> (overload 4)
	  IVEC4  VEC_NEW(INT    x, INT    y, INT    z, INT    w) -> (overload 5)
	  DVEC2  VEC_NEW(DOUBLE x, DOUBLE y)                     -> (overload 6)
	  DVEC3  VEC_NEW(DOUBLE x, DOUBLE y, DOUBLE z)           -> (overload 7)
	  DVEC4  VEC_NEW(DOUBLE x, DOUBLE y, DOUBLE z, DOUBLE w) -> (overload 8)

	* VEC2   VEC_PERP(VEC2  v)
	  IVEC2  VEC_PERP(IVEC2 v) -> (overload 1)
	  DVEC2  VEC_PERP(DVEC2 v) -> (overload 2)

	* VEC2   VEC_PROJECT(VEC2  x, VEC2  y)
	  IVEC2  VEC_PROJECT(IVEC2 x, IVEC2 y) -> (overload 1)
	  DVEC2  VEC_PROJECT(DVEC2 x, DVEC2 y) -> (overload 2)

	* VEC2   VEC_RPERP(VEC2  v)
	  IVEC2  VEC_RPERP(IVEC2 v) -> (overload 1)
	  DVEC2  VEC_RPERP(DVEC2 v) -> (overload 2)

	* VEC2   VEC_ROTATE(VEC2  x, VEC2  y)
	  IVEC2  VEC_ROTATE(IVEC2 x, IVEC2 y) -> (overload 1)
	  DVEC2  VEC_ROTATE(DVEC2 x, DVEC2 y) -> (overload 2)

	* VEC2   VEC_SUB(VEC2  x, VEC2  y)
	  VEC3   VEC_SUB(VEC3  x, VEC3  y) -> (overload 1)
	  VEC4   VEC_SUB(VEC4  x, VEC4  y) -> (overload 2)
	  IVEC2  VEC_SUB(IVEC2 x, IVEC2 y) -> (overload 3)
	  IVEC3  VEC_SUB(IVEC3 x, IVEC3 y) -> (overload 4)
	  IVEC4  VEC_SUB(IVEC4 x, IVEC4 y) -> (overload 5)
	  DVEC2  VEC_SUB(DVEC2 x, DVEC2 y) -> (overload 6)
	  DVEC3  VEC_SUB(DVEC3 x, DVEC3 y) -> (overload 7)
	  DVEC4  VEC_SUB(DVEC4 x, DVEC4 y) -> (overload 8)

	* FLOAT  VEC_TOANGLE(VEC2  x)
	  DOUBLE VEC_TOANGLE(DVEC2 x) -> (overload 1)

	* VEC2   VEC_UNROTATE(VEC2  x, VEC2  y)
	  IVEC2  VEC_UNROTATE(IVEC2 x, IVEC2 y) -> (overload 1)
	  DVEC2  VEC_UNROTATE(DVEC2 x, DVEC2 y) -> (overload 2)


// --- MATH LIBRARY SETTING AND INFORMATION ---

        * INT MATHLIB_GET_ANGLEUNIT()

        * INT MATHLIB_SET_ANGLEUNIT(INT angle_unit)
		- ANGLE_UNIT values:
                  math_degree_unit (0)
	          math_radian_unit (1)



---------------------------
--- MODE7
---------------------------
	/* *** CONSTANTS *** */

	* all_mode7	(-1)
	* c_m7		( 2)
	* m7fog_none	( 0)
	* m7fog_linear	( 1)
	* m7fog_quad	( 2)
	* m7fog_cubic	( 3)
	* m7fog_quart	( 4)
	* m7fog_quint	( 5)
	* m7fog_sine	( 6)
	* m7fog_exp	( 7)
	* m7fog_circ	( 8)


	/* *** VARIABLES *** */

	* INT height	(= 0)	-> (LOCAL)
	* INT m7_angle	(= 0)	-> (LOCAL)
	* INT m7_fog	(= 1)	-> (LOCAL)
	* STRUCT m7[10]
	    INT camera		(= 0)
	    INT height		(= 32)
	    INT distance	(= 64)
	    INT horizon		(= 0)
	    INT focus		(= 256)
	    INT z		(= 256)
	    INT color		(= 0)
	    INT visible		(= 1)
	    INT fog             (= 0, work only on 16/32 bits)
	    INT fogcolor        (= 0)
	    FLOAT fogdensity    (= 0.5)
		INT filter		(= 0) (MODERN mode only)
	  END


	/* *** FUNCTIONS *** */

	* INT MODE7_GET_SCALEFACTOR(INT mode7, INT x, INT y, INT height, INT resolution)

	* INT MODE7_SET_TARGET(INT mode7, INT target_file, INT target_graph, INT region)
		- MODE7 values:
		  all_mode7 (-1)
		  or 0 to 9
		- REGION values:
		  -1 = automatic (target_graph as region)
		  or 0 to 65336

	* INT MODE7_START(INT mode7, INT fpg_id, INT graph_id, INT graph_back_id,
			  INT region, INT horizon)
	  INT START_MODE7(INT mode7, INT fpg_id, INT graph_id, INT graph_back_id,
			  INT region, INT horizon) -> (alias of MODE7_START, LEGACY mode only)
		- MODE7 values:
		  0 to 9
		- REGION values:
		  -1 = automatic (screen resolution as region)
		  or 0 to 65336

	* INT MODE7_STOP(INT mode7)
	  INT STOP_MODE7(INT mode7) -> (alias of STOP_MODE7, LEGACY mode only)
		- MODE7 values:
		  all_mode7 (-1)
		  or 0 to 9

	* INT MODE7_TO_SCREEN(INT mode7, INT x, INT y, INT height, INT *screenx, INT *screeny)

	* INT SCREEN_TO_MODE7(INT mode7, INT screenx, INT screeny, INT *mode7x, INT *mode7y)
		


---------------------------
--- PATHFIND2D
---------------------------
	/* *** CONSTANTS *** */

	* pf_fast		(0)
	* pf_accurate		(1)
	* pf_fast_nodiag	(2)
	* pf_accurate_nodiag	(3)


	/* *** FUNCTIONS *** */
	
	* INT PATH_FIND(INT mode, INT fpg_id, INT graph_id, INT factor_size,
                        INT proc_dst_id, VOID *struct,
			INT sizeof(struct)) -> (Overload 1)
	  INT PATH_FIND(INT mode, INT fpg_id, INT graph_id, INT factor_size,
                        INT x, INT y, VOID *struct,
			INT sizeof(struct))
	  INT PATH_FIND(INT mode, INT fpg_id, INT graph_id, INT factor_size,
                        INT proc_src_id, INT x, INT y, VOID *struct,
			INT sizeof(struct)) -> (Overload 2)
	  INT PATH_FIND(INT mode, INT fpg_id, INT graph_id, INT factor_size,
                        INT src_x, INT src_y, INT dst_x, INT dst_y, VOID *struct,
			INT sizeof(struct)) -> (Overload 3)
		- MODE values:
		  pf_fast		(0)
		  pf_accurate		(1)
		  pf_fast_nodiag	(2)
		  pf_accurate_nodiag	(3)

	* INT PATH_FREE(INT fpg_id, INT graph_id, INT factor_size, INT x, INT y)

	* INT PATH_LINE(INT fpg_id, INT graph_id, INT factor_size, INT proc_dst) -> (Overload 1)
	  INT PATH_LINE(INT fpg_id, INT graph_id, INT factor_size, INT x, INT y)
	  INT PATH_LINE(INT fpg_id, INT graph_id, INT factor_size, INT proc_src, INT x, INT y) -> (Overload 2)
	  INT PATH_LINE(INT fpg_id, INT graph_id, INT factor_size, INT src_x, INT src_y, INT dst_x, INT dst_y) -> (Overload 3)



---------------------------
--- SCROLL2D
---------------------------
	/* *** CONSTANTS *** */

	* all_scroll		(-1)
	* c_scroll		( 1)
	* scroll_normal		( 0)
	* scroll_layers		( 1)
	* scroll_normal_key	( 2)
	* scroll_layers_key	( 3)


	/* *** VARIABLES *** */

	* STRUCT scroll[10]
	    INT camera	(= 0)
	    INT ratio	(= 200)
	    INT file    (= 0)
  	    INT graph1  (= 0)
	    INT graph2  (= 0)
	    INT region1	(= -1)
	    INT region2	(= -1)
	    INT speed	(= 0)
	    INT x0	(= 0)
	    INT y0	(= 0)
	    INT x1	(= 0)
	    INT y1	(= 0)
	    INT z	(= 512)
	    INT alpha   (= 255, work only on 16/32 bits)
	    INT visible (= 1)
	  END	


	/* *** FUNCTIONS *** */

	* INT SCROLL_MOVE(INT scroll)
	* INT MOVE_SCROLL(INT scroll) -> (alias of SCROLL_MOVE, LEGACY mode only)
		- SCROLL values:
		  0 to 9

	* INT SCROLL_REFRESH(INT scroll)
	* INT REFRESH_SCROLL(INT scroll) -> (alias of SCROLL_REFRESH, LEGACY mode only)
		- SCROLL values:
		  0 to 9

	* INT SCROLL_SET_TARGET(INT scroll, INT target_file, INT target_graph, INT region)
		- SCROLL values:
		  all_scroll (-1)
		  or 0 to 9
		- REGION values:
		  -1 = automatic (target_graph as region)
		  or 0 to 65336

	* INT SCROLL_START(INT scroll, INT fpg_id, INT grapg_id, INT graph_back_id,
			   INT region, INT flags)
	  INT SCROLL_START(INT scroll, INT fpg_id, INT grapg_id, INT graph_back_id,
			   INT region, INT flags, INT scroll_mode) -> (overload 1)
	  INT START_SCROLL(INT scroll, INT fpg_id, INT grapg_id, INT graph_back_id,
			   INT region, INT flags) -> (alias of SCROLL_START, LEGACY mode only)
	  INT START_SCROLL(INT scroll, INT fpg_id, INT grapg_id, INT graph_back_id,
			   INT region, INT flags, INT scroll_mode) -> (overload 1, alias of SCROLL_START, LEGACY mode only)
		- SCROLL values:
		  all_scroll	(-1)
		  or 0 to 9
		- REGION values:
		  -1 = automatic (screen resolution as region)
		  or 0 to 65336
		- FLAGS combination following values:
		  1 = tile horizontally the first plane
		  2 = tile vertically the first plane
		  4 = tile horizonatally the second plane
		  8 = tile vertically the second plane
		- SCROLL_MODE values:
		  scroll_normal	    (0)
		  scroll_layers	    (1)
		  scroll_normal_key (2)
		  scroll_layers_key (3)

	* INT SCROLL_STOP(INT scroll)
	  INT STOP_SCROLL(INT scroll) -> (alias of SCROLL_STOP, LEGACY mode only)
		- SCROLL values:
		  all_scroll	(-1)
		  or 0 to 9



---------------------------
--- SOCKET
---------------------------
	/* *** CONSTANTS *** */

	* socket_protocol_tcp (OS value)
	* socket_protocol_udp (OS value)


	/* *** FUNCTIONS *** */

// --- SOCKET MANAGEMENT ---

	* INT SOCKET_OPEN(INT protocol)
		- PROTOCOL values:
		  socket_protocol_tcp
		  socket_protocol_udp
	
	* INT SOCKET_BIND(INT socket, WORD port)

	* INT SOCKET_LISTEN(INT socket, INT backlog)

	* INT SOCKET_CONNECT(INT socket, STRING ip_or_domain, WORD port)

	* INT SOCKET_ACCEPT(INT socket, STRING *ip, WORD *port)

	* INT SOCKET_SELECT(INT socketreads, INT socketwrites, INT socketerros, INT wait_time)

	* INT SOCKET_SEND(INT socket, VOID *data, DWORD data_len, INT force_sentdall = false)

	* INT SOCKET_SENDTO(INT socket, VOID *data, DWORD data_len, STRING ip_or_domain, WORD port, INT force_sentdall = false)

	* INT SOCKET_RECV(INT socket, VOID *data, DWORD data_len)
	
	* INT SOCKET_RECVFROM(INT socket, VOID *data, DWORD data_len, STRING ip_or_domain, WORD port)

	* INT SOCKET_CLOSE(INT socket)


// --- SOCKET MONITORING MANAGEMENT ---

	* INT SOCKET_FD_ZERO(INT socketset)

	* INT SOCKET_FD_SET(INT socketset, INT socket)

	* INT SOCKET_FD_CLR(INT socketset, INT socket)

	* INT SOCKET_FD_ISSET(INT socketset, INT socket)


// --- SOCKET BLOCKING I/O STRATEGIES MANAGEMENT ---

	* INT SOCKET_SET_BLOCKING(INT socket, INT blocking)


// --- HOST/PEER MANAGEMENT ---

	* STRING SOCKET_GET_HOSTNAME()

	* STRING SOCKET_GET_HOSTADDR()

	* STRING SOCKET_GET_PEERADDR(INT socket)

	* STRING SOCKET_GET_PEERPORT(INT socket)

	
// --- ERROR MANAGEMENT ---

	* INT SOCKET_GET_ERRORNUM()

	* STRING SOCKET_GET_ERRORMSG()



---------------------------
--- SOUND
---------------------------
	/* *** CONSTANTS *** */

	* all_sound				(-1)
	* all_song				(-1)
	* all_cd				(-1)
	* all_channel				(-1)
	* fast_mixer				(1)	-> (for only SETUP audio structure, LEGACY mode only)
	* quality_mixer				(2)	-> (for only SETUP audio structure, LEGACY mode only)
	* sound_bits_8				(8)	-> (for only SETUP audio structure, LEGACY mode only)
	* sound_bits_16				(16)	-> (for only SETUP audio structure, LEGACY mode only)
	* audio_driver_default			(0)
	* audio_mixer_maxinterpolation		(-1)
	* audio_mixer_nointerpolation		(0)
	* audio_mixer_linearinterpolation	(1)
	* audio_mixer_cubicinterpolation	(2)
	* audio_mixer_splineinterpolation	(3)
	* audio_rate_8000			(8000)
	* audio_rate_11025			(11025)
	* audio_rate_22050			(22050)
	* audio_rate_33075			(33075)
	* audio_rate_44100			(44100)
	* audio_rate_48000			(48000)
	* audio_rate_65535			(65535)
	* audio_rate_96000			(96000)
	* audio_rate_192000			(192000)
	* audio_bits_8				(8)
	* audio_bits_16				(16)
	* audio_bits_24				(24)
	* audio_bits_32				(32)
	* audio_bits_32float			(33)
	* audio_speaker_mono			(1)
	* audio_speaker_stereo			(2)
	* refresh_audio_engine			(0)
	* refresh_audio_volume			(1)
	* cd_playonce				(0)(LEGACY mode only)
	* cd_playcontinuous			(1)(LEGACY mode only)
	* cd_playlooped				(2)(LEGACY mode only)
	* cd_playcontinuouslooped		(3)(LEGACY mode only)


	/* *** TYPEDEFS *** */

// --- AUDIO USAGE ---

	* TYPE audio_cpu_usage
	    FLOAT dsp
	    FLOAT stream
	    FLOAT geometry
	    FLOAT update
	    FLOAT total
	  END

	* TYPE audio_memory_usage (LEGACY mode only at moment)
	    DWORD other
	    DWORD stringdata
	    DWORD system
	    DWORD plugins
	    DWORD output
	    DWORD channel
	    DWORD channelgroup
	    DWORD codec
	    DWORD file
	    DWORD sound
	    DWORD secondaryram
	    DWORD soundgroup
	    DWORD streambuffer
	    DWORD dspconnection
	    DWORD dsp
	    DWORD dspcodec
	    DWORD profile
	    DWORD recordbuffer
	    DWORD reverb
	    DWORD reverbchannelprops
	    DWORD geometry
	    DWORD syncpoint
	    DWORD eventsystem
	    DWORD musicsystem
	    DWORD fev
	    DWORD memoryfsb
	    DWORD eventproject
	    DWORD eventgroupi
	    DWORD soundbankclass
	    DWORD soundbanklist
	    DWORD streaminstance
	    DWORD sounddefclass
	    DWORD sounddefdefclass
	    DWORD sounddefpool
	    DWORD reverbdef
	    DWORD eventreverb
	    DWORD eventinstance
	    DWORD eventinstance_complex
	    DWORD eventinstance_simple
	    DWORD eventinstance_layer
	    DWORD eventinstance_sound
	    DWORD eventenvelope
	    DWORD eventenvelopedef
	    DWORD eventparameter
	    DWORD eventcategory
	    DWORD eventenvelopepoint
	    DWORD eventinstancepool
	  END


	/* *** VARIABLES *** */

	* INT channel[352] 	(= 0)(LEGACY mode only)
	* STRUCT audio_setup
	    INT driver		(= 0)
	    INT mixer		(= 1)
	    INT mixerbuffer	(= 1024)
	    INT mixerlatency	(= 4)
	    INT streambuffer	(= 16384)
	    INT rate		(= 44100)
	    INT bits		(= 16)
	    INT speaker		(= 2)
	    INT sound_channels	(= 64)
	    INT song_channels	(= 1)
	    INT cd_channels	(= 1)(LEGACY mode only)
	    INT master_volume	(= 256)
	    INT sound_volume	(= 256)
	    INT song_volume	(= 256)
	    INT cdaudio_volume	(= 256)(LEGACY mode only)
	  END
	  // OLD SOUND SYSTEM STRUCT (ADDED FOR COMPATIBILITY)
	* STRUCT setup (LEGACY mode only)
	    INT card		(= 0) // OBSOLETE - NOT USED
	    INT port		(= 0) // OBSOLETE - NOT USED
	    INT irq		(= 0) // OBSOLETE - NOT USED
	    INT dma		(= 0) // OBSOLETE - NOT USED
	    INT dma2		(= 0) // OBSOLETE - NOT USED
	    INT mixer		(= 1)
	    INT rate		(= 44100)
	    INT bits		(= 16)
	    INT master		(= 15)
	    INT sound_fx	(= 15)
	    INT cd_audio	(= 15)
	  END


	/* *** FUNCTIONS *** */

// --- AUDIO AND SETUP MANAGEMENT ---

	* DWORD AUDIO_GET_MEMORYUSAGE(AUDIO_MEMORY_USAGE *memusage)(LEGACY mode only at moment)

	* INT AUDIO_IS_MUTED()

	* INT AUDIO_MUTE()

	* INT AUDIO_REFRESH_SETUP()			-> (REFRESH engine + volume)
	  INT AUDIO_REFRESH_SETUP(INT refresh_type)	-> (overload 1)
		- REFRESH_TYPE values:
		  refresh_audio_engine	(0)
		  refresh_audio_volume	(1)	

	* INT AUDIO_UNMUTE()

	* INT RESET_SOUND()(LEGACY mode only)

	* INT SET_VOLUME()(LEGACY mode only)


// --- SOUND RESOURCE MANAGEMENT (PCM/WAV/MP2/MP3/OGG) ---

	* INT LOAD_PCM(STRING fname, INT loop)(LEGACY mode only)

	* INT LOAD_WAV(STRING fname, INT loop)(LEGACY mode only)

	* STRING SOUND_GET_FORMAT(INT sound_id)

	* INT SOUND_GET_FREQUENCY(INT sound_id)

	* INT SOUND_GET_LENGTH(INT sound_id)

	* INT SOUND_GET_LENGTHMS(INT sound_id)

	* INT SOUND_GET_LOOP(INT sound_id)

	* INT SOUND_GET_LOOPCOUNT(INT sound_id)

	* DWORD SOUND_GET_MEMORYUSAGE(INT sound_id, AUDIO_MEMORY_USAGE *memusage)

	* STRING SOUND_GET_NAME(INT sound_id)

	* INT SOUND_GET_PAN(INT sound_id)

	* INT SOUND_GET_SIZE(INT sound_id)

	* INT SOUND_GET_SPEED(INT sound_id)

	* STRING SOUND_GET_TYPE(INT sound_id)

	* INT SOUND_GET_VOLUME(INT sound_id)

	* INT SOUND_LOAD(STRING fname, INT loop)
          INT SOUND_LOAD(STRING fname)                          -> (overload 1, loop default = 0)
	  INT SOUND_LOAD(STRING fname, INT loop, INT loopcount) -> (overload 2, loopcount 0 = infinite)

 	* INT SOUND_PLAY(INT sound_id, INT volume, INT speed)
	  INT SOUND_PLAY(INT sound_id)								    -> (overload 1)
          INT SOUND_PLAY(INT sound_id, INT channel)						    -> (overload 2)
	  INT SOUND_PLAY(INT sound_id, INT volume, INT speed, INT loop)				    -> (overload 3)
	  INT SOUND_PLAY(INT sound_id, INT volume, INT speed, INT loop, INT loopcount)		    -> (overload 4)
	  INT SOUND_PLAY(INT sound_id, INT volume, INT speed, INT loop, INT loopcount, INT channel) -> (overload 5)
 	  INT SOUND(INT sound_id, INT volume, INT speed) -> (alias of SOUND_PLAY, LEGACY mode only)
		- LOOP value:
		  -1 = use values setted by SOUND_LOAD or SOUND_SET_LOOP
		   0 = no looping
		   1 = looping
		- LOOPCOUNT value:
		  -1 = use values setted by SOUND_LOAD or SOUND_SET_LOOPCOUNT
		   0 = infinite looping
		   N = N looping
		- VOLUME values:
		  0 to 256
		- SPEED values:
		  0 to 1024

	* INT SOUND_RESERVE_CHANNELS(INT channels)

	* INT SOUND_SET_LOOP(INT sound_id, INT loop, INT update_channels)
		- LOOP values:
		  0 = no looping
		  1 = looping
		- UPDATE_CHANNELS values:
		  0 = no update sound channels playing
		  1 = update sound channels playing

	* INT SOUND_SET_LOOPCOUNT(INT sound_id, INT loopcount, INT update_channels)
		- LOOPCOUNT values:
		  0 = infinite looping
		  N = N looping
		- UPDATE_CHANNELS values:
		  0 = no update sound channels playing
		  1 = update sound channels playing

	* INT SOUND_SET_PAN(INT sound_id, INT pan, INT update_channels)
		- VOLUME values:
		  0 to 512
		- UPDATE_CHANNELS values:
		  0 = no update sound channels playing
		  1 = update sound channels playing

	* INT SOUND_SET_SPEED(INT sound_id, INT speed, INT update_channels)
		- SPEED values:
		  0 to 1024
		- UPDATE_CHANNELS values:
		  0 = no update sound channels playing
		  1 = update sound channels playing

	* INT SOUND_SET_VOLUME(INT sound_id, INT volume, INT update_channels)
		- VOLUME values:
		  0 to 256
		- UPDATE_CHANNELS values:
		  0 = no update sound channels playing
		  1 = update sound channels playing

	* INT UNLOAD_PCM(INT sound_id)(LEGACY mode only)
		- SOUND_ID values:
		  all_sound (-1)
		  or value returned by the LOAD_PCM function

	* INT SOUND_UNLOAD(INT sound_id)
		- SOUND_ID values:
		  all_sound (-1)
		  or value returned by the LOAD_PCM/LOAD_WAV/SOUND_LOAD function

	* INT UNLOAD_WAV(INT sound_id)(LEGACY mode only)
		- SOUND_ID values:
		  all_sound (-1)
		  or value returned by the LOAD_WAV function


// --- SOUND CHANNEL MANAGEMENT ---

	* INT CHANGE_CHANNEL(INT channel_id, INT volume, INT pan)(LEGACY mode only)

	* INT SOUNDCHANNEL_CHANGE(INT channel_id, INT volume, INT speed)
          INT CHANGE_SOUND(INT channel_id, INT volume, INT speed) -> (alias of SOUNDCHANNEL_CHANGE, LEGACY mode only)

	* INT SOUNDCHANNEL_FADE(INT channel_id, INT fade_type, INT ms)
		- FADE_TYPE values:
		  0 = FADE OUT
		  1 = FADE IN
		- MS values:
                  0 = inmediately fade
                  N = N MS (1000 = 1 second)

	* INT SOUNDCHANNEL_FADE_IN(INT channel_id)

	* INT SOUNDCHANNEL_FADE_OUT(INT channel_id)

	* INT SOUNDCHANNEL_GET_FREQUENCY(INT channel_id)

	* INT SOUNDCHANNEL_GET_LOOP(INT channel_id)

	* INT SOUNDCHANNEL_GET_LOOPCOUNT(INT channel_id)

	* DWORD SOUNDCHANNEL_GET_MEMORYUSAGE(INT channel_id, AUDIO_MEMORY_USAGE *memusage)

	* INT SOUNDCHANNEL_GET_PAN(INT channel_id)

	* INT SOUNDCHANNEL_GET_POS(INT channel_id)

	* INT SOUNDCHANNEL_GET_SOUND(INT channel_id)

	* INT SOUNDCHANNEL_GET_SPEED(INT channel_id)

	* INT SOUNDCHANNEL_GET_TIME(INT channel_id)

	* INT SOUNDCHANNEL_GET_TIMEMS(INT channel_id)

	* INT SOUNDCHANNEL_GET_VOLUME(INT channel_id)

	* INT SOUNDCHANNEL_IS_FADING(INT channel_id)

	* INT SOUNDCHANNEL_IS_MUTED(INT channel_id)

	* INT SOUNDCHANNEL_IS_PAUSED(INT channel_id)

	* INT SOUNDCHANNEL_IS_PLAYING(INT channel_id)
          INT IS_PLAYING_SOUND(INT channel_id) -> (alias of SOUNDCHANNEL_IS_PLAYING, LEGACY mode only)

	* INT SOUNDCHANNEL_MUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by the SOUND_PLAY function

	* INT SOUNDCHANNEL_PAUSE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by the SOUND_PLAY function

	* INT SOUNDCHANNEL_RESUME(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by the SOUND_PLAY function

	* INT SOUNDCHANNEL_SET_LOOP(INT channel_id, INT loop)
		- LOOP values:
		  0 = no looping
		  1 = looping (default infinite or set by SET_SOUNDATTRIB_LOOPCOUNT)

	* INT SOUNDCHANNEL_SET_LOOPCOUNT(INT channel_id, INT loopcount)
		- LOOPCOUNT values:
		  0 = infinite looping
		  N = N looping

	* INT SOUNDCHANNEL_SET_PAN(INT channel_id, INT pan)
		- PAN values:
		  0 to 512

	* INT SOUNDCHANNEL_SET_POS(INT channel_id, INT pos)
		- POS values:
		  0 to max value returned by GET_SOUNDATTRIB_SIZE - 1

	* INT SOUNDCHANNEL_SET_SPEED(INT channel_id, INT speed)
		- SPEED values:
		  0 to 1024

	* INT SOUNDCHANNEL_SET_TIME(INT channel_id, INT time)
		- TIME values:
		  0 to max value returned by SOUND_GET_LENGTH - 1

	* INT SOUNDCHANNEL_SET_TIMEMS(INT channel_id, INT timems)
		- TIMEMS values:
		  0 to max value returned by SOUND_GET_LENGTHMS - 1

	* INT SOUNDCHANNEL_SET_VOLUME(INT channel_id, INT volume)
		- VOLUME values:
		  0 to 256

	* INT SOUNDCHANNEL_STOP(INT channel_id)
          INT STOP_SOUND(INT channel_id) -> (alias of SOUNDCHANNEL_STOP, LEGACY mode only)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by the SOUND_PLAY function

	* INT SOUNDCHANNEL_UNMUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by the SOUND_PLAY function


// --- SONG RESOURCE MANAGEMENT (WAV/MP2/MP3/OGG/MOD/S3M/XM/IT/MID) ---

	* INT SONG_GET_CHANNELVOLUME(INT song_id, INT channel_num)
		- CHANNEL_NUM values:
		  0 to value returned by SONG_GET_NUMCHANNELS - 1;
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* STRING SONG_GET_FORMAT(INT song_id)

	* INT SONG_GET_FREQUENCY(INT song_id)

	* INT SONG_GET_LENGTH(INT song_id)

	* INT SONG_GET_LENGTHMS(INT song_id)

	* INT SONG_GET_LOOP(INT song_id)

	* INT SONG_GET_LOOPCOUNT(INT song_id)

	* DWORD SONG_GET_MEMORYUSAGE(INT song_id, AUDIO_MEMORY_USAGE *memusage)

	* STRING SONG_GET_NAME(INT song_id)

	* INT SONG_GET_NUMCHANNELS(INT song_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* INT SONG_GET_NUMORDERS(INT song_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONG_GET_NUMPATTERNS(INT song_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONG_GET_PAN(INT song_id)

	* INT SONG_GET_PANSEP(INT song_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* INT SONG_GET_SIZE(INT song_id)

	* INT SONG_GET_SPEED(INT song_id)

	* STRING SONG_GET_TYPE(INT song_id)

	* INT SONG_GET_VOLUME(INT song_id)

	* INT SONG_IS_CHANNELMUTED(INT song_id, INT channel_num)
		- CHANNEL_NUM values:
		  0 to value returned by SONG_GET_NUMCHANNELS - 1;
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* INT SONG_LOAD(STRING fname, INT loop)
	  INT SONG_LOAD(STRING fname)                          -> (overload 1, loop default = 0)
	  INT SONG_LOAD(STRING fname, INT loop, INT loopcount) -> (overload 2, loopcount 0 = infinite)
	  INT LOAD_SONG(STRING fname, INT loop)                -> (alias of SONG_LOAD, LEGACY mode only)

	* INT SONG_MUTECHANNEL(INT song_id, INT channel_num)
		- SONG_ID values:
		  all_song (-1)
		  or value returned by SONG_PLAY function
		- CHANNEL_NUM values:
		  0 to value returned by SONG_GET_NUMCHANNELS - 1;
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* INT SONG_PLAY(INT song_id)
	  INT SONG_PLAY(INT song_id, INT loop)	      	      -> (overload 1)
	  INT SONG_PLAY(INT song_id, INT loop, INT loopcount) -> (overload 2)
	  INT SONG(INT song_id)                               -> (alias of SONG_PLAY, LEGACY mode only)
		- LOOP value:
		  -1 = use values setted by SONG_LOAD or SONG_SET_LOOP
		   0 = no looping
		   1 = looping
		- LOOPCOUNT value:
		  -1 = use values setted by SONG_LOAD or SONG_SET_LOOPCOUNT
		   0 = infinite looping
		   N = N looping

	* INT SONG_SET_CHANNELVOLUME(INT song_id, INT channel_num, INT volume)
		- SONG_ID values:
		  all_song (-1)
		  or value returned by SONG_PLAY function
		- CHANNEL_NUM values:
		  0 to value returned by SONG_GET_NUMCHANNELS - 1;
		- VOLUME values:
		  0 to 256
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned

	* INT SONG_SET_LOOP(INT song_id, INT loop, INT update_channels)
		- LOOP values:
		  0 = no looping
		  1 = looping
		- UPDATE_CHANNELS values:
		  0 = no update song channels playing
		  1 = update song channels playing

	* INT SONG_SET_LOOPCOUNT(INT song_id, INT loopcount, INT update_channels)
		- LOOPCOUNT values:
		  0 = infinite looping
		  N = N looping
		- UPDATE_CHANNELS values:
		  0 = no update song channels playing
		  1 = update song channels playing

	* INT SONG_SET_PAN(INT song_id, INT pan, INT update_channels)
		- VOLUME values:
		  0 to 512
		- UPDATE_CHANNELS values:
		  0 = no update song channels playing
		  1 = update song channels playing

	* INT SONG_SET_SPEED(INT song_id, INT speed, INT update_channels)
		- SPEED values:
		  0 to 1024
		- UPDATE_CHANNELS values:
		  0 = no update song channels playing
		  1 = update song channels playing

	* INT SONG_SET_VOLUME(INT song_id, INT volume, INT update_channels)
		- VOLUME values:
		  0 to 256
		- UPDATE_CHANNELS values:
		  0 = no update song channels playing
		  1 = update song channels playing

	* INT SONG_UNLOAD(INT song_id)
          INT UNLOAD_SONG(INT song_id) -> (alias of SONG_UNLOAD, LEGACY mode only)
		- SONG_ID values:
		  all_song (-1)
		  or value returned by SONG_LOAD function

	* INT SONG_UNMUTECHANNEL(INT song_id, INT channel_num)
		- SONG_ID values:
		  all_song (-1)
		  or value returned by SONG_PLAY function
		- CHANNEL_NUM values:
		  0 to value returned by SONG_GET_NUMCHANNELS - 1;
	  NOTE: work only if format is: MOD, S3M, XM, IT, MID, otherwise -1 is returned


// --- SONG CHANNEL MANAGEMENT ---

	* INT SONGCHANNEL_FADE(INT channel_id, INT fade_type, INT ms)
		- FADE_TYPE values:
		  0 = FADE OUT
		  1 = FADE IN
		- MS values:
                  0 = inmediately fade
                  N = N MS (1000 = 1 second)

	* INT SONGCHANNEL_FADE_IN(INT channel_id)

	* INT SONGCHANNEL_FADE_OUT(INT channel_id)	

	* INT SONGCHANNEL_GET_FREQUENCY(INT channel_id)

	* INT SONGCHANNEL_GET_LOOP(INT channel_id)

	* INT SONGCHANNEL_GET_LOOPCOUNT(INT channel_id)

	* DWORD SONGCHANNEL_GET_MEMORYUSAGE(INT channel_id, AUDIO_MEMORY_USAGE *memusage)

	* INT SONGCHANNEL_GET_NUMROWS(INT channel_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONGCHANNEL_GET_ORDER(INT channel_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONGCHANNEL_GET_PAN(INT channel_id)

	* INT SONGCHANNEL_GET_PATTERN(INT channel_id)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONGCHANNEL_GET_POS()
	  INT SONGCHANNEL_GET_POS(INT channel_id) -> (overload 1)
	  INT GET_SONG_POS() -> (alias of SONGCHANNEL_GET_POS, LEGACY mode only)

        * INT SONGCHANNEL_GET_ROW()
          INT SONGCHANNEL_GET_ROW(INT channel_id) -> (overload 1)
	  INT GET_SONG_LINE() -> (alias of SONGCHANNEL_GET_ROW, LEGACY mode only)
	  NOTE: work only if format is: MOD, S3M, XM, IT, otherwise -1 is returned

	* INT SONGCHANNEL_GET_SONG(INT channel_id)

	* INT SONGCHANNEL_GET_SPEED(INT channel_id)

	* INT SONGCHANNEL_GET_TIME(INT channel_id)

	* INT SONGCHANNEL_GET_TIMEMS(INT channel_id)

	* INT SONGCHANNEL_GET_VOLUME(INT channel_id)

	* INT SONGCHANNEL_IS_FADING(INT channel_id)

	* INT SONGCHANNEL_IS_MUTED(INT channel_id)

	* INT SONGCHANNEL_IS_PAUSED(INT channel_id)

	* INT SONGCHANNEL_IS_PLAYING()
	  INT SONGCHANNEL_IS_PLAYING(INT channel_id) -> (overload 1)
	  INT IS_PLAYING_SONG() -> (alias of SONGCHANNEL_IS_PLAYING, LEGACY mode only)

	* INT SONGCHANNEL_MUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by SONG_PLAY function

	* INT SONGCHANNEL_PAUSE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by SONG_PLAY function

	* INT SONGCHANNEL_RESUME(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by SONG_PLAY function

	* INT SONGCHANNEL_SET_LOOP(INT channel_id, INT loop)
		- LOOP values:
		  0 = no looping
		  1 = looping (default infinite or set by SONG_SET_LOOPCOUNT)

	* INT SONGCHANNEL_SET_LOOPCOUNT(INT channel_id, INT loopcount)
		- LOOPCOUNT values:
		  0 = infinite looping
		  N = N looping

	* INT SONGCHANNEL_SET_PAN(INT channel_id, INT pan)
		- VOLUME values:
		  0 to 512

	* INT SONGCHANNEL_SET_POS(INT pos)
	  INT SONGCHANNEL_SET_POS(INT channel_id, INT pos) -> (overload 1)
	  INT SET_SONG_POS(INT pos) -> (alias of SONGCHANNEL_SET_POS, LEGACY mode only)

	* INT SONGCHANNEL_SET_SPEED(INT channel_id, INT speed)
		- SPEED values:
		  0 to 1024

	* INT SONGCHANNEL_SET_TIME(INT channel_id, INT time)
		- TIME values:
		  0 to max value returned by SONG_GET_LENGTH - 1

	* INT SONGCHANNEL_SET_TIMEMS(INT channel_id, INT timems)
		- TIMEMS values:
		  0 to max value returned by SONG_GET_LENGTHMS - 1

	* INT SONGCHANNEL_SET_VOLUME(INT channel_id, INT volume)
		- VOLUME values:
		  0 to 256

	* INT SONGCHANNEL_STOP()
	  INT SONGCHANNEL_STOP(INT channel_id) -> (overload 1)
	  INT STOP_SONG() -> (alias of SONGCHANNEL_STOP, LEGACY mode only)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by SONG_PLAY/SONG function

	* INT SONGCHANNEL_UNMUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by SONG_PLAY/SONG function


// --- CD RESOURCE MANAGEMENT (LEGACY mode only) --- 

	* INT CD_GET_LENGTH(INT cd_drive)

	* INT CD_GET_LENGTHMS(INT cd_drive)

	* DWORD CD_GET_MEMORYUSAGE(INT cd_drive, AUDIO_MEMORY_USAGE *memusage)

	* STRING CD_GET_NAME(INT cd_drive)

	* INT CD_GET_NUMTRACKS(INT cd_drive)

	* INT CD_GET_PAN(INT cd_drive)

	* INT CD_GET_SPEED(INT cd_drive)

	* INT CD_GET_VOLUME(INT cd_drive)

        * INT CD_PLAY(INT cd_drive, INT mode)
          INT CD_PLAY(INT cd_drive, INT track, INT mode) -> (overload 1)
	  INT PLAY_CD(INT cd_drive, INT mode) -> (alias of CD_PLAY)
		- MODE values:
		  cd_playonce			(0)
		  cd_playcontinuous		(1)
		  cd_playlooped			(2)
		  cd_playcontinuouslooped	(3)

	* INT CD_SET_PAN(INT cd_drive, INT pan)
		- VOLUME values:
		  0 to 512

	* INT CD_SET_SPEED(INT cd_drive, INT speed)
		- SPEED values:
		  0 to 1024

	* INT CD_SET_VOLUME(INT cd_drive, INT volume)
		- VOLUME values:
		  0 to 256


// --- CD CHANNEL MANAGEMENT ---

	* INT CDCHANNEL_FADE(INT channel_id, INT fade_type, INT ms)
		- FADE_TYPE values:
		  0 = FADE OUT
		  1 = FADE IN
		- MS values:
                  0 = inmediately fade
                  N = N MS (1000 = 1 second)

	* INT CDCHANNEL_FADE_IN(INT channel_id)

	* INT CDCHANNEL_FADE_OUT(INT channel_id)

	* INT CDCHANNEL_GET_DRIVE(INT channel_id)

	* INT CDCHANNEL_GET_FREQUENCY(INT channel_id)

	* DWORD CDCHANNEL_GET_MEMORYUSAGE(INT channel_id, AUDIO_MEMORY_USAGE *memusage)

	* INT CDCHANNEL_GET_MODE(INT channel_id)

	* INT CDCHANNEL_GET_PAN(INT channel_id)

	* INT CDCHANNEL_GET_SPEED(INT channel_id)

	* INT CDCHANNEL_GET_TRACKTIME(INT channel_id)

	* INT CDCHANNEL_GET_TRACKTIMEMS(INT channel_id)

	* INT CDCHANNEL_GET_TRACKLENGTH(INT channel_id)

	* INT CDCHANNEL_GET_TRACKLENGTHMS(INT channel_id)

	* STRING CDCHANNEL_GET_TRACKNAME(INT channel_id)

	* INT CDCHANNEL_GET_TRACKPLAYING(INT channel_id)

	* INT CDCHANNEL_GET_TRACKTIME(INT channel_id)

	* INT CDCHANNEL_GET_TRACKTIMEMS(INT channel_id)

	* INT CDCHANNEL_GET_VOLUME(INT channel_id)

	* INT CDCHANNEL_IS_FADING(INT channel_id)

	* INT CDCHANNEL_IS_MUTED(INT channel_id)

	* INT CDCHANNEL_IS_PAUSED(INT channel_id)

	* INT CDCHANNEL_IS_PLAYING()
	  INT CDCHANNEL_IS_PLAYING(INT channel_id) -> (overload 1)
	  INT IS_PLAYING_CD() -> (alias of CDCHANNEL_IS_PLAYING)

	* INT CDCHANNEL_MUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by CD_PLAY function

	* INT CDCHANNEL_PAUSE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by CD_PLAY function

	* INT CDCHANNEL_RESUME(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by CD_PLAY function

	* INT CDCHANNEL_SET_PAN(INT channel_id, INT pan)
		- VOLUME values:
		  0 to 512

	* INT CDCHANNEL_SET_SPEED(INT channel_id, INT speed)
		- SPEED values:
		  0 to 1024

	* INT CDCHANNEL_SET_TIME(INT channel_id, INT time)
		- TIME values:
		  0 to max value returned by CD_GET_LENGTH - 1

	* INT CDCHANNEL_SET_TIMEMS(INT channel_id, INT timems)
		- TIMEMS values:
		  0 to max value returned by CD_GET_LENGTHMS - 1

	* INT CDCHANNEL_SET_TRACK(INT channel_id, INT track)

	* INT CDCHANNEL_SET_VOLUME(INT channel_id, INT volume)
		- VOLUME values:
		  0 to 256

	* INT CDCHANNEL_STOP(INT channel_id)
	  INT STOP_CD() -> (alias of CDCHANNEL_STOP)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by CD_PLAY function

	* INT CDCHANNEL_UNMUTE(INT channel_id)
		- CHANNEL_ID values:
		  all_channel (-1)
		  or value returned by CD_PLAY function


// --- AUDIO LIBRARY INFORMATION ---

	* INT AUDIOLIB_GET_CDCHANNELS()(LEGACY mode only)

	* INT AUDIOLIB_GET_CDSLOADED()(LEGACY mode only)

	* INT AUDIOLIB_GET_CDSPLAYING()(LEGACY mode only)

	* INT AUDIOLIB_GET_CHANNELSPLAYING()

	* FLOAT AUDIOLIB_GET_CPUUSAGE(AUDIO_CPU_USAGE *cpuusage)

	* INT AUDIOLIB_GET_DRIVER()

	* INT AUDIOLIB_GET_DRIVERNAME()

	* INT AUDIOLIB_GET_HARDWARECHANNELS()

	* DWORD AUDIOLIB_GET_MEMORYUSAGE()

	* INT AUDIOLIB_GET_NUMCDDRIVES()(LEGACY mode only)

	* INT AUDIOLIB_GET_NUMDRIVERS()

	* INT AUDIOLIB_GET_SOFTWARECHANNELS()

	* INT AUDIOLIB_GET_SONGCHANNELS()

	* INT AUDIOLIB_GET_SONGSLOADED()

	* INT AUDIOLIB_GET_SONGSPLAYING()

	* INT AUDIOLIB_GET_SOUNDCHANNELS()

	* INT AUDIOLIB_GET_SOUNDSLOADED()

	* INT AUDIOLIB_GET_SOUNDSPLAYING()



---------------------------
--- STDMAIN
---------------------------
	/* *** CONSTANTS *** */

	* all_process            (-1)
	* c_0		 	 (1)
	* c_1			 (2)
	* c_2			 (4)
	* c_3			 (8)
	* c_4			 (16)
	* c_5			 (32)
	* c_6			 (64)
	* c_7			 (128)
	* c_8			 (256)
	* c_9			 (512)
	* NULL			 (0)
	* true			 (1)
	* false			 (0)
	* min_sbyte		 (-128)
	* max_sbyte		 (127)
	* min_byte		 (0)
	* max_byte		 (255)
	* min_short		 (-32768)
	* max_short		 (32767)
	* min_word		 (0)
	* max_word		 (65535)
	* min_int		 (-2147483648)
	* max_int		 (2147483647)
	* min_dword		 (0)
	* max_dword		 (4294967295)
	* s_behaviour_unknown    (-1)
	* s_behaviour_ignore     (0)
	* s_behaviour_receive    (1)
	* s_kill		 (0)
	* s_wakeup		 (1)
	* s_sleep		 (2)
	* s_freeze		 (3)
	* s_kill_tree		 (100)
	* s_wakeup_tree		 (101)
	* s_sleep_tree		 (102)
	* s_freeze_tree		 (103)
	* _p_wait		 (0)
	* _p_nowait		 (1)
	* os_windows             (0)
	* os_linux		 (1)
	* os_mac		 (2)


	/* *** TYPEDEFS *** */

	* TYPE process_hierarchy
	    INT father   = 0
	    INT son      = 0
	    INT bigbro   = 0
	    INT smallbro = 0
	  END


	/* *** VARIABLES *** */

	* INT max_process_time	(= 500)
	* INT argc	        (= 0)
	* INT *argv	        (= 0)	
	* STRUCT reserved		-> (LOCAL)
	    INT process_id	(= 0)
	    INT id_scan		(= 0)
	    INT process_type	(= 0)
	    INT type_scan	(= 0)
	    INT status		(= 2)
	    INT parameters	(= 0)
	    INT param_offset	(= 0)
	    INT program_index	(= 0)
	    INT stack_pointer	(= 0)
	    INT is_executed	(= 0)
	    INT is_painted	(= 0)
	    INT m8_object	(= -1)
	    INT old_ctype	(= 0)
	    INT frame_percent	(= 0)
	    INT box_x0		(= 0)
	    INT box_y0		(= 0)
	    INT box_x1		(= 0)
	    INT box_y1		(= 0)
	    INT f_count		(= 0)
	    INT caller_id	(= 0)
	    INT param_size      (= 0)
	  END
	* PROCESS_HIERARCHY hierarchy	-> (LOCAL)
	* INT father	(= 0)		-> (field of "hierarchy", LOCAL)
	* INT son	(= 0)		-> (field of "hierarchy", LOCAL)
	* INT smallbro	(= 0)		-> (field of "hierarchy", LOCAL)
	* INT bigbro	(= 0)		-> (field of "hierarchy", LOCAL)
	* INT priority  (= 0)		-> (LOCAL)


	/* *** FUNCTIONS *** */

	* INT EXEC(INT mode, STRING command, STRING args)
		- MODE values:
		  _p_wait	 (0)
		  _p_nowait	 (1)

	* INT EXIT(STRING message, INT return_code)

	* STRING GETENV(STRING env_variable)
		//https://es.wikipedia.org/wiki/Variable_de_entorno
		
	* INT GET_OS()

	* INT IGNORE_ERROR(INT error)

	* INT SYSTEM(STRING command)


// --- PROCESS AND SIGNALS MANAGEMENT ---

	* INT EXISTS(INT process_id)
	  INT EXISTS(TYPE process)

	* INT GET_DISTID(TYPE process, INT x, INT y, INT distmode)
		- distmode values:
                  1 = first near dist ID
                  2 = last near dist ID
                  3 = first exact dist ID
                  4 = last exact dist ID
	* INT GET_ID(TYPE process)
		- process values:
		  process name
                  all_process
                  0

	* INT GET_TYPE(INT process_id)

	* INT LET_ME_ALONE()

	* INT SIGNAL(INT process_id, INT signal)
	  INT SIGNAL(TYPE process, INT signal)
		- SIGNAL values:
		  s_kill		(0)
		  s_wakeup		(1)
		  s_sleep		(2)
		  s_freeze		(3)
		  s_kill_tree		(100)
		  s_wakeup_tree		(101)
		  s_sleep_tree		(102)
		  s_freeze_tree		(103)

	* INT SIGNAL_GET_BEHAVIOUR(INT process_id, INT signal)
		- SIGNAL values:
		  s_kill		(0)
		  s_wakeup		(1)
		  s_sleep		(2)
		  s_freeze		(3)

	* INT SIGNAL_SET_BEHAVIOUR(INT process_id, INT signal, INT behaviour)
	  INT SIGNAL_SET_BEHAVIOUR(TYPE process, INT signal, INT behaviour)
		- SIGNAL values:
		  s_kill		(0)
		  s_wakeup		(1)
		  s_sleep		(2)
		  s_freeze		(3)
		  s_kill_tree		(100)
		  s_wakeup_tree		(101)
		  s_sleep_tree		(102)
		  s_freeze_tree		(103)
		- BEHAVIOUR values:
		  s_behaviour_ignore    (0)
		  s_behaviour_receive   (1)



---------------------------
--- STRINGS
---------------------------
	/* *** FUNCTIONS *** */

	* STRING ASCCODE/CHR(BYTE ascii)

	* INT ASC/CHAR(STRING str)

	* DOUBLE ATOF(STRING str)

	* INT ATOI(STRING str)

	* INT BTOI(STRING str)

	* INT CALCULATE(STRING expression)

	* DOUBLE CALCULATEF(STRING expression)

	* STRING FTOA(DOUBLE num)
	  STRING FTOA(DOUBLE num, INT precision) -> (overload 1)
                - PRECISION values:
                  0 = automatic
                  1 to 128 = N precision

	* INT ISALNUM(STRING char)

	* INT ISALPHA(STRING char)

	* INT ISBINDIGIT(STRING char)

	* INT ISDIGIT(STRING char)

	* INT ISLOWER(STRING char)

	* INT ISNUMDIGIT(INT num)

	* INT ISOCTDIGIT(STRING char)

	* INT ISSTRALNUM(STRING str)

	* INT ISSTRALNUMSPACE(STRING str)

	* INT ISSTRALPHA(STRING str)

	* INT ISSTRBINDIGIT(STRING str)

	* INT ISSTRDIGIT(STRING str)

	* INT ISSTRLOWER(STRING str)

	* INT ISSPACE(STRING char)

	* INT ISSTROCTDIGIT(STRING str)

	* INT ISSTRHEXDIGIT(STRING str)

	* INT ISSIMB(STRING char)

	* INT ISSTRSIMB(STRING str)

	* INT ISSTRSPACE(STRING str)

	* INT ISSTRUPPER(STRING str)

	* INT ISUPPER(STRING char)

	* INT ISHEXDIGIT(STRING char)

	* INT ISHEXLOWER(STRING char)

	* INT ISHEXUPPER(STRING char)

	* STRING ITOA(INT num)

	* STRING ITOB(INT num)

	* STRING LOWER(STRING str)

	* STRING STRCAT(STRING dst, STRING src)
	
	* STRING STRCATNUMS(STRING dst, INT num1, INT num2, INT mode1, INT mode2)

	* STRING STRCATREV(STRING dst, STRING src)

	* INT STRCHR(STRING str, STRING char)

	* INT STRCHRCOUNT(STRING str, STRING chr)

	* STRING STRCHRSTR(STRING str1, STRING str2, STRING char)

	* STRING STRCHRTOCHR(STRING str, STRING char, STRING charNEW)

	* INT STRCMP(STRING str1, STRING str2)

	* STRING STRCPY(STRING dst, STRING src)

	* STRING STRCPYREV(STRING dst, STRING src)

	* INT STRDEL(STRING str, INT start, INT end)

	* INT STRDELCHR(STRING str, STRING strchar)

	* STRING STRDUP(BYTE char, INT num)

	* STRING STRDUPCOUNT(STRING str, INT num)

	* STRING STRFMT(STRING fmt, INT num)

	* INT STRLEN(STRING str)

	* STRING STRLFT(STRING str, INT num)

	* STRING STRLTRM(STRING str)

	* STRING STRMID(STRING str, INT start, INT length)

	* STRING STRNCAT(STRING dst, STRING src, INT num)
	
	* INT STRNCHR(STRING str, STRING char, INT num)

	* INT STRNCMP(STRING str1, STRING str2, INT num)

	* STRING STRNCPY(STRING dst, STRING src, INT num)

	* INT STRNEQCHRS(STRING str1, STRING str2)

	* INT STRNEQLEN(STRING str1, STRING str2)

	* INT STRNEQSPN(STRING str1, STRING str2)

	* STRING STRNSET(STRING str, STRING char, INT num)
 	
	* INT STRNSTR(STRING str, STRING substr, INT num)

	* STRING STRRHT(STRING str, INT num)

	* STRING STRREV(STRING str)

	* STRING STRRTRM(STRING str)

	* STRING STRSECTION(STRING str, STRING substr, INT start)

	* STRING STRSET(STRING str, STRING char)

	* INT STRSTR(STRING str, STRING substr)
	  INT STRSTR(STRING str, STRING substr, INT start) -> (overload 1)

	* INT STRTOKCOUNT(STRING str)

	* STRING STRTRM(STRING str)

	* STRING STRTTRM(STRING str)

	* STRING STRUNIQUE(STRING str)

	* STRING STRUNIQUECHR(STRING str, STRING char)

	* STRING STRXFMT(STRING str, STRING char, INT size, INT num, INT mode)

	* STRING UITOA(DWORD num)

	* STRING UPPER(STRING str)


* See DOC_strings_es or DOC_strings_it for more details



---------------------------
--- TEXT2D
---------------------------
	/* *** CONSTANTS *** */

	* all_fnt			(0)
	* all_text			(0)
	* wri_behaviour_new		(1)
	* wri_behaviour_overwrite	(2)


	/* *** VARIABLES *** */

	* INT text_z (= -256)(LEGACY mode only)
	* RENDER_ENTITY texts (texts.transform.position.z is setted to -256 by default)

	
	/* *** FUNCTIONS *** */

// --- FONT RESOURCE MANAGEMENT ---

	* INT FNT_CLONE(INT fnt_id)

	* INT FNT_CONVERT_PALETTE(INT fnt_id, INT *new_palette, INT update_texts)(LEGACY mode only)
		- UPDATE_TEXTS values:
		  0 = not update texts written
		  1 = update texts written

	* INT FNT_SET_COLOR/COLOUR(INT fnt_id, DWORD old_color, DWORD new_color, INT update_texts)
		- OLD_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function
		- NEW_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function
		- UPDATE_TEXTS values:
		  0 = not update texts written
		  1 = update texts written

	* DWORD FNT_GET_MEMORYUSAGE(INT fnt_id)

	* INT FNT_GET_STRHEIGHT(INT fnt_id, STRING text)

	* INT FNT_GET_STRWIDTH(INT fnt_id, STRING text)

	* INT FNT_LOAD(STRING fname)
	  INT FNT_LOAD(STRING fname, STRING password) -> (overload 1)
	  INT LOAD_FNT(STRING fname) -> (alias of FNT_LOAD, LEGACY mode only)

	* INT FNT_UNLOAD(INT fnt_id)
	  INT UNLOAD_FNT(INT fnt_id) -> (alias of FNT_UNLOAD, LEGACY mode only)
		- FNT_ID values:
		  all_fnt 	(0)
		  or values returned by FNT_LOAD


// --- TEXT MANAGEMENT ---

	* INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, STRING text)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, STRING text, INT update_text)                  -> (overload 1)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, VOID *text)                                    -> (overload 2)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, VOID *text, INT update_text)                   -> (overload 3)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, SBYTE *value)                                  -> (overload 4)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, SBYTE *value, INT update_text)                 -> (overload 5)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, BYTE *value)                                   -> (overload 6)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, BYTE *value, INT update_text)                  -> (overload 7)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, SHORT *value)                                  -> (overload 8)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, SHORT *value, INT update_text)                 -> (overload 9)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, WORD *value)                                   -> (overload 10)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, WORD *value, INT update_text)                  -> (overload 11)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, INT *value)                                    -> (overload 12)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, INT *value, INT update_text)                   -> (overload 13)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, DWORD *value)                                  -> (overload 14)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, DWORD *value, INT update_text)                 -> (overload 15)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, FLOAT *value)                                  -> (overload 16)(LEGACY mode only)
      INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, FLOAT *value, INT update_text)                 -> (overload 17)(LEGACY mode only)
      INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, FLOAT *value, INT update_text, INT precision)  -> (overload 18)(LEGACY mode only)
	  INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, DOUBLE *value)                                 -> (overload 19)(LEGACY mode only)
      INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, DOUBLE *value, INT update_text)                -> (overload 20)(LEGACY mode only)
      INT WRITE(INT fnt_id, INT   x, INT   y, INT anchor, DOUBLE *value, INT update_text, INT precision) -> (overload 21)(LEGACY mode only)
	* INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, STRING text)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, STRING text, INT update_text)                  -> (overload 1)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, VOID *text)                                    -> (overload 2)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, VOID *text, INT update_text)                   -> (overload 3)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, SBYTE *value)                                  -> (overload 4)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, SBYTE *value, INT update_text)                 -> (overload 5)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, BYTE *value)                                   -> (overload 6)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, BYTE *value, INT update_text)                  -> (overload 7)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, SHORT *value)                                  -> (overload 8)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, SHORT *value, INT update_text)                 -> (overload 9)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, WORD *value)                                   -> (overload 10)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, WORD *value, INT update_text)                  -> (overload 11)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, INT *value)                                    -> (overload 12)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, INT *value, INT update_text)                   -> (overload 13)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, DWORD *value)                                  -> (overload 14)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, DWORD *value, INT update_text)                 -> (overload 15)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, FLOAT *value)                                  -> (overload 16)
      INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, FLOAT *value, INT update_text)                 -> (overload 17)
      INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, FLOAT *value, INT update_text, INT precision)  -> (overload 18)
	  INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, DOUBLE *value)                                 -> (overload 19)
      INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, DOUBLE *value, INT update_text)                -> (overload 20)
      INT WRITE(INT fnt_id, FLOAT x, FLOAT y, INT anchor, DOUBLE *value, INT update_text, INT precision) -> (overload 21)
		- ANCHOR values:
		  transform_anchor_cpoint0		(-1)
		  transform_anchor_topleft		(0)
       	  transform_anchor_topcenter		(1)
		  transform_anchor_topright 		(2)
	      transform_anchor_left			(3)
		  transform_anchor_center		(4)
		  transform_anchor_right		(5)
		  transform_anchor_bottomleft		(6)
	      transform_anchor_bottomcenter		(7)
		  transform_anchor_bottomright		(8)
		- UPDATE_TEXT values:
		  0 = updating text off
		  1 = updating text on
         - PRECISION values:
		  0 = automatic
		  1 to 128 = N precision

	* INT WRITE_IN_MAP(INT fnt_id, VOID text, INT anchor)
		- ANCHOR values:
		  transform_anchor_cpoint0		(-1)
		  transform_anchor_topleft		(0)
       		  transform_anchor_topcenter		(1)
		  transform_anchor_topright 		(2)
	          transform_anchor_left			(3)
		  transform_anchor_center		(4)
		  transform_anchor_right		(5)
		  transform_anchor_bottomleft		(6)
	          transform_anchor_bottomcenter		(7)
		  transform_anchor_bottomright		(8)

	* INT WRITE_INT(INT fnt_id, INT x, INT y, INT anchor, INT *value) -> (DEPRECATED, use WRITE overload instead, LEGACY mode only)
		- ANCHOR values:
		  transform_anchor_cpoint0		(-1)
		  transform_anchor_topleft		(0)
       		  transform_anchor_topcenter		(1)
		  transform_anchor_topright 		(2)
	          transform_anchor_left			(3)
		  transform_anchor_center		(4)
		  transform_anchor_right		(5)
		  transform_anchor_bottomleft		(6)
	          transform_anchor_bottomcenter		(7)
		  transform_anchor_bottomright		(8)
		- UPDATE_TEXT values:
		  0 = updating text off
		  1 = updating text on

	// - ACTION -
	* INT TEXT_DELETE(INT text_id)
	* INT DELETE_TEXT(INT text_id) -> (alias of TEXT_DELETE, LEGACY mode only)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions

	* INT TEXT_EXISTS(INT text_id)

	* INT TEXT_FIX(INT text_id, INT fix)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- FIX values:
		  0 = unfix the text
		  1 = fix the text

	* INT TEXT_IS_FIXED(INT text_id)

	// - ASSET -
	* INT TEXT_GET_FNT(INT text_id)

	* INT TEXT_GET_TARGET(INT text_id, INT *targetfile, INT *target_graph)

	// - VISIBILITY -
	* INT TEXT_GET_CTYPE(INT text_id)

	* INT TEXT_GET_CNUMBER(INT text_id)

	* INT TEXT_GET_REGION(INT text_id)

	* INT TEXT_GET_VISIBLE(INT text_id);

	// - TRANSFORM.SET -
	* INT TEXT_GET_ANCHOR(INT text_id)

	* INT TEXT_GET_FLAGS(INT text_id)

	* INT TEXT_GET_ORDER(INT text_id)

	* INT TEXT_GET_RESOLUTION(INT text_id)

	// - TRANSFORM.POSITION -
	* INT TEXT_GET_X(INT text_id)

	* INT TEXT_GET_Y(INT text_id)

	* INT   TEXT_GET_Z(INT text_id) -> (LEGACY mode only)
	* FLOAT TEXT_GET_Z(INT text_id)

	* INT   TEXT_GET_POSITION(INT text_id, INT   *x, INT   *y, INT   *z) -> (LEGACY mode only)
	  IVEC3 TEXT_GET_POSITION(INT text_id) -> (overload 1)(LEGACY mode only)
	* INT   TEXT_GET_POSITION(INT text_id, FLOAT *x, FLOAT *y, FLOAT *z)
	  VEC3  TEXT_GET_POSITION(INT text_id) -> (overload 1)

	// - TRANSFORM.ROTATION -
	* INT   TEXT_GET_ROTATION(INT text_id, INT   *rotation_x, INT   *rotation_y, INT   *rotation_z) -> (LEGACY mode only)
	  IVEC3 TEXT_GET_ROTATION(INT text_id) -> (overload 1)(LEGACY mode only)
	* INT   TEXT_GET_ROTATION(INT text_id, FLOAT *rotation_x, FLOAT *rotation_y, FLOAT *rotation_z)
	  VEC3  TEXT_GET_ROTATION(INT text_id) -> (overload 1)

	// - TRANSFORM.SCALE -
	* INT   TEXT_GET_SCALE(INT text_id, INT   *scale_x, INT   *scale_y) -> (LEGACY mode only)
	  IVEC2 TEXT_GET_SCALE(INT text_id) -> (overload 1)(LEGACY Mode only)
	* INT   TEXT_GET_SCALE(INT text_id, FLOAT *scale_x, FLOAT *scale_y)
	  VEC2  TEXT_GET_SCALE(INT text_id)

	// - TRANSFORM.SHEAR -
	* INT   TEXT_GET_SHEAR(INT text_id, INT   *shear_x, INT   *shear_y) -> (LEGACY mode only)
	  IVEC2 TEXT_GET_SHEAR(INT text_id) -> (overload 1)(LEGACY Mode only)
	* INT   TEXT_GET_SHEAR(INT text_id, FLOAT *shear_x, FLOAT *shear_y)
	  VEC2  TEXT_GET_SHEAR(INT text_id)

	// - FX -
	* INT       TEXT_GET_ALPHA(INT text_id)
	* INT       TEXT_GET_FX(INT text_id, INT *fxmode, INT *fxref)
	  RENDER_FX TEXT_GET_FX(INT text_id) -> (overload 1)
	* INT       TEXT_GET_FILTER(INT text_id) -> (MODERN Mode only at the moment)

	// - MISC -
	* INT TEXT_GET_TYPE(INT text_id)

	* STRING TEXT_GET_VALUE(INT text_id)

	* INT TEXT_GET_WIDTH(INT text_id)

	* INT TEXT_GET_HEIGHT(INT text_id)

	// - LOCK -
	* INT TEXT_LOCK(INT text_id)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- call this before any TEXT_SET_XXX function

	* INT TEXT_UNLOCK(INT text_id)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- call this if do not want lock

	* INT TEXT_IS_LOCKED(INT text_id)

	// - ASSET - (SET)
	* INT TEXT_SET_TARGET(INT text_id, INT target_file, INT target_graph)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions

	// - VISIBILITY - (SET)
	* INT TEXT_SET_CTYPE(INT text_id, INT ctype)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- CTYPE values:
		  c_screen	(0) 
		  c_scroll	(1)
		  c_m7		(2)

	* INT TEXT_SET_CNUMBER(INT text_id, INT cnumber)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- CNUMBER values:
		  c_0 to c_9

	* INT TEXT_SET_REGION(INT text_id, INT region)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- REGION values:
		  0 to 65536

	* INT TEXT_SET_VISIBLE(INT text_id, INT visible)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- visible values:
		  0 = no visible
                  1 = visible

	// - TRANSFORM.SET - (SET)
	* INT TEXT_SET_ANCHOR(INT text_id, INT transform_anchor)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- ANCHOR values:
		  transform_anchor_cpoint0		(-1)
		  transform_anchor_topleft		(0)
       		  transform_anchor_topcenter		(1)
		  transform_anchor_topright 		(2)
	          transform_anchor_left			(3)
		  transform_anchor_center		(4)
		  transform_anchor_right		(5)
		  transform_anchor_bottomleft		(6)
	          transform_anchor_bottomcenter		(7)
		  transform_anchor_bottomright		(8)

	* INT TEXT_SET_FLAGS(INT text_id, INT flags)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- FLAGS values:
		   0 = normal
		   1 = hmirror
		   2 = vmirror
		   3 = hvmirror
		   4 = ghost
		   5 = ghost hmirror
		   6 = ghost vmirror
		   7 = ghost hvmirror
		   8 = nokey
		   9 = nokey hmirror
		  10 = nokey vmirror
		  11 = nokey hvmirror

	* INT TEXT_SET_ORDER(INT text_id, INT transform_order)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- TFMORDER values:
		  transform_order_hsr       (0)
		  transform_order_hrs       (1)
		  transform_order_shr       (2)
		  transform_order_srh       (3)
		  transform_order_rhs       (4)
		  transform_order_rsh       (5)

	* INT TEXT_SET_RESOLUTION(INT text_id, INT resolution)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- RESOLUTION values:
		  INT 32

	// - TRANSFORM.POSITION - (SET)
	* INT TEXT_MOVE(INT text_id, INT x, INT y)
	  INT MOVE_TEXT(INT text_id, INT x, INT y) -> (alias of TEXT_MOVE, LEGACY mode only)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions

	* INT TEXT_SET_Z(INT text_id, INT z) (LEGACY mode only)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- Z values:
		  INT 32 range
	* INT TEXT_SET_Z(INT text_id, FLOAT z)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- Z values:
		  FLOAT 32 range

	// - TRANSFORM.ROTATION - (SET)
	* INT TEXT_SET_ROTATION(INT text_id, INT rotation_x, INT rotation_y, INT rotation_z) (LEGACY mode only)
	  INT TEXT_SET_ROTATION(INT text_id, IVEC3 rotation) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- ROTATION_X/Y/Z/IVEC3 values:
		  INT 32 range
	* INT TEXT_SET_ROTATION(INT text_id, FLOAT rotation_x, FLOAT rotation_y, FLOAT rotation_z)
	  INT TEXT_SET_ROTATION(INT text_id, VEC3 rotation) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- ROTATION_X/Y/Z/VEC3 values:
		  FLOAT 32 range

	// - TRANSFORM.SCALE - (SET)
	* INT TEXT_SET_SCALE(INT text_id, INT scale_x, INT scale_y) (LEGACY mode only)
	  INT TEXT_SET_SCALE(INT text_id, IVEC2 scale) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- SCALE_X/Y/IVEC2 values:
		  INT 32 range
	* INT TEXT_SET_SCALE(INT text_id, FLOAT scale_x, FLOAT scale_y)
	  INT TEXT_SET_SCALE(INT text_id, VEC3 scale) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- SCALE_X/Y/Z/VEC2 values:
		  FLOAT 32 range

	// - TRANSFORM.SHEAR - (SET)
	* INT TEXT_SET_SHEAR(INT text_id, INT shear_x, INT shear_y) (LEGACY mode only)
	  INT TEXT_SET_SHEAR(INT text_id, IVEC2 shear) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- SHEAR_X/Y/IVEC2 values:
		  INT 32 range
	* INT TEXT_SET_SHEAR(INT text_id, FLOAT shear_x, FLOAT shear_y)
	  INT TEXT_SET_SHEAR(INT text_id, VEC3 shear) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- SHEAR_X/Y/Z/VEC2 values:
		  FLOAT 32 range

	// - FX -
	* INT TEXT_SET_ALPHA(INT text_id, INT alpha)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- ALPHA values:
		  0 to 255

	* INT TEXT_SET_FX(INT text_id, INT fxmode, INT *fxref)	  
	  INT TEXT_SET_FX(INT text_id, RENDER_FX fx) -> (overload 1)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- FXMODE values:
		  fx_solid				(0)
		  fx_alphacomposite_src			(1)
		  fx_alphacomposite_dst			(2)
		  fx_alphacomposite_srcover		(3)
		  fx_alphacomposite_dstover		(4)
		  fx_alphacomposite_srcin		(5)
		  fx_alphacomposite_dstin		(6)
		  fx_alphacomposite_srcout		(7)
		  fx_alphacomposite_dstout		(8)
		  fx_alphacomposite_srcatop		(9)
		  fx_alphacomposite_dstatop		(10)
		  fx_alphacomposite_clear		(11)
		  fx_alphacomposite_xor 		(12)
		  fx_blend_add				(13)(work only on 16/32bits)
		  fx_blend_subtract			(14)(work only on 16/32bits)
		  fx_blend_multiply			(15)(work only on 16/32bits)
		  fx_blend_average			(16)(work only on 16/32bits)
		  fx_blend_screen			(17)(work only on 16/32bits)
		  fx_blend_r				(18)(work only on 16/32bits)
		  fx_blend_g				(19)(work only on 16/32bits)
		  fx_blend_b				(20)(work only on 16/32bits)
		  fx_blend_rg				(21)(work only on 16/32bits)
		  fx_blend_rb				(22)(work only on 16/32bits)
		  fx_blend_gb				(23)(work only on 16/32bits)
		  fx_blend_lighten			(24)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_darken			(25)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_lightercolor			(26)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_darkercolor			(27)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_colordodge			(28)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_colorburn			(29)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_overlay			(30)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_softlight			(31)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_hardlight			(32)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_linearlight			(33)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_vividlight			(34)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_pinlight			(35)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_hardmix			(36)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_difference			(37)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_negation			(38)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_exclusion			(39)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_reflect			(40)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_glow				(41)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_phoenix			(42)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_hue				(43)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_saturation			(44)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_color			(45)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_blend_luminosity			(46)(work only on 16/32bits, MODERN mode only at the moment)
		  fx_invert				(1001)(work only on 16/32bits)
		  fx_invert_r				(1002)(work only on 16/32bits)
		  fx_invert_g				(1003)(work only on 16/32bits)
		  fx_invert_b				(1004)(work only on 16/32bits)
		  fx_invert_rg				(1005)(work only on 16/32bits)
		  fx_invert_rb				(1006)(work only on 16/32bits)
		  fx_invert_gb				(1007)(work only on 16/32bits)
		  fx_grayscale				(1008)(work only on 16/32bits)
		  fx_greyscale				(1008)(work only on 16/32bits)(UK name)
		  fx_scale_r				(1009)(work only on 16/32bits)
		  fx_scale_g				(1010)(work only on 16/32bits)
		  fx_scale_b				(1011)(work only on 16/32bits)
		  fx_scale_rg				(1012)(work only on 16/32bits)
		  fx_scale_rb				(1013)(work only on 16/32bits)
		  fx_scale_gb				(1014)(work only on 16/32bits)
		  fx_advanced_tint			(0x3FFFFFFF)(work only on 16/32bits)

	* INT TEXT_SET_FILTER(INT text_id, INT filter) (MODERN mode only at the moment)
		- TEXT_ID values:
		  all_text 	(0)
		  or values returned by WRITE s functions
		- FILTER values:
		  0 = Nearest
		  1 = Linear

	// - MISC -
	* INT TEXT_SET_COLOR/COLOUR(INT text_id, DWORD old_color, DWORD new_color)
		- OLD_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function
		- NEW_COLOR values:
		  0 to 255 on 8bits (LEGACY mode only)
		  0 to 65535 on 16bits or values returned by RGB function (LEGACY mode only)
		  0 to 16777215 on 32bits or values returned by RGB function


// --- WRITER MANAGEMENT ---

	* INT WRITER_GET_BEHAVIOUR()

	* INT WRITER_SET_BEHAVIOUR(INT behaviour)
		- BEHAVIOUR values:
		  wri_behaviour_new		(1)
		  wri_behaviour_overwrite	(2)


// --- GRAPHICS OPERATIONS ---

	* INT RENDER_TEXT(RENDER_ENTITY entity_text)
	  INT RENDER_TEXT(RENDER_ENTITY entity_text, STRING text) -> (overload 1)


// --- TEXT LIBRARY INFORMATION ---

	* INT TEXTLIB_GET_FNTSLOADED()

	* INT TEXTLIB_GET_TEXTSFIXED()

	* INT TEXTLIB_GET_TEXTSLOCKED()

	* INT TEXTLIB_GET_TEXTSWRITTEN()



---------------------------
--- TIMERS
---------------------------
	/* *** CONSTANTS *** */

	* clocks_sec			(1000)
	* date_digit			(1)
	* date_fulldigit		(2)
	* date_monthname		(3)
	* date_fullmonthname		(4)
	* date_weekdaymonthname		(5)
	* date_weekdayfullmonthname	(6)
	* date_fullweekdaymonthname	(7)
	* timer_status_off		(0)
	* timer_status_on		(1)


	/* *** VARIABLES *** */
	
	* INT timer_status	(= 1)
		- values:
		  timer_status_off	(0)
		  timer_status_on	(1)
	* INT timer[10]		(= 0)


	/* *** FUNCTIONS *** */

	* INT CLOCK()

	* INT GET_SECS()

	* INT GET_MILLISECS()

	* STRING GET_TIME()

	* STRING GET_DATE(INT format)
		- FORMAT values:
	 	  date_digit			(1)
		  date_fulldigit		(2)
		  date_monthname		(3)
		  date_fullmonthname		(4)
		  date_weekdaymonthname		(5)
		  date_weekdayfullmonthname	(6)
		  date_fullweekdaymonthname	(7)



---------------------------
--- TWEEN
---------------------------
	/* *** CONSTANTS *** */

	* all_tween			(0)
	* all_tweengroup		(0)

	* tween_paused			(0)
	* tween_playing			(1)
	* tween_stopped 		(2)
	* tween_autoplay		(1)

	* tween_ease_none		(0)
	* tween_ease_in			(1)
	* tween_ease_out		(2)
	* tween_ease_inout		(3)
	* tween_ease_outin		(4)

	* tween_move_first		(-1)
	* tween_move_last		(-2)
	* tween_move_backward		(-3)
	* tween_move_forward		(-4)

	* tween_loop_none		(0)
	* tween_loop_infinite		(-1)

	* tween_type_linear		(0)
	* tween_type_quad		(1)
	* tween_type_cubic		(2)
	* tween_type_quart		(3)
	* tween_type_quint		(4)
	* tween_type_sine		(5)
	* tween_type_exp		(6)
	* tween_type_circ		(7)
	* tween_type_back		(8)
	* tween_type_bounce		(9)
	* tween_type_elastic		(10)

	* tweengroup_type_parallel	(0)
	* tweengroup_type_sequential	(1)


	/* *** FUNCTIONS *** */

// --- TWEEN MANAGEMENT ---

	* INT TWEEN_DELETE(INT tween_id)
		- TWEEN_ID values:
		  all_tween	(0)
		  or value returned by TWEEN_NEW or TWEENGROUP_DETACH_TWEEN function

	* INT TWEEN_EXISTS(INT tween_id)

	* FLOAT TWEEN_GET_AMPLITUDE(INT tween_id)
	  FLOAT TWEEN_GET_AMPLITUDE(INT tweengroup_id, INT tween_id) -> (overload 1)

	* INT TWEEN_GET_DURATION(INT tween_id)
	  INT TWEEN_GET_DURATION(INT tweengroup_id, INT tween_id) -> (overload 1)

	* INT TWEEN_GET_EASING(INT tween_id)
	  INT TWEEN_GET_EASING(INT tweengroup_id, INT tween_id) -> (overload 1)

	* FLOAT TWEEN_GET_END(INT tween_id)
	  FLOAT TWEEN_GET_END(INT tweengroup_id, INT tween_id) -> (overload 1)

	* INT TWEEN_GET_LOOP(INT tween_id)

	* INT TWEEN_GET_LOOPCOUNT(INT tween_id)

	* FLOAT TWEEN_GET_OVERSHOOT(INT tween_id)
	  FLOAT TWEEN_GET_OVERSHOOT(INT tweengroup_id, INT tween_id) -> (overload 1)

	* FLOAT TWEEN_GET_PERIOD(INT tween_id)
	  FLOAT TWEEN_GET_PERIOD(INT tweengroup_id, INT tween_id) -> (overload 1)

	* FLOAT TWEEN_GET_START(INT tween_id)
	  FLOAT TWEEN_GET_START(INT tweengroup_id, INT tween_id) -> (overload 1)

	* INT TWEEN_GET_STATUS(INT tween_id)

	* INT TWEEN_GET_TYPE(INT tween_id)
	  INT TWEEN_GET_TYPE(INT tweengroup_id, INT tween_id) -> (overload 1)

	* INT TWEEN_IS_PLAYING(INT tween_id)

	* INT TWEEN_NEW(<type> *target, <type> start_value, <type> end_value, INT duration, INT tween_type, INT easing_mode, INT autoplay, INT loop)
	  INT TWEEN_NEW(<type> *target, <type> start_value, <type> end_value, INT duration, INT tween_type, INT easing_mode, INT autoplay, INT loop, INT target_init) -> (overload 1)
		- TWEEN_TYPE values: 
		  tween_type_linear		(0)
		  tween_type_quad		(1)
		  tween_type_cubic		(2)
		  tween_type_quart		(3)
		  tween_type_quint		(4)
		  tween_type_sine		(5)
		  tween_type_exp		(6)
		  tween_type_circ		(7)
		  tween_type_back		(8)
		  tween_type_bounce		(9)
		  tween_type_elastic		(10)
		- EASING_MODE values:
		  tween_ease_none		(0)
		  tween_ease_in			(1)
		  tween_ease_out		(2)
		  tween_ease_inout		(3)
		  tween_ease_outin		(4)
		- AUTOPLAY values:
		  0 = no autoplaying
		  1 = autoplaying
		- LOOP values:
		  tween_loop_none		(0)
		  tween_loop_infinite		(-1)
		- TARGET_INIT values:
		  tween_target_init_off		(0)
		  tween_target_init_on		(1)

	* INT TWEEN_PAUSE(INT tween_id)
		- TWEEN_ID values:
		  all_tween	(0)
		  or value returned by TWEEN_NEW or TWEENGROUP_DETACH_TWEEN function
	
	* INT TWEEN_PLAY(INT tween_id)
		- TWEEN_ID values:
		  all_tween	(0)
		  or value returned by TWEEN_NEW or TWEENGROUP_DETACH_TWEEN function

	* INT TWEEN_RESUME(INT tween_id)
		- TWEEN_ID values:
		  all_tween	(0)
		  or value returned by TWEEN_NEW or TWEENGROUP_DETACH_TWEEN function

	* FLOAT TWEEN_SET_AMPLITUDE(INT tween_id, FLOAT start_value)
	  FLOAT TWEEN_SET_AMPLITUDE(INT tweengroup_id, INT tween_id, FLOAT amplitude) -> (overload 1)

	* INT TWEEN_SET_DURATION(INT tween_id, INT duration)
	  INT TWEEN_SET_DURATION(INT tweengroup_id, INT tween_id, INT duration) -> (overload 1)

	* INT TWEEN_SET_EASING(INT tween_id, INT type)
	  INT TWEEN_SET_EASING(INT tweengroup_id, INT tween_id, INT easing_mode) -> (overload 1)
		- EASING_MODE values:
		  tween_ease_none		(0)
		  tween_ease_in			(1)
		  tween_ease_out		(2)
		  tween_ease_inout		(3)
		  tween_ease_outin		(4)

	* FLOAT TWEEN_SET_END(INT tween_id, FLOAT end_value)
	  FLOAT TWEEN_SET_END(INT tweengroup_id, INT tween_id, FLOAT end_value) -> (overload 1)

	* INT TWEEN_SET_LOOP(INT tween_id, INT loop)
		- LOOP values:
		  tween_loop_none		(0)
		  tween_loop_infinite		(-1)

	* FLOAT TWEEN_SET_OVERSHOOT(INT tween_id, FLOAT overshoot)
	  FLOAT TWEEN_SET_OVERSHOOT(INT tweengroup_id, INT tween_id, FLOAT overshoot) -> (overload 1)

	* FLOAT TWEEN_SET_PERIOD(INT tween_id, FLOAT period)
	  FLOAT TWEEN_SET_PERIOD(INT tweengroup_id, INT tween_id, FLOAT period) -> (overload 1)

	* FLOAT TWEEN_SET_START(INT tween_id, FLOAT start_value)
	  FLOAT TWEEN_SET_START(INT tweengroup_id, INT tween_id, FLOAT start_value) -> (overload 1)

	* INT TWEEN_SET_TYPE(INT tween_id, INT type)
	  INT TWEEN_SET_TYPE(INT tweengroup_id, INT tween_id, INT type) -> (overload 1)
		- TYPE values: 
		  tween_type_linear		(0)
		  tween_type_quad		(1)
		  tween_type_cubic		(2)
		  tween_type_quart		(3)
		  tween_type_quint		(4)
		  tween_type_sine		(5)
		  tween_type_exp		(6)
		  tween_type_circ		(7)
		  tween_type_back		(8)
		  tween_type_bounce		(9)
		  tween_type_elastic		(10)

	* INT TWEEN_STOP(INT tween_id)
		- TWEEN_ID values:
		  all_tween	(0)
		  or value returned by TWEEN_NEW or TWEENGROUP_DETACH_TWEEN function


// --- TWEENGROUP MANAGEMENT ---

	* INT TWEENGROUP_DELETE(INT tweengroup_id)
		- TWEENGROUP_ID values:
		  all_tweengroup	(0)
		  or value returned by TWEENGROUP_NEW function

	* INT TWEENGROUP_EXISTS(INT tweengroup_id)

	* INT TWEENGROUP_GET_NUMTWEENS(INT tweengroup_id)

	* INT TWEENGROUP_GET_LOOP(INT tweengroup_id)

	* INT TWEENGROUP_GET_LOOPCOUNT(INT tweengroup_id)

	* INT TWEENGROUP_GET_STATUS(INT tweengroup_id)

	* INT TWEENGROUP_GET_TWEENPLAYING(INT tweengroup_id)

	* INT TWEENGROUP_GET_TYPE(INT tweengroup_id)

	* INT TWEENGROUP_IS_PLAYING(INT tweengroup_id)

	* INT TWEENGROUP_NEW(INT tweengroup_type)
		- TWEENGROUP_TYPE values:	
		  tweengroup_type_parallel	(0)
		  tweengroup_type_sequential	(1)

	* INT TWEENGROUP_PAUSE(INT tweengroup_id)
		- TWEENGROUP_ID values:
		  all_tweengroup	(0)
		  or value returned by TWEENGROUP_NEW function

	* INT TWEENGROUP_PLAY(INT tweengroup_id)
		- TWEENGROUP_ID values:
		  all_tweengroup	(0)
		  or value returned by TWEENGROUP_NEW function

	* INT TWEENGROUP_RESUME(INT tweengroup_id)
		- TWEENGROUP_ID values:
		  all_tweengroup	(0)
		  or value returned by TWEENGROUP_NEW function

	* INT TWEENGROUP_SET_LOOP(INT tweengroup_id, INT loop)
		- LOOP values:
		  tween_loop_none		(0)
		  tween_loop_infinite		(-1)

	* INT TWEENGROUP_STOP(INT tweengroup_id)
		- TWEENGROUP_ID values:
		  all_tweengroup	(0)
		  or value returned by TWEENGROUP_NEW function


// --- TWEENGROUP - TWEEN MANAGEMENT ---

	* INT TWEENGROUP_ATTACH_TWEEN(INT tweengroup_id, INT tween_id)
	  INT TWEENGROUP_ATTACH_TWEEN(INT tweengroup_id, <type> *target, <type> start_value, <type> end_value, INT duration, INT tween_type, INT easing_mode) -> (overload 1)
	  INT TWEENGROUP_ATTACH_TWEEN(INT tweengroup_id, <type> *target, <type> start_value, <type> end_value, INT duration, INT tween_type, INT easing_mode, INT target_init) -> (overload 2)
		- TWEEN_TYPE values: 
		  tween_type_linear		(0)
		  tween_type_quad		(1)
		  tween_type_cubic		(2)
		  tween_type_quart		(3)
		  tween_type_quint		(4)
		  tween_type_sine		(5)
		  tween_type_exp		(6)
		  tween_type_circ		(7)
		  tween_type_back		(8)
		  tween_type_bounce		(9)
		  tween_type_elastic		(10)
		- EASING_MODE values:
		  tween_ease_none		(0)
		  tween_ease_in			(1)
		  tween_ease_out		(2)
		  tween_ease_inout		(3)
		  tween_ease_outin		(4)
		- TARGET_INIT values:
		  tween_target_init_off		(0)
		  tween_target_init_on		(1)

	* INT TWEENGROUP_DELETE_TWEEN(INT tweengroup_id, INT tween_id)

	* INT TWEENGROUP_DETACH_TWEEN(INT tweengroup_id, INT tween_id)

	* INT TWEENGROUP_MOVE_TWEEN(INT tweengroup_id, INT tween_id, INT new_position)
		- NEW_POSITION values:
		  tween_move_first		(-1)
		  tween_move_last		(-2)
		  tween_move_backward		(-3)
		  tween_move_forward		(-4)
	
	* INT TWEENGROUP_TWEEN_EXISTS(INT tweengroup_id, INT tween_id)


// --- GENERIC ---

	* FLOAT TWEEN_INTERPOLATE(FLOAT start_value, FLOAT end_value, FLOAT duration, FLOAT time,
                                  INT tween_type, INT easing_mode)
	  FLOAT TWEEN_INTERPOLATE(FLOAT start_value, FLOAT end_value, FLOAT duration, FLOAT time,
                                  INT tween_type, INT easing_mode,
                                  FLOAT overshoot, FLOAT amplitude, FLOAT period) -> (overload 1)
		- TWEEN_TYPE values: 
		  tween_type_linear		(0)
		  tween_type_quad		(1)
		  tween_type_cubic		(2)
		  tween_type_quart		(3)
		  tween_type_quint		(4)
		  tween_type_sine		(5)
		  tween_type_exp		(6)
		  tween_type_circ		(7)
		  tween_type_back		(8)
		  tween_type_bounce		(9)
		  tween_type_elastic		(10)
		- EASING_MODE values:
		  tween_ease_none		(0)
		  tween_ease_in			(1)
		  tween_ease_out		(2)
		  tween_ease_inout		(3)
		  tween_ease_outin		(4)


// --- TWEEN LIBRARY INFORMATION ---

	* INT TWEENLIB_GET_NUMTWEENS()

	* INT TWEENLIB_GET_NUMTWEENGROUPS()

	* INT TWEENLIB_GET_TWEENSPLAYING()

	* INT TWEENLIB_GET_TWEENGROUPSPLAYING()



---------------------------
--- URL
---------------------------
	/* *** CONSTANTS *** */

	* all_url                           (-1)

	* urlopt_accepttimeout_ms           (212)
	* urlopt_accept_encoding            (10102)
	* urlopt_address_scope              (171)
	* urlopt_append                     (50)
	* urlopt_autoreferer                (58)
	* urlopt_buffersize                 (98)
	* urlopt_cainfo                     (10065)
	* urlopt_capath                     (10097)
	* urlopt_certinfo                   (172)
	* urlopt_chunk_bgn_function         (20198)
	* urlopt_chunk_data                 (10201)
	* urlopt_chunk_end_function         (20199)
	* urlopt_closepolicy                (72)
	* urlopt_closesocketdata            (10209)
	* urlopt_closesocketfunction        (20208)
	* urlopt_connecttimeout             (78)
	* urlopt_connecttimeout_ms          (156)
	* urlopt_connect_only               (141)
	* urlopt_conv_from_network_function (20142)
	* urlopt_conv_from_utf8_function    (20144)
	* urlopt_conv_to_network_function   (20143)
	* urlopt_cookie                     (10022)
	* urlopt_cookiefile                 (10031)
	* urlopt_cookiejar                  (10082)
	* urlopt_cookielist                 (10135)
	* urlopt_cookiesession              (96)
	* urlopt_copypostfields             (10165)
	* urlopt_crlf                       (27)
	* urlopt_crlfile                    (10169)
	* urlopt_customrequest              (10036)
	* urlopt_debugdata                  (10095)
	* urlopt_debuginfo                  (20094)
	* urlopt_dirlistonly                (48)
	* urlopt_dns_cache_timeout          (92)
	* urlopt_dns_servers                (10211)
	* urlopt_dns_use_global_cache       (91)
	* urlopt_egdsocket                  (10077)
	* urlopt_encoding                   (10102)
	* urlopt_errorbuffer                (10010)
	* urlopt_failonerror                (45)
	* urlopt_file                       (10001)
	* urlopt_filetime                   (69)
	* urlopt_fnmatch_data               (10202)
	* urlopt_fnmatch_function           (20200)        
	* urlopt_followlocation             (52)
	* urlopt_forbid_reuse               (75)
	* urlopt_fresh_connect              (74)
	* urlopt_ftpappend                  (50)
	* urlopt_ftplistonly                (48)
	* urlopt_ftpport                    (10017)
	* urlopt_ftpsslauth                 (129)
	* urlopt_ftp_account                (10134)
	* urlopt_ftp_alternative_to_user    (10147)
	* urlopt_ftp_create_missing_dirs    (110)
	* urlopt_ftp_filemethod             (138)
	* urlopt_ftp_response_timeout       (112)
	* urlopt_ftp_skip_pasv_ip           (137)
	* urlopt_ftp_ssl                    (119)
	* urlopt_ftp_ssl_ccc                (154)
	* urlopt_ftp_use_eprt               (106)
	* urlopt_ftp_use_epsv               (85)
	* urlopt_ftp_use_pret               (188)
	* urlopt_gssapi_delegation          (210)
	* urlopt_header                     (42)
	* urlopt_headerdata                 (10029)
	* urlopt_headerfunction             (20079)
	* urlopt_http200aliases             (10104)
	* urlopt_httpauth                   (107)
	* urlopt_httpget                    (80)
	* urlopt_httpheader                 (10023)
	* urlopt_httppost                   (10024)
	* urlopt_httpproxytunnel            (61)
	* urlopt_http_content_encoding      (158)
	* urlopt_http_transfer_decoding     (157)
	* urlopt_http_version               (84)
	* urlopt_ignore_content_length      (136)
	* urlopt_infile                     (10009)
	* urlopt_infilesize                 (14)
	* urlopt_infilesize_large           (30115)
	* urlopt_interface                  (10062)
	* urlopt_interleavedata             (10195)
	* urlopt_interleavefunction         (20196)
	* urlopt_ioctldata                  (10131)
	* urlopt_ioctlfunction              (20130)
	* urlopt_ipresolve                  (113)
	* urlopt_issuercert                 (10170)
	* urlopt_keypasswd                  (10026)
	* urlopt_krb4level                  (10063)
	* urlopt_krblevel                   (10063)
	* urlopt_localport                  (139)
	* urlopt_localportrange             (140)
	* urlopt_low_speed_limit            (19)
	* urlopt_low_speed_time             (20)
	* urlopt_mail_auth                  (10217)
	* urlopt_mail_from                  (10186)
	* urlopt_mail_rcpt                  (10187)
	* urlopt_maxconnects                (71)
	* urlopt_maxfilesize                (114)
	* urlopt_maxfilesize_large          (30117)
	* urlopt_maxredirs                  (68)
	* urlopt_max_recv_speed_large       (30146)
	* urlopt_max_send_speed_large       (30145)
	* urlopt_netrc                      (51)
	* urlopt_netrc_file                 (10118)
	* urlopt_new_directory_perms        (160)
	* urlopt_new_file_perms             (159)
	* urlopt_nobody                     (44)
	* urlopt_noprogress                 (43)
	* urlopt_noproxy                    (10177)
	* urlopt_nosignal                   (99)
	* urlopt_opensocketdata             (10164)
	* urlopt_opensocketfunction         (20163)
	* urlopt_password                   (10174)
	* urlopt_port                       (3)
	* urlopt_post                       (47)
	* urlopt_post301                    (161)
	* urlopt_postfields                 (10015)
	* urlopt_postfieldsize              (60)
	* urlopt_postfieldsize_large        (30120)
	* urlopt_postquote                  (10039)
	* urlopt_postredir                  (161)
	* urlopt_prequote                   (10093)
	* urlopt_private                    (10103)
	* urlopt_progressdata               (10057)
	* urlopt_progressfunction           (20056)
	* urlopt_protocols                  (181)
	* urlopt_proxy                      (10004)
	* urlopt_proxyauth                  (111)
	* urlopt_proxypassword              (10176)
	* urlopt_proxyport                  (59)
	* urlopt_proxytype                  (101)
	* urlopt_proxyusername              (10175)
	* urlopt_proxyuserpwd               (10006)
	* urlopt_proxy_transfer_mode        (166)
	* urlopt_put                        (54)
	* urlopt_quote                      (10028)
	* urlopt_random_file                (10076)
	* urlopt_range                      (10007)
	* urlopt_readdata                   (10009)
	* urlopt_readfunction               (20012)
	* urlopt_redir_protocols            (182)
	* urlopt_referer                    (10016)
	* urlopt_resolve                    (10203)
	* urlopt_resume_from                (21)
	* urlopt_resume_from_large          (30116)
	* urlopt_rtspheader                 (10023)
	* urlopt_rtsp_client_cseq           (193)
	* urlopt_rtsp_request               (189)
	* urlopt_rtsp_server_cseq           (194)
	* urlopt_rtsp_session_id            (10190)
	* urlopt_rtsp_stream_uri            (10191)
	* urlopt_rtsp_transport             (10192)
	* urlopt_seekdata                   (10168)
	* urlopt_seekfunction               (20167)
	* urlopt_server_response_timeout    (112)
	* urlopt_share                      (10100)
	* urlopt_sockoptdata                (10149)
	* urlopt_sockoptfunction            (20148)
	* urlopt_socks5_gssapi_nec          (180)
	* urlopt_socks5_gssapi_service      (10179)
	* urlopt_ssh_auth_types             (151)
	* urlopt_ssh_host_public_key_md5    (10162)
	* urlopt_ssh_keydata                (10185)
	* urlopt_ssh_keyfunction            (20184)
	* urlopt_ssh_knownhosts             (10183)
	* urlopt_ssh_private_keyfile        (10153)
	* urlopt_ssh_public_keyfile         (10152)
	* urlopt_sslcert                    (10025)
	* urlopt_sslcertpasswd              (10026)
	* urlopt_sslcerttype                (10086)
	* urlopt_sslengine                  (10089)
	* urlopt_sslengine_default          (90)
	* urlopt_sslkey                     (10087)
	* urlopt_sslkeypasswd               (10026)
	* urlopt_sslkeytype                 (10088)
	* urlopt_sslversion                 (32)
	* urlopt_ssl_cipher_list            (10083)
	* urlopt_ssl_ctx_data               (10109)
	* urlopt_ssl_ctx_function           (20108)
	* urlopt_ssl_options                (216)
	* urlopt_ssl_sessionid_cache        (150)
	* urlopt_ssl_verifyhost             (81)
	* urlopt_ssl_verifypeer             (64)
	* urlopt_stderr                     (10037)
	* urlopt_tcp_keepalive              (213)
	* urlopt_tcp_keepidle               (214)
	* urlopt_tcp_keepintvl              (215)
	* urlopt_tcp_nodelay                (121)
	* urlopt_telnetoptions              (10070)
	* urlopt_tftp_blksize               (178)
	* urlopt_timecondition              (33)
	* urlopt_timeout                    (13)
	* urlopt_timeout_ms                 (155)
	* urlopt_timevalue                  (34)
	* urlopt_tlsauth_password           (10205)
	* urlopt_tlsauth_type               (10206)
	* urlopt_tlsauth_username           (10204)
	* urlopt_transfertext               (53)
	* urlopt_transfer_encoding          (207)
	* urlopt_unrestricted_auth          (105)
	* urlopt_upload                     (46)
	* urlopt_url                        (10002)
	* urlopt_useragent                  (10018)
	* urlopt_username                   (10173)
	* urlopt_userpwd                    (10005)
	* urlopt_use_ssl                    (119)
	* urlopt_verbose                    (41)
	* urlopt_wildcardmatch              (197)
	* urlopt_writedata                  (10001)
	* urlopt_writefunction              (20011)
	* urlopt_writeheader                (10029)
	* urlopt_writeinfo                  (10040)


	/* *** FUNCTIONS *** */

	* INT URL_CLOSE(INT url_id)
		- URL_ID values:
		  all_url	(-1)
		  or value returned by URL_OPEN

	* INT URL_OPEN()

	* INT URL_PERFORM(INT url_id, INT *status)

	* INT URL_SET_OPT(INT url_id, INT option, INT param)
	  INT URL_SET_OPT(INT url_id, INT option, STRING param) -> (overload 1)
		- OPTION values:
		  urlopt_accepttimeout_ms           (212)
		  urlopt_accept_encoding            (10102)
		  urlopt_address_scope              (171)
		  urlopt_append                     (50)
		  urlopt_autoreferer                (58)
		  urlopt_buffersize                 (98)
		  urlopt_cainfo                     (10065)
		  urlopt_capath                     (10097)
		  urlopt_certinfo                   (172)
		  urlopt_chunk_bgn_function         (20198)
		  urlopt_chunk_data                 (10201)
		  urlopt_chunk_end_function         (20199)
		  urlopt_closepolicy                (72)
		  urlopt_closesocketdata            (10209)
		  urlopt_closesocketfunction        (20208)
		  urlopt_connecttimeout             (78)
		  urlopt_connecttimeout_ms          (156)
		  urlopt_connect_only               (141)
		  urlopt_conv_from_network_function (20142)
		  urlopt_conv_from_utf8_function    (20144)
		  urlopt_conv_to_network_function   (20143)
		  urlopt_cookie                     (10022)
		  urlopt_cookiefile                 (10031)
		  urlopt_cookiejar                  (10082)
		  urlopt_cookielist                 (10135)
		  urlopt_cookiesession              (96)
		  urlopt_copypostfields             (10165)
		  urlopt_crlf                       (27)
		  urlopt_crlfile                    (10169)
		  urlopt_customrequest              (10036)
		  urlopt_debugdata                  (10095)
		  urlopt_debuginfo                  (20094)
		  urlopt_dirlistonly                (48)
		  urlopt_dns_cache_timeout          (92)
		  urlopt_dns_servers                (10211)
		  urlopt_dns_use_global_cache       (91)
		  urlopt_egdsocket                  (10077)
		  urlopt_encoding                   (10102)
		  urlopt_errorbuffer                (10010)
		  urlopt_failonerror                (45)
		  urlopt_file                       (10001)
		  urlopt_filetime                   (69)
		  urlopt_fnmatch_data               (10202)
		  urlopt_fnmatch_function           (20200)        
		  urlopt_followlocation             (52)
		  urlopt_forbid_reuse               (75)
		  urlopt_fresh_connect              (74)
		  urlopt_ftpappend                  (50)
		  urlopt_ftplistonly                (48)
		  urlopt_ftpport                    (10017)
		  urlopt_ftpsslauth                 (129)
		  urlopt_ftp_account                (10134)
		  urlopt_ftp_alternative_to_user    (10147)
		  urlopt_ftp_create_missing_dirs    (110)
		  urlopt_ftp_filemethod             (138)
		  urlopt_ftp_response_timeout       (112)
		  urlopt_ftp_skip_pasv_ip           (137)
		  urlopt_ftp_ssl                    (119)
		  urlopt_ftp_ssl_ccc                (154)
		  urlopt_ftp_use_eprt               (106)
		  urlopt_ftp_use_epsv               (85)
		  urlopt_ftp_use_pret               (188)
		  urlopt_gssapi_delegation          (210)
		  urlopt_header                     (42)
		  urlopt_headerdata                 (10029)
		  urlopt_headerfunction             (20079)
		  urlopt_http200aliases             (10104)
		  urlopt_httpauth                   (107)
		  urlopt_httpget                    (80)
		  urlopt_httpheader                 (10023)
		  urlopt_httppost                   (10024)
		  urlopt_httpproxytunnel            (61)
		  urlopt_http_content_encoding      (158)
		  urlopt_http_transfer_decoding     (157)
		  urlopt_http_version               (84)
		  urlopt_ignore_content_length      (136)
		  urlopt_infile                     (10009)
		  urlopt_infilesize                 (14)
		  urlopt_infilesize_large           (30115)
		  urlopt_interface                  (10062)
		  urlopt_interleavedata             (10195)
		  urlopt_interleavefunction         (20196)
		  urlopt_ioctldata                  (10131)
		  urlopt_ioctlfunction              (20130)
		  urlopt_ipresolve                  (113)
		  urlopt_issuercert                 (10170)
		  urlopt_keypasswd                  (10026)
		  urlopt_krb4level                  (10063)
		  urlopt_krblevel                   (10063)
		  urlopt_localport                  (139)
		  urlopt_localportrange             (140)
		  urlopt_low_speed_limit            (19)
		  urlopt_low_speed_time             (20)
		  urlopt_mail_auth                  (10217)
		  urlopt_mail_from                  (10186)
		  urlopt_mail_rcpt                  (10187)
		  urlopt_maxconnects                (71)
		  urlopt_maxfilesize                (114)
		  urlopt_maxfilesize_large          (30117)
		  urlopt_maxredirs                  (68)
		  urlopt_max_recv_speed_large       (30146)
		  urlopt_max_send_speed_large       (30145)
		  urlopt_netrc                      (51)
		  urlopt_netrc_file                 (10118)
		  urlopt_new_directory_perms        (160)
		  urlopt_new_file_perms             (159)
		  urlopt_nobody                     (44)
		  urlopt_noprogress                 (43)
		  urlopt_noproxy                    (10177)
		  urlopt_nosignal                   (99)
		  urlopt_opensocketdata             (10164)
		  urlopt_opensocketfunction         (20163)
		  urlopt_password                   (10174)
		  urlopt_port                       (3)
		  urlopt_post                       (47)
		  urlopt_post301                    (161)
		  urlopt_postfields                 (10015)
		  urlopt_postfieldsize              (60)
		  urlopt_postfieldsize_large        (30120)
		  urlopt_postquote                  (10039)
		  urlopt_postredir                  (161)
		  urlopt_prequote                   (10093)
		  urlopt_private                    (10103)
		  urlopt_progressdata               (10057)
		  urlopt_progressfunction           (20056)
		  urlopt_protocols                  (181)
		  urlopt_proxy                      (10004)
		  urlopt_proxyauth                  (111)
		  urlopt_proxypassword              (10176)
		  urlopt_proxyport                  (59)
		  urlopt_proxytype                  (101)
		  urlopt_proxyusername              (10175)
		  urlopt_proxyuserpwd               (10006)
		  urlopt_proxy_transfer_mode        (166)
		  urlopt_put                        (54)
		  urlopt_quote                      (10028)
		  urlopt_random_file                (10076)
		  urlopt_range                      (10007)
		  urlopt_readdata                   (10009)
		  urlopt_readfunction               (20012)
		  urlopt_redir_protocols            (182)
		  urlopt_referer                    (10016)
		  urlopt_resolve                    (10203)
		  urlopt_resume_from                (21)
		  urlopt_resume_from_large          (30116)
		  urlopt_rtspheader                 (10023)
		  urlopt_rtsp_client_cseq           (193)
		  urlopt_rtsp_request               (189)
		  urlopt_rtsp_server_cseq           (194)
		  urlopt_rtsp_session_id            (10190)
		  urlopt_rtsp_stream_uri            (10191)
		  urlopt_rtsp_transport             (10192)
		  urlopt_seekdata                   (10168)
		  urlopt_seekfunction               (20167)
		  urlopt_server_response_timeout    (112)
		  urlopt_share                      (10100)
		  urlopt_sockoptdata                (10149)
		  urlopt_sockoptfunction            (20148)
		  urlopt_socks5_gssapi_nec          (180)
		  urlopt_socks5_gssapi_service      (10179)
		  urlopt_ssh_auth_types             (151)
		  urlopt_ssh_host_public_key_md5    (10162)
		  urlopt_ssh_keydata                (10185)
		  urlopt_ssh_keyfunction            (20184)
		  urlopt_ssh_knownhosts             (10183)
		  urlopt_ssh_private_keyfile        (10153)
		  urlopt_ssh_public_keyfile         (10152)
		  urlopt_sslcert                    (10025)
		  urlopt_sslcertpasswd              (10026)
		  urlopt_sslcerttype                (10086)
		  urlopt_sslengine                  (10089)
		  urlopt_sslengine_default          (90)
		  urlopt_sslkey                     (10087)
		  urlopt_sslkeypasswd               (10026)
		  urlopt_sslkeytype                 (10088)
		  urlopt_sslversion                 (32)
		  urlopt_ssl_cipher_list            (10083)
		  urlopt_ssl_ctx_data               (10109)
		  urlopt_ssl_ctx_function           (20108)
		  urlopt_ssl_options                (216)
		  urlopt_ssl_sessionid_cache        (150)
		  urlopt_ssl_verifyhost             (81)
		  urlopt_ssl_verifypeer             (64)
		  urlopt_stderr                     (10037)
		  urlopt_tcp_keepalive              (213)
		  urlopt_tcp_keepidle               (214)
		  urlopt_tcp_keepintvl              (215)
		  urlopt_tcp_nodelay                (121)
		  urlopt_telnetoptions              (10070)
		  urlopt_tftp_blksize               (178)
		  urlopt_timecondition              (33)
		  urlopt_timeout                    (13)
		  urlopt_timeout_ms                 (155)
		  urlopt_timevalue                  (34)
		  urlopt_tlsauth_password           (10205)
		  urlopt_tlsauth_type               (10206)
		  urlopt_tlsauth_username           (10204)
		  urlopt_transfertext               (53)
		  urlopt_transfer_encoding          (207)
		  urlopt_unrestricted_auth          (105)
		  urlopt_upload                     (46)
		  urlopt_url                        (10002)
		  urlopt_useragent                  (10018)
		  urlopt_username                   (10173)
		  urlopt_userpwd                    (10005)
		  urlopt_use_ssl                    (119)
		  urlopt_verbose                    (41)
		  urlopt_wildcardmatch              (197)
		  urlopt_writedata                  (10001)
		  urlopt_writefunction              (20011)
		  urlopt_writeheader                (10029)
		  urlopt_writeinfo                  (10040)



---------------------------
--- WM
---------------------------
	/* *** FUNCTIONS *** */

	* INT DESKTOP_GET_SIZE(INT *width, INT *height)

	* INT WINDOW_CLOSE()

	* INT WINDOW_GET_POS(INT *x, INT *y)

	* INT WINDOW_GET_SIZE(INT *width, INT *height)

	* INT WINDOW_HIDE()

	* INT WINDOW_HIDE_FRAME() (Don t work on Linux)

	* INT WINDOW_IS_FRAMELESS() (Don t work on Linux)

	* INT WINDOW_IS_MINIMIZED()

	* INT WINDOW_IS_VISIBLE()

	* INT WINDOW_MINIMIZE()

	* INT WINDOW_MOVE(INT x, INT y)

	* INT WINDOW_RESTORE()

	* INT WINDOW_SET_TITLE(STRING text)

	* INT WINDOW_SHOW()

	* INT WINDOW_SHOW_FRAME() (Don t work on Linux)
