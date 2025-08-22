# ============================================
# Análisis de correlacion para datos de Tiempo Minimo de Residencia (TMR): datos físicos vs. datos en línea
# Autora: Magali Burni
# Objetivo: Comparar registros de colecciones de especies en herbario físico y las cargadas online,
#           visualizar correlación y verificar distribución de datos.
# ============================================

# --- 1. Cargar librerías ---
library(PerformanceAnalytics)
library(ggplot2)
library(viridis)
library(dplyr)

# --- 2. Cargar datos ---
colecciones <- read.csv('chequeos_herbario.csv', 
                        header = T, sep = ',', 
                        stringsAsFactors = T)

# --- 3. Exploración inicial de NAs ---
# Especies con NA en herbario físico
which(is.na(colecciones$TRM_fisico))
colecciones[c(13, 20, 25, 27),1] #especies con NA en herbario físico

# Especies con NA en herbario online
which(is.na(colecciones$TRM_on.line))
colecciones[c(13, 25), 1] #especies con NA en herbario on-line

# Porcentaje de datos presentes en herbario físico pero ausentes en el herbario on-line
per_na <- (2*100) / nrow(colecciones)
per_na              

# Eliminar filas con datos faltantes para análisis de correlacion
colecciones <- na.omit(colecciones) 


# --- 4. Visualización de correlación ---
# Preparar datos
datos_correlacion <- data.frame(colecciones$TRM_on.line, colecciones$TRM_fisico)

# Traducir al español los niveles del factor status
colecciones <- mutate(colecciones, status = case_when(status == 'invasive' ~ 'Invasora',
                                          status == 'non-invasive' ~ 'No invasora',
                                          status == 'native' ~ 'Nativa'))

# Ordenar los niveles del factor para la visualizacion
colecciones$status <- factor(colecciones$status, levels = c('Invasora', 'No invasora', 'Nativa'))

# Scatter plot con ggplot2
plot_tmr <- ggplot(data= colecciones, aes(x= TRM_on.line, y= TRM_fisico))+
  geom_point(size= 4.5, shape= 20, aes(col = status))+
  geom_smooth(method = 'lm', col = 'darkgray', alpha = 0, size= 0.6) +
  geom_text(aes(x= 45, y= 155, label= 'rho = 0.999, p < 2.2e-16'), stat = 'unique', col= 'black')+
  xlab('TMR (datos en línea)') + ylab('TMR (datos físicos)') +
  ylim(0,155) +
  xlim(0,155)+
  scale_colour_manual(values = c('coral4', 'cornflowerblue', 'gold3')) +
  theme_bw()

plot_tmr


# --- 5. Comprobación de normalidad ---
shapiro.test(colecciones$TRM_on.line) #no es normal
shapiro.test(colecciones$TRM_fisico) #no es normal

# --- 6. Correlación ---
# Se utiliza Spearman porque los datos no son normales
correlacion_spearman <- cor.test(colecciones$TRM_on.line,
         colecciones$TRM_fisico, 
         method = 'spearman')

correlacion_spearman
