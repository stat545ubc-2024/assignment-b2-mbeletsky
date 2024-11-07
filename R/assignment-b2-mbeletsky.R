#' @title Group your data by a variable, then summarize unique observations in another variable
#' @description Group your dataset by one variable, then summarize counts of unique observations for another variable. Rows will be sorted from highest counts to lowest.
#' @param data A dataframe you are working with. I named this argument "data" to keep things simple and to the point, and for existing functions, it's common for the argument "data" to be a dataframe.
#' @param group_var The variable (column) you wish to group your data by. I named this argument "group_var" because it's the variable (var) you are wanting to group by (group) and to distinguish it easily from the other variable we are using as an argument.
#' @param count_var The variable (column) you wish to count unique observations for. I named this argument "count_var" because it's the variable (var) you are wanting to count unique observations in (count) and to distinguish it easily from the other variable we are using as an argument.
#' @return Tibble that shows counts of unique observations within a variable, for each group you specified based on the grouping variable.
#' @examples
#' library(datateachr)
#' group_then_sumz(vancouver_trees, neighbourhood_name, species_name)
#' library(palmerpenguins)
#' group_then_sumz(penguins, island, species)
#' @export
group_then_sumz <- function(data, group_var, count_var) {
  table <- data %>%
    tidyr::drop_na({{ group_var }}) %>%
    dplyr::group_by({{ group_var }}) %>%
    tidyr::drop_na({{ count_var }}) %>%
    dplyr::summarize(n_distinct = dplyr::n_distinct({{ count_var }})) %>%
    dplyr::arrange(dplyr::desc(n_distinct))
  tibble::as_tibble(table)
  print(table)
}
