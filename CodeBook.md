Code Book
=========

run_analysis.R will produce a data frame (tidy) containing the following variables

Subject
--------
The subject is a numeric identifier of the individual performing the activity

Activity
--------
One of 7 activities performed while carrying the device, including WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

81 Readings
-----------
The remaining variables are sensor signals recorded during the tests

---

run_analysis.R performs the following operations:

1. Reads required files for subsequent steps into R
2. Sanitizes variable names to be used as column names
3. Replaces numeric identifiers with descriptive names
4. Subsets the data frame to include only required standard deviation and mean columsn
5. Merges subject, activity, and main dataframes together
6. Aggregates data