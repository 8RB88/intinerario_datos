library(rvest)
library(xml2)
library(dplyr)
 url = "https://www.alphaeditorialcloud.com/library/search/fisica"
 pagina = read_html(url)

 nodos = pagina %>%
   html_elements(" .Issue-container")
 
 titulos_del_libro = nodos %>%
   html_elements("h2 ") %>%
   html_text2()
 
 fecha = nodos %>%
   html_elements(" .Issue-publicationDate") %>%
   html_text2()
 
 autor = nodos %>%
   html_elements("h6 ") %>%
   html_text2()
 
 precio = nodos %>%
   html_elements(" .cart") %>%
   html_text2() %>%
   gsub("[\\$,A-Z\\s]", "", .) %>%
   as.numeric()
 
 url_imagen = nodos %>%
   html_elements(" .Issue-cover img ") %>%
   html_attr("data-src")
 
 libros = data.frame(Titulo  = titulos_del_libro,
                     Fecha = fecha,
                     Autor = autor,
                     Precio = precio,
                     IMG = url_imagen )
 
str(libros)

