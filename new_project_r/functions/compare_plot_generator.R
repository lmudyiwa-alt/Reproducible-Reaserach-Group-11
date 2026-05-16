library(ggplot2)
library(dplyr)
library(patchwork)

compare_plot_generator <- function(df, col_name) {
  
  # 1. Histogram for claim_status == 0
  p1 <- df %>%
    filter(claim_status == 0) %>%
    ggplot(aes(x = .data[[col_name]])) +
    geom_histogram(bins = 30, fill = "skyblue", color = "black") +
    labs(title = paste(col_name, "(No Claim)"), y = "Frequency") +
    theme_minimal()
  
  # 2. Histogram for claim_status == 1
  p2 <- df %>%
    filter(claim_status == 1) %>%
    ggplot(aes(x = .data[[col_name]])) +
    geom_histogram(bins = 30, fill = "salmon", color = "black") +
    labs(title = paste(col_name, "(Claim)"), y = "Frequency") +
    theme_minimal()
  
  histograms_combined <- p1 + p2
  
  # 3. Boxplot 
  p3 <- ggplot(df, aes(x = as.factor(claim_status), y = .data[[col_name]], fill = as.factor(claim_status))) +
    geom_boxplot() +
    scale_fill_manual(values = c("0" = "skyblue", "1" = "salmon")) +
    labs(title = paste(col_name, "Distribution by Claim Status"),
         x = "Claim Status",
         fill = "Claim Status") +
    theme_minimal()
  
  # Printing plots
  print(histograms_combined)
  print(p3)
  
  
  return(list(histograms = histograms_combined, boxplot = p3))
}