library(DBI)
library(RMySQL)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "p2",
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "Peluza78@@")

# cosntruccion de la consulta SQL
comando_sql <- paste0("select * ",
                      "from siniestros ",
                      "where provincia = 'GUAYAS' ",
                      "and zona = 'URBANA'")


# Ejecucion de la consulta sql
datos_mysql <- dbGetQuery(con,comando_sql)

#cierre de la conexion MySQL
dbDisconnect(con)
View(datos_mysql)
