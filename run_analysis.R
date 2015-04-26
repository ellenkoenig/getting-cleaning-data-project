# This scripts cleans the data provided in 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# as specified in the project assignment for the Coursera course "Getting and cleaning data"
# The steps of this script are outlined below

# Read the column names
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
col.names <- as.list(features[,2])


# Read the test data and filter the relevant columns
full.test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=col.names)
library("dplyr")
test <- select(full.test, matches("mean|std", ignore.case = F))
test <- select(test, -contains("meanFreq"))

#Read the train data and filter the relevant columns
full.train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=col.names)
train <- select(full.train, matches("mean|std", ignore.case = F))
train <- select(train, -contains("meanFreq"))

# Add activity labels to the test and train data
test['activity'] <-readLines("UCI HAR Dataset/test/y_test.txt")
train['activity'] <- readLines("UCI HAR Dataset/train/y_train.txt")

# Add subject information to the test and train data
test['subject'] <- readLines("UCI HAR Dataset/test/subject_test.txt")
train['subject'] <- readLines("UCI HAR Dataset/train/subject_train.txt")

# Merge test and train data into one frame
combined.data <- rbind(train, test)

# Resolve activity labels (convert numbers into labels)
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity", "activity_label"))
complete.data <- merge(combined.data, activity.labels)
complete.data <- select(complete.data, -activity)
# Extract averages for each measurement per activity and subject into a clean dataset
library("data.table")
dt <- data.table(complete.data)
extracted.data <- dt[, lapply(.SD, mean), by=list(activity_label, subject)]
# Write clean dataset into a file
write.table(extracted.data, "cleaned_data.txt", row.name=FALSE)