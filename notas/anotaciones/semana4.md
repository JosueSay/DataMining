# Otras herramientas para metodología no supervisada

## Análisis de Componentes Principales (PCA)

El Análisis de Componentes Principales (PCA) es una técnica estadística no supervisada utilizada para examinar las interacciones entre variables dentro de un conjunto de datos. También es conocido como Análisis de Factores General.

No es un modelo en sí, sino una herramienta utilizada antes de aplicar un modelo.

### Aplicaciones del PCA

- Filtrado de ruido.
- Visualización de datos.
- Extracción de características (feature selection).
- Predicciones en bolsas de valores.
- Análisis de datos genéticos.

### Objetivos del PCA

- Identificar patrones en los datos.
- Detectar correlaciones entre variables (proporcionales o inversamente proporcionales).
- Reducir la dimensionalidad de un conjunto de datos de dimensión *d* proyectándolo en un subespacio de *k* dimensiones, donde *k < d*.

Una regresión ajusta los valores a un modelo específico (por ejemplo, una recta). En cambio, el PCA determina varias líneas ortogonales que mejor se ajustan a los datos. Esto genera un nuevo sistema de componentes ortogonales que abarcan la mayor varianza posible en los datos.

Cada componente generado es ortogonal a los demás, asegurando la ausencia de correlación entre ellos.

### Limitaciones del PCA

- La interpretación de los componentes puede ser complicada, ya que estos son combinaciones de las variables originales.
- Es sensible a valores atípicos (outliers).
- No es un modelo predictivo en sí, sino una técnica exploratoria.

Antes de aplicar PCA, es necesario normalizar o escalar los datos.

> **Nota:** En conjuntos de datos con variables categóricas o clases objetivo (*target*), es importante que las clases tengan distribuciones balanceadas para evitar sesgos en el entrenamiento del modelo.

Para más información sobre PCA, consultar [este recurso](https://setosa.io/ev/principal-component-analysis/).

## Aprendizaje de Reglas de Asociación (ARA)

Las reglas de asociación buscan identificar patrones en conjuntos de datos, estableciendo relaciones entre elementos. Un ejemplo común es la recomendación de productos en plataformas de comercio electrónico, donde se sugiere a los usuarios productos comprados frecuentemente juntos.

Estas reglas pueden utilizarse en:

- Estrategias de negocio y mercadeo.
- Análisis de comportamiento de usuarios.
- Recomendaciones de contenido.

Ejemplo de conjunto de datos:

| ID usuario | Películas que le gustaron |
|------------|--------------------------|
| 234567     | Peli1, Peli2, Peli3, Peli4 |
| 4328765    | Peli1, Peli2              |
| 5163903    | Peli1, Peli2, Peli4       |
| 7414792    | Peli1, Peli2              |
| 12357935   | Peli2, Peli4              |
| 5516037    | Peli1, Peli3              |

### Reglas Potenciales

- **Peli1 → Peli2** (Las personas que vieron *Peli1* también vieron *Peli2*).
- **Peli2 → Peli4** (Las personas que vieron *Peli2* también vieron *Peli4*).
- **Peli1 → Peli3** (Las personas que vieron *Peli1* también vieron *Peli3*).

Estas asociaciones pueden extenderse a combinaciones más complejas, lo que genera un problema de combinación explosiva de reglas.

### Método Apriori

El algoritmo Apriori es una estrategia común para descubrir reglas de asociación en grandes conjuntos de datos. Se basa en tres conceptos fundamentales:

#### Algoritmo

1. Se fijan valores mínimos para soporte y confianza para reducir la cantidad de reglas generadas.
2. Se toman todos los subconjuntos de transacciones donde $Soporte > Soporte(min) $.
3. Se extraen todas las reglas de los subconjuntos donde $Confianza > Confianza(min) $.
4. Se ordenan las reglas en orden descendente según su **Lift**, lo que garantiza que las reglas más fuertes aparezcan primero.

#### Fórmulas

1. **Soporte (Support)**

   – Mide la frecuencia con la que ocurre un conjunto de elementos en el conjunto de datos.

   $$ support(M) = \frac{\text{ Número de listas que contienen } M}{\text{Total de listas analizadas}} $$

2. **Confianza (Confidence)**

   – Mide cuánto podemos confiar en que una asociación es válida.

   $$ confidence(M1 \rightarrow M2) = \frac{\text{ Número de listas con } M1 \, y \, M2}{\text{Número de listas con } M1} $$

3. **Lift (Mejora de confianza)**

   – Mide cuánto mejora la confianza de una regla en comparación con la probabilidad independiente de los elementos.

   $$ lift(M1 \rightarrow M2) = \frac{confidence(M1 \rightarrow M2)}{support(M2)} $$

El valor de *lift* indica la fortaleza de la relación:

- *Lift > 1*: La presencia de *M1* aumenta la probabilidad de *M2*.
- *Lift = 1*: No hay relación entre *M1* y *M2*.
- *Lift < 1*: La presencia de *M1* disminuye la probabilidad de *M2*.

Este análisis permite identificar patrones de interés y optimizar estrategias de recomendación y segmentación de mercado.

### ECLAT (Equivalence Class Clustering and Bottom-Up Lattice Traversal)

El algoritmo ECLAT es una alternativa a Apriori, enfocada en identificar asociaciones rápidas y eficientes.

Ejemplo de intuición:

"Las personas que compran **X** también compran **Y**..."

ECLAT trabaja de manera similar a Apriori, pero en lugar de analizar transacciones completas, busca directamente en subconjuntos de elementos frecuentes.

#### Algoritmo

1. Fijar un valor mínimo para el soporte.
2. Tomar todos los subconjuntos de transacciones donde $Soporte > Soporte(min) $.
3. Ordenar los subconjuntos en orden descendente de soporte.

ECLAT es más rápido que Apriori en ciertos casos, ya que utiliza una representación más eficiente de los datos. Sin embargo, la elección entre Apriori y ECLAT depende del tamaño y estructura del conjunto de datos.

#### Fórmulas

- **Soporte:**
  - Para recomendación de películas:

    $Support(M) = \frac{\# \text{listas de películas que contienen } M}{\# \text{listas de películas}} $
  
  - Para optimización en supermercados:

    $Support(M) = \frac{\# \text{transacciones que contienen } I}{\# \text{transacciones}} $
  
> **Importante:** $M $ e $I $ deben contener más de 2 elementos. Esto es porque si un solo elemento es demasiado frecuente, el análisis perdería sentido, ya que no se identificarían combinaciones relevantes de productos.
