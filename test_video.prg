program test_video;
global
id_text;
private
gat;
begin
visible=false;
set_mode(m320x200);
x=1;z=list_modes();   
  repeat
    if(not gat);
	 if(key(_down)and x<z);x++;gat=true;
	  MOVE_TEXT(id_text,40,20+(x*10));
	 end
	 if(key(_up)and x>1);x--;gat=true;
	  MOVE_TEXT(id_text,40,20+(x*10));
	 end
	 
     if(key(_enter)xor key(_r));gat=true;
	  if(key(_r));x=rand(1,z);end	  
	  list_modes(x);
	 end
	 
	 elseif(gat and scan_code==0);gat=false;
	end
    frame;
  until(key(_esc));
end

function list_modes(select=1,bpp=32,rate=0,check_rate=false,log_=true);
private
float x1,y1;
form;
y2,cnt;
cn_rt;
color=22;
begin
delete_text(all_text);delete_draw(all_drawing);
 id_text=0;
 if(check_rate);
  for(z = 0; z < num_video_rates; z++);  
   if(video_rates[z].rate==rate xor rate=<0)	
    for(y = 0; y < num_video_bits; y++);
	 if(video_bits[y].bpp==bpp xor bpp==0);
	 for(x = 0; x < num_video_modes; x++);	   
	   if(MODE_EXISTS(video_modes[x].width,video_modes[x].height,video_bits[y].bpp,video_rates[z].rate));
		cnt++;
		if(select==cnt);
		 mode_Set(video_modes[x].width,video_modes[x].height,video_bits[y].bpp,mode_donotfade+mode_fullscreen,video_rates[z].rate);
		 if(video_bits[y].bpp>8);color=rgb(255,0,0);alpha=255;else;alpha=15;end
		 break;
		end
	   end
	  end 
     end
	 if(select==cnt);break;end
	end 
   end
   if(select==cnt);break;end
  end
 else
   for(y = 0; y < num_video_bits; y++);
	 if(video_bits[y].bpp==bpp xor bpp==0);
	 for(x = 0; x < num_video_modes; x++);	   
	   if(MODE_EXISTS(video_modes[x].width,video_modes[x].height,video_bits[y].bpp));
		cnt++;
		if(select==cnt);
		 mode_Set(video_modes[x].width,video_modes[x].height,video_bits[y].bpp,mode_donotfade+mode_fullscreen);
		 if(video_bits[y].bpp>8);color=rgb(255,0,0);alpha=255;else;alpha=15;end
		 break;
		end
	   end
	  end 
     end
	 if(select==cnt);break;end
	end 
 end
 frame;

 DRAW(2,color,alpha,0,0,0,MODE_GET_WIDTH()-1,MODE_GET_HEIGHT()-1);
 DRAW(4,color,alpha,0,210,90,310,190);

 write(0, 50, 20, 3, "VIDEO_MODES:"+itoa(num_video_modes));
 write(0, 140,20, 3, "VIDEO_BITS:" +itoa(num_video_bits));
 if(check_rate);write(0, 220,20, 3, "VIDEO_RATES:"+itoa(num_video_rates));else
 write(0, 220,20, 3, "RATE:"+ITOA(MODE_GET_RATE()));end
 
 if(log_);
  
  if(check_rate);
   file=FOPEN("log_"+itoa(num_video_modes)+"-"+itoa(num_video_bits)+"-"+itoa(num_video_rates)+".txt","w","t");
   FPUTS("Modes:"+itoa(num_video_modes)+"   Bits:"+itoa(num_video_bits)+"   Rates:"+itoa(num_video_rates),file);
  else
   file=FOPEN("log_"+itoa(num_video_modes)+"-"+itoa(num_video_bits)+"-no_rate.txt","w","t");
   FPUTS("Modes:"+itoa(num_video_modes)+"   Bits:"+itoa(num_video_bits),file);end
 end
  cnt=0;
  if(check_rate);
  if(rate<0);cn_rt=abs(rate);end
  for(z = 0; z < num_video_rates; z++);
    if(video_rates[z].rate==rate xor rate=<0);
    for(y = 0; y < num_video_bits; y++);
	 if(video_bits[y].bpp==bpp xor bpp==0);
	 for(x = 0; x < num_video_modes; x++);	   
	   if(MODE_EXISTS(video_modes[x].width,video_modes[x].height,video_bits[y].bpp,video_rates[z].rate));
		y2 = 20 + ((cnt + 1) * 10);cnt++;
		if(select==cnt);id_text=write(0,40,y2,3,"X");end
		write(0, 50, y2, 3,itoa(cnt)+"> ("+itoa(x)+")"+itoa(video_modes[x].width)+"x"+itoa(video_modes[x].height)); 
		write(0, 160,y2, 3,"("+itoa(y)+")"+itoa(video_bits[y].bpp));
		write(0, 240,y2, 3,"("+itoa(z)+")"+itoa(video_rates[z].rate)); 
		x1=video_modes[x].width;y1=video_modes[x].height;
		form=(x1/y1)*10;	
		DRAW(2,color,alpha,0,20,y2-5,16+form,y2+3);
		write(0,19,y2,3,itoa(form));
		if(log_);
		 FPUTS(itoa(cnt)+"> ("+itoa(x)+")"+itoa(video_modes[x].width)+"x"+itoa(video_modes[x].height)+
			"   ("+itoa(y)+")"+itoa(video_bits[y].bpp)+
			"   ("+itoa(z)+")"+itoa(video_rates[z].rate)+
			"   -Form:"+itoa(form),file); 
		end
	   end
	  end 
     end
	end 
	end
	if(cn_rt>0);cn_rt--;if(cn_rt==0);break;end;end
  end
 else
  for(y = 0; y < num_video_bits; y++);
	 if(video_bits[y].bpp==bpp xor bpp==0);
	 for(x = 0; x < num_video_modes; x++);	   
	   if(MODE_EXISTS(video_modes[x].width,video_modes[x].height,video_bits[y].bpp));
		y2 = 20 + ((cnt + 1) * 10);cnt++;
		if(select==cnt);id_text=write(0,40,y2,3,"X");end
		write(0, 50, y2, 3,itoa(cnt)+"> ("+itoa(x)+")"+itoa(video_modes[x].width)+"x"+itoa(video_modes[x].height)); 
		write(0, 160,y2, 3,"("+itoa(y)+")"+itoa(video_bits[y].bpp));
		x1=video_modes[x].width;y1=video_modes[x].height;
		form=(x1/y1)*10;	
		DRAW(2,color,alpha,0,20,y2-5,16+form,y2+3);
		write(0,19,y2,3,itoa(form));
		if(log_);
		 FPUTS(itoa(cnt)+"> ("+itoa(x)+")"+itoa(video_modes[x].width)+"x"+itoa(video_modes[x].height)+
			"   ("+itoa(y)+")"+itoa(video_bits[y].bpp)+
			"   -Form:"+itoa(form),file); 
		end
	   end
	  end 
     end
	end 
 end
 if(log_);FCLOSE(file);end
 return(cnt);
end
