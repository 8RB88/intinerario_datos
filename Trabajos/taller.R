# carga de librerias a usar
library(DBI)
library(RMySQL)
library(dplyr)

# conexion a MySQL
conexion <- dbConnect(MySQL(),
                 dbname = "world",
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "Peluza78@@") 

# Cargar los datos de la vista
datos <- dbGetQuery(conexion, "SELECT * FROM Vista_Ciudades")

#atributos derivados 

datos <- datos %>%
  mutate(PoblacionMillones = Poblacion / 1e6,
         DensidadPais = Poblacion / AreaSuperficie)

# estadisticas generadas


# Estadística 1: Promedio de población por continente

estadistica1 <- datos %>%
  group_by(Continente) %>%
  summarise(PromedioPoblacion = mean(Poblacion)) %>%
  arrange(desc(PromedioPoblacion))

print(estadistica1)


# Estadística 2: Top 5 ciudades más pobladas por continente

estadistica2 <- datos %>%
  group_by(Continente) %>%
  arrange(desc(Poblacion)) %>%
  slice_head(n = 5) %>%
  select(Continente, Ciudad, Poblacion)

print(estadistica2)


# Estadística 3: Número de idiomas oficiales por continente

estadistica3 <- datos %>%
  group_by(Continente) %>%
  summarise(NumIdiomasOficiales = n_distinct(Idioma)) %>%
  arrange(desc(NumIdiomasOficiales))

print(estadistica3)


# Estadística 4: Promedio de densidad por región

estadistica4 <- datos %>%
  group_by(Region) %>%
  summarise(PromedioDensidad = mean(DensidadPais, na.rm = TRUE)) %>%
  arrange(desc(PromedioDensidad))

print(estadistica4)


# Estadística 5: Ciudades con más de 1 millón de habitantes por continente

estadistica5 <- datos %>%
  filter(Poblacion > 1e6) %>%
  group_by(Continente) %>%
  summarise(NumCiudadesGrandes = n()) %>%
  arrange(desc(NumCiudadesGrandes))

print(estadistica5)

# Cerrar conexión
dbDisconnect(con)