#cargar datos
datos <- read.csv("titanic.csv")
########################
# JOINS
########################

library(dplyr)

datos %>% distinct(Embarked)

puertos <- data.frame(Embarked = c ("C","Q","S",""),
                      Puerto = c ("Cherbourg", "Queenstown", "SouthHampton", "Indeterminado"))

datos <- datos  %>%  inner_join(puertos, by = "Embarked")

resultado <- datos %>% inner_join(puertos, by = "Embarked")

#o
resultado <- datos %>% inner_join(puertos)


estaturas <- datos %>% data.frame(Id = c(1:891),
                                  Estatura = sample(150:193,size = 891,replace = TRUE))
resultado <- resultado %>% 
  inner_join(estaturas,by = join_by(PassengerId == Id))

tarifas <- data.frame( desde = c(0,30,100),
                       hasta = c(29,99,99,99,9999,99),
                       TipoTarifa = c("Baja","Normal","Alta"))
resultado <- resultado %>% 
  inner_join(tarifas, by = join_by(between(Fare,desde,hasta))) 

resultado <- resultado %>%
  select(-c(desde,hasta))

