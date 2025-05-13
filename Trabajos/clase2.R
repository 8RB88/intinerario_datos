setwd("C:/Users/busta/Desktop/INT.Datos/Trabajos")
getwd()
datossini <- read.csv("siniestros.csv" , sep = ';')
print(datossini)
head(datossini)
str(datossini)
summary(datossini)
dim(datossini)
class(datossini)
mode(datossini)
datossini$GRAVEDAD <- ifelse(as.numeric(datossini$NUM_FALLECIDO) > 0, "Grave", 
                             "No Grave")
datossini$ES_FIN_SEMANA <- ifelse(datossini$DIA %in% c("SÁBADO", "DOMINGO"), 
                                  "Si", "No")
subset_datos <- subset(datossini,(ES_FIN_SEMANA) >= 6,select = c("ANIO", 
    "PROVINCIA", "CANTÓN", "NUM_FALLECIDO", "NUM_LESIONADO", "TOTAL_VICTIMAS"))

head(subset_datos)

mean(datossini$TOTAL_VICTIMAS)
median(datossini$TOTAL_VICTIMAS)
max(datossini$TOTAL_VICTIMAS)
min(datossini$TOTAL_VICTIMAS)
sum(datossini$TOTAL_VICTIMAS)
sd(datossini$TOTAL_VICTIMAS)
var(datossini$TOTAL_VICTIMAS)
range(datossini$TOTAL_VICTIMAS)
diff(range(datossini$TOTAL_VICTIMAS))

install.packages("dplyr")

library(dplyr)

datossini %>%
  group_by(PROVINCIA) %>%
  summarise(
    promedio_victimas = mean(as.numeric(TOTAL_VICTIMAS), na.rm = TRUE),
    mediana_victimas = median(as.numeric(TOTAL_VICTIMAS), na.rm = TRUE),
    desv_tipica_victimas = sd(as.numeric(TOTAL_VICTIMAS), na.rm = TRUE),
    accidentes = n()

subset_datos <- subset(datossini, ES_FIN_SEMANA == "Si", select = 
c("ANIO", "PROVINCIA", "CANTÓN", "NUM_FALLECIDO", "NUM_LESIONADO", 
  "TOTAL_VICTIMAS", "ES_FIN_SEMANA"))
head(subset_datos)

