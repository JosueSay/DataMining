# Análisis Exploratorio de Datos 📊

## 🐍 Entorno

**Lenguaje**: Python

**Versión**: 3.12.3

## 📂 Archivos principales

- **`03-Vida_facil.ipynb`**: Script principal donde se hace todo el trabajo de limpieza y transformación de los datos.
- **`titanic3.csv`**: Conjunto de datos crudos que contienen variables no numéricas, listas para ser procesadas.
- **`requirements.txt`**: Dependencias utilizadas.
- **`Variables_titanic3.pdf`**: Significado de variables.
- **`resultados.csv`**: Archivo final con los datos preprocesados y listos para su análisis o para ser usados en modelos de clasificación.

## 🔄 Repetir el proceso

1. **Crear un entorno virtual**:
   - Crear un entorno virtual. Usa el siguiente comando:

     ```bash
     python -m venv .venv
     ```

2. **Instalar las dependencias**:
   - Dirígete a la carpeta del proyecto y ejecuta:

     ```bash
     pip install -r requirements.txt
     ```

     Esto instalará todas las librerías necesarias.

3. **Configurar el entorno en Jupyter**:
   - Activa el entorno virtual y configúralo como el kernel de Jupyter Notebook para que puedas ejecutar las instrucciones del proyecto en el entorno aislado.

4. **Ejecutar el script**:
   - Corre las instrucciones de `03-Vida_facil.ipynb` para replicar el proceso de limpieza y transformación de datos.

## 🤔 ¿Qué se hizo?

1. **Manejo de variables no numéricas** 🧑‍💻:
   - **Codificación**: Se usaron técnicas como **OneHotEncoding** para convertir variables categóricas (como colores, categorías de productos) en columnas numéricas. 🔢
   - Se realizó una **transformación de etiquetas** para variables que no podían ser representadas de otra manera. 🏷️

2. **Limpieza de datos** 🧹:
   - Se eliminaron o imputaron los valores faltantes (NaN) para evitar distorsiones en el análisis. ❌
   - Se estandarizaron las  columnas para que todas tuvieran tanta variabilidad en sus categorias. 📏

3. **Análisis exploratorio básico** 🔍:
   - Se hizo un análisis preliminar de los datos para identificar patrones, relaciones entre las variables y posibles problemas antes de preprocesar. 📊

4. **Preparación final** 🏁:
   - Después de transformar y limpiar los datos, se exportaron en un archivo **`resultados.csv`** para usarlos en futuras etapas de análisis o para alimentar modelos de clasificación. 🚀
