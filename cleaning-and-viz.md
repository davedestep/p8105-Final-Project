R Notebook
================

``` r
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.2.1     v purrr   0.3.3
    ## v tibble  2.1.3     v dplyr   0.8.3
    ## v tidyr   1.0.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## -- Conflicts ------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
setwd("./PRSA_Data_20130301-20170228")
files = list.files()
all<-map(files, read_csv) %>% 
  bind_rows() %>% 
  janitor::clean_names()
```

Average PM 25 by year for all stations

``` r
all %>%  
  group_by(year) %>% 
  summarize(avg_pm25=mean(pm2_5, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=avg_pm25)) +
  geom_line()
```

![](cleaning-and-viz_files/figure-markdown_github/unnamed-chunk-3-1.png)

Average PM 25 by year for each station

``` r
all %>%  
  group_by(year, station) %>% 
  summarize(avg_pm25=mean(pm2_5, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=avg_pm25, color=station, group=station)) +
  geom_line()
```

![](cleaning-and-viz_files/figure-markdown_github/unnamed-chunk-4-1.png)
