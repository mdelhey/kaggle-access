library(ggplot2)
library(caret)

set.seed(25)

### Read in given data sets.
# All variables are factors, let's go ahead and make the conversions.
test <- read.csv("../Data/test.csv", colClasses = c(rep("factor", 10)))
train <- read.csv("../Data/train.csv", colClasses = c(rep("factor", 10)))
sample_submit <- read.csv("../Data/sampleSubmission.csv")

### Logistic regression
lgr <- glm(ACTION ~ ., data = train, family = "binomial")
#lgr <- train(ACTION ~ ., data = train, method = "multinom", trControl = fitControl)
sample_submit$Action2 <- predict(lgr, test)
write.table(submit, "../Submissions/test_lgr_submission", sep = ",", row.names = FALSE)