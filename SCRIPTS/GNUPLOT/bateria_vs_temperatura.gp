# =====================================================================
# Script Interactivo de Gnuplot: Voltaje de Batería vs Temperatura
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# 1. Validación inicial del archivo de datos
if (!exists("archivo")) {
    print "========================================================="
    print " ERROR: Debes especificar el archivo antes de cargar el script."
    print " Ejemplo en la consola de gnuplot:"
    print " gnuplot> archivo='tu_archivo.dat'; load 'bateria_vs_temperatura.gp'"
    print "========================================================="
    exit
}

# 2. Configuración de la ventana interactiva en Debian
set terminal qt enhanced font "Helvetica,10" size 950, 600 title "Visualizador - Batería vs Temperatura"

# Estética y rejilla limpia
set border 31 linewidth 1.0 linecolor rgb "#444444"
set grid ytics lc rgb "#e0e0e0" lt 1 lw 0.5
set grid noxtics

# Título principal de la gráfica
set title "Voltaje de Batería vs Temperatura de Operación" font "Helvetica-Bold,13" textcolor rgb "#222222" offset 0, 1

# 3. Configuración del Eje X (Tiempo)
set xlabel "Tiempo del Día" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 0, -1
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"
set xtics nomirror font "Helvetica,9" textcolor rgb "#444444"

# 4. Configuración de Ejes Y (Doble Eje)
set y2tics nomirror
set tic scale 0

# Eje Y Izquierdo (y1): Temperatura del Sistema de Operación (Columna 4)
set ylabel "Temperatura del Sistema [°C]" font "Helvetica-Bold,10" textcolor rgb "#d62728" offset 0, 0
set ytics nomirror font "Helvetica,9" textcolor rgb "#d62728"

# Eje Y Derecho (y2): Voltaje de la Batería (Columna 6) - Fijado de 0 a 15V
set y2range [0:15]
set y2label "Voltaje de Batería [V]" font "Helvetica-Bold,10" textcolor rgb "#2ca02c" offset 2, 0
set y2tics font "Helvetica,9" textcolor rgb "#2ca02c"

# Ubicación de la leyenda
set key top center horizontal box height 0.5 width 1 font "Helvetica,9"

# 5. Mapeo de Columnas:
# Col 1: Tiempo -> Eje X
# Col 4: Temperatura del sistema de operación -> Eje Y Izquierdo (x1y1)
# Col 6: Voltaje de la batería -> Eje Y Derecho (x1y2)

plot archivo using 1:4 axes x1y1 with lines linewidth 1.6 linecolor rgb "#d62728" title "Temp. Sistema de Operación", \
     archivo using 1:6 axes x1y2 with lines linewidth 1.6 linecolor rgb "#2ca02c" title "Voltaje Batería"

print ""
print "========================================================================="
print " ¡Gráfica de voltaje de batería vs temperatura cargada con éxito!"
print " Rango del eje Y derecho configurado de 0 a 15V."
print "========================================================================="
