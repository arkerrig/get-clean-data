library(dplyr)

#read_df function creates dataframe 'tf' from current working directory and given filename
read_df <- function(file_name) {
  tf <- read.delim2(file_name, header=FALSE, sep="")
}

#make_table function creates dataframe for given dataset ('test' or 'train') from supplied data. 
#X data supplies raw measurement, Y data supplies activity number, subject data supplies participant id number.
#activity_labels.txt is used as a lookup file to give descriptive activity names to column 2 of final returned dataframe (steps 3 & 4 of assignment)
#column 1 name is 'subjects' for subject id's; column 2 is 'activities (step 4 of assignment)
#features.txt is used to give descriptive names to all measurements in columns 3 or higher 
make_table <- function(data_set) {

  #create dataframes for measurements, subject id's, activity numbers, and activity labels
  df_measurements <- mutate_all(read_df(sprintf("./%s/X_%s.txt",data_set,data_set)), function(x) as.numeric(as.character(x)))
  df_subj <- read_df(sprintf("./%s/subject_%s.txt",data_set,data_set))
  df_activity <- read_df(sprintf("./%s/Y_%s.txt",data_set,data_set))
  df_act_labels <- read_df("./activity_labels.txt")

  #convert activity numbers into activity names via given labels
  df_act_name <- df_activity
  df_act_name[] <- df_act_labels$V2[match(unlist(df_activity), df_act_labels$V1)]

  #create dataframe of subject id's and activity names
  df_subj_act <- cbind(df_subj,df_act_name)

  #create dataframe of subject id's, activity names, and measurements without descriptive column names
  df_full_nonames <- cbind(df_subj_act, df_measurements)

  #create dataframe of descriptive measurement names as given
  df_var_names <- read.delim2("./features.txt", header=FALSE, sep="")

  #create dataframe with names for all columns of final dataframe
  column_names <- append(c("subject","activity"), df_var_names[,2])

  #assign column names and return completed, descriptive, tidy dataset for given dataset
  colnames(df_full_nonames) = column_names
  df_full <- df_full_nonames

}

#create dataframes for test and train datasets
df_test <- make_table("test")
df_train <- make_table("train")

#combine test and train datasets into on data set (step 1 in assignment)
df_all <- rbind(df_test, df_train)

#creates dataframe of just mean and standard deviation variables (step 2 in assignment)
df_select <- df_all[,1:2]
df_select <- cbind(df_select,(select(df_all, contains("mean") | contains("std"))))

#creates tidy dataset of unique subject/activities and exports to csv file (step 5 of assignment)
df_avgs <- df_select %>% group_by(subject, activity) %>% summarise_all("mean")
write.csv(df_avgs,"./tidy_averages.csv",row.names=FALSE)