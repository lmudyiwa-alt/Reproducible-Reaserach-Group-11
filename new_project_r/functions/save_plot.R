library(ggplot2)
library(here)

save_plot <- function(plot_object) {
  
  object_name <- deparse(substitute(plot_object))
  
  file_name <- paste0(object_name, ".png")
  
  plot_path <- here("new_project_r", "plots", file_name)
  
  ggsave(
    filename = plot_path,
    plot = plot_object,
    width = 15,
    height = 15,
    dpi = 300
  )
  
  message("Plot saved successfully: ", file_name)
}