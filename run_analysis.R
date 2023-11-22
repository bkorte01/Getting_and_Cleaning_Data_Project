# 1. Merges the training and test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject



# Create a new folder called "course_project" and set the working directory to this folder. 

if (!file.exists("course_project")) {
        dir.create("course_project")
}
setwd("./course_project")

# Download and unzip the raw data into this new folder.

rawdata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(rawdata, destfile = "./course_project.zip")
unzip("course_project.zip")

