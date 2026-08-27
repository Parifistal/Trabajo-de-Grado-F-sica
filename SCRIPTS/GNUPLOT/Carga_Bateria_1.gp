# =====================================================================
# Script Gnuplot: Zoom Matutino - Transición del Regulador PWM
# Generación automática para todos los archivos .dat
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# ---------------------------------------------------------------------
# 1. Configuración
# ---------------------------------------------------------------------

# Carpeta donde están los archivos .dat
data_dir = "."

# Carpeta donde se guardarán las gráficas
output_dir = "Graficas_Zoom_Matutino"

# Crear la carpeta de salida si no existe
system(sprintf("mkdir -p '%s'", output_dir))

# Terminal PDF vectorial
set terminal pdfcairo enhanced font "Helvetica,10" \
    size 12cm, 7.5cm

# ---------------------------------------------------------------------
# 2. Estética general
# ---------------------------------------------------------------------

set border 31 linewidth 1.0 linecolor rgb "#444444"

set grid xtics ytics lc rgb "#e0e0e0" lt 1 lw 0.5

# ---------------------------------------------------------------------
# 3. Eje X - Tiempo
# ---------------------------------------------------------------------

set xlabel "Tiempo de la Mañana" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#333333" \
    offset 0,-1

set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"

# Intervalo de interés
set xrange ["05:00:00":"08:30:00"]

set xtics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#444444"

# ---------------------------------------------------------------------
# 4. Eje Y - Voltaje
# ---------------------------------------------------------------------

set ylabel "Voltaje [V]" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#333333"

set yrange [10:15]

set ytics 1 nomirror \
    font "Helvetica,9" \
    textcolor rgb "#444444"

# ---------------------------------------------------------------------
# 5. Líneas de referencia del regulador PWM
# ---------------------------------------------------------------------

# Umbral inferior: 12.4 V
set arrow 1 from "05:00:00",12.4 \
    to "08:30:00",12.4 \
    nohead \
    linetype 1 \
    linecolor rgb "#d62728" \
    linewidth 1.5 \
    dashtype 2

set label 1 "Umbral PWM (12.4 V)" \
    at "05:12:00",12.65 \
    font "Helvetica-Bold,8" \
    textcolor rgb "#d62728"

# Umbral superior: 13.4 V
set arrow 2 from "05:00:00",13.4 \
    to "08:30:00",13.4 \
    nohead \
    linetype 1 \
    linecolor rgb "#d62728" \
    linewidth 1.5 \
    dashtype 2

set label 2 "Umbral PWM (13.4 V)" \
    at "05:12:00",13.65 \
    font "Helvetica-Bold,8" \
    textcolor rgb "#d62728"

# ---------------------------------------------------------------------
# 6. Leyenda
# ---------------------------------------------------------------------

set key top left \
    box height 0.5 width 1 \
    font "Helvetica,9"

# ---------------------------------------------------------------------
# 7. Obtener todos los archivos .dat
# ---------------------------------------------------------------------

files = system("find . -maxdepth 1 -type f -name '*.dat' | sort")

# ---------------------------------------------------------------------
# 8. Generar una gráfica PDF para cada archivo
# ---------------------------------------------------------------------

do for [archivo in files] {

    # Obtener únicamente el nombre del archivo
    nombre = system(sprintf("basename '%s'", archivo))

    # Eliminar la extensión .dat
    fecha = substr(nombre, 1, strlen(nombre)-4)

    # Nombre del PDF de salida
    salida = sprintf("%s/Zoom_Matutino_%s.pdf", \
                     output_dir, fecha)

    # Configurar archivo de salida
    set output salida

    # Título individual para cada fecha
    set title sprintf("Transición de Carga Matutina (12.4 V - 13.4 V) - %s", fecha) \
        font "Helvetica-Bold,12" \
        textcolor rgb "#222222" \
        offset 0,1

    # -----------------------------------------------------------------
    # Graficar
    #
    # Columna 1 -> Tiempo
    # Columna 5 -> Voltaje del módulo PV
    # Columna 6 -> Voltaje de batería
    # -----------------------------------------------------------------

    plot archivo using 1:5 \
             with lines \
             linewidth 1.8 \
             linecolor rgb "#ff7f0e" \
             title "Voltaje Módulo PV (V_{PV})", \
         archivo using 1:6 \
             with lines \
             linewidth 1.8 \
             linecolor rgb "#2ca02c" \
             title "Voltaje Batería (V_B)"

    # Cerrar el PDF actual
    unset output

    print sprintf("Gráfica generada: %s", salida)
}

# ---------------------------------------------------------------------
# 9. Mensaje final
# ---------------------------------------------------------------------

print "========================================================="
print " Proceso terminado."
print sprintf(" Las gráficas están en: %s/", output_dir)
print "========================================================="
