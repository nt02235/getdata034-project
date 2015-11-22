## Getting & Cleaning Data Course Project

### Installing necessary packages
# install.packages("readr") # Faster alternative to read.fwf
library(readr)
# install.packages("reshape2") # For melting???
library(reshape2)

### Reading in activity labels & merging with aggregated Y data
Ytrain <- read.csv2("UCIdataset/train/y_train.txt", header = F, stringsAsFactors = F)
Ytest <- read.csv2("UCIdataset/test/y_test.txt", header = F, stringsAsFactors = F)
Ymerge <- rbind(Ytrain, Ytest)

labels <- read.delim("UCIdataset/activity_labels.txt", header = F, stringsAsFactors = F, sep = " ")

Ymerge <- merge(Ymerge, labels, by.x = "V1", by.y = "V1")
# colnames(Ymerge) <- c("activityCode", "activityName")
activityName <- Ymerge[,2]

### Reading in features & X data; isolating only necessary feature columns
features <- read.delim("UCIdataset/features.txt", header = F, stringsAsFactors = F, sep = " ")
necCols <- grepl("std|mean\\(", features[,2], ignore.case = F)
features <- features[which(necCols==T),]
features <- as.vector(features[,2])

Xtrain <- read_fwf("UCIdataset/train/X_train.txt", fwf_widths(c(rep(c(1,15), 561))))
Xtest <- read_fwf("UCIdataset/test/X_test.txt", fwf_widths(c(rep(c(1,15), 561))))
Xmerge <- rbind(Xtrain, Xtest)
Xmerge <- Xmerge[,-seq(1,1122,2)]
Xmerge <- Xmerge[, which(necCols == T)]

colnames(Xmerge) <- features

### Subject reading & aggregating 
subtrain <- read.csv2("UCIdataset/train/subject_train.txt", header = F)
subtest <- read.csv2("UCIdataset/test/subject_test.txt", header = F)
submerge <- rbind(subtrain, subtest)
colnames(submerge) <- "subject"

### Merging into finl dataset
# finaldata_long <- cbind(submerge, Ymerge, Xmerge)
finaldata <- cbind(submerge, activityName, Xmerge)

### Reshaping aggregated dataset
melted <- melt(finaldata, id = c("subject", "activityName"), variables = features)
casted <- dcast(melted, subject + activityName ~ variable,mean)

### Write casted dataset to .txt for submission
write.table(casted, file = "./subject_activity_means.txt", row.names = F)

# ### Quality assurance checks
# # Determine which activities each subject conducted
# subjectActivity <- cbind(submerge, Ymerge)
# dcast(subjectActivity)
# dcast(subjectActivity, subject ~ activityName)
# 
# # Spot check whether manual calculations of 1 subejct matched casted results
# sub1 <- finaldata[finaldata$subject == 1, ]
# sub1mean <- sapply(sub1[,features], mean)
# casted1 <- casted[casted$subject == 1, features]
# casted1 == sub1mean
# 
# sub15 <- finaldata[finaldata$subject == 15, ]
# sub15mean <- sapply(sub15[,features], mean)
# casted15 <- casted[casted$subject == 15, features]
# casted15 == sub15mean
# rm(list = c("sub1", "sub15", "sub15mean", "sub1mean", "casted1", "casted15", "subjectActivity"))
