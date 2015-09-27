# Download/Unzip the file and put the file in the data folder

if(!file.exists("./data")){dir.create("./data")}
FURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FURL,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# unzipped files are in the folderUCI HAR Dataset. 

path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)


#Read the Activity/Subject/Features files

dataActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

dataSubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

dataFeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)



#Merges the training and the test sets to create one data set
#Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#Define names 
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2


#Merge columns to get the data frame Dat for all data
dataCombine <- cbind(dataSubject, dataActivity)
Dat <- cbind(dataFeatures, dataCombine)

#Extracts only the measurements on the mean and standard deviation for each measurement

SubNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#Subset the data frame Data by seleted names of Features
Names<-c(as.character(SubNames), "subject", "activity" )
Dat<-subset(Dat,select=Names)

#Uses descriptive activity names to name the activities in the data set
#Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

#Factorize Variale activity
Dat$activity <- factor(Dat$activity, labels = activityLabels$V2)

#Appropriately label the data set with descriptive variable names
names(Dat)<-gsub("^t", "time", names(Dat))
names(Dat)<-gsub("^f", "frequency", names(Dat))
names(Dat)<-gsub("Acc", "Accelerometer", names(Dat))
names(Dat)<-gsub("Gyro", "Gyroscope", names(Dat))
names(Dat)<-gsub("Mag", "Magnitude", names(Dat))
names(Dat)<-gsub("BodyBody", "Body", names(Dat))

#Creates a second,independent tidy data set with the average of each variable for each activity and each subject
library(plyr);
Dat2<-aggregate(. ~subject + activity, Dat, mean)
Dat2<-Dat2[order(Dat2$subject,Dat2$activity),]
write.table(Dat2, file = "tidydata.txt",row.name=FALSE)
