library(ggplot2)
library(dplyr)
library(patchwork)
library(RColorBrewer)

bar_plot_generator <- function(df, col_name) {
  
  # Setting colours for our plots
  n_categories <- length(unique(df[[col_name]]))
  
  blue_palette <- colorRampPalette(brewer.pal(9, "Blues"))(n_categories)
  red_palette  <- colorRampPalette(brewer.pal(9, "Reds"))(n_categories)
  
  # Plot for Claim Status = 0
  p1 <- df %>%
    filter(claim_status == 0) %>%
    ggplot(aes(x = .data[[col_name]], fill = .data[[col_name]])) +
    geom_bar() +
    scale_fill_manual(values = blue_palette) +
    labs(title = paste(col_name, "(No Claim)"), x = col_name, y = "Count") +
    theme_minimal() +
    theme(legend.position = "none") 
  
  # Plot for Claim Status = 1
  p2 <- df %>%
    filter(claim_status == 1) %>%
    ggplot(aes(x = .data[[col_name]], fill = .data[[col_name]])) +
    geom_bar() +
    scale_fill_manual(values = red_palette) +
    labs(title = paste(col_name, "(Claim)"), x = col_name, y = "Count") +
    theme_minimal() +
    theme(legend.position = "none")
  
  # Combining plots
  combined_plot <- p1 + p2
  
  print(combined_plot)
  
  return(combined_plot)
}