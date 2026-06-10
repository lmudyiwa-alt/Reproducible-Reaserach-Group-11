library(testthat)
library(dplyr)

source_file <- function(path) {
  source(file.path("..", "..", path), local = parent.frame())
}

source_file("new_project_r/functions/bar_plot_generator.R")
source_file("new_project_r/functions/compare_plot_generator.R")

sample_df <- tibble(
  claim_status = c(0, 0, 1, 1),
  category = c("A", "B", "A", "B"),
  value = c(10, 15, 20, 25)
)

test_that("bar_plot_generator returns a patchwork object with two plots", {
  p <- bar_plot_generator(sample_df, "category")

  expect_true(inherits(p, "patchwork"))
  expect_equal(length(p), 2)
})

test_that("compare_plot_generator returns a list of two ggplot objects", {
  result <- compare_plot_generator(sample_df, "value")

  expect_type(result, "list")
  expect_named(result, c("histograms", "boxplot"))
  expect_true(inherits(result$histograms, "patchwork"))
  expect_true(inherits(result$boxplot, "gg"))
})
