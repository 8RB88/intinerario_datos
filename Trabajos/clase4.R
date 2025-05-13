# Cargar librerías necesarias
install.packages("DBI")
install.packages("RMySQL")  
install.packages("dplyr")

library(DBI)
library(RMySQL)
library(dplyr)

# Conexión a la base de datos
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "p2",
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "Peluza78@@")

# Leer los datos de la vista
datos <- dbReadTable(con, "vista_guayas_urbana")

# Mostrar primeros registros

head(datos)

# Dos nuevos atributos
datos <- datos %>%
  mutate(
    es_fin_semana = ifelse(dia %in% c('SABADO', 'DOMINGO'), "SI", "NO"),
    tiene_victimas = ifelse(total_victimas > 0, "SI", "NO")
  )

head(datos)

# 1. Número de accidentes por día y zona, ordenados por cantidad descendente
estadistica1 <- datos %>%
  group_by(dia, zona) %>%
  summarise(num_accidentes = n()) %>%
  arrange(desc(num_accidentes))

print(estadistica1)

# 2. Promedio de víctimas por clase de accidente (filtrando solo los que tienen víctimas)
estadistica2 <- datos %>%
  filter(tiene_victimas == "SI") %>%
  group_by(clase) %>%
  summarise(prom_victimas = mean(total_victimas)) %>%
  arrange(desc(prom_victimas))

Sprint(estadistica2)

#  3. Causas más frecuentes de accidentes en zona urbana (top 5)
estadistica3 <- datos %>%
  filter(zona == "URBANA") %>%
  group_by(causa) %>%
  summarise(frecuencia = n()) %>%
  arrange(desc(frecuencia)) %>%
  head(5)

print(estadistica3)

# 4. Accidentes agrupados por hora y si fue fin de semana
estadistica4 <- datos %>%
  group_by(hora, es_fin_semana) %>%
  summarise(accidentes = n()) %>%
  arrange(hora)

print(estadistica4)

# 5. Promedio de lesionados por día (solo días con accidentes con lesionados)
estadistica5 <- datos %>%
  filter(num_lesionado > 0) %>%
  group_by(dia) %>%
  summarise(prom_lesionados = mean(num_lesionado)) %>%
  arrange(desc(prom_lesionados))

print(estadistica5)
