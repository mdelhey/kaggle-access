library(ggplot2)
library(caret)

# Read in given data sets.
# All variables are factors, let's go ahead and make the conversions.
test <- read.csv("Data/test.csv", colClasses = c(rep("factor", 10)))
train <- read.csv("Data/train.csv", colClasses = c(rep("factor", 10)))
sample_submit <- read.csv("Data/sampleSubmission.csv")

# Principal Components analysis
fit <- princomp(train, cor = TRUE)

# Visualizations


# Logforsest
logforest <- train(ACTION ~., data = train, method = "logforest")
sample_submit$Action

# RandomForest
rf <- train(ACTION ~ ., data = train, method = "rf")
sample_submit$Action2 <- predict(rf, test)
write.table(submit, "Submissions/test_submission.csv", sep = ",", row.names = FALSE)