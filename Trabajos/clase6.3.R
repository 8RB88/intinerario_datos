################################
#WEB SCRAPING                  #
################################

install.packages("rvest")
install.packages("xml2")
library(rvest)
library(xml2)
library(dplyr)

url <- "https://es.wikipedia.org/wiki/Provincias_de_Ecuador"

pagina <- read_html(url)

class(pagina)

tablas = html_table(pagina)

class(tablas)

tabla_provincias = tablas[[1]]

names(tabla_provincias)

provincias = tabla_provincias %>% 
  select(Provincia, Poblacion = 5, Área = 7, Densidad = 8, Cantones = 9)

str(provincias)

x = substr(provincias$Poblacion[1],4,4)

provincias = provincias %>%
  mutate(Poblacion = as.integer(gsub(x,"",Poblacion)))

provincias = provincias %>%
  mutate(Área = as.integer(gsub(x,"",Área)),
         Densidad = as.numeric(gsub(",",".",Densidad)))

str(provincias)


################################
# EJEMPLO 2                    #
################################

url = "https://books.toscrape.com/catalogue/page-1.html"
pagina = read_html(url)

nodos = pagina %>%
  html_elements(".product_pod h3 a")

titulos = nodos %>% 
  html_attr("title")

enlaces = nodos %>% 
  html_attr("href")

nodos = pagina %>% 
  html_element(".price_color") %>%
  html_text2()

libros = data.frame(titulo = titulos,
                    enlace = enlaces,
                    precio = precios)

libros = libros %>%
  mutate(precio = gsub("£","",precio))

################################
# EJEMPLO 2   B                #
################################
url = "https://books.toscrape.com/catalogue/page-1.html"

pagina = read_html(url)

nodos = pagina %>%
  html_elements(" .product_pod")

titulos = nodos %>%
  html_element("h3 a") %>%
  html_attr("title")

enlaces = nodos %>%
  html_element("h3 a") %>%
  html_attr("href")

precios = nodos %>%
  html_element(" .price_color") %>%
  html_text2()

imagenes = nodos %>%
  html_element(" .image_container a img") %>%
  html_attr("src")

libros = data.frame(titulo = titulos,
                    enlace = enlaces,
                    precio = precios,
                    imagen = imagenes)

libros = libros %>%
  mutate(precio = gsub("£","",precio))
