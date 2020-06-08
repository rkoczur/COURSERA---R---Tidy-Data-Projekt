#Read the test and training datasets into memory and bind together

testSubjects <- read.table("./data/test/subject_test.txt", fill=TRUE)
trainSubjects <- read.table("./data/train/subject_train.txt", fill=TRUE)

#Read activity vectors / activity labels and joint them together
activityLabels <- tolower(gsub("_"," ",read.table("./data/activity_labels.txt", fill=TRUE)[,2]))

testActivity <- activityLabels[read.table("./data/test/y_test.txt", fill=TRUE)[,1]]
trainActivity <- activityLabels[read.table("./data/train/y_train.txt", fill=TRUE)[,1]]

# Bind all vectors and dataset together
testData <- cbind(type = "test", subject = testSubjects, activity = testActivity, read.table("./data/test/X_test.txt", fill=TRUE))
trainData <- cbind(type = "train", subject = trainSubjects, activity = trainActivity, read.table("./data/train/X_train.txt", fill=TRUE))

myDataset <- rbind(testData, trainData)

#Free up memory
rm(list=setdiff(ls(), "myDataset"))

#Name the variables according to features.txt
names(myDataset) <- c("obsType", "subject", "activity", as.vector(read.table("./data/features.txt", fill=TRUE)[,2]))

#Keep only the variables with mean and standard deviaton values (and of course the activity type)
myDataset <- myDataset[, c(1:3, grep("mean\\(\\)|std\\(\\)", names(myDataset)))]

#Clean variable names
names(myDataset) <- gsub("-","",names(myDataset))
names(myDataset) <- gsub(",","",names(myDataset))
names(myDataset) <- gsub("mean\\(\\)","\\.Mean\\.",names(myDataset))
names(myDataset) <- gsub("std\\(\\)","\\.Std\\.",names(myDataset))
names(myDataset) <- gsub("\\.$","",names(myDataset))

#Summarizing means grouped by subjects and activities using dplyr
library(dplyr)

AvgDataset <- tbl_df(myDataset)
AvgDataset <- AvgDataset[,-1] 
AvgDataset <- AvgDataset %>% group_by(subject, activity) %>% summarise_all(funs(mean))

#Writing the final dataset to TXT
write.table(AvgDataset, "tidyDataset.txt", row.names = FALSE)
