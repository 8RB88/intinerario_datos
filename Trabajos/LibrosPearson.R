# INSTALACION Y CARGA DE LIBRERIAS 

install.packages("jsonlite")

library(jsonlite)

# Leer y cargar contenido desde archivos json

libros <- fromJSON("LibrosPearson.json")

# Inspeccionar formato y contenido de dataset resultante 

class(libros)
View(libros)
str(libros)
libros$area
libros$autor

