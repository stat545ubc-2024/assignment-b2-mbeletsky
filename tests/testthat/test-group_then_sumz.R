library(datateachr)
library(dplyr)
library(tidyr)

test3_manual <- vancouver_trees %>%
  drop_na(neighbourhood_name) %>%
  group_by(neighbourhood_name) %>%
  drop_na(species_name) %>%
  summarize(n_distinct = n_distinct(species_name)) %>%
  arrange(desc(n_distinct))

test3_function <- group_then_sumz(vancouver_trees, neighbourhood_name, species_name)

test_that("group_then_sumz works", {
  expect_type(table, "closure")
  expect_no_error(group_then_sumz(vancouver_trees, neighbourhood_name, species_name), message = NULL, class = NULL)
  expect_no_error(group_then_sumz(vancouver_trees, genus_name, cultivar_name), message = NULL, class = NULL)
  expect_no_error(group_then_sumz(vancouver_trees, neighbourhood_name, date_planted), message = NULL, class = NULL)
  expect_no_error(group_then_sumz(vancouver_trees, neighbourhood_name, on_street_block), message = NULL, class = NULL)
  expect_equal(test3_function, test3_manual)
})

rm('test3_manual')
rm('test3_function')

