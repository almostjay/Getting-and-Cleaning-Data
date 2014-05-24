### please ensure that all of the needed text files are in the working directory
files  <- list.files() ### list files in the directory and store them for later reading

### for loop below reads in all of the text files and assigns them to variables corresponsing to the filenames
for(i in files) {
  tempname = gsub(".txt","",i)
  assign(tempname, read.table(i, fill = TRUE))
}

names(X_test)  <- features$V2 ### apply appropriate column names to X_test
names(X_train)  <- features$V2 ### apply appropriate column names to X_train 
means  <-  grep("mean",names(X_test)) ### pull out all variables that contain "mean"
stds  <- grep("std",names(X_test)) ### pull out all variables that contain "std"
X_test  <- X_test[,c(means,stds)] ### redefine X_test to only include mean/std columns
X_train  <- X_train[,c(means,stds)] ### redefine X_train to only include mean/std columns

### the below renames the first two variables in the dataset to "subject" and "activity"
names(subject_test)  <- "subject"
names(subject_train)  <- "subject"
names(y_test)  <- "activity"
names(y_train)  <- "activity"

test_data  <- cbind(subject_test,y_test,X_test) ### build complete test dataset
train_data  <- cbind(subject_train,y_train,X_train) ### build complete training dataset
combined_data  <- rbind(test_data,train_data) ### combine the test and training datasets
names(combined_data)  <- gsub("\\(\\)", "", names(combined_data)) ###remove parentheses
names(combined_data)  <- tolower(gsub("-", "", names(combined_data))) ###remove hyphens and sets column names to lowercase
names(combined_data)  <- sub("tbody", "timebody", names(combined_data))
names(combined_data)  <- sub("tgravity", "timegravity", names(combined_data))
names(combined_data)  <- sub("fbody", "freqbody", names(combined_data))
names(combined_data)  <- sub("fgravity", "freqgravity", names(combined_data))

combined_data$activity  <- as.factor(combined_data$activity) ###convert actcode column to factors for sorting
levels(combined_data$activity)[1]  <- "WALKING" ###convert level 1 of the activity variable from "1" to "WALKING"
levels(combined_data$activity)[2]  <- "WALKING UPSTAIRS" ###convert level 2 of the activity variable from "2" to "WALKING UPSTAIRS"
levels(combined_data$activity)[3]  <- "WALKING DOWNSTAIRS" ###convert level 1 of the activity variable from "3" to "WALKING DOWNSTAIRS"
levels(combined_data$activity)[4]  <- "SITTING" ###convert level 1 of the activity variable from "4" to "SITTING"
levels(combined_data$activity)[5]  <- "STANDING" ###convert level 1 of the activity variable from "5" to "STANDING"
levels(combined_data$activity)[6]  <- "LAYING" ###convert level 1 of the activity variable from "6" to "LAYING"

data  <- combined_data ###rename dataset to data; less typing later
tidy = aggregate(data[,3:81], list(subject = data$subject, activity = data$activity),mean) ###generates 2nd tidy data set as per project instructions