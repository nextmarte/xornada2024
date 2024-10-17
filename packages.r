# packages.R
install.packages('renv')
renv::init(bare = TRUE)
renv::install(c(
  'rbcb', 'tidyverse', 'timetk', 'PerformanceAnalytics', 'gtrendsR', 'rio', 
  'quantmod', 'git2r', 'bizdays', 'purrr', 'pbapply', 'scales', 'ggeasy', 
  'xts', 'tseries', 'GGally','DT', 'plotly', 'esquisse'
))
renv::install('remotes')
remotes::install_github('ropensci/rb3')
renv::snapshot()