# =====================================================================
# Script Gnuplot: V_PV vs Irradiancia (G)
# Generación automática para todos los archivos .dat
# Trabajo de Grado - Sistemas Fotovoltaicos
# =====================================================================

# ---------------------------------------------------------------------
# 1. Configuración
# ---------------------------------------------------------------------

# Carpeta donde están los archivos .dat
data_dir = "."

# Carpeta donde se guardarán las gráficas
output_dir = "Graficas_VPV_Irradiancia"

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
# 3. Título
# ---------------------------------------------------------------------

set title "Relación entre Temperatura Ambiente y Voltaje del Módulo PV" \
    font "Helvetica-Bold,12" \
    textcolor rgb "#222222" \
    offset 0,1

# ---------------------------------------------------------------------
# 4. Eje X - Irradiancia
# ---------------------------------------------------------------------

set xlabel "Temperatura Ambiente (°C)" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#1f77b4" \
    offset 0,-1

set xrange [5:30]

set xtics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#444444"

# ---------------------------------------------------------------------
# 5. Eje Y - Voltaje del módulo PV
# ---------------------------------------------------------------------

set ylabel "Voltaje del Módulo PV V_{PV} [V]" \
    font "Helvetica-Bold,11" \
    textcolor rgb "#ff7f0e"

set yrange [0:25]

set ytics nomirror \
    font "Helvetica,9" \
    textcolor rgb "#ff7f0e"

# ---------------------------------------------------------------------
# 6. Leyenda
# ---------------------------------------------------------------------

set key bottom right \
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
    salida = sprintf("%s/VPV_Irradiancia_%s.pdf", \
                     output_dir, fecha)

    # Configurar archivo de salida
    set output salida

    # Título individual para cada fecha
    set title sprintf("Relación entre Irradiancia Incidente y Voltaje del Módulo PV - %s", fecha) \
        font "Helvetica-Bold,12" \
        textcolor rgb "#222222" \
        offset 0,1

    # -----------------------------------------------------------------
    # Graficar
    #
    # Columna 2 -> Irradiancia G [W/m²] -> Eje X
    # Columna 5 -> Voltaje del módulo PV [V] -> Eje Y
    # -----------------------------------------------------------------

    plot archivo using 3:5 \
         with points \
         pt 7 \
         ps 0.4 \
         linecolor rgb "#1f77b4" \
         title "V_{PV} vs G"

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
