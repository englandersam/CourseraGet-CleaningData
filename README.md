Getting and Cleaning Data
Project Scope
The script found inside this repo (run_analysis.R) does the following:
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive activity names.
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Steps
1.	(Optional) Download the data source and put into a folder on your local drive..
2.	Use setwd() to make the UCI HAR Dataset, your working directory.
3.	Place run_analysis.R in your working directory 
4.	Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.
Dependencies
run_analysis.R depends on having dplyr installed already
