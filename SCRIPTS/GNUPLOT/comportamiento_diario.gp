# =====================================================================
# Script Interactivo de Gnuplot para Trabajo de Grado
# =====================================================================

# 1. Validación inicial del archivo de datos
if (!exists("archivo")) {
    print "========================================================="
    print " ERROR: Debes especificar el archivo antes de cargar el script."
    print " Ejemplo en la consola de gnuplot:"
    print " gnuplot> archivo='tu_archivo.dat'; load 'comportamiento_diario.gp'"
    print "========================================================="
    exit
}

# 2. Configuración de la terminal interactiva para Debian (qt o wxt)
# Intentamos usar 'qt' por su alta compatibilidad y nitidez, con tamaño de ventana cómodo
set terminal qt enhanced font "Helvetica,10" size 950, 600 title "Visualizador - Comportamiento Diario"

# Estética y rejilla limpia
set border 31 linewidth 1.0 linecolor rgb "#444444"
set grid ytics lc rgb "#e0e0e0" lt 1 lw 0.5
set grid noxtics

# Título principal de la gráfica
set title "Comportamiento Diario Superpuesto" font "Helvetica-Bold,13" textcolor rgb "#222222" offset 0, 1

# 3. Configuración del Eje X (Tiempo)
set xlabel "Tiempo del Día" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 0, -1
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"
set xtics nomirror font "Helvetica,9" textcolor rgb "#444444"

# 4. Configuración de Ejes Y (Doble Eje)
set y2tics nomirror
set tic scale 0

# Eje Y Izquierdo (y1): Radiación Global
set ylabel "Radiación Global [W/m²]" font "Helvetica-Bold,10" textcolor rgb "#1f77b4" offset 0, 0
set ytics nomirror font "Helvetica,9" textcolor rgb "#1f77b4"

# Eje Y Derecho (y2): Voltajes
set y2label "Voltaje [V]" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 2, 0
set y2range [0:22]
set y2tics font "Helvetica,9" textcolor rgb "#444444"

# Leyenda limpia en la parte superior central
set key top center horizontal box height 0.5 width 1 font "Helvetica,9"

# 5. Trazado de las curvas
plot archivo using 1:2 axes x1y1 with lines linewidth 1.6 linecolor rgb "#1f77b4" title "Radiación Global", \
     archivo using 1:5 axes x1y2 with lines linewidth 1.6 linecolor rgb "#ff7f0e" title "Voltaje Módulo PV", \
     archivo using 1:6 axes x1y2 with lines linewidth 1.6 linecolor rgb "#2ca02c" title "Voltaje Batería"

print ""
print "========================================================================="
print " ¡Gráfica cargada en la ventana interactiva!"
print " Puedes hacer zoom, moverte y revisar los datos."
print " Si deseas exportarla a PDF con calidad académica, ejecuta en la consola:"
print "   load 'exportar_pdf.gp'"
print "========================================================================="
