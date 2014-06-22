activityLabels <- read.table('UCI\ HAR\ Dataset/activity_labels.txt')
columnNames <- read.table('UCI\ HAR\ Dataset/features.txt')
testY <- read.table('UCI\ HAR\ Dataset/test/Y_test.txt')
testX <- read.table('UCI\ HAR\ Dataset/test/X_test.txt')
testSubject <- read.table('UCI\ HAR\ Dataset/test/subject_test.txt')
trainY <- read.table('UCI\ HAR\ Dataset/train/Y_train.txt')
trainX <- read.table('UCI\ HAR\ Dataset/train/X_train.txt')
trainSubject <- read.table('UCI\ HAR\ Dataset/train/subject_train.txt')

columnNames$V2 <- sub("()","",columnNames$V2, fixed=TRUE)

testActivityLabels <- merge(testY, activityLabels)
trainActivityLabels <- merge(trainY, activityLabels)

colnames(testX) <- columnNames$V2
colnames(trainX) <- columnNames$V2

subsetTest <- testX[,grep(paste(c("std","mean"),collapse="|"), colnames(testX), value=TRUE)]
subsetTrain <- trainX[,grep(paste(c("std","mean"),collapse="|"), colnames(trainX), value=TRUE)]

test <- cbind(activity=testActivityLabels$V2, subsetTest)
train <- cbind(activity=trainActivityLabels$V2, subsetTrain)

test <- cbind(subject=testSubject$V1, test)
train <- cbind(subject=trainSubject$V1, train)

merged <- merge(test,train,all=TRUE)

tidy <- aggregate(.~subject+activity, FUN=mean, data=merged)