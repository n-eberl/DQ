install.packages("dplyr")
install.packages("dlookr")
install.packages("nycflights13")


library(dplyr)
library(dlookr)
library(nycflights13)



#Außreiser
diagnose_outlier(flights)

#SensibilitätAnpassen
diagnose_outlier(flights) %>% 
  filter(outliers_ratio > 5) %>% 
  mutate(rate = outliers_mean / with_mean) %>% 
  arrange(desc(rate)) %>% 
  select(-outliers_cnt)

#Plot
flights %>%
  plot_outlier(arr_delay) 

#PlotmitSensi
flights %>%
  plot_outlier(diagnose_outlier(flights) %>% 
                 filter(outliers_ratio >= 0.5) %>% 
                 select(variables) %>% 
                 unlist())

#Report
flights %>%
  diagnose_report()

