install.packages("RODBC")
install.packages("dplyr")
install.packages("dlookr")
install.packages("nycflights13")
install.packages("caret")

library("RODBC") # RODBC Package für die Verbindung zu einem SQL Server
library("dplyr")
library("dlookr")
library("nycflights13")
library("caret")

my_server="ServerName"
my_db="DatenbankName"
my_username="Username"
my_pwd="Passwort"


db <- odbcDriverConnect(paste0("DRIVER={SQL Server};
                                 server=",my_server,";
                                 database=",my_db,";
                                 uid=",my_username,";
                                 pwd=",my_pwd))


sql="SELECT * FROM schema.TabellenName" 
df <- sqlQuery(db,sql)

# Testtabelle
TabellenName <- flights


## Vollständigkeit berechnen
Fehlende <-
  (1 - sum(is.na(TabellenName))/prod(dim(TabellenName))) * 100

print(Fehlende)



## Ausreiser berechnen
Ausreiser <-
  TabellenName %>%
  diagnose_outlier() %>%
  select(variables, outliers_ratio) %>%
  filter(outliers_ratio > 0)

calcAusreiser <-  100 - colSums(Ausreiser[,-1]) / nrow(Ausreiser)


print(calcAusreiser)

## Eindeutigkeit
Doppel <- 
  TabellenName %>%
  diagnose() %>%
  select(variables, unique_rate) %>%
  filter(unique_rate > 0)

calcDoppel <- (1- (colSums(Doppel[,-1]) / nrow(Doppel)) )*100
print(calcDoppel)


## Aktualität der Tabelle

# bei einem Pfad
indicator <- 100.00
TabellenName <- R.home()
startDate <- as.POSIXct(file.info(TabellenName)$ctime)
endDate <- Sys.time()

calcDate <- endDate - startDate
calcDatenum <- as.numeric(calcDate)


if (calcDatenum == 0){
  indicator <- 100
  print(indicator)
}
if (calcDatenum > 5 && calcDatenum < 10){
  indicator - 2.5
  print(indicator)
}
if (calcDatenum > 10 && calcDatenum < 15){
  indicator - 5.0
  print(indicator)
}
if (calcDatenum > 15 && calcDatenum < 20){
  indicator - 7.5
  print(indicator)
} 
if (calcDatenum > 20 && calcDatenum < 25){
  indicator <- 100 - 10
  print(indicator)
}
if (calcDatenum > 25 && calcDatenum < 30){
  indicator - 12.5
  print(indicator)
}
if (calcDatenum > 30){
  indicator - 15
  print(indicator)
}
if (calcDatenum > 31){
  indicator - 50
  print(indicator)
}



# Mehrere Pfade
paths <- dir(R.home(), full.names=TRUE)
tail(file.info(paths)$ctime)

