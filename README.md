# Análisis de correlación TMR: datos de herbario físicos vs. datos de herbario en línea

**Autora:** Magali Burni  
**Objetivo:** Comparar registros de especies de herbario físicos y online, visualizar correlación y verificar distribución de datos.

---

## 1. Descripción del proyecto
Este proyecto analiza registros de TMR (Tiempo Mínimo de Residencia) de especies arbóreas exóticas (invasoras y no invasoras) y nativas del centro de Argentina.  
El objetivo es comparar los datos de **herbario físico** con los del **herbario online**, identificar datos faltantes y explorar la relación entre ambos conjuntos de datos mediante visualización y análisis de correlación.

---

## 2. Contenido del repositorio
- `chequeos_herbario.R`: Script en R con análisis completo, preparado para trabajar con un archivo .csv.  
- `README.md`: Este archivo, que explica el proyecto y los resultados.

> **Nota:** Los datos no se incluyen por motivos de privacidad; el script está listo para reproducirse con un archivo similar.

---

## 3. Librerías utilizadas
```r
library(dplyr)
library(ggplot2)
library(viridis)
library(PerformanceAnalytics)
