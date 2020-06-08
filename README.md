## TidyData
#Getting and Cleaning Data Course Project

*run_analysis.R* - The script reads the appropriate files into memory, and merge them together into a DataFrame (named myDataset). The following files are used:
* **features.txt** - Variable names
* **activity_labels.txt** - Labels for activity numbers
* **subject_ .txt** - Subjects vector
* **y_ .txt** - Activity vector
* **X_ .txt** - Observations

After making the dataframe, subset it by column names (contains mean() or std()), than cleaning the variable names: deleting parentheses and hypens. After the mean and std strings it uses a dot to keep the names readable.

The last part is made with dplyr packages. Copy the dataset to AvgDataset as a "Tibble". Before summarizing delete the type variable, as it would generate a warning. 

*My opinions:*
- It took almost an hour to understand what's going on with all these text files.
- Was 3,5 hour to make everything done
- It was fun :)