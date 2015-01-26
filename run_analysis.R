library(plyr)
setwd("~/Dropbox/COURSERA/DATA SCIENCE/03 Getting and Cleaning Data/Project")
setwd('UCI HAR Dataset')

# Merges the training and the test sets to create one data set.

X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))
subj <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))
Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))

# Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
X <- X[ , grep("-mean\\(\\)|-std\\(\\)", features[, 2])]
features <- features[grep("-mean\\(\\)|-std\\(\\)", features[, 2]), 2]
names(X) <- gsub("\\(|\\)", "", features)

# Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# Appropriately labels the data set with descriptive activity names.

names(subj) <- "subject"
dat <- cbind(subj, Y, X)

# Creates a second, independent data set with the average of each variable for each activity and each subject.

aux <- aggregate(x = dat[, 3:ncol(dat)], 
                 by = list(subject = dat$subject, activity= dat$activity), 
                 FUN = "mean", na.rm = T)

write.table(aux, "data_averages.txt", row.name = FALSE)
