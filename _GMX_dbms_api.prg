/* 
 * Gemix Studio (C) 2016 Skygem Software, All right reserved
 * Example: DBMS (Data Base Management System) system
 */


// use this option to inform the system to use the modern graphics engine with hardware acceleration (OpenGL, etc...)
//compiler_options _gmxsystem_graphics = gmxgraphics_modern;



// use this option to inform the system to use the legacy graphics engine with software implementation (Software, etc...)
// note: this option is automatic enabled on the gemix.cfg, so is not necessary to use
//compiler_options _gmxsystem_graphics = gmxgraphics_legacy;

program Gemix_dbms_api;

global
  db;
  db_exists;
  db_res;
  table_records;
  query;
  query_fields, query_records;
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
  db_exists = file_exists("_GMX_dbms_api.db"); 
  if(!db_exists) 
    // Creamos/Abrimos la base de datos '_GMX_dbms_api' cuyo gestor (DBMS) es 'SQLite'
    // NOTA: Para info sobre consultas (utilizando DB_QUERY) utilizar un buen manual de SQL standard + la ayuda SQL de SQLite: https://www.sqlite.org/lang.html
    db = db_open("_GMX_dbms_api.db", dbms_sqlite, db_create);  
    if(db <= 0)
      exit("error to create _GMX_dbms_api.db", 0);
    end

///*
    // -> MODE 1: Utilizamos la API de gestion de tablas para crear tablas, añadir campos y insertar records de valores (comentar este bloque si se quiere usar el MODE 2)

    // Creamos la tabla 'Gemix' con el primer campo 'ID' (campo primario clave)
    dbtable_new(db, "Gemix");

    // Añadimos a la tabla 'Gemix' el campo 'Function' de tipo 'VARCHAR(255)' (texto variable de maximo 255 caracteres).
    // NOTA: Cuando añadimos un nuevo record (riga), si no especificamos su valor, esto sea por default 'empty', ya que el campo no puede ser vacio
    dbtable_add_field(db, "Gemix", "Function"   , "VARCHAR(255)", "empty", 1);
    // Añadimos a la tabla 'Gemix' el campo 'Description' de tipo 'LONGTEXT' (texto largo variable).
    // NOTA: Cuando añadimos un nuevo record (riga), si no especificamos su valor, este sera vacio (ya que hemos indicado que el campo no es obligadorio)
    dbtable_add_field(db, "Gemix", "Description", "LONGTEXT"    , ""     , 0);

    dbtable_insert_record(db, "Gemix", "Function, Description", "'db_open', 'Crea/Abre una Base de Datos'");
    dbtable_insert_record(db, "Gemix", "Function, Description", "'db_query', 'Hace una consulta SQL a la Base de Datos'");
    dbtable_insert_record(db, "Gemix", "Function, Description", "'db_close', 'Cierra una Base de Datos'");  
//*/

/*  
    // -> MODE 2: Utilizamos consultas (DB_QUERY) para crear tablas, añadir campos y insertar records de valores, etc... (comentar este bloque si se quiere usar el MODE 1)

    // Creamos la tabla 'Gemix' con:
    // - El primer campo 'ID' (campo primario clave).
    // - El campo 'Function' de tipo 'VARCHAR(255)' (texto variable de maximo 255 caracteres).
    //   NOTA: Cuando añadimos un nuevo record (riga), si no especificamos su valor, esto sera por default 'empty', ya que el campo no puede ser vacio
    // - El campo 'Description' de tipo 'LONGTEXT' (texto largo variable).
    //   NOTA: Cuando añadimos un nuevo record (riga), si no especificamos su valor, este sera vacio (ya que hemos indicado que el campo no es obligadorio)
    db_query(db, "CREATE TABLE Gemix (ID INTEGER PRIMARY KEY, Function VARCHAR(255) DEFAULT 'empty' NOT NULL, Description LONGTEXT DEFAULT '');", true);

    // Añadimos a la tabla 'Gemix' unos records:
    db_query(db, "INSERT INTO Gemix (Function, Description) VALUES ('db_open', 'Crea/Abre una Base de Datos');", true);
    db_query(db, "INSERT INTO Gemix (Function, Description) VALUES ('db_query', 'Hace una consulta SQL a la Base de Datos');", true);
    db_query(db, "INSERT INTO Gemix (Function, Description) VALUES ('db_close', 'Cierra una Base de Datos');", true);
*/

    // Cerramos la base de datos correspondiente a 'db'
    db_close(db);  
  end
   
    
  // ------------------------------------------------------------------------------------------------------------------------------------------------------------ 

 
  write(0, 320, 10, 4, &db);
  write(0, 320, 20, 4, &table_records);  
  write(0, 320, 30, 4, &query);  
  write(0, 320, 40, 4, &query_fields);  
  write(0, 320, 50, 4, &query_records);  

  
  // Abrimos la base de datos '_GMX_dbms_api' cuyo gestor (DBMS) es 'SQLite' en sola lectura
  db = db_open("_GMX_dbms_api.db", dbms_sqlite, db_readonly);  
  
  // Obtenemos el numero total de records (rigas) de la tabla
  table_records = dbtable_get_numrecords(db, "Gemix");
  
  // Obtenemos una consulta para recorrer los record de la 'tabla' especificada
  query = dbtable_get_query(db, "Gemix");
  
  // Ejecutamos la consulta hasta obtener todos los resultasos de la misma (> 0 = quedan resultados, 0 = resultados acabados, < 0 = error de algun tipo) 
  row = 0;
  cy  = 80;
  while(dbquery_evaluate(query) > 0)  
    // Obtenemos el numero de campos de la consulta (este numero puede variar en base a la consulta)
    query_fields = dbquery_get_numfields(query);
    
    // Recorremos los campos de la consulta
    for(col = 0; col < query_fields; col++)
      // Averiguamos el tipo de campo de la consulta y obtenemos el valor adecuado
      switch(dbquery_get_type(query, col))
        case dbquery_type_int:
          if(dbquery_get_value(query, col, &query_values[col, row].value_int))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_int);
          end
        end
        case dbquery_type_double:
          if(dbquery_get_value(query, col, &query_values[col, row].value_double))
            write(0, 50 + (col * 20 * 6), cy, 3, &query_values[col, row].value_double);
          end
        end
        case dbquery_type_string:
          if(dbquery_get_value(query, col, &query_values[col, row].value_string))
            write(0, 50 + (col * 20 * 6), cy, 3, query_values[col, row].value_string);
          end
        end
      end
    end
    
    row += 1;
    cy  += 10;
  end
 
  // Cerramos la base de datos correspondiente a 'db' 
  db_close(db); 
 
  repeat
    frame;
  until(keydown(_esc));  
end
