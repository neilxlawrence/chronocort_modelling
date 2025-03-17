load_efmody_files_function <- 
  function(previous_file_name,
           file_load_message="files successfully loaded",
           parent_directory,
           list_of_data_frames_to_load=NULL
           ){
  
  #note the list of data frames to save and to load is listed in the load_efmody_libraries_and_sources_function file   
load(paste0(parent_directory, 
            "list_of_data_frames_to_save.Rdata"))

#if the user hasn't specified data frames to load, then load them all by copying the list_of_data_frames_to_save
if(is.null(list_of_data_frames_to_load)){
      list_of_data_frames_to_load <- list_of_data_frames_to_save
}
    
#now run through the list of dataframes to load, combining them with the previous file name to load them into the environment
for (i in 1:length(list_of_data_frames_to_load)){  
  
  data_frame_name_to_load <- 
    list_of_data_frames_to_load[[i]]
  
  file_name_to_load <- 
    (paste0(parent_directory, 
            data_frame_name_to_load, 
            "_after_", 
            previous_file_name, 
            ".Rdata"))
  #we now need a clause that looks for the file, and if it doesn't exist, informs the user
  
  if(!file.exists(file_name_to_load)){
    print(paste(file_name_to_load, 
                ": this file you are trying to load does not exist - please try reverting to a previous file to load from"))
  }
  
  if(file.exists(file_name_to_load)){
  #we load the frame into the environment, but this will be named the name it was saved, 
  #which if looped, will be generic  
  #print the name to let the user know what we are doing as some files will take a while to load
  print(paste("now loading", file_name_to_load))
  
  load(file_name_to_load, 
       envir = .GlobalEnv)
  
  #we therefore also have to assign it into the global environment, 
    #and assign the name it was originally in the list
  assign(x=data_frame_name_to_load, 
         value=data_frame_to_save, 
         envir=.GlobalEnv )
  }
}



}
