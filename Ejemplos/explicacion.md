# Explicación Código

## Primer Código **01-Pre-procesamiento_Datos**

lo que se quiere ver con los datos es tener el registro de los datos y si este cliente y determinar si es facilmente inclinado a comprar ofertas que se manden.

entonces se debe separar las caracteristicas con una meta que es la variable si compro o no.

lo que se debe hacer es la separación de variable dependiente e independiente.

### Primera Parte (Exploración de Datos)

```python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
datos = pd.read_csv('Datos.csv')
datos.head()
X = datos.iloc[:, :-1].values
y = datos.iloc[:, -1].values
type(X)
type(y)
datos.head()
print(X)
print(y)
```

1. **Importación de Bibliotecas**  
   - **`numpy` (importado como `np`)**: Una biblioteca para realizar cálculos matemáticos y trabajar con matrices o arrays.  
   - **`matplotlib.pyplot` (importado como `plt`)**: Se usa para crear gráficos.  
   - **`pandas` (importado como `pd`)**: Biblioteca para manejar y analizar datos en estructuras como tablas (DataFrames).

2. **Lectura del archivo CSV**  

3. **Vista previa de los datos**  
   - **`datos.head()`**: Muestra las primeras 5 filas del DataFrame para dar una idea de cómo son los datos.

4. **Separación de las variables independientes (X) y la variable dependiente (y)**  

   - **`datos.iloc[fila_inicio:fila_fin, columna_inicio:columna_fin]`**: Permite seleccionar filas o columnas basándose en índices.  
     - **`[:, :-1]`**: Toma todas las filas (`:`) y todas las columnas excepto la última (`:-1`). Esto se almacena en `X` como las variables independientes (las características).  
     - **`[:, -1]`**: Toma todas las filas y **solo la última columna** como la variable dependiente (la salida o etiqueta). Esto se almacena en `y`.

5. **Verificación del tipo de datos**  

6. **Impresión de los datos**

### Segunda Parte (Datos Faltantes)

En un conjunto de datos, a veces hay valores faltantes representados como **NaN** (Not a Number). Esto puede suceder si no se tienen datos para ciertas columnas o filas. Si los datos faltantes son muchos, pueden dificultar el análisis. Aquí hay dos enfoques principales para tratar los NaN:

1. **Eliminar los datos faltantes**:
   - Si la cantidad de valores faltantes es pequeña (por ejemplo, menos del 5%), puedes eliminar esas filas o columnas sin afectar mucho los resultados.
   - **Problema**: Si eliminas demasiados datos, pierdes información importante, lo que puede perjudicar el análisis o modelo.

2. **Rellenar los datos faltantes**:
   - Cuando no es ideal eliminar datos, puedes rellenar los valores faltantes usando una estrategia. Por ejemplo:
     - **Usar el promedio (mean)**: Rellena los valores NaN con el promedio de los datos de la columna.
     - **Usar la mediana (median)** o el valor más frecuente (mode).

El relleno es útil porque:

- Preserva la cantidad de registros.
- **Usar el promedio no altera la distribución estadística** de los datos (el promedio de los valores no cambia).

```python
from sklearn.impute import SimpleImputer
import numpy as np

# Crea un objeto SimpleImputer para reemplazar valores faltantes con el promedio
imputer = SimpleImputer(missing_values=np.nan, strategy='mean')

# Ajusta el imputer a las columnas donde hay valores NaN (en este caso, las columnas 1 y 2)
imputer.fit(X[:, 1:3])

# Transforma las columnas para reemplazar los valores NaN con el promedio
X[:, 1:3] = imputer.transform(X[:, 1:3])

print(X)
```

En este caso se usa un imputer que es un objeto que asigna valores y primero se crea, luego se hace un calculo con `fit` para determinar los valores nan basado en la estrategia, en este caso crea los promedio de los valores nan y los guarda para luego usar `transform` y cambiar esos nan por su respectivo promedio.

### Tercera Parte (Clasificación de Variables NO Núméricas)

En ocasiones veremos como existen variables categoricas y datos numericos, esto debe solucionarse estableciendo una conversion numerica para la parte categorica regularmente se utiliza esta libreria sklearn, que convierte un valor categorico a un valor numerico de 0s y 1s, esto lo hace identificando la cantidad de diferencias entre las categorias como en el ejemplo de los paises, aca hay 3 categorías únicas por lo tanto la opcion para cada uno será:

Cada categoría se transforma en una columna binaria:

France: [1.0, 0.0, 0.0]
Spain: [0.0, 0.0, 1.0]
Germany: [0.0, 1.0, 0.0]

```python
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
# 
transfCol = ColumnTransformer(transformers=[('encoder', OneHotEncoder(), [0])], remainder='passthrough')
X = np.array(transfCol.fit_transform(X))

print(X)
```

El proceso paso a paso sería:

1. **`transformers=[('encoder', OneHotEncoder(), [0])]`:**
   - Es una lista de transformaciones a aplicar.  
   - `'encoder'`: Un nombre que se da a esta transformación (puede ser cualquier texto).  
   - **`OneHotEncoder()`**: Es la transformación aplicada; convierte variables categóricas (como texto) en variables binarias.  
   - **`[0]`**: Especifica que la transformación se aplicará a la columna 0 de la matriz `X` (la primera columna).  
   - **`remainder='passthrough'`:**
     - Indica que el resto de las columnas que **no** están seleccionadas ([1, 2, ...]) deben dejarse sin cambios y mantenerse en el resultado final.

2. **`transfCol.fit_transform(X)`**:
   - **`fit_transform()`**:  
     - Primero, analiza los datos en la columna especificada (`[0]`) para identificar las categorías únicas presentes (por ejemplo, "France", "Germany", "Spain").  
     - Luego, transforma la columna seleccionada aplicando la codificación **OneHot**.  
     - Finalmente, combina el resultado transformado con el resto de las columnas no afectadas (`remainder='passthrough'`).

### Cuarta Parte: Dividir Datos para Entrenamiento y Pruebas  

En esta etapa, dividimos los datos en conjuntos para entrenamiento y pruebas utilizando la función `train_test_split` de **scikit-learn**. Este método divide los datos de forma aleatoria, pero se puede controlar esta aleatoriedad con el parámetro `random_state` para garantizar la reproducibilidad de los resultados.  

```python
from sklearn.model_selection import train_test_split

X_entreno, X_prueba, y_entreno, y_prueba = train_test_split(X, y, test_size=0.2, random_state=1)

print(X_entreno)
print(X_prueba)
print(y_entreno)
print(y_prueba)
```  

- **`test_size`**: Proporción de datos que se asignarán al conjunto de pruebas (en este caso, 20%).
- **`random_state`**: Semilla para garantizar que la división aleatoria sea reproducible.  

---

### Quinta Parte: Escalamiento de Datos  

El escalamiento de los datos debe realizarse **después** de dividirlos en conjuntos de entrenamiento y prueba. Para este propósito, utilizamos el `StandardScaler` de **scikit-learn**, que estandariza los datos para que tengan:  
- Media igual a **0**.  
- Desviación estándar igual a **1**.  

Esto transforma los valores para que, en general, se encuentren dentro de un intervalo aproximado de **[-3, 3]**, siempre que los datos originales sigan una distribución normal.  

```python
from sklearn.preprocessing import StandardScaler

escalador = StandardScaler()

# Escalamos solo las columnas necesarias (en este caso, desde la columna 3 en adelante)
X_entreno[:, 3:] = escalador.fit_transform(X_entreno[:, 3:])
X_prueba[:, 3:] = escalador.transform(X_prueba[:, 3:])

print(X_entreno)
print(X_prueba)
```  

- **`fit_transform`**: Calcula la media y desviación estándar del conjunto de entrenamiento y aplica la transformación.  
- **`transform`**: Usa los valores calculados previamente en el conjunto de entrenamiento para transformar el conjunto de prueba, asegurando consistencia.  
