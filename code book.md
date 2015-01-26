Code Book for Project 
===================

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R code does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Labels the data set with descriptive variable names.
* Creates a second, independent data set with the average of each variable for each activity and each subject.


This last data set has each variable in a column and each observation in a row.

The labels are the same as the initial data set, but now they are the means of those original values.
