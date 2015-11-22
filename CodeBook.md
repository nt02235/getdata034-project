# CodeBook

a code book that describes the variables, the data, and any transformations or 
work that you performed to clean up the data called CodeBook.md.

## Sources utilized
- features.txt: list of all measurement calculations distilled from the smartphone signal data capture
- subject_test.txt: subset of total 30 subjects who participated in data capture
- subject_train.txt: remaining list of subjects who participated in data capture
- x_test.txt: data capture for participants in test group
- x_train.txt: data capture for participants in train group 
- y_test.txt: activity each test subject performed during data capture
- y_train.txt: activity each train subject performed during data capture
- activity_labels.txt: activity names that are associated with each activity code

## Variables
1. subject: ID number between 1-30 to identify participant data capture
2. activityname: identifies what action each pariticpant performed during data capture.  One of the following: sitting, standing, laying, walking, walking upstairs, walking downstairs
3. measurement calculations (columns 3 through 68): standard deviation and mean values associated with the various signals collected during data capture:
```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

## Steps & transformations performed
1. Aggregated all data sources into one set
2. Merged `activity_labels` with final dataset for use as descriptive labels for activities
3. Melted final dataset to make a long and narrow dataset
4. Casted melted dataset to summarize measurement calculations means for each activity per subject

## Datasets created
1. finaldataset: aggregated & merged dataset created from all sources 
2. casted: based on finaldataset, dataset that summarizes every measurement mean (from features) for each activity per subject
