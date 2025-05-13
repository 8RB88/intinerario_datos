# INSTALACION Y CARGA DE LIBRERIAS 

install.packages("jsonlite")

library(jsonlite)

# Leer y cargar contenido desde archivos json

personas <- fromJSON("personas.json",flatten = TRUE)

# inspeccionar formato y contenido de dataset resultante 
class(personas)
view(personas)
str(personas)
