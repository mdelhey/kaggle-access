library(ggplot2)
library(caret)

set.seed(25)
ntrees <- 400

### Read in given data sets.
# All variables are factors, let's go ahead and make the conversions.
test <- read.csv("../Data/test.csv", colClasses = c(rep("factor", 10)))
train <- read.csv("../Data/train.csv", colClasses = c(rep("factor", 10)))
sample_submit <- read.csv("../Data/sampleSubmission.csv")

### Random forest
rf <- train(ACTION ~ ., data = train, method = "rf", ntrees = ntrees)
sample_submit$Action2 <- predict(rf, test)
write.table(submit, "../Submissions/test_rf_submission.csv", sep = ",", row.names = FALSE)