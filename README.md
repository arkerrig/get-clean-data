README.md

run_analysis.R cleans and merges test and train datasets from the Human Activity Recognition Using Smartphones Dataset.
Final output is a cleaned dataframe in the file tidy_averages.txt.

It uses two key functions:

read_df:
creates dataframe 'tf' from current working directory and given filename, used to create dataframes for given txt files

make_table:
creates dataframe for given dataset ('test' or 'train') from supplied data. 
X data supplies raw measurement, Y data supplies activity number, subject data supplies participant id number.
activity_labels.txt is used as a lookup file to give descriptive activity names to column 2 of final returned dataframe (steps 3 & 4 of assignment)
column 1 name is 'subjects' for subject id's; column 2 is 'activities (step 4 of assignment)
features.txt is used to give descriptive names to all measurements in columns 3 or higher 


Use of functions:
make_table calls read_df throughout its run to create dataframes for each needed input file

The body of run_analysis calls make_table twice - once to create a dataframe for the test dataset and a second time to create a dataframe for the train dataset


To properly run, run_analysis.R needs to have the following files from the https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip dataset stored in the current working directory:
'./test/X_test.txt'
'./test/Y_test.txt'
'./test/subject_test.txt'
'./train/X_train.txt'
'./train/Y_train.txt'
'./train/subject_train.txt'
'./activity_labels.txt'