/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: Audio Song system
 */


// use this option to inform the system to use the modern graphics engine with hardware acceleration (OpenGL, etc...)
//compiler_options _gmxsystem_graphics = gmxgraphics_modern;

// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
//compiler_options _gmxsystem_graphics = gmxgraphics_legacy;

// use this option to inform the system to use the modern audio engine based on FMOD Studio
//compiler_options _gmxsystem_audio = gmxaudio_modern;

// use this option to inform the system to use the legacy audio engine based on FMOD Ex
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
//compiler_options _gmxsystem_audios = gmxaudio_legacy;
program Gemix_songs;

global
  int songsplaying;

  int song_playing;
  int song_paused;
  int song_fading;
  int song_muted;

  string songattrib_name, songattrib_type, songattrib_format;
  int songattrib_numchannels, songattrib_numorders, songattrib_numpatterns,
      songattrib_frequency,
      songattrib_length, songattrib_lengthms, songattrib_size,
      songattrib_loop, songattrib_loopcount,
      songattrib_volume, songattrib_speed,
      songattrib_pan, songattrib_pansep;      
  int song_loop  , song_loopcount,
      song_volume, song_speed    , song_pan, song_frequency,
      song_time  , song_timems   , song_pos,
      song_order , song_pattern  , song_numrows, song_row;

  audio_cpu_usage audio_cpuusage;
  dword audio_memoryusage,        
        song_memoryusage,        
        songchannel_memoryusage,        
        audiolib_memoryusage;        

  int set_;

  int song_channel, _loop, _loopcount, _volume, _speed, _pan;

  int song_id, sng_id[8], l_song[8] = 1, 1, 1, 1;

  int idt1, idt1_x = -50;
  int idt2, idt2_x = 582;

  // add between " " your favorite songs on formatos WAV/MP2/MP3/OGG/MOD/S3M/XM/IT/MID
  // anades entre " " tu songs prefieridas en formatos WAV/MP2/MP3/OGG/MOD/S3M/XM/IT/MID
  // inserisci tra " " le tue song preferite in formati WAV/MP2/MP3/OGG/MOD/S3M/XM/IT/MID
  struct fsong[8]
    string name;
  end = "bst_sgd2.xm",
        " ",
	" ",
	" ",
	" ",
	" ",
	" ",
	" ",
	" ";
        
begin
  mode_set(512, 384);
	
  screen_set_color(rgb(128, 128, 128));

  mouse_status = mouse_status_off;
  joy_status   = joy_status_off;

  audio_setup.sound_channels = 0;
  audio_setup.song_channels  = 1;
  audio_refresh_setup(refresh_audio_engine);

  sng_id[0] = song_load(fsong[0].name, 1);
  /*sng_id[1] = song_load(fsong[1].name, 1);
  sng_id[2] = song_load(fsong[2].name, 1);
  sng_id[3] = song_load(fsong[3].name, 1);
  sng_id[4] = song_load(fsong[4].name, 1);
  sng_id[5] = song_load(fsong[5].name, 1);
  sng_id[6] = song_load(fsong[6].name, 1);
  sng_id[7] = song_load(fsong[7].name, 1);
  sng_id[8] = song_load(fsong[8].name, 1);*/

  idt1 = write(0, -50, 5, 4, "*** SONG ***");

  write(0, 10, 20, 3, "SONGS:"); write(0, 52, 20, 3, &songsplaying);

  write(0, 10, 35, 3, "PLAYING:"); write(0, 64, 35, 3, &song_playing);
  write(0, 10, 45, 3, "PAUSED.:"); write(0, 64, 45, 3, &song_paused);
  write(0, 10, 55, 3, "FADING.:"); write(0, 64, 55, 3, &song_fading);
  write(0, 10, 65, 3, "MUTED..:"); write(0, 64, 65, 3, &song_muted);

  write(0, 10,  80, 3, "SET_LOOP.....:"); write(0, 100,  80, 3, &_loop);
  write(0, 10,  90, 3, "SET_LOOPCOUNT:"); write(0, 100,  90, 3, &_loopcount);
  write(0, 10, 100, 3, "SET_VOLUME...:"); write(0, 100, 100, 3, &_volume);
  write(0, 10, 110, 3, "SET_SPEED....:"); write(0, 100, 110, 3, &_speed);
  write(0, 10, 120, 3, "SET_PAN......:"); write(0, 100, 120, 3, &_pan);

  write(0, 10, 135, 3, "SNG[0]:"); write(0, 58, 135, 3, &sng_id[0]);
  write(0, 10, 145, 3, "SNG[1]:"); write(0, 58, 145, 3, &sng_id[1]);
  write(0, 10, 155, 3, "SNG[2]:"); write(0, 58, 155, 3, &sng_id[2]);
  write(0, 10, 165, 3, "SNG[3]:"); write(0, 58, 165, 3, &sng_id[3]);
  write(0, 10, 175, 3, "SNG[4]:"); write(0, 58, 175, 3, &sng_id[4]);
  write(0, 10, 185, 3, "SNG[5]:"); write(0, 58, 185, 3, &sng_id[5]);
  write(0, 10, 195, 3, "SNG[6]:"); write(0, 58, 195, 3, &sng_id[6]);
  write(0, 10, 205, 3, "SNG[7]:"); write(0, 58, 205, 3, &sng_id[7]);
  write(0, 10, 215, 3, "SNG[8]:"); write(0, 58, 215, 3, &sng_id[8]);

  write(0, 166,  20, 3, "--- SONG INFO ---");
  write(0, 166,  30, 3, "NAME.....:"); write(0, 232,  30, 3, songattrib_name);
  write(0, 166,  40, 3, "TYPE.....:"); write(0, 232,  40, 3, songattrib_type);
  write(0, 166,  50, 3, "FORMAT...:"); write(0, 232,  50, 3, songattrib_format);
  write(0, 166,  60, 3, "FREQUENCY:"); write(0, 232,  60, 3, &songattrib_frequency);
  write(0, 166,  70, 3, "LENGTH...:"); write(0, 232,  70, 3, &songattrib_length);
  write(0, 166,  80, 3, "LENGTHMS.:"); write(0, 232,  80, 3, &songattrib_lengthms);
  write(0, 166,  90, 3, "SIZE.....:"); write(0, 232,  90, 3, &songattrib_size);
  write(0, 166, 100, 3, "CHANNELS.:"); write(0, 232, 100, 3, &songattrib_numchannels);
  write(0, 166, 110, 3, "ORDERS...:"); write(0, 232, 110, 3, &songattrib_numorders);
  write(0, 166, 120, 3, "PATTERNS.:"); write(0, 232, 120, 3, &songattrib_numpatterns);
  write(0, 166, 130, 3, "LOOP.....:"); write(0, 232, 130, 3, &songattrib_loop);
  write(0, 166, 140, 3, "LOOPCOUNT:"); write(0, 232, 140, 3, &songattrib_loopcount);
  write(0, 166, 150, 3, "VOLUME...:"); write(0, 232, 150, 3, &songattrib_volume);
  write(0, 166, 160, 3, "SPEED....:"); write(0, 232, 160, 3, &songattrib_speed);
  write(0, 166, 170, 3, "PAN......:"); write(0, 232, 170, 3, &songattrib_pan);

  write(0, 166, 185, 3, "--- CHANNEL INFO ---");
  write(0, 166, 195, 3, "FREQUENCY:"); write(0, 232, 195, 3, &song_frequency);
  write(0, 166, 205, 3, "ORDER....:"); write(0, 232, 205, 3, &song_order);
  write(0, 166, 215, 3, "PATTERN..:"); write(0, 232, 215, 3, &song_pattern);
  write(0, 166, 225, 3, "ROWS.....:"); write(0, 232, 225, 3, &song_numrows);
  write(0, 166, 235, 3, "ROW......:"); write(0, 232, 235, 3, &song_row);
  write(0, 166, 245, 3, "POS......:"); write(0, 232, 245, 3, &song_pos);
  write(0, 166, 255, 3, "TIME.....:"); write(0, 232, 255, 3, &song_time);
  write(0, 166, 265, 3, "TIMEMS...:"); write(0, 232, 265, 3, &song_timems);
  write(0, 166, 275, 3, "LOOP.....:"); write(0, 232, 275, 3, &song_loop);
  write(0, 166, 285, 3, "LOOPCOUNT:"); write(0, 232, 285, 3, &song_loopcount);
  write(0, 166, 295, 3, "VOLUME...:"); write(0, 232, 295, 3, &song_volume);
  write(0, 166, 305, 3, "SPEED....:"); write(0, 232, 305, 3, &song_speed);
  write(0, 166, 315, 3, "PAN......:"); write(0, 232, 315, 3, &song_pan);

  write(0, 342, 185, 3, "--- CPU USAGE INFO ---");
  write(0, 342, 195, 3, "DSP.....:"); write(0, 402, 195, 3, &audio_cpuusage.dsp, 1, 2);
  write(0, 342, 205, 3, "GEOMETRY:"); write(0, 402, 205, 3, &audio_cpuusage.geometry, 1, 2);
  write(0, 342, 215, 3, "STREAM..:"); write(0, 402, 215, 3, &audio_cpuusage.stream, 1, 2);
  write(0, 342, 225, 3, "UPDATE..:"); write(0, 402, 225, 3, &audio_cpuusage.update, 1, 2);
  write(0, 342, 235, 3, "TOTAL...:"); write(0, 402, 235, 3, &audio_cpuusage.total, 1, 2);

  write(0, 342, 255, 3, "--- MEMORY USAGE INFO ---");
  write(0, 342, 265, 3, "AUDIO..:"); write(0, 396, 265, 3, &audio_memoryusage);
  write(0, 342, 275, 3, "SONG...:"); write(0, 396, 275, 3, &song_memoryusage);
  write(0, 342, 285, 3, "CHANNEL:"); write(0, 396, 285, 3, &songchannel_memoryusage);
  write(0, 342, 295, 3, "LIBRARY:"); write(0, 396, 295, 3, &audiolib_memoryusage);

  idt2 = write(0, 380, 380, 4, "PRESS ESC FOR EXIT");

  song_channel = song_play(song_id);

  repeat
    if(!set_)
      _loop      = songchannel_get_loop(song_channel);
      _loopcount = songchannel_get_loopcount(song_channel);
      _speed     = songchannel_get_speed(song_channel);
      _volume    = songchannel_get_volume(song_channel);
      _pan       = songchannel_get_pan(song_channel);
      set_ = 1;
    end

    if(keydown(_1)) song_channel = song_play(sng_id[0]); song_id = 0; set_ = 0; end
    if(keydown(_2)) song_channel = song_play(sng_id[1]); song_id = 1; set_ = 0; end
    if(keydown(_3)) song_channel = song_play(sng_id[2]); song_id = 2; set_ = 0; end
    if(keydown(_4)) song_channel = song_play(sng_id[3]); song_id = 3; set_ = 0; end
    if(keydown(_5)) song_channel = song_play(sng_id[4]); song_id = 4; set_ = 0; end
    if(keydown(_6)) song_channel = song_play(sng_id[5]); song_id = 5; set_ = 0; end
    if(keydown(_7)) song_channel = song_play(sng_id[6]); song_id = 6; set_ = 0; end
    if(keydown(_8)) song_channel = song_play(sng_id[7]); song_id = 7; set_ = 0; end
    if(keydown(_9)) song_channel = song_play(sng_id[8]); song_id = 8; set_ = 0; end

    // set LOOP
    if(keydown(_f1) && keydown(_left)  && _loop > 0)
      _loop = 0;
      song_set_loop(song_id, _loop, 0);
      songchannel_set_loop(song_channel, _loop);
    end
    if(keydown(_f1) && keydown(_right) && _loop < 1)
      _loop = 1;
      song_set_loop(song_id, _loop, 0);
      songchannel_set_loop(song_channel, _loop);
    end
    // set LOOPCOUNT
    if(keydown(_f2) && keydown(_left)  && _loopcount > 0)
      _loopcount--;
      song_set_loopcount(song_id, _loopcount, 0);
      songchannel_set_loopcount(song_channel, _loopcount);
    end
    if(keydown(_f2) && keydown(_right) && _loopcount < max_int)
      _loopcount++;
      song_set_loopcount(song_id, _loopcount, 0);
      songchannel_set_loopcount(song_channel, _loopcount);
    end
    // set VOLUME
    if(keydown(_f3) && keydown(_left)  && _volume >   0)
      _volume--;
      song_set_volume(song_id, _volume, 0);
      songchannel_set_volume(song_channel, _volume);
    end
    if(keydown(_f3) && keydown(_right) && _volume < 256)
      _volume++;
      song_set_volume(song_id, _volume, 0);    
      songchannel_set_volume(song_channel, _volume);
    end
    // set SPEED
    if(keydown(_f4) && keydown(_left)  && _speed >    0)
      _speed--;
      song_set_speed(song_id, _speed, 0);
      songchannel_set_speed(song_channel, _speed);
    end 
    if(keydown(_f4) && keydown(_right) && _speed < 1024)
      _speed++;
      song_set_speed(song_id, _speed, 0);     
      songchannel_set_speed(song_channel, _speed);
    end
    // set PAN 
    if(keydown(_f5) && keydown(_left)  && _pan >   0)
      _pan--;
      song_set_pan(song_id, _pan, 0);
      songchannel_set_pan(song_channel, _pan);
    end
    if(keydown(_f5) && keydown(_right) && _pan < 512)
      _pan++;
      song_set_pan(song_id, _pan, 0);
      songchannel_set_pan(song_channel, _pan);
    end

    if(keydown(_f6) && keydown(_1) && !l_song[0]) sng_id[0] = song_load(fsong[0].name, 1); l_song[0] = 1; end
    if(keydown(_f6) && keydown(_2) && !l_song[1]) sng_id[1] = song_load(fsong[1].name, 1); l_song[1] = 1; end
    if(keydown(_f6) && keydown(_3) && !l_song[2]) sng_id[2] = song_load(fsong[2].name, 1); l_song[2] = 1; end
    if(keydown(_f6) && keydown(_4) && !l_song[3]) sng_id[3] = song_load(fsong[3].name, 1); l_song[3] = 1; end
    if(keydown(_f6) && keydown(_5) && !l_song[4]) sng_id[4] = song_load(fsong[4].name, 1); l_song[4] = 1; end
    if(keydown(_f6) && keydown(_6) && !l_song[5]) sng_id[5] = song_load(fsong[5].name, 1); l_song[5] = 1; end
    if(keydown(_f6) && keydown(_7) && !l_song[6]) sng_id[6] = song_load(fsong[6].name, 1); l_song[6] = 1; end
    if(keydown(_f6) && keydown(_8) && !l_song[7]) sng_id[7] = song_load(fsong[7].name, 1); l_song[7] = 1; end
    if(keydown(_f6) && keydown(_9) && !l_song[8]) sng_id[8] = song_load(fsong[8].name, 1); l_song[8] = 1; end

    if(keydown(_f7) && keydown(_1) &&  l_song[0]) song_unload(sng_id[0]); sng_id[0] = -1; l_song[0] = 0; end
    if(keydown(_f7) && keydown(_2) &&  l_song[1]) song_unload(sng_id[1]); sng_id[1] = -1; l_song[1] = 0; end
    if(keydown(_f7) && keydown(_3) &&  l_song[2]) song_unload(sng_id[2]); sng_id[2] = -1; l_song[2] = 0; end
    if(keydown(_f7) && keydown(_4) &&  l_song[3]) song_unload(sng_id[3]); sng_id[3] = -1; l_song[3] = 0; end
    if(keydown(_f7) && keydown(_5) &&  l_song[4]) song_unload(sng_id[4]); sng_id[4] = -1; l_song[4] = 0; end
    if(keydown(_f7) && keydown(_6) &&  l_song[5]) song_unload(sng_id[5]); sng_id[5] = -1; l_song[5] = 0; end
    if(keydown(_f7) && keydown(_7) &&  l_song[6]) song_unload(sng_id[6]); sng_id[6] = -1; l_song[6] = 0; end
    if(keydown(_f7) && keydown(_8) &&  l_song[7]) song_unload(sng_id[7]); sng_id[7] = -1; l_song[7] = 0; end
    if(keydown(_f7) && keydown(_9) &&  l_song[8]) song_unload(sng_id[8]); sng_id[8] = -1; l_song[8] = 0; end

    if(keydown(_m) && !song_muted) songchannel_mute(song_channel);   end
    if(keydown(_u) &&  song_muted) songchannel_unmute(song_channel); end

    if(keydown(_z) && !song_fading) songchannel_fade_out(song_channel);      end
    if(keydown(_x) && !song_fading) songchannel_fade_in(song_channel);       end
    if(keydown(_c) && !song_fading) songchannel_fade(song_channel, 0, 7000); end
    if(keydown(_v) && !song_fading) songchannel_fade(song_channel, 1, 7000); end

    if(keydown(_space))
      sng_id[0] = -1;
      sng_id[1] = -1;
      sng_id[2] = -1;
      sng_id[3] = -1;
      sng_id[4] = -1;
      sng_id[5] = -1;
      sng_id[6] = -1;
      sng_id[7] = -1;
      sng_id[8] = -1;
      l_song[0] =  0;
      l_song[1] =  0;
      l_song[2] =  0;
      l_song[3] =  0;
      l_song[4] =  0;
      l_song[5] =  0;
      l_song[6] =  0;
      l_song[7] =  0;
      l_song[8] =  0;
      song_unload(all_song);
    end

    if(keydown(_p)) songchannel_pause(song_channel);  end
    if(keydown(_r)) songchannel_resume(song_channel); end
    if(keydown(_s)) songchannel_stop(song_channel);   end

    if(keydown(_l))
      audio_setup.mixer   = audio_mixer_nointerpolation;
      audio_setup.bits    = audio_bits_8;
      audio_setup.rate    = audio_rate_11025;
      audio_setup.speaker = audio_speaker_mono;
      audio_refresh_setup(refresh_audio_engine);
    end
    if(keydown(_n))
      audio_setup.mixer   = audio_mixer_linearinterpolation;
      audio_setup.bits    = audio_bits_16;
      audio_setup.rate    = audio_rate_44100;
      audio_setup.speaker = audio_speaker_stereo;
      audio_refresh_setup(refresh_audio_engine);
    end
    if(keydown(_h))
      audio_setup.mixer   = audio_mixer_cubicinterpolation;
      audio_setup.bits    = audio_bits_32;
      audio_setup.rate    = audio_rate_48000;
      audio_setup.speaker = audio_speaker_stereo;
      audio_refresh_setup(refresh_audio_engine);
    end
    if(keydown(_b))
      audio_setup.mixer   = audio_mixer_splineinterpolation;
      audio_setup.bits    = audio_bits_32float;
      audio_setup.rate    = audio_rate_96000;
      audio_setup.speaker = audio_speaker_stereo;
      audio_refresh_setup(refresh_audio_engine);
    end

    if(keydown(_c_minus) && audio_setup.song_volume > 0)
      audio_setup.song_volume--;
      audio_refresh_setup(refresh_audio_volume);
    end
    if(keydown(_c_plus)  && audio_setup.song_volume < 256)
      audio_setup.song_volume++;
      audio_refresh_setup(refresh_audio_volume);
    end

    if(keydown(_i)) set_fps( 0, 0); end
    if(keydown(_o)) set_fps(24, 0); end

    if(keydown(_f)) mode_change(mode_fullscreen); end
    if(keydown(_w)) mode_change(mode_window);     end

    if(keydown(_j))
      songchannel_set_time(song_channel, 20);
    end
    
    songsplaying = audiolib_get_songsplaying();

    song_playing = songchannel_is_playing(song_channel);
    song_paused  = songchannel_is_paused(song_channel);
    song_fading  = songchannel_is_fading(song_channel);
    song_muted   = songchannel_is_muted(song_channel);

    songattrib_name        = song_get_name(song_id);
    songattrib_type        = song_get_type(song_id);
    songattrib_format      = song_get_format(song_id);
    songattrib_frequency   = song_get_frequency(song_id);
    songattrib_length      = song_get_length(song_id);
    songattrib_lengthms    = song_get_lengthms(song_id);
    songattrib_size        = song_get_size(song_id);
    songattrib_numchannels = song_get_numchannels(song_id);
    songattrib_numorders   = song_get_numorders(song_id);
    songattrib_numpatterns = song_get_numpatterns(song_id);
    songattrib_loop        = song_get_loop(song_id);
    songattrib_loopcount   = song_get_loopcount(song_id);
    songattrib_volume      = song_get_volume(song_id);
    songattrib_speed       = song_get_speed(song_id);
    songattrib_pan         = song_get_pan(song_id);

    song_frequency         = songchannel_get_frequency(song_channel);
    song_order             = songchannel_get_order(song_channel);
    song_pattern           = songchannel_get_pattern(song_channel);
    song_numrows           = songchannel_get_numrows(song_channel);
    song_row               = songchannel_get_row(song_channel);
    song_pos               = songchannel_get_pos(song_channel);
    song_loop              = songchannel_get_loop(song_channel);
    song_loopcount         = songchannel_get_loopcount(song_channel);
    song_volume            = songchannel_get_volume(song_channel);
    song_speed             = songchannel_get_speed(song_channel);
    song_pan               = songchannel_get_pan(song_channel);
    song_time              = songchannel_get_time(song_channel);
    song_timems            = songchannel_get_timems(song_channel);

    audiolib_get_cpuusage(&audio_cpuusage);
    audio_memoryusage       = audio_get_memoryusage(NULL);
    song_memoryusage        = song_get_memoryusage(song_id, NULL);
    songchannel_memoryusage = songchannel_get_memoryusage(song_channel, NULL);
    audiolib_memoryusage    = audiolib_get_memoryusage();

    idt1_x++; if(idt1_x > 582) idt1_x = -70; end
    text_move(idt1, idt1_x, 5);
    idt2_x--; if(idt2_x < -70) idt2_x = 582; end
    text_move(idt2, idt2_x, 380);

    frame;
  until(key(_esc))
end
