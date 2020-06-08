#Read the test and training datasets into memory and bind together

testSubjects <- read.table("./data/test/subject_test.txt", fill=TRUE)
trainSubjects <- read.table("./data/train/subject_train.txt", fill=TRUE)

testActivity <- read.table("./data/test/y_test.txt", fill=TRUE)
trainActivity <- read.table("./data/train/y_train.txt", fill=TRUE)

testData <- cbind(type = "test", subject = testSubjects, activity = testActivity, read.table("./data/test/X_test.txt", fill=TRUE))
trainData <- cbind(type = "train", subject = trainSubjects, activity = trainActivity, read.table("./data/train/X_train.txt", fill=TRUE))

myDataset <- rbind(testData, trainData)

#Free up memory

rm(list=setdiff(ls(), "myDataset"))

#Name the variables according to features.txt

names(myDataset) <- c("obsType", "subject", "activity", as.vector(read.table("./data/features.txt", fill=TRUE)[,2]))

#Keep only the variables with mean and standard deviaton values (and of course the activity type)

myDataset <- myDataset[, c(1:3, grep("mean\\(\\)|std\\(\\)", names(myDataset)))]

