# Explicación Código

## Primer Código **01-Pre-procesamiento_Datos**

El objetivo de este análisis es registrar y analizar los datos de los clientes para determinar su predisposición a aceptar ofertas enviadas. Para lograr esto, es necesario identificar las características principales de los clientes y separar las variables en dos categorías:  

1. **Variable dependiente**: Representa si el cliente realizó o no una compra como resultado de las ofertas enviadas.  
2. **Variables independientes**: Incluyen las características del cliente que podrían influir en su decisión de compra (edad, historial de compras, preferencias, etc.).  

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

Cuando escalas **antes de dividir**:

1. Calculas la **media ($ \mu $)** y la **desviación estándar ($ \sigma $)** de **todos los datos** (entrenamiento + prueba).  
2. Esa información ($ \mu $ y $ \sigma $) se usa para escalar tanto los datos de entrenamiento como los de prueba.  
3. Esto significa que los datos de prueba **afectan indirectamente** los datos de entrenamiento porque contribuyen al cálculo de $ \mu $ y $ \sigma $. Así, se rompe la separación entre ambos conjuntos y "mezclas" la información.  

Cuando escalas **después de dividir**:

1. Primero separas los datos en entrenamiento y prueba.
2. Calculas $ \mu $ y $ \sigma $ **solo** usando los datos de entrenamiento.  
3. Escalas los datos de entrenamiento con esos valores, y luego usas esos mismos $ \mu $ y $ \sigma $ para escalar los datos de prueba.  

En este caso, los datos de prueba **no tienen ninguna influencia** sobre los datos de entrenamiento, lo que garantiza que el modelo solo aprenda de los datos de entrenamiento, como en un escenario real.  

Por eso, **escalando después de dividir**, mantienes la separación correcta entre entrenamiento y prueba y obtienes una evaluación más realista del desempeño del modelo.

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

## Segundo código **02-Pre-procesamiento-Datos_Pandas**

### Primera Parte (Exploración de Datos)

Los primeros pasos son iguales que el anterior hasta Datos faltantes.

### Segunda Parte (Datos Faltantes)

En este código usando pandas se rellenan todos los valores nan usando la media y unicmante valores numericos de la columna `Age` y `Salary`.

```python
X = X.fillna(X.mean(numeric_only = True)["Age":"Salary"])
```

### Tercera Parte (Clasificación de Variables NO Núméricas)

En este punto se sigue el mismo proceso que el primer código, pero usando panas para crear columnas y un comodín donde se tienen nuevas columnas de conversion numérica de los países y luego añadiendolo a dataframe original.

```python
comodin = pd.get_dummies(X['Country'])
concatenado = pd.concat([X, comodin], axis = 1)
concatenado = concatenado.drop(['Country'], axis = 1)
```

O se puede hacer un enfoque más flexible:

```python
def codif_y_ligar(dataframe_original, variables_a_codificar):
    dummies = pd.get_dummies(dataframe_original[[variables_a_codificar]])
    resultado = pd.concat([dataframe_original, dummies], axis = 1)
    resultado = resultado.drop([variables_a_codificar], axis = 1)
    return(resultado)

variables_a_codificar = ['Country']  # Lista de variables a codificar
for variable in variables_a_codificar:
    X = codif_y_ligar(X, variable)
```

#### **Diferencias clave:**

| Característica                  | **Enfoque 1** (con función `codif_y_ligar`)                  | **Enfoque 2** (con `get_dummies()` directamente)             |
|----------------------------------|-------------------------------------------------------------|------------------------------------------------------------|
| **Flexibilidad**                 | Más flexible, permite trabajar con varias columnas en un bucle. | Más directo y simple, pero se aplica solo a una columna a la vez. |
| **Uso de bucles**                | Usa un bucle para aplicar la transformación a múltiples columnas. | Se aplica directamente a la columna `Country`.             |
| **Manejo de múltiples variables**| Se pueden agregar múltiples variables a la lista `variables_a_codificar`. | No permite aplicar directamente a múltiples columnas sin modificaciones adicionales. |

#### **Similitudes**

- En ambos enfoques se obtiene el mismo resultado: se crean columnas binarias para cada valor de `Country` y se eliminan las columnas originales.
- Ambos métodos usan `pd.get_dummies()` para realizar el **one-hot encoding**.

> **Nota:** One Hot Encoding es una técnica de preprocesamiento de datos utilizada para convertir variables categóricas en variables numéricas.

### Procesos Posteriores

Para el caso de la variable independiente se hace algo parecido pero solo con `sí` y `no` y el escalamiento se hace igual que en el código 1 con `sklearn`.
