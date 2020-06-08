#Read the test and training datasets into memory and bind together

myDataset <- rbind(cbind(activity = "test", read.table("./data/test/X_test.txt", fill=TRUE)), 
                   cbind(activity = "train", read.table("./data/train/X_train.txt", fill=TRUE)))

#Name the variables according to features.txt

names(myDataset) <- c("activity", as.vector(read.table("./data/features.txt", fill=TRUE)[,2]))

#Keep only the variables with mean and standard deviaton values (and of course the activity type)

myDataset <- myDataset[, grep("mean\\(\\)|std\\(\\)|type", names(myDataset))]

