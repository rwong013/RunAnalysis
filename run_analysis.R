#Download data set. Extract the file using 3rd party program, not in the script
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/run_analysis.zip")

#Load libraries used 
library(data.table)
library(dplyr)

#Reads and combines test and training data sets. Gives columns descriptive names
#lists who the subject taking the test
subject_test <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/test/subject_test.txt")
subject_train <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject_test, subject_train)
subject <- rename(subject, subjectID = V1)

#training labels
y_test <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/test/y_test.txt", colClasses = "factor")
y_train <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/train/y_train.txt", colClasses = "factor")
y <- rbind(y_test, y_train)
y <- rename(y, activities = V1)
#Give the activities label meaningful names, instead of 1-6 numbers.
for(i in 1:(nrow(y))) {
  
  if(y[i] == 1){ y[i] <- "WALKING" 
  } else if( y[i] == 2){
    y[i] <- "WALKING_UPSTAIRS"
  } else if( y[i] == 3) {
    y[i] <- "WALKING_DOWNSTAIRS"
  } else if( y[i] == 4) {
    y[i] <- "SITTING"
  } else if( y[i] == 5) {
    y[i] <- "STANDING"
  } else if( y[i] == 6) {
    y[i] <- "LAYING"}
  else { }
}

#read training data
#read text file with column names
colnames <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/features.txt", select = "V2")
x_test <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/test/X_test.txt", col.names = t(colnames))
x_train <- fread("C:/Users/rwong/Documents/DSS/GettingCleaningData/RunAnalysis/UCI HAR Dataset/train/X_train.txt", col.names = t(colnames))
x <- rbind(x_test, x_train)
x_sub <- select(x, sort(c(grep("mean()", names(x), fixed = TRUE), grep("std()", names(x), fixed = TRUE))))

#combines the three tables of subjects, activities and data
activitysub <- cbind(subject,y,x_sub)
activitymelt <- melt(activitysub, c("subjectID", "activities"))
activitysummary <- dcast.data.table(activitymelt, subjectID + activities ~ variable,mean)