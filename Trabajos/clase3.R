#Cargar datos
getwd()
datos <- read.csv("titanic.csv", sep = ',', quote = "\"", dec = ".") 
head(datos)
str(datos)
summary(datos)
dim(datos)

#SELECCION Y PROYECCION.

# obtener nombre, genero, edad, el estad de supervivencia, puerto de embarque
# de pasajeros de 3ra clase menores a 40 años

#opcion 1
r <- datos[datos$Pclass == 3 & datos$Age < 40 & !is.na(datos$Age), c("Name", "Sex",
"Age", "Survived", "Embarked")]

#opcion 2
r <- subset(datos,Pclass == 3 & Age < 40 & !is.na(Age), c(Name, Sex, Age, Survived,
                                                        Embarked))
r <- subset(datos,Pclass == 3 & Age < 40 & !is.na(Age), c(Name, Age, Survived,
                                                          Embarked))

?subset
r <- subset(datos,Pclass == 3 & Age < 40 & !is.na(Age), c(Name: Age, Survived,
                                                          Embarked))

#opcion 3
install.packages("dplyr")
library("dplyr")
r <- datos %>% filter(Pclass == 3 & Age < 40 & !is.na(Age))

r <- datos %>% filter(!is.na(Age)) %>% 
               filter(Pclass == 3 & Age < 40) %>%
               select(c(Name: Age, Survived, Embarked))

r <- datos %>% filter(!is.na(Age)) %>% 
               filter(Pclass == 3 & Age < 40) %>%
               select(Nombre = Name, Genero = Sex, Edad = Age, 
                      Estado_Supervivencia = Survived
                      , Puerto_Embarque = Embarked) %>% 
  arrange(desc(Estado_Supervivencia), Nombre) %>% 
  mutate(RangoEdad = if_else(Edad<= 13, "Niño", if_else(Edad <=  25, "Joven", 
  "Adulto"))) %>% mutate(NombrePuerto = case_when(Puerto_Embarque == "C" ~ "Cherbourg",
                                                  Puerto_Embarque == "Q" ~ "Queenstown",
                                                  Puerto_Embarque == "S" ~ "Southampton",
                                                  TRUE ~ "Desconocido")) %>%
                                                  

mutate(Genero = if_else(Genero == "male", "Hombre", "Mujer")) %>%
mutate(EdadversusPromedio = case_when(Edad > mean(Edad) ~ "Arriba",
                                      Edad < mean(Edad) ~ "Debajo",
                                      TRUE ~ "Promedio"))
#AGRUPAMIENTO
datos %>% 
  summarise(TotalPasajeros = n(), 
            SumaTarifas = sum(Fare),
            TarifaPromedio = mean(Fare),
            Edadminima = min(Age, na.rm = TRUE),
            EdadMaxima = max(na.omit(Age)),
            PuertoSalida = n_distinct(Embarked[Embarked != ""]))
datos %>% 
  mutate(Fare = if_else(Fare == 0, NA, Fare)) %>%
  group_by(Pclass) %>%
  summarise(TotalPasajeros = n(),
            Edadpromedio = mean(Age, na.rm = TRUE),
            TarifaMAxima = max(Fare, na.rm = TRUE),
            TArifaMinima = min(Fare, na.rm = TRUE))

datos %>% 
  group_by(Pclass) %>%
  summarise(TotalPasajeros = n(),
            Edadpromedio = mean(Age, na.rm = TRUE),
            TarifaMAxima = max(Fare),
            TArifaMinima = min(Fare[Fare > 0]),
            PasajerosMujeres = sum(Sex == "female"),
            PorcentajeMujeres = PasajerosMujeres / TotalPasajeros * 100) %>%
  filter(PorcentajeMujeres > 30 )

r1 <- datos %>% 
  filter(!is.na(Age)) %>%
  group_by(Age) %>% 
  summarise(Total = n()) %>%
  filter(Total > 10) %>%
  arrange(desc(Total))

r2 <- datos %>% 
  filter(!is.na(Age)) %>%
  group_by(Age) %>% 
  summarise(Total = n()) %>%
  slice_max(order_by = Total, n = 5)
