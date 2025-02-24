# **🌳 Árboles de Decisión y Regresión: Explicación Simplificada**  

## **📌 ¿Qué es una regresión?**

La **regresión** es un tipo de modelo de aprendizaje automático que se usa para **predecir valores numéricos continuos**.  

Ejemplo:  

- **Pregunta:** ¿Cuánto costará una casa según su tamaño? 🏠💰  
- **Respuesta:** La regresión puede estimar el precio basándose en datos previos.  

En términos simples, una regresión **ajusta los datos a un modelo matemático** para hacer predicciones. Un modelo simple es una **línea recta**, pero hay modelos más avanzados como curvas o árboles de decisión.

## **🌳 ¿Qué son los Árboles de Decisión?**

Los **árboles de decisión** son modelos que hacen predicciones dividiendo los datos en grupos cada vez más pequeños, basándose en preguntas simples.  

Ejemplo:  

- **¿La casa tiene más de 100m²?** ➝ Si sí, sigue una rama del árbol; si no, otra.  
- **¿Está en el centro de la ciudad?** ➝ Otra división.  
- Finalmente, cada grupo tiene un precio promedio como predicción.  

🔹 **Diferencia clave:**  
A diferencia de otros modelos, como la regresión lineal (que intenta ajustar una línea recta a los datos), los árboles de decisión **dividen los datos en segmentos y predicen valores basados en promedios dentro de cada grupo**.

## **📌 ¿Cómo funcionan en regresión?**

1️⃣ **Dividen los datos** en grupos según sus características.  
2️⃣ **Cada grupo tiene un valor promedio de salida** (por ejemplo, el precio promedio de casas en esa categoría).  
3️⃣ **Para predecir un nuevo valor**, el modelo encuentra en qué grupo cae y asigna el promedio de ese grupo.  

🔹 **Diferencia con clasificación:**

- En clasificación, el árbol decide entre **categorías** (Ej.: "perro" 🐶 o "gato" 🐱).  
- En regresión, el árbol predice **valores numéricos** (Ej.: precio de casa 💰).  

## **🎯 Resumen Simplificado:**

✅ **Regresión:** Predice valores numéricos (Ej.: salario, precio de casas, temperatura).  
✅ **Árbol de Decisión en Regresión:** Divide los datos en grupos y predice valores basados en los promedios de esos grupos.  
✅ **Ventaja:** No necesita suponer una forma específica de los datos (como una línea recta), sino que se adapta a los valores observados.  
