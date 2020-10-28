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