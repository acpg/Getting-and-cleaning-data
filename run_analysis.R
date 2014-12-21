# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))

subj <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))

Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices]
names(X) <- features[indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(subj) <- "subject"
cleaned <- cbind(subject, Y, X)
write.table(cleaned, "merged_data.txt")

# 5. Creates a second, independent data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(subj)[,1]
numSubjects = length(unique(subj)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (i in 1:numSubjects) {
  for (j in 1:numActivities) {
    result[row, 1] = uniqueSubjects[i]
    result[row, 2] = activities[j, 2]
    tmp <- cleaned[cleaned$subject == i & cleaned$activity == activities[j, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "data_averages.txt")
