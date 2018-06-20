#!/bin/bash
############# Definición de variables
year=$(date +%Y) # valor por defecto año actual
mes=$(date +%m)  # valor por defecto mes en curso
idioma=$(locale | grep LC_MESSAGES | cut -d'=' -f2) # obtener lenguaje establecido para mensajes
if [  $idioma == '"es_ES.UTF-8"' ]; then  # si el sistema tiene establecido lenguaje ES para mensajes
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
      - You can especified month in spanish or english, or abreviated with three leters.
      - If only one argument is given in the range  1 to  12, it's asume that mounth of the current year.
      - If only one argument is given  and greater tan 12  it wil be consider like a year
      - If two argument are given the first must be a month or a number betewen 1 and 12 
        and the second will be consider a year. Pay Atention: use the century form for the year (four digit).

:help
}

function ES_ayuda
{
cat << :ayuda
Sintaxis de uso:
 $0 [mes] [año]

  donde:

      - Mes y año son opcionales. Si no se especifica ninguno se asume mes y año actuales
      - Los argumentos  se pueden indicar como números  mayores de cero.
      - El mes también se puede expresar como nombre en español o inglés, o su abreviatura en tres letras.
      - Si solo especifica un argumento  y está en el rango del 1 al 12 se entendera el mes indicado del año actual
      - Si solo se especifica un argumento y  es 13 o mayor se entiende  ese año
      - Si se especifican dos argumentos el primero deberá ser un número del  rango [1 - 12]
         y el segundo argumento se considera el año. Atención: incluya los dígitos de siglo.

:ayuda
}
function manual  # ayuda según el idioma establecido en el sistema
{
local idioma=$(locale | grep LC_MESSAGES | cut -d'=' -f2) # obtener lenguaje establecido para mensajes
if [ $idioma == '"es_ES.UTF-8"' ]; then  # si el sistema tiene establecido lenguaje ES para mensajes
 ES_ayuda  # Ayuda en Español
else
 EN_help   # Por defecto, ayuda en inglés
fi
}
########### Código de controles
[ $# -gt 2 ] &&   manual  && exit 1 # no puede haber más de dos argumentos, mostrar ayuda según el idioma establecido en el sistema
[ $# -gt 1 ] &&   year=${2,,} # obterner 2º argumento convertido a minúsculas
arg=${1,,} # obterner 1º argumento convertido a minúsculas
[ "$arg" == "ayuda" ] &&   ES_ayuda && exit 1 # si el argumento es la palabra "ayuda" mostrar ayuda en español 
[ "$arg" == "help" ]  &&  EN_help && exit 1 # si el argumento es la palabra "help" mostrar ayuda en inglés
########### Acción por defecto si no hay argumentos
#[ "$arg" == "" ] &&  cal && exit 1 # sin argumentos mostrar mes en curso del año actual
[ -z $arg ] &&  cal && exit 1 # sin argumentos mostrar mes en curso del año actual
########### Selección de argumentos correctos
case  $arg in 
 [1-9])
    mes=$arg;;
 1 | enero | ene | jan |january)
    mes=1;;
 2 | fenero | fen | fab |fabruary)
    mes=2;;
 3 | marzo | mar | mar |march)
    mes=3;;

 12 | diciembre | dic | dec |decembar)
    mes=12;;
 *)
esac
########### Ejecución de comando parametrizado
cal $mes $year
let index=1 #  ${meses[index]}
for index in ${meses[@]}; do 
echo $index 
done
exit 0 # Fin del programa devuelve código de valor sin errores

