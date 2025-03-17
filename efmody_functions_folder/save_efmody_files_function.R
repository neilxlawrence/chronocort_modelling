#this file creates the function of the data frames to save after each file if they exist

save_efmody_files_function <- 
  function(parent_directory,
           parent_file_name,
           file_save_message="files successfully saved"){
  
#note the list of data frames to save and to load is listed in the load_bp_libraries_and_sources_function file   
load(paste0(parent_directory, 
            "list_of_data_frames_to_save", 
            ".Rdata"))
  
for (i in 1:length(list_of_data_frames_to_save)){  
  
  name_of_data_frame_to_save <- 
    list_of_data_frames_to_save[[i]]
  
  if(exists(name_of_data_frame_to_save)){
    data_frame_to_save <- get(eval(list_of_data_frames_to_save[[i]]))
    
    #let the user know what frame we are about to save
    print(paste("now saving", name_of_data_frame_to_save))
    #save as csv only if the item is a data frame
#I've stopped saving as csv as well as saving as R files for the time being because of the sheer size of the files and space it was taking up    
#    if (is.data.frame(data_frame_to_save)){
#    write.csv(x=data_frame_to_save, 
#              file=paste0(parent_directory, name_of_data_frame_to_save, "_after_", parent_file_name, ".csv"),
#              row.names = FALSE)
#    }
    #save the item as an Rdata file no matter what sort of file it is, so that we can save lists as well as data frames
    save(x=data_frame_to_save, 
         file = paste0(parent_directory, 
         name_of_data_frame_to_save, 
         "_after_", parent_file_name, 
         ".Rdata"), 
         compress=F)
  }
}

print(file_save_message)  
}
