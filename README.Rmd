# Getting and Cleaning Data Course Project

**This file outlines the purpose and functionality of the R Script written to complete the assignment. It also documents the assumptions made when cleaning the data. Please refer to the R Script itself for explanations about the functionality of each individual line of code.**

### Purpose
The purpose of this code is to read, organize, and aggregate data obtained from the UCI Machine Learning Repository. The data used in the project come from the Human Acitivity Recognition Using Smartphones Data Set, and they represent data collected from the accelerometers and gyroscopes embedded in Samsung Galaxy SII smartphones carried by 30 test subjects as they engaged in a variety of activities. 
### Assumptions: 
In order to run the code it is necessary that all of the required text files are downloaded, unzipped, and located in the working directory for the R session. The files required for the script to run are as follows:
<ol>
<li>"activity_labels.txt"</li> 
<li>"features.txt"</li>      
<li>"features_info.txt"</li>  
<li>"subject_test.txt"</li>     
<li>"subject_train.txt"</li>    
<li>"X_test.txt"</li>           
<li>"X_train.txt" "y_test.txt"</li>           
<li>"y_train.txt".</li>  
</ol>
Please verify that these files are in your working directory by executing the list.files() command. The code loops through the files, reads them into R using the read.table command, and assigns each data set to a variable associated with its filename. By exploring the individual files, the dimensions of the tables they contained (# of rows/# of columns), and the codebook, it was straightforward to determine how the individual files were related. After reading in the individual files, the code then pieces together the files to create a large combined dataset which includes both the training and test data. 
### Variable selection:
Data was collected/generated for 561 different variables. The project instructions stated that only variables that are related to means and standard deviations were to be considered. The code utilizes the "grep" command to pull out only variables that have the words "mean" or "std" in their name. This pared down the variables from 561 to 79. 
### Tidy Data Set Building:
Analysis of the text files provided for the project led to the following conclusions:
<ol>
<li>The training data set can be built using subject_train, y_train, and X_train. subject_train.txt provides the identifier for which of the 30 subjects the data corresponds to, y_train.txt provides the identifier for which of the 6 activities the data corresponds to, and X_train .txt provides the collected variables data. The variables were given the necessary column name using the "names" function and then the files were pieced together using the "cbind" function to create the complete training data set.</li>
<li>A similar process was used to create the test data set using subject_test, y_test and X_test.</li>
<li>The combined data frame was built by applying the "rbind" function to the test_data and the train_data. </li></ol>
### Readability/Human Interpretation
Several transformations were applied to the combined_data frame to make it more readable and user friendly. Parentheses and hyphens were removed from the variable names using the "gsub" command. The variable names were reduced to all lowercase using the "tolower" command, and the leading "t" and "f" characters were replaced with "time" and "freq" as per the provided codebook using the "sub" command. Finally, the index data that was in y_train and y_test was converted to character descriptions to which the indices correspond via the "levels" command and direct assignment. 
###Second Tidy Data Set
The project instructions ask for "a second, independent tidy data set with the average of each variable for each activity and each subject". This was obtained from the original tidy data set using the "aggregate" command, which splits the data into specified subsets, performs a specified computation, and returns the result in a convenient form. The second data set was named "tidy" and the code used to obtain it is as follows:
tidy = aggregate(data[,3:81], list(subject = data$subject, activity = data$activity),mean)
