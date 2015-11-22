# getdata034-project
*Peer-review project for Getting &amp; Cleaning Data Course*

This readme.md files explains steps in run-analysis.R for creating one master dataset that combines:
- x_train.txt
- x_test.txt
- y_train.txt
- y_test.txt
- subject_train.txt
- subject_test.txt
- activity_labels.txt
- features.txt 

Final set is reshaped into a tiny dataset whereby each subject has mean values for each activity conducted 

## Loading necessary libraries
- Loads **reader** library so that `read_fwf` can be used instead of `read.fwf` (speed issue)
- Loads **reshape2** library so that datasets can be melted and casted

## Reading in data
### A. Preparing y datasets and merging with activity labels
1. Reads in `y_train.txt` and `y_test.txt` as .csv files
2. Aggregates both y datasets into **Ymerge** by rows
3. Reads in `activity_labels.txt` as a file delimited by " " 
4. Merges **Ymerge** with **labels** to describe activities beyond num 1-6
5. Isolates necessary columns to **activityName** for final merging later

### B. Preparing features dataset
1. Reads in `features.txt` as a file delimited by " " 
2. Locates only standard deviation and mean variables associated with signals; additional vectors excluded
3. Reduces **features** to a vector only containing necessary variables from Step B2

### C. Preparing x dataset
1. Reads in `x_train.txt` and `x_test.txt` as fixed-width format files; data columns are 15 wide separated by 1 space
2. Aggregates both x datasets into **Xmerge** by rows
3. Eliminates empty columns created in `read_fwf`
4. Reduces **Xmerge** to only have necessary variables as identified in Step B1
5. Changes colnames of **Xmerge** to reflect variables names from **features**

### D. Preparing subjects dataset
1. Reads in `subject_train.txt` and `subject_test.txt` as .csv files
2. Aggregates both subject datasets into **submerge** by rows

### E. Aggregating final dataset & reshaping into final tidy dataset
1. Aggregates a final dataset by column binding **submerge**, **activityName**, **Xmerge**
2. Creates dataset by maintaining **subject** and **activityName** and melting features
3. Casts final tidy dataset by maintaining **subject** and **activityName** and calculating feature means
4. Writes final tidy dataset as `subject_activity_mean.txt`
