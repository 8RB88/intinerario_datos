# librerias 
library(rvest)
library(xml2)
library(dplyr)
library(stringr)
#url usado
url = "https://es.wikipedia.org/wiki/Anexo:Artistas_de_m%C3%BAsica_latina_con_mayores_ventas"

# Leer la página HTML
pagina = read_html(url)

# Extraer todas las tablas disponibles
tablas = html_table(pagina)


# Seleccionar la segunda tabla con datos relevantes
tabla_artistas = tablas[[2]]

#ver  los nombres de las colunmas 
names(tabla_artistas)

# Selección y limpieza de columnas
resultado1 = tabla_artistas %>%
  select(Artista = 1, paises_Origen = 2, genero = 4, ventas = 7) %>%
  mutate(ventas = str_replace_all(ventas, "\\[.*\\]", "")) %>%
  mutate(genero = str_replace_all(genero, "\\[.*\\]", ""))



#########################################
#Parte  2                               #
#########################################

url2 = "https://www.artefacta.com/search/licuadoras"

pagina2 = read_html(url2)

productos <- pagina2 %>%
  html_elements(".product-item-info")

# Nombre del producto
nombres <- productos %>%
  html_elements(".product-item-link") %>%
  html_text2()

# Enlaces a cada producto
enlaces <- productos %>%
  html_elements(".product-item-link") %>%
  html_attr("href")

# Precios
precios <- productos %>%
  html_elements(".price-box") %>%
  html_text2()

# Creamos el data.frame
Resultado2 <- data.frame(
  nombre = nombres,
  enlace = enlaces,
  precio = precios
)
