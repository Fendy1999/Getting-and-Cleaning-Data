## load required packages

## load the data.table and dplyr packages
library(dplyr)
library(data.table)

################################################################
## 1. Merges the training and the test sets to create one data set
#################################################################
### read files into data frames
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activityLabel <-read.table("./UCI HAR Dataset/activity_labels.txt")

### add column name for subject files
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

### add column name for activity label files
names(y_train) <- "activity"
names(y_test) <- "activity"

### add column names for measurement files
featureNames <- read.table("./UCI HAR Dataset/features.txt")
names(x_train) <- featureNames$V2
names(x_test) <- featureNames$V2

### combine files into one dataset 
trainData <- cbind(subject_train, y_train, x_train)
testData <- cbind(subject_test, y_test, x_test)
combinedData <- rbind(trainData, testData)

#########################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###########################################################################################
# Fine columns contain "mean()" or "std()"
col_meanstd <- grepl("mean\\(\\)", names(combinedData))|grepl("std\\(\\)", names(combinedData))


# remove unnecessary columns
combinedFinal <- cbind(combinedData[,c(1:2)], combinedData[, col_meanstd])

###################################################################
## 3. Uses descriptive activity names to name the activities in the data set.
###################################################################

# convert the activity column from integer to labels
combinedFinal$activity <- factor(combinedFinal$activity, labels=activityLabel$V2)

#####################################################################
## 4.Label dataset with descriptive variable names
#####################################################################
names(combinedFinal) <-gsub("Acc", "Accelerometer", names(combinedFinal))
names(combinedFinal) <-gsub("Gyro", "Gyroscope", names(combinedFinal))
names(combinedFinal) <-gsub("Mag", "Magnitude", names(combinedFinal))
names(combinedFinal) <-gsub("^t", "Time", names(combinedFinal))
names(combinedFinal) <-gsub("^f", "Frequency", names(combinedFinal))

##################################################################################
## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
##################################################################################

# create the tidy data set with average
tempData <- data.table(combinedFinal)
tidyData <- aggregate(. ~subjectID + activity, tempData, mean)
# write the tidy data set to a file
write.csv(tidyData, "tidy.txt", row.names=FALSE)
