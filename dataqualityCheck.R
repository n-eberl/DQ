library(RODBC) # RODBC Package für die Verbindung zu einem SQL Server

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

TabellenName <- #Tabelle zuweißen

  
  ## Ausreiser berechnen
Ausreiser <-
  TabellenName %>%
  diagnose_outlier() %>%
  select(variables, outliers_ratio) %>%
  filter(outliers_ratio > 0)

calcAusreiser <- colSums(Ausreiser[,-1]) / nrow(Ausreiser)


print(calcAusreiser)

  ## Eindeutigkeit
Doppel <- 
  TabellenName %>%
  diagnose() %>%
  select(variables, unique_rate) %>%
  filter(unique_rate > 0)

calcDoppel <- 1- (colSums(Doppel[,-1]) / nrow(Doppel))
print(calcDoppel)


  ## Aktualität der Tabelle

## bei einem Pfad
p <- R.home()
file.info(p)$ctime


## Mehrere Pfade
paths <- dir(R.home(), full.names=TRUE)
tail(file.info(paths)$ctime)