#VARIABLES
x <- 3
y <- 4
z <- x + y
print(z)
z

a <- 8 == 2 ** 3
b <- "Roberto"
c <- 2 > 5
a & c
a | c

#VECTORES

v1 <- c(2,7,4)
v1[2]
v2 <- c(5,9,3)
v3 <- v1 * v2
v4 <- v1 * 5

v5 <- c(1:10)
v6 <- c("Hola","como","estas")
v6[3]

#CONFIGURACION DEL DIRECTORIO DE TRABAJO
getwd()
setwd("D:/Universidad/INT.Datos/Trabajos")

#CARGA DE DATOS DESDE CSV
?read.table()

datos <- read.csv("titanic.csv" , sep = ',')

#CARGAR DATOS DESDE EXEL
install.packages("xlsx")
library("xlsx")
datos2 <- read.xlsx("titanic.xlsx", 1)

#INSPECCION DE DATOS 

print(datos)
datos
head(datos)
str(datos)
summary(datos)
dim(datos)
class(datos)
mode(datos)

#SELECCIONAR O CONSULTAR DATOS
x1 <- datos$Name
x2 <- datos["Name"]
class(x1)
class(x2)


x3 <- datos[c ("Name", "Age")]
x4 <- datos[!is.na (datos$Age) & datos$Age > 65 , c ("Name", "Age")]
x5 <- datos[!is.na (datos$Age) & datos$Age > 65, ]

x6 <- subset(datos,!is.na(Age) & Age  > 65, c(Name, Age))
head(datos)
str(datos)
x7 <- subset(datos,!is.na(Age) & Age  > 65, c(4, 6))
x8 <- subset(datos,!is.na(Age) & Age  > 65, c(4 : 6))
x9 <- subset(datos,!is.na(Age) & Age  > 65, -c(4 : 6))

#ESTADISTICA BASICAS
mean(datos$Fare)
median(datos$Fare)
max(datos$Fare)
min(datos$Fare)
sum(datos$Fare)
sd(datos$Fare)
var(datos$Fare)
range(datos$Fare)
diff(range(datos$Fare))
table(datos$Embarked)

mean(datos$Age,na.rm = TRUE)

#AGREGAR VARIABLES DERIVADAS
datos$MayorEdad <- datos$Age > 18

#EXPORTAR DATOS
write.table(datos, "titanic_new.csv", sep= ',' , row.names = FALSE)
