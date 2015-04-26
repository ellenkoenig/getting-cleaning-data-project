# Running the script
This script assumes that 
 1. the data is present in a subfolder called `UCI HAR Dataset`
 2. the packages `dplyr` and `data.table` are installed

To run the cleaning script, just execute (source) `run-analysis.R`

# How the script works
The script executes the following steps (all steps are also marked with comments in the source code, so you can find the details there)
 1. Read the `test` data from `test/X_test.txt` using the labels from `features.txt`and filter the relevant columns (all columns including either `mean()`or `std()` in their column name)
 2. Read the `train` data from `train/X_train.txt` using the labels from `features.txt`and filter the relevant columns (all columns including either `mean()`or `std()` in their column name)
 3. Add the activity labels for the `test` and `train` data each from `test/y_test.txt` and `train/y_train.txt`
 4. Add the subject information for the `test` and `train` data each from `test/subject_test.txt` `train/subject_train.txt`
 5. Merge test and train data into one frame using `rbind`
 5. Resolve the activity labels (convert numbers into text labels) by merging/joining the combined data with the labels from `activity_labels.txt` and removing the numerical `activity` column
 6. Compute the averages for each measurement by subject and activity using `data.table` functionality
 7. Write the extracted data to a file using `write.table`
