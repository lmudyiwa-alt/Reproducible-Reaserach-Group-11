library(caret)
library(ranger)

random_forest_cross_val <- function(X_train, y_train, 
                                    max_samples_range = NULL, 
                                    max_depth_range = NULL, 
                                    min_samples_leaf_range = NULL, 
                                    max_features_range = NULL, 
                                    cv = 5, 
                                    n_estimators = 300) {
  
  if (is.null(max_samples_range))      max_samples_range <- c(0.6, 0.8, 1.0)
  if (is.null(max_depth_range))         max_depth_range <- c(3, 5, 8, 0) 
  if (is.null(min_samples_leaf_range))  min_samples_leaf_range <- c(1, 5, 10)
  if (is.null(max_features_range)) {
    num_features <- ncol(X_train)
    max_features_range <- unique(c(floor(sqrt(num_features)), floor(log2(num_features)), floor(num_features * 0.5)))
    if(any(max_features_range == 0)) max_features_range[max_features_range == 0] <- 1
  }
  
  grid <- expand.grid(
    mtry = max_features_range,
    splitrule = "gini",
    min.node.size = min_samples_leaf_range
  )
  
  balanced_accuracy_summary <- function(data, lev = NULL, model = NULL) {
    lvls <- levels(data$obs)
    cm <- confusionMatrix(data$pred, data$obs, positive = lvls[2])
    out <- cm$byClass["Balanced Accuracy"]
    names(out) <- "Balanced_Accuracy"
    out
  }
  
  control <- trainControl(
    method = "cv",
    number = cv,
    summaryFunction = balanced_accuracy_summary,
    classProbs = TRUE,
    verboseIter = F
  )
  
  y_factor <- as.factor(paste0("class_", y_train))
  
  class_counts <- table(y_factor)
  weights <- ifelse(y_factor == names(class_counts)[1], 
                    sum(class_counts) / (2 * class_counts[1]), 
                    sum(class_counts) / (2 * class_counts[2]))
  
  message("Starting Grid Search...")
  
  
  best_score <- -Inf
  best_tune_result <- NULL
  
  for (depth in max_depth_range) {
    for (sample_fr in max_samples_range) {
      
      cat(paste0("\nChecking: max.depth = ", depth, ", sample.fraction = ", sample_fr, "\n"))
      
      model_tune <- train(
        x = X_train,
        y = y_factor,
        method = "ranger",
        num.trees = n_estimators,
        tuneGrid = grid,
        trControl = control,
        metric = "Balanced_Accuracy",
        weights = weights,
        num.threads = parallel::detectCores(),
        max.depth = depth,
        sample.fraction = sample_fr
      )
      
      current_best_score <- max(model_tune$results$Balanced_Accuracy, na.rm = TRUE)
      
      if (current_best_score > best_score) {
        best_score <- current_best_score
        best_tune_result <- model_tune$bestTune
        best_tune_result$max.depth <- depth
        best_tune_result$sample.fraction <- sample_fr
      }
    }
  }
  
  cat("\nBest parameters found:\n")
  print(best_tune_result)
  cat(paste("  balanced_accuracy =", round(best_score, 4), "\n"))
  
  return(best_tune_result)
}