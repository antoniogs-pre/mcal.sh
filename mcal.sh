#!/bin/bash
# Definición de variables
year=$(date +%Y) 
mes=$(date +%m) 
# Definición de funciones
function enhelp
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

function ayuda
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
function manual
{
local idioma=$(locale | grep LC_MESSAGES | cut -d'=' -f2)
if [ $idioma == '"es_ES.UTF-8"' ]; then
 ayuda
else
 enhelp
fi
}
#
[ $# -gt 2 ] &&   manual  && exit 1

arg=$1
[ "$arg" == "ayuda" ] &&   ayuda && exit 1
[ "$arg" == "help" ]  &&  enhelp && exit 1
#[ "$arg" == "" ] &&  cal && exit 1 

case  $arg in 
 [1-9])
    mes=$arg
    echo $mes ;;
 enero | ene | jan |january)
    mes=1;;
 fenero | fen | fab |fabruary)
    mes=2;;
 marzo | mar | mar |march)
    mes=3;;

 12 | diciembre | dic | dec |decembar)
    mes=12;;
esac
cal $mes $year 


