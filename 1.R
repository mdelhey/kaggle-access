library(caret)

test <- read.csv("Data/test.csv")
train <- read.csv("Data/train.csv")
submit <- read.csv("Data/sampleSubmission.csv")

train$ACTION <- factor(train$ACTION)

rf <- train(ACTION ~ ., data = train, method = "rf")

submit$Action2 <- predict(rf, test)

write.table(submit, "Submissions/test_submission.csv", sep = ",", row.names = FALSE)