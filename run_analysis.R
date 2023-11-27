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
library(dplyr)

# Download and unzip the raw data into this new folder.

rawdata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(rawdata, destfile = "./course_project.zip")
unzip("course_project.zip")


# Read the tables within the unziped files and assign variables to them.

features <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# MERGE THE TRAINING AND TEST SET TO CREATE ONE DATA SET.

# First, I want to add columns to both the training and test set that indicates which activity
# was being performed and which subject was performing them. The activity is indicated by the 
# 'testLabels' and 'trainingLabels' data frames. Each number 1-6 corresponds to an activity as such: 
# 1 = "walking", 2 = "walkingUpstairs", 3 = "walkingDownstairs", 4 = "sitting", 5 = "standing", 
# 6 = "laying". The subjects are indicated by 'testSubjects' or 'trainSubjects' with the numbers 
# 1-30 being subject numbers. I merged the activity and subject number to the larger data set and 
# named the new columns 'activityType' and 'subject' with the new data frame as 'test' or 'training'.

read.table("./UCI HAR Dataset/test/subject_test.txt")
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "activityType")
testSubjects <-  read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test <- cbind(testSet, c(testLabels, testSubjects))

read.table("./UCI HAR Dataset/train/subject_train.txt")
trainingSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingLabels <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "activityType")
trainSubjects <-  read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
training <- cbind(trainingSet, c(trainingLabels, trainSubjects))

# Now that each of these data sets include the activity and have the same column names, I can
# merge them into one data set named 'combinedData'. By looking at the dimensions of the resulting
# data frame, the successful merge can be validated.

combinedData <- rbind(training, test)


# EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.

# Read the feature table that contains all of the features and create an index for only the features 
# that include entries with 'mean()' or 'std()'. I did not include meanFreq() in my index. My 
# interpretation of the directions for this assignment was to only extract mean or sd for each 
# measurement, thus, not including mean frequency. Then, I created a subset of 'combinedData' 
# named 'indexedData' that only included the features selected for and activity type.

features <- read.table("./UCI HAR Dataset/features.txt")
featureIndex <- grep("std|mean\\()", features$V2, value = FALSE)

indexedData <- subset(combinedData, select = c(featureIndex, activityType, subject))
colnames(indexedData) <- c(features$V2[featureIndex], "activityType", "subject")

# USE DESCRIPTIVE ACTIVITY NAMES TO NAME ACTIVITIES IN DATA SET.

# I created a lowercase, "tidy" vector of the activity labels and replaced the 1-6 activity labels
# with the corresponded activity name in the 'indexedData' data frame.

activityVector <- sub("_", "", tolower(activityLabels$V2))
indexedData$activityType <- activityVector[indexedData$activityType]


# APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# I replaced the provided names with descriptive column names that can be easily interpereted.

oldNames <- names(indexedData)
newNames <- oldNames[1:66] %>%
        gsub(pattern = "^t", replacement = "time") %>%
        gsub(pattern = "^f", replacement = "frequency") %>%
        gsub(pattern = "Acc", replacement = "Accelerometer") %>%
        gsub(pattern = "Gyro", replacement = "Gyroscope") %>%
        gsub(pattern = "Mag", replacement = "Magnitude") %>%
        gsub(pattern = "mean", replacement = "Mean") %>%
        gsub(pattern = "std", replacement = "Std") %>%
        gsub(pattern = "-|\\()", replacement = "") %>%
        gsub(pattern = "BodyBody", replacement = "Body")
colnames(indexedData) <- c(newNames, "activityType", "subject")

# CREATE AN INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.

indexedData %>%
        group_by(subject, activityType) %>% 
        summarise(across(all_of(newNames), mean))


