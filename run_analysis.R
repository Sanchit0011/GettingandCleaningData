
#Downloading zip file which contains training data and test data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "C:/R/Dataset.zip")

#Unzipping the zip file and extracting it 
unzip(zipfile = "C:/R/Dataset.zip", exdir = "C:/R")

#reading training data into R
x_train <- read.table("C:/R/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/R/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("C:/R/UCI HAR Dataset/train/subject_train.txt")

#reading test data into R
x_test <- read.table("C:/R/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/R/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("C:/R/UCI HAR Dataset/test/subject_test.txt")

#reading list of all features into R
features <- read.table("C:/R/UCI HAR Dataset/features.txt")

#reading activity labels into R
activity_labels <- read.table("C:/R/UCI HAR Dataset/activity_labels.txt")

#assigning appropriate column names to training data, test data and activity labels 
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityid"
colnames(subject_train) <- "subjectid"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityid"
colnames(subject_test) <- "subjectid"

colnames(activity_labels) <- c("activityid", "activitytype")

#merging training data and test data together
merge_train <- cbind(x_train, y_train, subject_train)
merge_test <- cbind(x_test, y_test, subject_test)
dataset <- rbind(merge_train, merge_test)

#extracting measurements on the mean and standard deviation of each measurement
meanstd <- (grepl("activityid", colnames(dataset)) | grepl("subjectid", colnames(dataset)) | grepl("mean..", colnames(dataset)) | grepl("std..", colnames(dataset)))
dataset <- dataset[, meanstd]

#appropriately labeling the data set with descriptive variable names
properdataset <- merge(dataset, activity_labels, by = "activityid", all.x = TRUE)

#creating a second, independent tidy data set with the average of each variable for each activity and each subject
tidydataset <- aggregate(. ~subjectid + activityid, properdataset, mean)

#writing the final dataset to the working directory
write.table(tidydataset, "tidydataset.txt", row.name = FALSE)








