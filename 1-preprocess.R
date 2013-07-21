library(ggplot2)
library(caret)

set.seed(25)

### Read in given data sets.
# All variables are factors, let's go ahead and make the conversions.
test <- read.csv("Data/test.csv", colClasses = c(rep("factor", 10)))
train <- read.csv("Data/train.csv", colClasses = c(rep("factor", 10)))
sample_submit <- read.csv("Data/sampleSubmission.csv")

### Preprocessing
variables <- c("RESOURCE", "MGR_ID", "ROLE_ROLLUP_1", "ROLE_ROLLUP_2",
               "ROLE_DEPTNAME", "ROLE_TITLE", "ROLE_FAMILY_DESC",
               "ROLE_FAMILY", "ROLE_CODE")

# Generate counts column for each variable
train_process <- train
for (var in variables) {
  count_var <- eval(parse(text = paste0("as.data.frame(table(train$", var, "))")))
  names(count_var) <- c(var, paste0(var, "_count"))
  train_process <- join(train_process, count_var, type = "full", match = "all")
}
tp <- train_process

centroids <- classDist()

# Split train into two data sets for cross-validation
inTraining <- createDataPartition(Sonar$Class, p = 0.75, list = FALSE)
fitControl <- trainControl(# 10-kfold CV 
  method = "repeatedcv",
  number = 10,
  repeats = 10)

### Visualizations

### Logistic regression
lgr <- glm(ACTION ~ ., data = train, family = "binomial")
#lgr <- train(ACTION ~ ., data = train, method = "multinom", trControl = fitControl)
sample_submit$Action2 <- predict(lgr, test)
write.table(submit, "Submissions/lgr_sub", sep = ",", row.names = FALSE)

### RandomForest
#rf <- train(ACTION ~ ., data = train, method = "rf")
#sample_submit$Action2 <- predict(rf, test)
#write.table(submit, "Submissions/test_rf_submission.csv", sep = ",", row.names = FALSE)