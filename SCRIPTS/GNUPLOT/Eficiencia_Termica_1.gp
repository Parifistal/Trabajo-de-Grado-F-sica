# =====================================================================
# Script Gnuplot: Caída de Eficiencia Térmica
# Generación automática para todos los archivos .dat
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# ---------------------------------------------------------------------
# 1. Configuración
# ---------------------------------------------------------------------

# Carpeta donde están los archivos .dat
data_dir = "."

# Carpeta donde se guardarán las gráficas
output_dir = "Graficas_Eficiencia_Termica"

# Crear la carpeta de salida si no existe
system(sprintf("mkdir -p '%s'", output_dir))

# Terminal PDF vectorial
set terminal pdfcairo enhanced font "Helvetica,10" \
    size 12cm, 7.5cm

# ---------------------------------------------------------------------
# 2. Estética general
# ---------------------------------------------------------------------

set border 31 linewidth 1.0 linecolor rgb "#444444"

set grid ytics lc rgb "#e0e0e0" lt 1 lw 0.5
set grid noxtics

set xlabel "Tiempo del Día" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#333333" \
    offset 0,-1

set ylabel "Temperatura del Sistema [°C]" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#d62728"

set y2label "Voltaje [V]" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#1f77b4" \
    offset 2,0

# ---------------------------------------------------------------------
# 3. Eje X
# ---------------------------------------------------------------------

set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"

set xtics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#444444"

# ---------------------------------------------------------------------
# 4. Ejes Y
# ---------------------------------------------------------------------

set y2tics nomirror
set tic scale 0

set ytics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#d62728"

# Rango fijo para el voltaje
set y2range [0:22]

set y2tics \
    font "Helvetica,9" \
    textcolor rgb "#1f77b4"

# ---------------------------------------------------------------------
# 5. Leyenda
# ---------------------------------------------------------------------

set key top center horizontal \
    box height 0.5 width 1 \
    font "Helvetica,9"

# ---------------------------------------------------------------------
# 6. Obtener todos los archivos .dat
# ---------------------------------------------------------------------

files = system("find . -maxdepth 1 -type f -name '*.dat' | sort")

# ---------------------------------------------------------------------
# 7. Generar una gráfica PDF para cada archivo
# ---------------------------------------------------------------------

do for [archivo in files] {

    # Obtener solamente el nombre del archivo
    nombre = system(sprintf("basename '%s'", archivo))

    # Quitar la extensión .dat
    fecha = substr(nombre, 1, strlen(nombre)-4)

    # Nombre del archivo PDF
    salida = sprintf("%s/Eficiencia_Termica_%s.pdf", output_dir, fecha)

    # Configurar archivo de salida
    set output salida

    # Título de la gráfica
    set title sprintf("Caída de Eficiencia Térmica - %s", fecha) \
        font "Helvetica-Bold,13" \
        textcolor rgb "#222222" \
        offset 0,1

    # -----------------------------------------------------------------
    # Graficar
    # -----------------------------------------------------------------

    plot archivo using 1:3 axes x1y1 \
             with lines linewidth 1.6 \
             linecolor rgb "#d62728" \
             title "Temp. Sistema de Operación", \
         archivo using 1:5 axes x1y2 \
             with lines linewidth 1.6 \
             linecolor rgb "#1f77b4" \
             title "Voltaje Módulo PV"

    unset output

    print sprintf("Gráfica generada: %s", salida)
}

print "========================================================="
print " Proceso terminado."
print sprintf(" Las gráficas están en: %s/", output_dir)
print "========================================================="
