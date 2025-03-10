/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: DBMS (Data Base Management System) system
 */


// use this option to inform the system to use the modern graphics engine with hardware acceleration (OpenGL, etc...)
//compiler_options _gmxsystem_graphics = gmxgraphics_modern;


// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use

program Gemix_dbms_import_export;

global
  db;
  db_exists;
  db_res;
  table_records;
  query_txt, query_csv;
  query_fields, query_records;
  export_res[2];
  row, col;
  cx, cy;
  
  struct query_values[2, 9]  
    string value_string;
    int    value_int;
    double value_double;
  end
  
begin
  //mode_set(640, 480); // For graphics modern
  mode_set(640, 480, 32); // For graphics legacy

  // Averiguamos si el fichero no existe ya que 'db_create' no sobreescribe la DB existente sino que sigue añadiendo cosas en cola 
  db_exists = file_exists("_GMX_dbms_impexp.db"); 
  if(!db_exists) 
    // Creamos/Abrimos la base de datos '_GMX_dbms_impexp' cuyo gestor (DBMS) es 'SQLite'
    db = db_open("_GMX_dbms_impexp.db", dbms_sqlite, db_create);  
    if(db <= 0)
      exit("error to create _GMX_dbms_impexp.db", 0);
    end

    // Creamos una tabla 'Gemix_TXT' importando los valores de un fichero TXT
    dbtable_import(db, "Gemix_TXT", "_GMX_dbtable_gemix_txt_import.txt", "|");
    
    // Creamos una tabla 'Gemix_CSV' importando los valores de un fichero CSV
    dbtable_import(db, "Gemix_CSV", "_GMX_dbtable_gemix_csv_import.csv", ";");   

    // Cerramos la base de datos correspondiente a 'db'
    db_close(db);  
  end
   
    
  // ------------------------------------------------------------------------------------------------------------------------------------------------------------ 

  write(0, 320, 10, 4, &db);
  write(0, 320, 20, 4, &table_records);  
  write(0, 320, 30, 4, &query_txt);  
  write(0, 320, 40, 4, &query_csv);  
  write(0, 320, 50, 4, &query_fields);  
  write(0, 320, 60, 4, &query_records);  
 
  // Abrimos la base de datos '_GMX_dbms_impexp' cuyo gestor (DBMS) es 'SQLite' en sola lectura
  db = db_open("_GMX_dbms_impexp.db", dbms_sqlite, db_readonly);  

  // Obtenemos el numero total de records (rigas) de la tabla
  table_records = dbtable_get_numrecords(db, "Gemix_TXT");
  
  // Obtenemos una consulta para recorrer los record de la 'tabla' especificada
  query_txt = dbtable_get_query(db, "Gemix_TXT");
  
  while(!keydown(_space)) frame; end  
  
  // Ejecutamos la consulta hasta obtener todos los resultasos de la misma (> 0 = quedan resultados, 0 = resultados acabados, < 0 = error de algun tipo) 
  row = 0;
  cy  = 90;
  while(dbquery_evaluate(query_txt) > 0)  
    // Obtenemos el numero de campos de la consulta (este numero puede variar en base a la consulta)
    query_fields = dbquery_get_numfields(query_txt);
    
    // Recorremos los campos de la consulta
    for(col = 0; col < query_fields; col++)
      // Averiguamos el tipo de campo de la consulta y obtenemos el valor adecuado
      switch(dbquery_get_type(query_txt, col))
        case dbquery_type_int:
          if(dbquery_get_value(query_txt, col, &query_values[col, row].value_int))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_int);
          end
        end
        case dbquery_type_double:
          if(dbquery_get_value(query_txt, col, &query_values[col, row].value_double))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_double);
          end
        end
        case dbquery_type_string:
          if(dbquery_get_value(query_txt, col, &query_values[col, row].value_string))
            write(0, 50 + (col * 20 * 6), cy, 3, query_values[col, row].value_string);
          end
        end
      end
    end
    
    row += 1;
    cy  += 10;
  end


  // Obtenemos el numero total de records (rigas) de la tabla
  table_records = dbtable_get_numrecords(db, "Gemix_CSV");

  // Obtenemos una consulta para recorrer los record de la 'tabla' especificada
  query_csv = dbtable_get_query(db, "Gemix_CSV");
  
  while(!keydown(_space)) frame; end
  
  // Ejecutamos la consulta hasta obtener todos los resultasos de la misma (> 0 = quedan resultados, 0 = resultados acabados, < 0 = error de algun tipo) 
  row = 0;
  cy  = 150;
  while(dbquery_evaluate(query_csv) > 0)  
    // Obtenemos el numero de campos de la consulta (este numero puede variar en base a la consulta)
    query_fields = dbquery_get_numfields(query_csv);
    
    // Recorremos los campos de la consulta
    for(col = 0; col < query_fields; col++)
      // Averiguamos el tipo de campo de la consulta y obtenemos el valor adecuado
      switch(dbquery_get_type(query_csv, col))
        case dbquery_type_int:
          if(dbquery_get_value(query_csv, col, &query_values[col, row].value_int))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_int);
          end
        end
        case dbquery_type_double:
          if(dbquery_get_value(query_csv, col, &query_values[col, row].value_double))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_double);
          end
        end
        case dbquery_type_string:
          if(dbquery_get_value(query_csv, col, &query_values[col, row].value_string))
            write(0, 50 + (col * 20 * 6), cy, 3, query_values[col, row].value_string);
          end
        end
      end
    end
    
    row += 1;
    cy  += 10;
  end       

  
  // *** EXPORT ***
  write(0, 320, 450, 4, &export_res[0]);  
  write(0, 320, 460, 4, &export_res[1]);  

  // Exportamos la tabla 'Gemix_TXT' en un fichero TXT
  export_res[0] = dbtable_export(db, "Gemix_TXT", "_GMX_dbtable_gemix_txt_export.txt", "|");
    
  // Exportamos la tabla 'Gemix_CSV' en un fichero CSV
  export_res[1] = dbtable_export(db, "Gemix_CSV", "_GMX_dbtable_gemix_csv_export.csv", ";");   
  
  // Cerramos la base de datos correspondiente a 'db'   
  db_close(db); 
    
  repeat
    frame;
  until(keydown(_esc));  
end
