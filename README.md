# RunAnalysis
A run analysis using data from accelerometers from the Samsung Galaxy S smartphone. For the Getting and Cleaning Data class in the Data Scientist Series on Coursera Data

The script reads data gathered from Samsung Galaxy S smartphones.

For all 3 files, the script reads the test data first, then reads the training data. The two data sets are then combined using the rbind function. The training data is appended to the end of the test data.

For the subject data, the subjects are named via the subjectID variable.

For the activities data, a function loops through the entire vector, and replaces the activity numbers with a description of the activity, given in the activity_labels.txt file from the UCI HAR files.

For the measurements, the columns are named via the features.txt file that comes with the data set. This txt file has the description of each column of measurements. The measurement data is subsetted by selecting all columns that have mean() and std() in their names. By using the fixed = TRUE parameter, the code is prevented from incorrectly selecting meanFreq() columns and angle(__mean) columns.

Using cbind, the three tables are combined into the activitysub data frame.

Using subjectID and activities as the ID variables, the melt function is called on the activitysub data table.

Afterwards, the melted table is recast, using subjectID and activities, and calling mean on all variables.
