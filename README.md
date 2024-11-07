
<!-- README.md is generated from README.Rmd. Please edit that file -->

# assignmentb2mbeletsky

<!-- badges: start -->
<!-- badges: end -->

The goal of assignmentb2mbeletsky is to compress a specific
**group_by()** then **summarize()** dplyr data exploration workflow into
one function, **group_then_sumz()**. The workflow this function carries
out accomplishes the following: in a dataset of your choice, groups the
data by one variable, then for all those groups, counts unique
observations for another variable. The function outputs a tibble where
the rows are all organized from top to bottom by most to least unique
counts.

## Installation

You can install the development version of assignmentb2mbeletsky from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("stat545ubc-2024/assignmentb2mbeletsky")
```

## Examples

Let’s look at some examples to more clearly see exactly what the package
does.

First, let’s load some packages that will give us access to datasets we
can use in the examples.

``` r
library(palmerpenguins)
library(datateachr)
```

The “palmerpenguins” package includes a dataset about 344 penguins of 3
different species living on 3 different islands in the Palmer
Archipelago, Antarctica. This package is often used as an example when
learning how to do data exploration and analysis in R.

The “datateachr” package includes several datasets that are also
intended to be used as examples when learning how to do data exploration
and analysis in R.

Then, let’s load our package, which will give us the ability to use the
**group_then_sumz()** function! We will also load the “dplyr” and
“tidyr” packages as our “assignmentb2mbeletsky” package relies on
functions imported from those packages.

``` r
library(assignmentb2mbeletsky)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)
```

### Penguins Example

Now that all our packages have been loaded, here is an example of how
**group_then_sumz()** can be used on the “penguins” dataset from the
“palmerpenguins” package. Here’s how the dataset looks.

``` r
head(penguins)
#> # A tibble: 6 × 8
#>   species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
#>   <fct>   <fct>              <dbl>         <dbl>             <int>       <int>
#> 1 Adelie  Torgersen           39.1          18.7               181        3750
#> 2 Adelie  Torgersen           39.5          17.4               186        3800
#> 3 Adelie  Torgersen           40.3          18                 195        3250
#> 4 Adelie  Torgersen           NA            NA                  NA          NA
#> 5 Adelie  Torgersen           36.7          19.3               193        3450
#> 6 Adelie  Torgersen           39.3          20.6               190        3650
#> # ℹ 2 more variables: sex <fct>, year <int>
```

Let’s say we are interested in knowing how many penguin species there
are on each island. We can group the data by island and then summarize
by species. Using our **group_then_sumz()** function, that looks like
this.

``` r
group_then_sumz(penguins, island, species)
#> # A tibble: 3 × 2
#>   island    n_distinct
#>   <fct>          <int>
#> 1 Biscoe             2
#> 2 Dream              2
#> 3 Torgersen          1
```

The function outputs a tibble telling us that on Biscoe there are 2
species, on Dream there are 2 species, and on Torgersen there is only 1
species.

### Trees Example

Let’s do another example with the “vancouver_trees” dataset from
“datateachr”. The “vancouver_trees” dataset includes data about public
trees planted in the City of Vancouver, BC, Canada. Here’s how the data
looks.

``` r
head(vancouver_trees)
#> # A tibble: 6 × 20
#>   tree_id civic_number std_street genus_name species_name cultivar_name  
#>     <dbl>        <dbl> <chr>      <chr>      <chr>        <chr>          
#> 1  149556          494 W 58TH AV  ULMUS      AMERICANA    BRANDON        
#> 2  149563          450 W 58TH AV  ZELKOVA    SERRATA      <NA>           
#> 3  149579         4994 WINDSOR ST STYRAX     JAPONICA     <NA>           
#> 4  149590          858 E 39TH AV  FRAXINUS   AMERICANA    AUTUMN APPLAUSE
#> 5  149604         5032 WINDSOR ST ACER       CAMPESTRE    <NA>           
#> 6  149616          585 W 61ST AV  PYRUS      CALLERYANA   CHANTICLEER    
#> # ℹ 14 more variables: common_name <chr>, assigned <chr>, root_barrier <chr>,
#> #   plant_area <chr>, on_street_block <dbl>, on_street <chr>,
#> #   neighbourhood_name <chr>, street_side_name <chr>, height_range_id <dbl>,
#> #   diameter <dbl>, curb <chr>, date_planted <date>, longitude <dbl>,
#> #   latitude <dbl>
```

Looking at this data, we might want to know how many different species
there are in each of the Vancouver neighbourhoods. We can find this out
with the **group_then_sumz** function.

``` r
group_then_sumz(vancouver_trees, neighbourhood_name, species_name)
#> # A tibble: 22 × 2
#>    neighbourhood_name       n_distinct
#>    <chr>                         <int>
#>  1 HASTINGS-SUNRISE                176
#>  2 KITSILANO                       171
#>  3 RENFREW-COLLINGWOOD             170
#>  4 DUNBAR-SOUTHLANDS               161
#>  5 KENSINGTON-CEDAR COTTAGE        159
#>  6 RILEY PARK                      154
#>  7 SHAUGHNESSY                     150
#>  8 SUNSET                          147
#>  9 GRANDVIEW-WOODLAND              146
#> 10 MARPOLE                         139
#> # ℹ 12 more rows
```

Now not only do we know how many species of trees there in each of the
Vancouver neighbourhoods, we can easily see the neighbourhoods with the
most variety in species because they have been sorted from highest to
lowest counts of unique observations. Hastings-Sunrise, Kitsilano, and
Renfrew-Collingwood have the highest amounts of unique species of trees
you can find there.
