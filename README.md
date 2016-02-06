# coursera-get-clean-data
Final project for the Coursera course "Getting and Cleaning Data"

# Summary
This repository contains this README.md file, along with four key items of interest:

1. An R script used to read and tidy the input data (run_analysis.R)
2. The full tidy data set (tidy_data.csv)
3. A summarized, tidy data set (tidy_data_summary.csv)
4. A code book (codebook.md) describing the tidy data noted in 2 & 3

# Source Data and Information
The original data for this project can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and a description of both how the data was obtained and why it could be useful can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The below description assumes that you have read and are familiar with the above referenced inforamtion.

# Project Requirements
This project was seeking to, and does fulfill the following requirements.

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

# Tidy Data
The key to this assignment was ensuring that the data was transformed such that it meets the three criteria of "tidy data" [from Hadley](http://vita.had.co.nz/papers/tidy-data.pdf):

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

The transformations required to get our data in a tidy form were of three types:

1. Bind columns, to pull descriptive variables into the same table
2. Merge tables, to associate descriptive variable names in place of relational numbers
3. Reshape 561 columns of table into a table into many rows with two columns representing that inforamtion

The first two transformations are trivial, but the third requires the use of the gather() and extract_numeric functions from the package tidyr that is well suited for this exact purpose.
