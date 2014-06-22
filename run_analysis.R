#load data files
activityLabels <- read.table('UCI\ HAR\ Dataset/activity_labels.txt')
columnNames <- read.table('UCI\ HAR\ Dataset/features.txt')
testY <- read.table('UCI\ HAR\ Dataset/test/Y_test.txt')
testX <- read.table('UCI\ HAR\ Dataset/test/X_test.txt')
testSubject <- read.table('UCI\ HAR\ Dataset/test/subject_test.txt')
trainY <- read.table('UCI\ HAR\ Dataset/train/Y_train.txt')
trainX <- read.table('UCI\ HAR\ Dataset/train/X_train.txt')
trainSubject <- read.table('UCI\ HAR\ Dataset/train/subject_train.txt')

# fix column names
columnNames$V2 <- sub("()","",columnNames$V2, fixed=TRUE)

# build vectors of activity labels for later use
testActivityLabels <- merge(testY, activityLabels)
trainActivityLabels <- merge(trainY, activityLabels)

# assign fixed column names to test and train datasets
colnames(testX) <- columnNames$V2
colnames(trainX) <- columnNames$V2

# subset test and train datasets to include only std and mean columns
subsetTest <- testX[,grep(paste(c("std","mean"),collapse="|"), colnames(testX), value=TRUE)]
subsetTrain <- trainX[,grep(paste(c("std","mean"),collapse="|"), colnames(trainX), value=TRUE)]

# add activity labels to subsets
test <- cbind(activity=testActivityLabels$V2, subsetTest)
train <- cbind(activity=trainActivityLabels$V2, subsetTrain)

# add subject column to datasets
test <- cbind(subject=testSubject$V1, test)
train <- cbind(subject=trainSubject$V1, train)

# merge datasets
merged <- merge(test,train,all=TRUE)

# aggregate
tidy <- aggregate(.~subject+activity, FUN=mean, data=merged)