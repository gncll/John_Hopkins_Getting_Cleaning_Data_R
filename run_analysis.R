## Final Project of Getting and Cleaning Data



# To reading "txt" format files in certain directory



x_train <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/train/subject_train.txt")




#Same operations for test files now.



x_test <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/test/subject_test.txt")





#To see features and activity labels



features <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/features.txt")

activitylabels <- read.table("C:/Users/user/Downloads/a1/UCI HAR Dataset/activity_labels.txt")



#Labeling test and train data



colnames(x_train) = features[,2]
colnames(y_train)= "activityId"
colnames(subject_train) = "subjectId"
colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"
colnames(activitylabels) <- c('activityId','activityType')




#Merging

mrg_train = cbind(y_train, subject_train, x_train)
mrg_test = cbind(y_test, subject_test, x_test)
setAllInOne = rbind(mrg_train, mrg_test)



#Extracts only the measurements on the mean and standard deviation for each measurement.




colNames = colnames(setAllInOne)

mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]


#Use descriptive activity names to name the activities in the data set



setWithActivityNames = merge(setForMeanAndStd, activitylabels, by='activityId', all.x=TRUE)



#From the data set in step 4, creates a second, independent tidy data set with the average
#of each variable for each activity and each subject.

    

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "TidySet.txt", row.name=FALSE)

