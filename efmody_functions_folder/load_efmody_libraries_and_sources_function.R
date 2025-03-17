load_efmody_libraries_and_sources_function <- 
  function(thing_to_print="efmody functions loaded"){
  print(thing_to_print)
    
    #first we create a list of dataframes that we save, if they exist, after each file to be able to split the code up   
    #add a frame to this list to ensure it is both saved after a file if it exists, and loaded at the beginning of a file if it exists
list_of_data_frames_to_save <- 
  as.list(c(
      "steroid_profiles", #one biomarker measurement on each row, long format
      "dosing_frame_by_visit", # this is the dose of glucocorticoid each patient was on at each visit, that is contained within steroid_profiles (but duplicated visits in that frame as there are multiple biomarkers measured at each visit)
      "wide_actual_regular_exposure", 
      "area_under_curve_frame",
      "patient_details",
      "patient_body_metrics_wide",
      "all_patient_spline_fits",
      "all_patient_spline_fits_both_markers",
      "spline_summary_stats_total_by_degrees",
      "list_of_spline_curve_frames_Androstenedione",
      "list_of_visit_spline_fit_frames_Androstenedione",
      "list_of_spline_curve_frames_17OHP",
      "list_of_visit_spline_fit_frames_17OHP",
      "list_of_spline_difference_frames",
      "list_of_spline_model_fit_frames_joined",
      "giant_spline_difference_frame",
      "giant_spline_fit_frame_17OHP",
      "giant_spline_fit_frame_Androstenedione",
      "giant_spline_model_fit_frame_joined",
      "giant_spline_curve_frame_Androstenedione",
      "giant_spline_curve_frame_17OHP",
      #change of name for the saliva
      "giant_salivary_spline_fit_frame",
      "giant_salivary_spline_fit_frame_flexible_degrees_of_freedom",
      "salivary_auc_frame_long",
      "salivary_auc_frame_wide",
      "salivary_auc_frame_flexible_degrees_of_freedom_long",
      "salivary_auc_frame_flexible_degrees_of_freedom_wide",
      "steroid_profiles_ln_17OHP",
      "steroid_profiles_ln_Androstenedione",
      "steroid_profiles_wide_ln_values",
      "steroid_profiles_wide_ln_values_Androstenedione",
      "steroid_profiles_wide_ln_values_17OHP",
      "steroid_profiles_with_auc_17OHP",
      "steroid_profiles_with_auc_Androstenedione",
      "hkmeans_clusters_by_both_markers_ln_AUC_to_save",
      "hkmeans_clusters_by_both_markers_raw_data_to_save",
      "hkmeans_clusters_by_both_markers_ln_AUC_to_save_17OHP_dependent",
      "hkmeans_clusters_by_both_markers_ln_AUC_to_save_Androstenedione_dependent",
      "spline_summary_data_both_markers",
      "clusters_by_dtw_for_17OHP",
      "clusters_by_dtw_for_Androstenedione",
      "clusters_by_dtw_for_both_markers_joined",
      "kmeans_clusters_by_ln_AUC_17OHP_to_save",
      "kmeans_clusters_by_ln_AUC_Androstenedione_to_save",
      "clusters_by_kmeans_for_ln_AUC_each_marker_clustered_alone_joined",
      "steroid_profiles_Androstenedione",
      "steroid_profiles_androstenedione",
      "steroid_profiles_17OHP",
      "normative_data",
      #addition of salivary data
      "single_centre_saliva_data",
      "single_centre_saliva_data_long",
      "normative_data_17OHP",
      "normative_data_Androstenedione",
      "normative_data_Testosterone",
      "normative_data_wide",
      "normative_patient_details",
      "normative_patient_details_and_SST",
      "normative_all_patient_spline_fits_both_markers",
      "giant_normative_spline_difference_frame",
      "giant_normative_spline_fit_frame_17OHP",
      "giant_normative_spline_fit_frame_Androstenedione",
      "giant_normative_spline_curve_frame_Androstenedione",
      "giant_normative_spline_curve_frame_17OHP",
      "giant_normative_spline_model_fit_frame_joined",
      "cross_correlation_individual_data_points_to_join",
      "cross_correlation_best_lags_to_join",
      "both_markers",
      "all_markers_wide",
      "total_mcp_results",
      "all_study_patient_ccf_points",
      "all_study_patient_ccf_points_with_arm",
      "all_study_patient_acf_points_17OHP_with_arm",
      "all_study_patient_acf_points_androstenedione_with_arm",#the study cross correlation points to plot against normative data
      "auc_total_rankings_across_all_visits",
      "testosterone_measurements", #this is taken from ADLB in file 1,
      "steroid_profiles_with_auc_and_saliva_wide" # this i snow created in file 52 and has all saliva and serum in one wide frame with all calculated aucs
    ))

#assign the list to the global environment
    assign(x="list_of_data_frames_to_save", 
           value=list_of_data_frames_to_save, 
           env=.GlobalEnv)

#save the list outside of R 
    dir.create("efmody_data_files_to_load")
    save(x=list_of_data_frames_to_save, 
         file = paste0("./efmody_data_files_to_load/list_of_data_frames_to_save.Rdata"), 
         compress=F)    

suppressWarnings({
  library(vctrs)
  library(rlang)
  library(nlme)
  library(sitar)
  library(plyr)
  library(dplyr)
  library(shrink)
  library(bootImpute)
  library(mfp)
  library(piecewiseSEM)
  library(tibble)
  library(DescTools)
  library(summarytools)
  library(tidyr)
  library(ggplot2)
  library(mice)
  library(miceRanger)
  library(sjstats)
  library(rlist)
  library(plotROC)
  library(missForest)
  library(pROC)
  library(ggpubr)  
  library(doRNG)
  library(gridExtra)
  library(readxl)
  library(Hmisc)
  library(rms)
  library(lme4)
  library(lmerTest)
  library(merlin)
  library(factoextra)
  library(NbClust)
  library(ggdendro) # dendrograms
  library(gplots) # heatmap
  library(tseries) # bootstrap
  library(TSclust) # cluster time series
  library(dtwclust) # cluster time series with dynamic time warping
  library(cocor) # comparison or correlation coefficients across groups
  library(mcp) # univariate bayesian multiple change point analysis
  library(ecp) # multivariable change point analyis
  library(rgl)
  library(glmnet) # to run LASSO models
  library(brms) #to run bayesian joint models
  source("./efmody_functions_folder/efmody_plot_themes.R")
  source("./efmody_functions_folder/save_efmody_files_function.R")
  source("./efmody_functions_folder/load_efmody_files_function.R")

})


}
