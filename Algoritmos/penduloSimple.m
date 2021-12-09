#OBLIGATORIO 2 - Metodos Numericos 2021 - Grupo 63
# Problema del PENDULO SIMPLE

# Definicion de CONSTANTES:
g = 1;
L = 1;
w = sqrt(g/L);
# Definicion de TIEMPO:
T = 33.7210;
delta_t = T/400;
tmax = 3*T;
# Inicializacion de VALORES INICIALES:
u0 = 0;
v0 = 1.9999992384564990;

# Definicion de FUNCIONES:
pendSimple = @(tita, dtita, tiempo) [-(w^2)*sin(tita)];

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
  aceleracion = pendSimple(posicion_ts, velocidad_ts, tiempo);
  #PASO 2.
  posicion_t13 = posicion_ts + (1/3)*delta_t*velocidad_ts + (1/18)*(delta_t^2)*aceleracion;
  velocidad_t13 = velocidad_ts + (1/3)*delta_t*aceleracion;
  #PASO 3.
  aceleracion_13 = pendSimple(posicion_t13, velocidad_t13, (tiempo + (1/3)*delta_t));
  #PASO 4.
  posicion_t23 = posicion_ts + (2/3)*delta_t*velocidad_ts + (1/27)*(delta_t^2)*(2*aceleracion + 4*aceleracion_13);
  velocidad_t23 = velocidad_ts + (2/3)*delta_t*aceleracion_13;
  #PASO 5.
  aceleracion_23 = pendSimple(posicion_t23, velocidad_t23, (tiempo + (2/3)*delta_t));
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
title('Pendulo Simple: Metodo de TERCER ORDEN','FontSize', 22 );
xlabel('Posicion','FontSize', 22);
ylabel('Velocidad','FontSize', 22);
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
  aceleracion = pendSimple(posicion_ts, velocidad_ts, tiempo);
  #PASO 2
  posicion_t13 = posicion_ts + (1/3)*delta_t*velocidad_ts + (1/18)*(delta_t^2)*aceleracion;
  velocidad_t13 = velocidad_ts + (1/3)*delta_t*aceleracion;
  #PASO 3
  aceleracion_13 = pendSimple(posicion_t13, velocidad_t13, (tiempo + (1/3)*delta_t));
  #PASO 4
  posicion_t12 = posicion_ts + (1/8)*delta_t*(velocidad_ts + 3*velocidad_t13) + (3/40)*(delta_t^2)*(-aceleracion + aceleracion_13);
  velocidad_t12 = velocidad_ts + (1/8)*delta_t*(aceleracion + 3*aceleracion_13);
  #PASO 5
  aceleracion_12 = pendSimple(posicion_t12, velocidad_t12, (tiempo + (1/2)*delta_t));
  #PASO 6
  posicion_t = posicion_ts + (1/2)*delta_t*(velocidad_ts - 3*velocidad_t13 + 4*velocidad_t12) + (3/10)*(delta_t^2)*(aceleracion - aceleracion_13);
  velocidad_t = velocidad_ts + (1/2)*delta_t*(aceleracion - 3*aceleracion_13 + 4*aceleracion_12);
  #PASO 7
  aceleracion_t = pendSimple(posicion_t, velocidad_t, (tiempo + delta_t));
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
title('Pendulo Simple: Metodo de CUARTO ORDEN','FontSize', 22);
xlabel('Posicion','FontSize', 22);
ylabel('Velocidad','FontSize', 22);
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
  aceleracion = pendSimple(posicion_ts, velocidad_ts, tiempo);
  #PASO 2
  posicion_t12 = posicion_ts + (1/2)*delta_t*velocidad_ts;
  velocidad_t12 = velocidad_ts + (1/2)*delta_t*aceleracion;
  #PASO 3
  aceleracion_12 = pendSimple(posicion_t12, velocidad_t12, (tiempo + (1/2)*delta_t));
  #PASO 4
  posicion_t = posicion_ts + delta_t*((-1)*velocidad_ts + 2*velocidad_t12);
  velocidad_t = velocidad_ts + delta_t*((-1)*aceleracion + 2*aceleracion_12);
  #PASO 5
  aceleracion_t = pendSimple(posicion_t, velocidad_t, (tiempo + delta_t));
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
title('Pendulo Simple: Metodo de RUNGE-KUTTA','FontSize', 22);
xlabel('Posicion','FontSize', 22);
ylabel('Velocidad','FontSize', 22);
# Fin RUNGE-KUTTA

# Implementacion de la grafica conjunta Posicion-Tiempo entre metodos:
figure(4)
plot(vector_tiempo_TO, vector_pos_TO, 'b')
hold on
plot(vector_tiempo_CO, vector_pos_CO, 'r')
hold on
plot(vector_tiempo_RK, vector_pos_RK, 'g')
legend({'Tercer Orden', 'Cuarto Orden','Runge-Kutta'})
title('Pendulo Simple: Comparacion Tiempo-Posicion','FontSize', 22);
xlabel('Tiempo','FontSize', 22);
ylabel('Posicion','FontSize', 22);