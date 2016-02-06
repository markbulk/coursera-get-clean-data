## Note this script will work on data found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Because this data set is known to be internally consistent, there is no error checking on merges 
## to ensure no rows dropped out.

## Load required libraries
library(tidyr)
library(dplyr)
library(data.table)

## set working directory to the root of where your data set resides; commented out, because the submission
## instructions said to assume that "that can be run as long as the Samsung data is in your working directory."
#setwd("/Volumes/Kingston/DropBox/Coursera/3 Data Cleaning/Project/UCI HAR Dataset/")

## Read in descriptive, relational information that is constant over both the test and the training sets
dt.activities <- data.table(read.csv(paste0("activity_labels.txt"), 
                                   sep = " ", header = FALSE, col.names = c("activity", "activity_name")))
dt.features <- data.table(read.csv(paste0("features.txt"),
                                  sep = " ", header = FALSE, col.names = c("feature", "measurement_type")))
dt.features[, measurement_type := as.character(measurement_type)]
## Point 2: We will only want the measurements coded as "mean", "Mean" and "std" for mean and stardard deviation
dt.features <- dt.features[grepl("[mM]{1}ean", measurement_type) | grepl("std", measurement_type)]
## Point 4: All columns in dt.final have descriptive variable names, so here there is more description added to make things clear
dt.features[, measurement_type := gsub("(Body|Gravity|Gyro|Jerk)", "\\1_", measurement_type, perl = TRUE)]
dt.features[, measurement_type := gsub("^angle\\(", "RelativeAngleBetween_", measurement_type)]
dt.features[, measurement_type := gsub("^t|_t", "_time_", measurement_type)]
dt.features[, measurement_type := gsub("^f", "frequency_", measurement_type)]
dt.features[, measurement_type := gsub("\\(\\)", "_", measurement_type)]
dt.features[, measurement_type := gsub("Mag", "Magnitude_", measurement_type)]
dt.features[, measurement_type := gsub("Freq", "Frequency_", measurement_type)]
dt.features[, measurement_type := gsub("Acc", "Acceleration_", measurement_type)]
dt.features[, measurement_type := gsub("-std", "StandardDeviation", measurement_type)]
dt.features[, measurement_type := gsub("[Mm]ean", "_Mean_", measurement_type)]
dt.features[, measurement_type := gsub("-|,", "_", measurement_type)]
dt.features[, measurement_type := gsub("\\)", "", measurement_type)]
dt.features[, measurement_type := gsub("__|___", "_", measurement_type)]
dt.features[, measurement_type := gsub("_$|^_", "", measurement_type)]

## Point 1: Merges test and training data sets. Load from the working directory
forms <- c("test", "train")
dt.data <- do.call(rbind, lapply(forms, function(form){
    dt.subject <- data.table(read.table(file = paste0(form, "/subject_", form, ".txt"), header = FALSE,
                                        col.names = "subject"))
    dt.activity <- data.table(read.table(file = paste0(form, "/y_", form, ".txt"), header = FALSE,
                                         col.names = "activity"))
    dt.measurement <- data.table(read.table(file = paste0(form, "/X_", form, ".txt"), header = FALSE))
    ## link data elements together
    dt.full <- cbind(dt.subject, dt.activity, dt.measurement)
    ## keep track as to whether was test or training data
    dt.full[, data_form := form]
    return(dt.full)
}))
## Point 3: Merge to get activity names as part of the data set
dt.final <- merge(dt.data, dt.activities, by="activity")[, activity := NULL]

## reshape data to a tidy form (turn V1:V561 into a column)
dt.final <- data.table(gather(data=dt.final, key=feature, value=value, V1:V561))

## adjust feature column to just the number, so we can merge on desired features
dt.final[, feature := extract_numeric(feature)]

## Point 2: merge with features (to get the labels), but only with the desired features;
##          and drop columns that are no longer needed
dt.final <- merge(dt.final, dt.features, by="feature")[, feature := NULL]

## Point 4: All columns in dt.final have descriptive variable names, reordered so that 
##          the observation is on the far right
dt.final <- dt.final[, list(data_form, subject, activity_name, measurement_type, value)]
write.csv(dt.final, file = "tidy_data.csv", row.names = FALSE)

## Point 5: From the data set in Point 4, creates a second, independent tidy data set with
##          the average of each variable for each activity and each subject.
dt.summary <- dt.final[, list(value = mean(value)), by=list(subject, activity_name, measurement_type)]
write.csv(dt.summary, file = "tidy_data_summary.csv", row.names = FALSE)
