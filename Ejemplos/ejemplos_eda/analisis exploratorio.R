carros<-read.csv("datos/cars.csv")
View(carros)
nrow(carros) #Cantidad de filas
ncol(carros) #Cantidad de columnas
str(carros) #Estructura de los datos

head(carros,3) #Muestra las primeras filas 
tail(carros,3) #Muestra las últimas filas


head(carros[,1:3])


#¿Cuantos carros tipo hatchback tiene la muestra?
nrow(carros[carros$body_style=="hatchback",])

#¿Cuál es el promedio de pérdidas de los carros convertibles? Obvie los carros 
#que tienen valores NA en el atributo “normalized_losses”

mean(carros[carros$body_style=="convertible","normalized_losses"],na.rm = TRUE)

peligrosos<-aggregate(carros[,1:2],list(carros$make),mean)
head(peligrosos)

#Cámbiele los nombres a las columnas del data frame peligrosos
names(peligrosos)<-c("marca","peligrosidad","perdidas")
names(peligrosos)

#Guarde en una nueva variable los datos que no tienen NA en el promedio de las 
#pérdidas. Esta variable será la que usará para los siguientes ejercicios.

peligrosos_completos<-peligrosos[complete.cases(peligrosos$perdidas),]

#Haga un vector con el promedio de pérdidas normalizadas de cada una de las marcas de carros.
perdidas<-peligrosos_completos$perdidas

#Utilice el vector creado en el inciso anterior para hacer un gráfico de barras 
#que permita visualizar las marcas que más pérdidas han tenido.
names(perdidas) <- peligrosos_completos$marca
barplot(perdidas,main = "Perdidas por marcas", col=c("red","blue","yellow","orange","green","cyan","purple"),
        xlab="Marcas",ylab = "pérdidas",ylim = c(0,150))


# e) Basado en el gráfico que generó responda las siguientes preguntas:
#   a. ¿Cuáles podrían decirse que eran las marcas de carros de menor riesgo en la época en que fueron obtenidos los datos? ¿Por qué?
#   b. ¿Cuáles podrían decirse que eran las marcas de carros de mayor riesgo en la época en que fueron obtenidos los datos? ¿Por qué?
#   f) Investigue un poco más el conjunto de datos:
#   a. Explique cómo se distribuyen los datos en las variables cuantitativas. Saque medidas de tendencia central y dispersión y orden.
# Tendencia Central
summary(carros[,c("normalized_losses","wheel_base","length","width","height","curb_weight","engine_size","bore","stroke","city_mpg","highway_mpg","price")])
# Dispersión. Desviación Estandar
sd(carros$normalized_losses,na.rm = T)
sd(carros$height,na.rm = T)
#Para sacar los cuartiles, se puede usar la función quantile
quantile(carros$normalized_losses,na.rm = T)

# b. ¿Se puede decir que las variables cuantitativas siguen una distribución normal? Compruébelo tanto gráficamente como usando pruebas de normalidad. Explique los resultados.
# Se puede hacer un histograma y un diagrama de caja y bigotes, además de las pruebas de normalidad
#Comprobación de normalidad de forma gráfica
#histograma
hist(carros$normalized_losses)
#No parece seguir una distribución normal.

#boxplot
boxplot(carros$normalized_losses)
#Hay un punto atípico y no parece seguir una distribución normal


qqnorm(carros$normalized_losses, col="blue")
qqline(carros$normalized_losses, col="red")

#Como se ve los extremos no se acercan a la línea de normalidad teóríca. Gráficamente no podemos afirmar normalidad
#Haremos pruebas no paramétricas
#Shapiro Wilks
shapiro.test(carros$normalized_losses)
# la p es menor a 0.05 por lo que se rechaza la hipótesis nula de que los datos siguen una distribución normal
# pero shapiro wilks es para un n de 50 o menos

#Kolmogorov-Smirnov
ks.test(x = carros$normalized_losses,"pnorm", mean(carros$normalized_losses,na.rm = T), sd(carros$normalized_losses,na.rm = T))
#el p value es menor a 0.05 por lo que se rechaza la hipótesis nula de normalidad

#El test de kolmogorov asume que se conoce la media y la varianza poblacional lo cual no es del todo cierto
# el test de lilliefors corrige eso, pero hay que instalar el paquete nortest
#install.package("nortest")
library(nortest)
lillie.test(carros$normalized_losses)
#Se rechaza la hipótesis nula de normalidad por lo que tanto gráficamente como de forma
# paramétrica se puede concluir que la variable no está distribuida normalmente

# c. ¿Cuál es la distribución de los datos de las variables cualitativas? Haga, tablas de frecuencias de cada una. Explique los resultados.
table(carros$make)
table(carros$fuel_type)
table(carros$body_style)

# d. ¿Hay correlaciones entre algunas de las variables? ¿Cuáles? Explique.
plot(carros[,c("normalized_losses","wheel_base","length","width","height","curb_weight","engine_size","bore","stroke","city_mpg","highway_mpg","price")])
