# =====================================================================
# Script Interactivo de Gnuplot: Irradiancia vs Tiempo
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# 1. Validación inicial del archivo de datos
if (!exists("archivo")) {
    print "========================================================="
    print " ERROR: Debes especificar el archivo antes de cargar el script."
    print " Ejemplo en la consola de gnuplot:"
    print " gnuplot> archivo='2026-07-22'; load 'irradiancia_tiempo.gp'"
    print "========================================================="
    exit
}

# 2. Configuración de la ventana interactiva en Debian
set terminal qt enhanced font "Helvetica,10" size 950, 600 title "Visualizador - Irradiancia vs Tiempo"

# Estética y rejilla limpia
set border 31 linewidth 1.0 linecolor rgb "#444444"
set grid ytics lc rgb "#e0e0e0" lt 1 lw 0.5
set grid noxtics

# Título principal de la gráfica
set title "Comportamiento Diario de Irradiancia Global" font "Helvetica-Bold,13" textcolor rgb "#222222" offset 0, 1

# 3. Configuración del Eje X (Tiempo)
set xlabel "Tiempo del Día" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 0, -1
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"
set xtics nomirror font "Helvetica,9" textcolor rgb "#444444"

# 4. Configuración del Eje Y (Radiación Global)
set ylabel "Irradiancia / Radiación Global [W/m²]" font "Helvetica-Bold,10" textcolor rgb "#1f77b4" offset 0, 0
set ytics nomirror font "Helvetica,9" textcolor rgb "#1f77b4"

# Ubicación de la leyenda
set key top center horizontal box height 0.5 width 1 font "Helvetica,9"

# 5. Mapeo de Columnas (añadiendo automáticamente la extensión .dat, 
# puedes cambiarla a .txt si tus archivos usan esa extensión):
# Col 1: Tiempo -> Eje X
# Col 2: Radiación global -> Eje Y

plot archivo.'.dat' using 1:2 with lines linewidth 1.8 linecolor rgb "#1f77b4" title "Irradiancia Global"

print ""
print "========================================================================="
print " ¡Gráfica de irradiancia cargada con éxito!"
print "========================================================================="
