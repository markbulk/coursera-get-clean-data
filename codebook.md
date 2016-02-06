# Codebook.md

This file describes the data (in table form) found in tidy_data.csv and tidy_data_summary.csv.  This assumes that you have read and are familiar with the README.txt and features_info.txt files from the original data set.

# Variables

1. *subject*: a number between 1 and 30 indicating a specific volunteer (with no other identifying characteristics) who generated the data
2. *activity_name*: an english-language description of what they were doing when they generated the data.  This is equivalent of an ENUM field, with six available levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING
3. *measurement_type*: more information below, but at high level, it is a summary of very specific kind of information about the subject's movements while doing the different activities.  This is derived from the information in "feature.txt" in the original data set.
4. *value*: the specific measurements or further summarization (as described below in the tidy_data_summary.csv section).  As noted in the original documentation, the values are normalized between -1 and 1.

# tidy_data.csv Details

This file contains all summary observations of mean and standard deviation from the original data set, transformed in a tidy data form as described in the Variables section.  It contains a header line, with the variables as described above.

# tidy_data_summary.csv Details

This file is a summary of the tidy_data.csv file.  The values represent the mean, by subject, activity and measurement_type of the data in tidy_data.csv.  The file contains a header line, with the variables as described above.

# measurement_type Details

In an attempt to be more descriptive, this field was expanded from the definitions in features_info.txt in the following ways:

1. The underscore "_" was used throughout to separate portions of the field definition.
2. Abbreviations were expanded in the following fashion (original .. updated):
  1. angle .. RelativeAngleBetween
  2. t .. time (generally a leading t, but also cases where it occurs after 'angle(' )
  3. f .. frequency (leading f)
  4. Mag .. Magnitude
  5. Freq .. Frequency
  6. Acc .. Acceleration
  7. std .. StandardDeviation
3. Extraneous '-' and '()' were removed for clarity

To understand what each measurement_type represents, refer back to features_info.txt.
