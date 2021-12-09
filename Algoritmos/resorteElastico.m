#OBLIGATORIO 2 - Metodos Numericos 2021 - Grupo 63
# Problema del RESORTE ELASTICO

# Definicion de CONSTANTES:
s1 = 100;
s2 = 10;
# Definicion de TIEMPO:
T = 0.15153; 
delta_t = T/32;
tmax = 50*T;
# Inicializacion de VALORES INICIALES:
u0 = 1.5; 
v0 = 0;

# Definicion de FUNCIONES:
# u'' - accelResorteElastico(u, v, t) = 0
# , donde accelResorteElastico(u, v, t) = - s1*(1 + s2*u^2)*u  y  v = u'
accelResorteElastico = @(u, v, t) [-s1 * (1 + s2*(u^2)) * u];

# -------------------------------- #
# Metodo explicito de TERCER ORDEN:
# -------------------------------- #
tiempo = 0;
posicion_ts = u0;
velocidad_ts = v0;
# Inicializacion de Vectores:
vector_pos_TO = [posicion_ts];
vector_vel_TO = [velocidad_ts];
vector_tiempo_TO = [tiempo];
do
  #PASO 1.
  aceleracion = accelResorteElastico(posicion_ts, velocidad_ts, tiempo);
  #PASO 2.
  posicion_t13 = posicion_ts + (1/3)*delta_t*velocidad_ts + (1/18)*(delta_t^2)*aceleracion;
  velocidad_t13 = velocidad_ts + (1/3)*delta_t*aceleracion;
  #PASO 3.
  aceleracion_13 = accelResorteElastico(posicion_t13, velocidad_t13, (tiempo + (1/3)*delta_t));
  #PASO 4.
  posicion_t23 = posicion_ts + (2/3)*delta_t*velocidad_ts + (1/27)*(delta_t^2)*(2*aceleracion + 4*aceleracion_13);
  velocidad_t23 = velocidad_ts + (2/3)*delta_t*aceleracion_13;
  #PASO 5.
  aceleracion_23 = accelResorteElastico(posicion_t23, velocidad_t23, (tiempo + (2/3)*delta_t));
  #PASO 6.
  posicion_ts = posicion_ts + delta_t*velocidad_ts + (1/6)*(delta_t^2)*(aceleracion + aceleracion_13 + aceleracion_23);
  velocidad_ts = velocidad_ts + (1/4)*delta_t*(aceleracion + 3*aceleracion_23);
  # Agrego los valores a sus respectivos vectores.
  vector_pos_TO = [vector_pos_TO, posicion_ts];
  vector_vel_TO = [vector_vel_TO, velocidad_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_TO = [vector_tiempo_TO, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(1)
plot(vector_pos_TO, vector_vel_TO, '-o')
title('Resorte Elastico: Metodo de TERCER ORDEN');
xlabel('Posicion');
ylabel('Velocidad');
# Fin TERCER ORDEN

# -------------------------------- #
# Metodo explicito de CUARTO ORDEN:
# -------------------------------- #
tiempo = 0;
posicion_ts = u0;
velocidad_ts = v0;
# Inicializacion de Vectores:
vector_pos_CO = [posicion_ts];
vector_vel_CO = [velocidad_ts];
vector_tiempo_CO = [tiempo];
do
  #PASO 1
  aceleracion = accelResorteElastico(posicion_ts, velocidad_ts, tiempo);
  #PASO 2
  posicion_t13 = posicion_ts + (1/3)*delta_t*velocidad_ts + (1/18)*(delta_t^2)*aceleracion;
  velocidad_t13 = velocidad_ts + (1/3)*delta_t*aceleracion;
  #PASO 3
  aceleracion_13 = accelResorteElastico(posicion_t13, velocidad_t13, (tiempo + (1/3)*delta_t));
  #PASO 4
  posicion_t12 = posicion_ts + (1/8)*delta_t*(velocidad_ts + 3*velocidad_t13) + (3/40)*(delta_t^2)*(-aceleracion + aceleracion_13);
  velocidad_t12 = velocidad_ts + (1/8)*delta_t*(aceleracion + 3*aceleracion_13);
  #PASO 5
  aceleracion_12 = accelResorteElastico(posicion_t12, velocidad_t12, (tiempo + (1/2)*delta_t));
  #PASO 6
  posicion_t = posicion_ts + (1/2)*delta_t*(velocidad_ts - 3*velocidad_t13 + 4*velocidad_t12) + (3/10)*(delta_t^2)*(aceleracion - aceleracion_13);
  velocidad_t = velocidad_ts + (1/2)*delta_t*(aceleracion - 3*aceleracion_13 + 4*aceleracion_12);
  #PASO 7
  aceleracion_t = accelResorteElastico(posicion_t, velocidad_t, (tiempo + delta_t));
  #PASO 8
  posicion_ts = posicion_ts + (1/6)*delta_t*(velocidad_ts + 4*velocidad_t12 + velocidad_t);
  velocidad_ts = velocidad_ts + (1/6)*delta_t*(aceleracion + 4*aceleracion_12 + aceleracion_t);
  # Agrego los valores a sus respectivos vectores.
  vector_pos_CO = [vector_pos_CO, posicion_ts];
  vector_vel_CO = [vector_vel_CO, velocidad_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_CO = [vector_tiempo_CO, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(2)
plot(vector_pos_CO, vector_vel_CO, '-o')
title('Resorte Elastico: Metodo de CUARTO ORDEN');
xlabel('Posicion');
ylabel('Velocidad');
# Fin CUARTO ORDEN

# -------------------------------- #
# Metodo de RUNGE-KUTTA de tercer orden:
# -------------------------------- #
tiempo = 0;
posicion_ts = u0;
velocidad_ts = v0;
# Inicializacion de Vectores:
vector_pos_RK = [posicion_ts];
vector_vel_RK = [velocidad_ts];
vector_tiempo_RK = [tiempo];
do
  #PASO 1
  aceleracion = accelResorteElastico(posicion_ts, velocidad_ts, tiempo);
  #PASO 2
  posicion_t12 = posicion_ts + (1/2)*delta_t*velocidad_ts;
  velocidad_t12 = velocidad_ts + (1/2)*delta_t*aceleracion;
  #PASO 3
  aceleracion_12 = accelResorteElastico(posicion_t12, velocidad_t12, (tiempo + (1/2)*delta_t));
  #PASO 4
  posicion_t = posicion_ts + delta_t*((-1)*velocidad_ts + 2*velocidad_t12);
  velocidad_t = velocidad_ts + delta_t*((-1)*aceleracion + 2*aceleracion_12);
  #PASO 5
  aceleracion_t = accelResorteElastico(posicion_t, velocidad_t, (tiempo + delta_t));
  #PASO 6
  posicion_ts = posicion_ts + (1/6)*delta_t*(velocidad_ts + 4*velocidad_t12 + velocidad_t);
  velocidad_ts = velocidad_ts + (1/6)*delta_t*(aceleracion + 4*aceleracion_12 + aceleracion_t);
  # Agrego los valores a sus respectivos vectores.
  vector_pos_RK = [vector_pos_RK, posicion_ts];
  vector_vel_RK = [vector_vel_RK, velocidad_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_RK = [vector_tiempo_RK, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(3)
plot(vector_pos_RK, vector_vel_RK, '-o')
title('Resorte Elastico: Metodo de RUNGE-KUTTA');
xlabel('Posicion');
ylabel('Velocidad');
# Fin RUNGE-KUTTA

# Implementacion de la grafica conjunta Posicion-Tiempo entre metodos:
# Entre 0 y 2T
# Precondicion: delta_t = 1/32
figure(4)
plot(vector_tiempo_TO(1:65), vector_pos_TO(1:65), 'b')
hold on
plot(vector_tiempo_CO(1:65), vector_pos_CO(1:65), 'r')
hold on
plot(vector_tiempo_RK(1:65), vector_pos_RK(1:65), 'g')
legend({'Tercer Orden', 'Cuarto Orden','Runge-Kutta'})
title('Resorte Elastico: Comparacion Tiempo-Posicion entre 0 y 2T');
xlabel('Tiempo');
ylabel('Posicion');

# Entre 48T y 50T
# Precondicion: delta_t = 1/32
# Precondicion: tmax = 50*T
figure(5)
plot(vector_tiempo_TO(end - 64:end), vector_pos_TO(end - 64:end), 'b')
hold on
plot(vector_tiempo_CO(end - 64:end), vector_pos_CO(end - 64:end), 'r')
hold on
plot(vector_tiempo_RK(end - 64:end), vector_pos_RK(end - 64:end), 'g')
legend({'Tercer Orden', 'Cuarto Orden','Runge-Kutta'})
title('Resorte Elastico: Comparacion Tiempo-Posicion entre 48T y 50T');
xlabel('Tiempo');
ylabel('Posicion');