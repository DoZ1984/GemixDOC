******* Photon Network *******
===// https://www.photonengine.com

---------------------------
--- GemixPhoton
---------------------------
http://www.gemixstudio.com/forums/viewtopic.php?f=205&t=6408
******* Colombian Developers (MIT) License  *******
===  LastUpdate: 20/02/2018

COMPILER_OPTIONS _use_cstyle_sizeof; //fix sizeof GemixPhoton pack sizes  

// *** ================ GLOBALS VARIABLES ================ 

	* INT photon_connected (= 0)  //return  true if connected

	* INT photon_player_id (= 0) //return current player number (numero incremental inrepetible +1)

	* INT photon_player_max (= 4)  //set max players in room (default 4)

	* INT photon_player_count (= 0) //return room count players

	* INT photon_debug (= 0)  //set true to enable debug (slow)

	* INT photon_is_master_client (= 0) //return true if client is master client

	* INT photon_compress_enable (= 1) //set true to enable compress packets (default true)

	* INT photon_encrypt_enable (= 0)  //set true to enable encrypt packets

	* INT photon_master_client_id (= 0)  //return master client  in current room

	* INT photon_server_ping (= 0) //return my ping

	* INT photon_server_time (= 0)  //return server time in milliseconds


// *** ================ TYPEDEFS ==============

	* TYPE photon_packed
		  int player_id;
		  int data_length;
		  void  *data;
	 end 

	* TYPE photon_event 
		  int code_event;
		  int  data_id;
	  end 

	* TYPE photon_room 
		  int  max_players;
		  int  num_players;
		  string name;
	  end 

	* TYPE photon_player 
		 int  player_id;
		 int  is_master_client;
		 string name;
	  end 


// *** ================ CONSTANTS =============

//NET EVENTS 
	* photon_event_player_connected 
	* photon_event_player_disconnected 

	* photon_event_connected 
	* photon_event_connecting 
	* photon_event_joining 
	* photon_event_joined 
	* photon_event_disconnecting 
	* photon_event_disconnected
	* photon_event_player_kicked

	* photon_event_error_connecting 
	* photon_event_error_joining 
	* photon_event_error_leaving
	* photon_event_error_password

	* photon_event_room_properties_change 
	* photon_event_player_properties_change 


//REGION MODES
	* photon_region_default 
	* photon_region_select 
	* photon_region_best 

// *** ================ FUNCTIONS =============

	//CORE

	* INT PHOTON_INITIALIZE(String matchName,String playername,String appversion,String appid) 
    //Initialize Photon Vars 
	
	* INT PHOTON_FINALIZE()
    //Unload Photon Module
	
	
	
	//PACKS

	* INT PHOTON_PACK_GET()
    //Get net packet   	

    * INT PHOTON_PACK_REMOVE() 
	//Remove a net pack (first use get) 

	* INT PHOTON_PACK_SEND(void *data, int reliable) 
    // Send a net pack (reliable packed set to true)

	* INT PHOTON_PACK_SENDGROUP(void *data,int reliable void *targets,int targets_count) 
	//Send a  net group, send any packets to   specified players in targets var.  
	//Ex:      Client_Targets[0]=8;	  //send to player with  id 8
	//photon_pack_sendgroup(& paquete,true, &Client_Targets,  1); // 1 		target	
	
	* INT PHOTON_EVENT_GET() 
	//get net event	

	* INT PHOTON_EVENT_REMOVE()
	//remove a net event (first use get)

	
	
	//UTILS

	* INT PHOTON_MALLOC(Int size)
	//Allocates a block of size bytes of memory, returning a pointer to the beginning of 	the block.

	* INT PHOTON_MEMSET(Void *data, int value ,Int size) 
	//Sets the first num bytes of the block of memory pointed by data to the specified 	value

	* INT PHOTON_MEMCPY(Void *dest,Void *source,Int total) 
	//Copies the values of num bytes from the location pointed to by source directly to 	the memory block pointed to by destination

	* INT PHOTON_FREE(Void *data) 
	//Deallocate memory block

	
	
	//DEBUG

	* INT PHOTON_LOG(String text)
	//Create a log file with appended text

	
	
	//ROOMS

	* INT PHOTON_ROOM_JOINORCREATE()
    //Join or create a room (if not exists then create)

	* INT PHOTON_ROOM_CREATE()
    //Create a Room

	* INT PHOTON_ROOM_JOIN()
    //Join a Existing Room 
	
	* INT PHOTON_ROOM_LIST() 
	//List rooms available in current region , return rooms count

	* INT PHOTON_ROOM_GET(Int room_id) 
	//Get a room 

	* INT PHOTON_ROOM_GETCURRENT() 
	//Get current room (join a room is required)

	* INT PHOTON_ROOM_SET_PASSWORD(string password) 
	//Set current room password

	* INT PHOTON_ROOM_SET_OPEN(int isopen) 
	//Set current room, open and close to new players , Don't set isOpen to false, or else 	no one can join.'

	* INT PHOTON_ROOM_SET_VISIBLE(int visible) 
	//Set current room, visible in rooms search (excelent to private rooms),  Set "visible" to false to hide a room from the lobby.
	
	
	
	//PLAYERS	
	
	* INT PHOTON_PLAYER_LIST() 
	//List Players in current room, return players count(Super fast) Actualiza lista

	* INT PHOTON_PLAYER_GET(INT player_id) 
	//Get a player info (1,2,3,4,5....)
	
	* INT PHOTON_PLAYER_GET_BY_INDEX(Int playerIndex) 
	//Get a player by Index (0 to PHOTON_PLAYER_LIST() - 1)
	
	* INT PHOTON_PLAYER_GETCURRENT() 
	//Get  current local player

	* INT PHOTON_PLAYER_KICK(int player_id) 
	//Kick  player_id
	
	* INT PHOTON_PLAYER_SET_PROP(string  key, string value) 
	//set player property

	* STRING PHOTON_PLAYER_GET_PROP(int playerid, string  key) 
	//get player property
	
	
	//REGIONS

	* INT PHOTON_REGION_LIST()
	//List regions available 

	* STRING PHOTON_REGION_GET(Int region_id)
	//Get region 

	* INT PHOTON_REGION_SET(Int region_mode,String region_token) 
 	//Set a region using a mode, PHOTON_REGION_DEFAULT , PHOTON_REGION_SELECT , PHOTON_REGION_BEST 
	//Ej:
	//select america 
		PHOTON_REGION_SET(PHOTON_REGION_SELECT,"us");

	//select best region (best ping)
		PHOTON_REGION_SET(PHOTON_REGION_BEST,"");

	
	//select default region  
		PHOTON_REGION_SET(PHOTON_REGION_DEFAULT,"");
 	
	//More region Tokens available in: 
	// https://doc.photonengine.com/en/pun/current/reference/regions

	
	
	//SERVIDOR
	* STRING PHOTON_SERVER_ADDRESS() 
	//Get server IP adddress
	
	
	
	//COMPRESS
	* INT PHOTON_COMPRESS_INITIALIZE() 
	//initialize compress zlib library, return a valid zlib ID

	* INT PHOTON_COMPRESS_FINALIZE(int zlibID) 
	//finalize compress ID and free mem

	* INT PHOTON_COMPRESS(pointer data, int datalength, int pointer dataDest, int pointer dataDestLength) 
	//compress bytes

 	* INT PHOTON_UNCOMPRESS(pointer data, int datalength, int pointer dataDest, int	pointer dataDestLength) 
	//uncompress bytes

