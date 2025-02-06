# Pruebas en R
# http://ciencias.bogota.unal.edu.co/fileadmin/content/eventos/simposioestadistica/documentos/memorias/MEMORIAS_2015/Comunicaciones/Est_Matematica/Isaza_Acevedo___Hernandez_Pruebas_Normalidad.pdf
#install.packages("nortest")
library(nortest)
#Probar normalidad de la longitud y el ancho del pétalo
# H0: Sigue una distribución normal 
# H1: No sigue una distribución normal

datos<-iris

# Pruebas
#Shapiro-Wilks 
#https://en.wikipedia.org/wiki/Shapiro%E2%80%93Wilk_test#Interpretation
shapiro.test(datos$Petal.Length)

# Shapiro-Wilk normality test
# 
# data:  datos$Petal.Length
# W = 0.87627, p-value = 7.412e-10

#Como el p-value = 7.412e-10 es menor que 0.05 se rechaza la hipótesis nula por lo que los datos no siguen una distribución normal

#Anderson-Darling
#http://www.estadisticacondago.com/images/estadistica_inferencial/pruebas%20de%20normalidad.pdf
ad.test(datos$Petal.Length)

# Anderson-Darling normality test
# 
# data:  datos$Petal.Length
# A = 7.6785, p-value < 2.2e-16

#Como el p-value es menor que 0.05 se rechaza la hipótesis nula por lo que los datos no siguen una distribución normal

#Kolmogorov - Smirnov
ks.test(datos$Sepal.Length,rnorm(nrow(datos),mean = mean(datos$Petal.Length), sd = sd(datos$Petal.Length)))
# Two-sample Kolmogorov-Smirnov test
# 
# data:  datos$Sepal.Length and rnorm(nrow(datos), mean = mean(datos$Petal.Length), sd = sd(datos$Petal.Length))
# D = 0.62667, p-value < 2.2e-16
# alternative hypothesis: two-sided

#Como el p-value es menor que 0.05 se rechaza la hipótesis nula por lo que los datos no siguen una distribución normal

#Lilliefors (Corrección de Kolmogorov smirnov)
lillie.test(datos$Petal.Length)

# Lilliefors (Kolmogorov-Smirnov) normality test
# 
# data:  datos$Petal.Length
# D = 0.19815, p-value = 7.901e-16
#Como el p-value es menor que 0.05 se rechaza la hipótesis nula por lo que los datos no siguen una distribución normal
