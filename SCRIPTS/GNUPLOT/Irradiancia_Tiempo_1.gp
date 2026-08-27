# =====================================================================
# Script Gnuplot: Irradiancia vs Tiempo
# Generación automática para todos los archivos .dat
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# ---------------------------------------------------------------------
# 1. Configuración
# ---------------------------------------------------------------------

# Carpeta donde están los archivos .dat
data_dir = "."

# Carpeta donde se guardarán las gráficas
output_dir = "Graficas_Irradiancia"

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

# ---------------------------------------------------------------------
# 3. Título
# ---------------------------------------------------------------------

set title "Comportamiento Diario de Irradiancia Global" \
    font "Helvetica-Bold,13" \
    textcolor rgb "#222222" \
    offset 0,1

# ---------------------------------------------------------------------
# 4. Eje X - Tiempo
# ---------------------------------------------------------------------

set xlabel "Tiempo del Día" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#333333" \
    offset 0,-1

set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"

set xtics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#444444"

# ---------------------------------------------------------------------
# 5. Eje Y - Irradiancia
# ---------------------------------------------------------------------

set ylabel "Irradiancia / Radiación Global [W/m²]" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#1f77b4"

set ytics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#1f77b4"

# ---------------------------------------------------------------------
# 6. Leyenda
# ---------------------------------------------------------------------

set key top center horizontal \
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
    salida = sprintf("%s/Irradiancia_%s.pdf", \
                     output_dir, fecha)

    # Configurar archivo de salida
    set output salida

    # Título individual para cada fecha
    set title sprintf("Comportamiento Diario de Irradiancia Global - %s", fecha) \
        font "Helvetica-Bold,13" \
        textcolor rgb "#222222" \
        offset 0,1

    # -----------------------------------------------------------------
    # Graficar
    #
    # Columna 1 -> Tiempo
    # Columna 2 -> Irradiancia global
    # -----------------------------------------------------------------

    plot archivo using 1:2 \
         with lines linewidth 1.8 \
         linecolor rgb "#1f77b4" \
         title "Irradiancia Global"

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
