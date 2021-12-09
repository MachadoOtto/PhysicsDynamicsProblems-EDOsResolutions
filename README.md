
# Problemas Físicos de Dinámica - Resolución por Ecuaciones Diferenciales Ordinarias
## Jorge Machado Ottonelli - Métodos Numéricos - Facultad de Ingenieria UdelaR

Proyecto de la asignatura Métodos Numéricos, realizada con los compañeros:
 *      Cesar Agustin Cortondo Landache
 *      Jorge Miguel Machado Ottonelli
 *      Eber Manuel Rodríguez Gonzalez
 *      Jorge Daniel Perez Kranilovich

Proyecto para la asignatura Métodos Numéricos de la Facultad de Ingeniería (UdelaR). El mismo estudia la resolución de problemas físicos de dinámica establecidos por ecuaciones diferenciales ordinarias, utilizando métodos de aproximación de tercer y cuarto orden, implementados mediante algoritmos iterativos.

Se recomienda la lectura del documento para comprender más acerca del problema y la resolución planteada.

## Manual de uso para los algoritmos presentados en el Proyecto.

### Se presentan tres scripts, uno para cada problema presentado (Resorte Elástico, Péndulo Simple y Péndulo Resorte).

Para ejecutar todos los algoritmos de un problema basta con ejecutar su respectivo script (aunque no exenta el hecho de cambiar los datos de entrada). En cada uno es posible realizar la modificación de los datos de entrada, como se muestra a continuación:

### resorteElastico.m : Representa el conjunto de algoritmos para la resolución del problema Resorte Elástico.
	Los datos a modificar pueden ser los siguientes:
	* Constantes del problema: s1 ; s2.
	* Variables de tiempo: T (periodo de tiempo) ; delta_t (representa la variacion del tiempo en cada
		iteracion de los metodos); tmax (representa el tiempo maximo hasta el cual se itera).
	* Valores Iniciales: u0 (equivalente a posicion inicial) ; v0 (equivalente a velocidad inicial).
	* Funcion de aceleracion: accelResorteElastico (es posible modificar la funcion de aceleracion 
		correspondiente a la EDO a aproximar).

### penduloSimple.m : Representa el conjunto de algoritmos para la resolución del problema Péndulo Simple.
	Los datos a modificar pueden ser los siguientes:
	* Constantes del problema: g (constante gravitacional) ; L (largo de la cuerda) ; 
		w (raizCuadrada(g / L)).
	* Variables de tiempo: T (periodo de tiempo) ; delta_t (representa la variacion del tiempo en cada
		iteracion de los metodos); tmax (representa el tiempo maximo hasta el cual se itera).
	* Valores Iniciales: u0 (equivalente a posicion inicial) ; v0 (equivalente a velocidad inicial).
	* Funcion de aceleracion: pendSimple (es posible modificar la funcion de aceleracion 
		correspondiente a la EDO a aproximar).

### penduloResorte.m : Representa el conjunto de algoritmos para la resolución del problema Péndulo Resorte.
	Los datos a modificar pueden ser los siguientes:
	* Constantes del problema: m (masa) ; g (constante gravitacional) ; k (constante del resorte) ;
		L0 (longitud del resorte).
	* Variables de tiempo: delta_t (representa la variacion del tiempo en cada iteracion de los metodos, 
		notar que se encuentran ya ingresadas dos opciones a elegir con solo "descomentarlas") ; 
		tmax (representa el tiempo maximo hasta el cual se itera).
	* Valores Iniciales: r0 (equivalente a posicion inicial radial) ; dr0 (equivalente a velocidad inicial 
		radial) ; tita0 (equivalente a posicion inicial angular) ; dtita0 (equivalente a velocidad
		inicial angular).
	* Funciones de aceleracion: aceleracionRadial ; aceleracionCircuf (representa la aceleracion angular)
		(es posible modificar las funciones de aceleracion correspondiente al sistema de EDOs a 
		aproximar, notar que ambas comparten variables).