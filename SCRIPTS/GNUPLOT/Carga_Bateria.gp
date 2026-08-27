# =====================================================================
# Script Interactivo de Gnuplot: Zoom Matutino - Transición del Regulador PWM
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

if (!exists("archivo")) {
    print "========================================================="
    print " ERROR: Debes especificar el archivo antes de cargar el script."
    print " Ejemplo en la consola de gnuplot:"
    print " gnuplot> archivo='2026-08-10'; load 'zoom_matutino.gp'"
    print "========================================================="
    exit
}

set terminal qt enhanced font "Helvetica,10" size 950, 600 title "Zoom Matutino - Activación del Regulador PWM"

set border 31 linewidth 1.0 linecolor rgb "#444444"
set grid xtics ytics lc rgb "#e0e0e0" lt 1 lw 0.5

set title sprintf("Transición de Carga Matutina (Umbral de 12.4V a 13.4V) - %s", archivo) font "Helvetica-Bold,12" textcolor rgb "#222222" offset 0, 1

# Configuración del Eje X: Restringido a la mañana (Ej: 06:00 a 08:30)
set xlabel "Tiempo de la Mañana" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 0, -1
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"
set xrange ["05:00:00":"08:30:00"]
set xtics nomirror font "Helvetica,9" textcolor rgb "#444444"

# Configuración del Eje Y: Enfocado en el rango de voltajes de 0V a 15V para ver el cruce
set ylabel "Voltaje [V]" font "Helvetica-Bold,10" textcolor rgb "#333333" offset 0, 0
set yrange [10:15]
set ytics 1 nomirror font "Helvetica,9" textcolor rgb "#444444"

# Línea de referencia horizontal en los 12.2V (Umbral del regulador) iniciando a las 05:00:00
set arrow from "05:00:00", 12.4 to "08:30:00", 12.4 nohead linetype 1 linecolor rgb "#d62728" linewidth 1.5 dashtype 2
set label "Umbral PWM (12.4V)" at "05:12:00", 12.8 font "Helvetica-Bold,8" textcolor rgb "#d62728"

set key top left box height 0.5 width 1 font "Helvetica,9"

# Línea de referencia horizontal en los 13.4V (Umbral del regulador) iniciando a las 05:00:00
set arrow from "05:00:00", 13.4 to "08:30:00", 13.4 nohead linetype 1 linecolor rgb "#d62728" linewidth 1.5 dashtype 2
set label "Umbral PWM (13.4V)" at "05:012:00", 13.8 font "Helvetica-Bold,8" textcolor rgb "#d62728"

set key top left box height 0.5 width 1 font "Helvetica,9"


# Mapeo: Col 1 (Tiempo), Col 5 (Voltaje PV), Col 6 (Voltaje Batería)
plot archivo.'.dat' using 1:5 with lines linewidth 1.8 linecolor rgb "#ff7f0e" title "Voltaje Módulo PV (V_{PV})", \
     archivo.'.dat' using 1:6 with lines linewidth 1.8 linecolor rgb "#2ca02c" title "Voltaje Batería (V_B)"

print ""
print "========================================================================="
print " ¡Zoom matutino generado con éxito! Analiza el comportamiento a los 12.4V."
print "========================================================================="
