# 1. Merges the training and test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject



# Create a new folder called 'course_project' and set the working directory to this folder. 

if (!file.exists("course_project")) {
        dir.create("course_project")
}
setwd("./course_project")


# Download and unzip the raw data into this new folder.

rawdata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(rawdata, destfile = "./course_project.zip")
unzip("course_project.zip")

# Read the tables within the unziped files, assign variables to them, and extract basic information 
# from them.
features <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")


# Read the table that contains all of the features and create an index for only the features that 
# include entries with 'mean()' or 'std()'.

features <- read.table("./UCI HAR Dataset/features.txt")
featureIndex <- grep("std()|mean()", features$V2)

read.table("./UCI HAR Dataset/activity_labels.txt")

read.table("./UCI HAR Dataset/test/subject_test.txt")
read.table("./UCI HAR Dataset/test/X_test.txt")
read.table("./UCI HAR Dataset/test/Y_test.txt")

read.table("./UCI HAR Dataset/train/subject_train.txt")
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "activityType")
# row.names = c(1 = "walking", 2 = "walkingUpstairs", 3 = "walkingDownstairs", 4 = "sitting", 5 = "standing", 6 = "laying")
training <- cbind(training_set, training_labels)

