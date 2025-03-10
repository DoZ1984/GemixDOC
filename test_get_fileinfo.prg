Program test_get_fileinfo;
Begin

GET_FILEINFO("win32_modules");
//oculto.txt,lectura.txt,normal.txt,BOOTSECT.DOS
//win32_modules
/*
  0 - Archivo normal.
  1 - Archivo de sólo lectura.
  2 - Archivo oculto.
  4 - Archivo de sistema.
  8 - Etiqueta de volumen.
 16 - Subdirectorio.
 32 - Marcha de archivo.
*/

if((fileinfo.attrib & _rdonly) == _rdonly)
  write(0,160,100,4,"Read Only");
end
if((fileinfo.attrib & _hidden) == _hidden)
  write(0,160,110,4,"Hidden");
end
if((fileinfo.attrib & _subdir) == _subdir)
  write(0,160,120,4,"Directory");
end
if((fileinfo.attrib & _arch) == _arch)
  write(0,160,130,4,"Archive");
end
write(0,160,150,4,"attrib:"+ITOA(fileinfo.attrib)+"=_arch="+itoa(_arch));
 Loop

 Frame;
 End

End
