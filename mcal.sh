#!/bin/bash
############# Definición de variables
export year=$(date +%Y) # valor por defecto año actual tipo global
                        # accesible en todas las funciones y subshells
export mes=$(date +%m)  # valor por defecto mes en curso
export idioma=$(locale | grep LC_MESSAGES | cut -d'=' -f2) # obtener lenguaje establecido para mensajes
if [  $idioma == '"es_ES.UTF-8"' ]; then  # si el sistema tiene establecido lenguaje ES para mensajes
RED=' \033[0;31m '
NC=' \033[0m ' # No Color
# array de meses en español
 meses=(meses enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre)
else
# array de meses en inglés
 meses=(months january february march april may jun julay agust septembar november decembar)
fi
############# Definición de funciones
function EN_help
{
cat << :help
Sintax:
  $0 [month] [year]

  where:

      - Month and year are opcional. Current month and year are assume by default.
      - Arguments can be given as numbers gretes than zero.
      - You can especified month in spanish or english, or abreviated with at least three leters.
      - If only one argument is given in the range  1 to  12, it's asume that mounth of the current year.
      - If only one argument is given  and greater tan 12  it wil be consider like a year
      - If two argument are given the first must be a month and the second the year 
        and the second will be consider a year. Pay Atention: use the century form for the year (four digit).
      - Write the year using only digits

:help
}
#
function ES_ayuda
{
cat << :ayuda
Sintaxis de uso:
 $0 [mes] [año]

  donde:
      - si el argumento es la palabra ayuda o help recibirá esta ayuda en su respectivo idioma
      - Mes y año son opcionales. Si no se especifica ninguno se asume mes y año actuales
      - Los argumentos  se pueden indicar como números  mayores de cero.
      - El mes también se puede expresar como nombre en español o inglés, o su abreviatura con almenos tres letras.
      - Si solo especifica un argumento  y está en el rango del 1 al 12 se entendera el mes indicado del año actual
      - Si solo se especifica un argumento y  es 13 o mayor se entiende  como año
      - Si se especifican dos argumentos el primero se considera el mes 
         y el segundo argumento se considera como año. Atención: incluya los dígitos de siglo.
      - El año se debe expresar siempre como número

:ayuda
}
function manual  # ayuda según el idioma establecido en el sistema
{
local error=$1
local mensaje=$2
local idioma=$(locale | grep LC_MESSAGES | cut -d'=' -f2) # obtener lenguaje establecido para mensajes
if [ $idioma == '"es_ES.UTF-8"' ]; then  # si el sistema tiene establecido lenguaje ES para mensajes
 ES_ayuda  # Ayuda en Español
 else
 EN_help   # Por defecto, ayuda en inglés
fi
[ $error -gt 0 ] && echo -e  \* " \t  $RED Error $error : $mensaje "
}
########### Selección de argumentos correctos
function controlafecha
{
local nmes
let nmes=$mes
if [ $nmes -gt 0 -a $nmes -le 12 ] ; then
  mes=$nmes
 elif [ $nmes -gt 12 ]; then
  mes=''
  year=$nmes
fi
}
#
function muetrameses
{
let index=1 #  ${meses[index]}
while [ $index -lt 13 ]; do 
echo ${meses[$index]} 
let "index++" # incremento
done
}
########### Fin definición de funciones, Inicio del programa
########### Código de controles
[ $# -gt 2 ] &&   manual  && exit 1 # no puede haber más de dos argumentos, mostrar ayuda según el idioma establecido en el sistema
[ $# -eq 2 ] &&   mes=${1,,} year=${2,,} # obterner argumento convertido a minúsculas
[ $# -eq 1 ] &&   mes=${1,,}      # obterner argumento convertido a minúsculas
#[ $# -eq 0 ] &&  cal && exit 1 # sin argumentos mostrar mes en curso del año actual
[ "$mes" == "ayuda" -o "$year" == "ayuda" ] &&   ES_ayuda && exit 1 # si el argumento es la palabra "ayuda" mostrar ayuda en español 
[ "$mes" == "help" -o  "$year" == "help" ]  &&  EN_help && exit 1 # si el argumento es la palabra "help" mostrar ayuda en inglés
controlafecha || (echo " Mes o Año erroneos " ; exit 2) # si mes o año erroneo salir
########### Ejecución de comando parametrizado
cal $mes $year 2> /dev/null  || error=$?
if [ $error ] ; then
manual $error 'No ha tecleado un mes o un año correcto'
fi
# FIN del programa
