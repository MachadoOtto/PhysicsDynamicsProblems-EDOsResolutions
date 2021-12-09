#OBLIGATORIO 2 - Metodos Numericos 2021 - Grupo 63
# Problema del PENDULO RESORTE

# Definicion de CONSTANTES:
m = 1; # Masa
g = 9.8; # Constante gravitacional
k = 98.1; # Constante del Resorte
L0 = 0.5; # Longitud del Resorte
# Definicion de TIEMPO:
# (Comentar o descomentar delta_t dependiendo del caso)
#delta_t = 0.1;
delta_t = 0.1;
tmax = 100; # Maximo de tiempo, puede variar.
# Inicializacion de VALORES INICIALES:
tita0 =(pi)/2; # Desplazamiento en la circuferencia
dtita0 = 0; # Velocidad en la circuferencia
r0 = 0.25; # Desplazamiento Radial
dr0 = 0; # Velocidad Radial

# Definicion de FUNCIONES:
aceleracionRadial = @(r, dr, tita, dtita, tiempo) [ (L0 + r)*((dtita)^2) + g*(cos(tita))- k*r/m];
aceleracionCircuf = @(r, dr, tita, dtita, tiempo) [ -(2*dr*dtita + g*(sin(tita)))/(L0 + r)];

# -------------------------------- #
# Metodo explicito de TERCER ORDEN:
# -------------------------------- #
tiempo = 0;
posRadial_ts = r0;
velRadial_ts = dr0;
posCircuf_ts = tita0;
velCircuf_ts = dtita0;
# Inicializacion de Vectores:
vector_posRadial_TO = [posRadial_ts];
vector_velRadial_TO = [velRadial_ts];
vector_posCircuf_TO = [posCircuf_ts];
vector_velCircuf_TO = [velCircuf_ts];
vector_tiempo_TO = [tiempo];
do
  #PASO 1.
  accelRadial = aceleracionRadial(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  accelCircuf = aceleracionCircuf(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  #PASO 2.
  posRadial_t13 = posRadial_ts + (1/3)*delta_t*velRadial_ts + (1/18)*(delta_t^2)*accelRadial;
  velRadial_t13 = velRadial_ts + (1/3)*delta_t*accelRadial;
  posCircuf_t13 = posCircuf_ts + (1/3)*delta_t*velCircuf_ts + (1/18)*(delta_t^2)*accelCircuf;
  velCircuf_t13 = velCircuf_ts + (1/3)*delta_t*accelCircuf;
  #PASO 3.
  accelRadial_13 = aceleracionRadial(posRadial_t13, velRadial_t13, posCircuf_t13, velCircuf_t13, (tiempo + (1/3)*delta_t));
  accelCircuf_13 = aceleracionCircuf(posRadial_t13, velRadial_t13, posCircuf_t13, velCircuf_t13, (tiempo + (1/3)*delta_t));
  #PASO 4.
  posRadial_t23 = posRadial_ts + (2/3)*delta_t*velRadial_ts + (1/27)*(delta_t^2)*(2*accelRadial + 4*accelRadial_13);
  velRadial_t23 = velRadial_ts + (2/3)*delta_t*accelRadial_13;
  posCircuf_t23 = posCircuf_ts + (2/3)*delta_t*velCircuf_ts + (1/27)*(delta_t^2)*(2*accelCircuf + 4*accelCircuf_13);
  velCircuf_t23 = velCircuf_ts + (2/3)*delta_t*accelCircuf_13;
  #PASO 5.
  accelRadial_23 = aceleracionRadial(posRadial_t23, velRadial_t23, posCircuf_t23, velCircuf_t23, (tiempo + (2/3)*delta_t));
  accelCircuf_23 = aceleracionCircuf(posRadial_t23, velRadial_t23, posCircuf_t23, velCircuf_t23, (tiempo + (2/3)*delta_t));
  #PASO 6.
  posRadial_ts = posRadial_ts + delta_t*velRadial_ts + (1/6)*(delta_t^2)*(accelRadial + accelRadial_13 + accelRadial_23);
  velRadial_ts = velRadial_ts + (1/4)*delta_t*(accelRadial + 3*accelRadial_23);
  posCircuf_ts = posCircuf_ts + delta_t*velCircuf_ts + (1/6)*(delta_t^2)*(accelCircuf + accelCircuf_13 + accelCircuf_23);
  velCircuf_ts = velCircuf_ts + (1/4)*delta_t*(accelCircuf + 3*accelCircuf_23);
  # Agrego los valores a sus respectivos vectores.
  vector_posRadial_TO = [vector_posRadial_TO, posRadial_ts];
  vector_velRadial_TO = [vector_velRadial_TO, velRadial_ts];
  vector_posCircuf_TO = [vector_posCircuf_TO, posCircuf_ts];
  vector_velCircuf_TO = [vector_velCircuf_TO, velCircuf_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_TO = [vector_tiempo_TO, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(1)
plot(vector_posRadial_TO, vector_velRadial_TO, '-o')
title('Pendulo Resorte: Metodo de TERCER ORDEN para aceleracion radial.');
xlabel('Posicion radial');
ylabel('Velocidad radial');
figure(2)
plot(vector_posCircuf_TO, vector_velCircuf_TO, '-o')
title('Pendulo Resorte: Metodo de TERCER ORDEN para aceleracion circuferencia.');
xlabel('Posicion angular');
ylabel('Velocidad angular');
# Fin TERCER ORDEN

# -------------------------------- #
# Metodo explicito de CUARTO ORDEN:
# -------------------------------- #
tiempo = 0;
posRadial_ts = r0;
velRadial_ts = dr0;
posCircuf_ts = tita0;
velCircuf_ts = dtita0;
# Inicializacion de Vectores:
vector_posRadial_CO = [posRadial_ts];
vector_velRadial_CO = [velRadial_ts];
vector_posCircuf_CO = [posCircuf_ts];
vector_velCircuf_CO = [velCircuf_ts];
vector_tiempo_CO = [tiempo];
do
  #PASO 1
  accelRadial = aceleracionRadial(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  accelCircuf = aceleracionCircuf(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  #PASO 2
  posRadial_t13 = posRadial_ts + (1/3)*delta_t*velRadial_ts + (1/18)*(delta_t^2)*accelRadial;
  velRadial_t13 = velRadial_ts + (1/3)*delta_t*accelRadial;
  posCircuf_t13 = posCircuf_ts + (1/3)*delta_t*velCircuf_ts + (1/18)*(delta_t^2)*accelCircuf;
  velCircuf_t13 = velCircuf_ts + (1/3)*delta_t*accelCircuf;
  #PASO 3
  accelRadial_13 = aceleracionRadial(posRadial_t13, velRadial_t13, posCircuf_t13, velCircuf_t13, (tiempo + (1/3)*delta_t));
  accelCircuf_13 = aceleracionCircuf(posRadial_t13, velRadial_t13, posCircuf_t13, velCircuf_t13, (tiempo + (1/3)*delta_t));
  #PASO 4
  posRadial_t12 = posRadial_ts + (1/8)*delta_t*(velRadial_ts + 3*velRadial_t13) + (3/40)*(delta_t^2)*(-accelRadial + accelRadial_13);
  velRadial_t12 = velRadial_ts + (1/8)*delta_t*(accelRadial + 3*accelRadial_13);
  posCircuf_t12 = posCircuf_ts + (1/8)*delta_t*(velCircuf_ts + 3*velCircuf_t13) + (3/40)*(delta_t^2)*(-accelCircuf + accelCircuf_13);
  velCircuf_t12 = velCircuf_ts + (1/8)*delta_t*(accelCircuf + 3*accelCircuf_13);
  #PASO 5
  accelRadial_12 = aceleracionRadial(posRadial_t12, velRadial_t12, posCircuf_t12, velCircuf_t12, (tiempo + (1/2)*delta_t));
  accelCircuf_12 = aceleracionCircuf(posRadial_t12, velRadial_t12, posCircuf_t12, velCircuf_t12, (tiempo + (1/2)*delta_t));
  #PASO 6
  posRadial_t = posRadial_ts + (1/2)*delta_t*(velRadial_ts - 3*velRadial_t13 + 4*velRadial_t12) + (3/10)*(delta_t^2)*(accelRadial - accelRadial_13);
  velRadial_t = velRadial_ts + (1/2)*delta_t*(accelRadial - 3*accelRadial_13 + 4*accelRadial_12);
  posCircuf_t = posCircuf_ts + (1/2)*delta_t*(velCircuf_ts - 3*velCircuf_t13 + 4*velCircuf_t12) + (3/10)*(delta_t^2)*(accelCircuf - accelCircuf_13);
  velCircuf_t = velCircuf_ts + (1/2)*delta_t*(accelCircuf - 3*accelCircuf_13 + 4*accelCircuf_12);
  #PASO 7
  accelRadial_t = aceleracionRadial(posRadial_t, velRadial_t, posCircuf_t, velCircuf_t, (tiempo + delta_t));
  accelCircuf_t = aceleracionCircuf(posRadial_t, velRadial_t, posCircuf_t, velCircuf_t, (tiempo + delta_t));
  #PASO 8
  posRadial_ts = posRadial_ts + (1/6)*delta_t*(velRadial_ts + 4*velRadial_t12 + velRadial_t);
  velRadial_ts = velRadial_ts + (1/6)*delta_t*(accelRadial + 4*accelRadial_12 + accelRadial_t);
  posCircuf_ts = posCircuf_ts + (1/6)*delta_t*(velCircuf_ts + 4*velCircuf_t12 + velCircuf_t);
  velCircuf_ts = velCircuf_ts + (1/6)*delta_t*(accelCircuf + 4*accelCircuf_12 + accelCircuf_t);
  # Agrego los valores a sus respectivos vectores.
  vector_posRadial_CO = [vector_posRadial_CO, posRadial_ts];
  vector_velRadial_CO = [vector_velRadial_CO, velRadial_ts];
  vector_posCircuf_CO = [vector_posCircuf_CO, posCircuf_ts];
  vector_velCircuf_CO = [vector_velCircuf_CO, velCircuf_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_CO = [vector_tiempo_CO, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(3)
plot(vector_posRadial_CO, vector_velRadial_CO, '-o')
title('Pendulo Resorte: Metodo de CUARTO ORDEN para aceleracion radial.');
xlabel('Posicion radial');
ylabel('Velocidad radial');
figure(4)
plot(vector_posCircuf_CO, vector_velCircuf_CO, '-o')
title('Pendulo Resorte: Metodo de CUARTO ORDEN para aceleracion angular.');
xlabel('Posicion angular');
ylabel('Velocidad angular');
# Fin CUARTO ORDEN

# -------------------------------- #
# Metodo de RUNGE-KUTTA de tercer orden:
# -------------------------------- #
tiempo = 0;
posRadial_ts = r0;
velRadial_ts = dr0;
posCircuf_ts = tita0;
velCircuf_ts = dtita0;
# Inicializacion de Vectores:
vector_posRadial_RK = [posRadial_ts];
vector_velRadial_RK = [velRadial_ts];
vector_posCircuf_RK = [posCircuf_ts];
vector_velCircuf_RK = [velCircuf_ts];
vector_tiempo_RK = [tiempo];
do
  #PASO 1
  accelRadial = aceleracionRadial(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  accelCircuf = aceleracionCircuf(posRadial_ts, velRadial_ts, posCircuf_ts, velCircuf_ts, tiempo);
  #PASO 2
  posRadial_t12 = posRadial_ts + (1/2)*delta_t*velRadial_ts;
  velRadial_t12 = velRadial_ts + (1/2)*delta_t*accelRadial;
  posCircuf_t12 = posCircuf_ts + (1/2)*delta_t*velCircuf_ts;
  velCircuf_t12 = velCircuf_ts + (1/2)*delta_t*accelCircuf;
  #PASO 3
  accelRadial_12 = aceleracionRadial(posRadial_t12, velRadial_t12, posCircuf_t12, velCircuf_t12, (tiempo + (1/2)*delta_t));
  accelCircuf_12 = aceleracionCircuf(posRadial_t12, velRadial_t12, posCircuf_t12, velCircuf_t12, (tiempo + (1/2)*delta_t));
  #PASO 4
  posRadial_t = posRadial_ts + delta_t*((-1)*velRadial_ts + 2*velRadial_t12);
  velRadial_t = velRadial_ts + delta_t*((-1)*accelRadial + 2*accelRadial_12);
  posCircuf_t = posCircuf_ts + delta_t*((-1)*velCircuf_ts + 2*velCircuf_t12);
  velCircuf_t = velCircuf_ts + delta_t*((-1)*accelCircuf + 2*accelCircuf_12);
  #PASO 5
  accelRadial_t = aceleracionRadial(posRadial_t, velRadial_t, posCircuf_t, velCircuf_t, (tiempo + delta_t));
  accelCircuf_t = aceleracionCircuf(posRadial_t, velRadial_t, posCircuf_t, velCircuf_t, (tiempo + delta_t));
  #PASO 6
  posRadial_ts = posRadial_ts + (1/6)*delta_t*(velRadial_ts + 4*velRadial_t12 + velRadial_t);
  velRadial_ts = velRadial_ts + (1/6)*delta_t*(accelRadial + 4*accelRadial_12 + accelRadial_t);
  posCircuf_ts = posCircuf_ts + (1/6)*delta_t*(velCircuf_ts + 4*velCircuf_t12 + velCircuf_t);
  velCircuf_ts = velCircuf_ts + (1/6)*delta_t*(accelCircuf + 4*accelCircuf_12 + accelCircuf_t);
  # Agrego los valores a sus respectivos vectores.
  vector_posRadial_RK = [vector_posRadial_RK, posRadial_ts];
  vector_velRadial_RK = [vector_velRadial_RK, velRadial_ts];
  vector_posCircuf_RK = [vector_posCircuf_RK, posCircuf_ts];
  vector_velCircuf_RK = [vector_velCircuf_RK, velCircuf_ts];
  # Incremento el contador de tiempo.
  tiempo += delta_t;
  vector_tiempo_RK = [vector_tiempo_RK, tiempo];
until (tiempo > (tmax - delta_t))
# Ploteo de grafica:
figure(5)
plot(vector_posRadial_RK, vector_velRadial_RK, '-o')
title('Pendulo Resorte: Metodo de RUNGE-KUTTA para aceleracion radial.');
xlabel('Posicion radial');
ylabel('Velocidad radial');
figure(6)
plot(vector_posCircuf_RK, vector_velCircuf_RK, '-o')
title('Pendulo Resorte: Metodo de RUNGE-KUTTA para aceleracion angular.');
xlabel('Posicion angular');
ylabel('Velocidad angular');
# Fin RUNGE-KUTTA

# Implementacion de la grafica conjunta posRadial-Tiempo entre metodos:
figure(7)
plot(vector_tiempo_TO, vector_posCircuf_TO, 'b')
hold on
plot(vector_tiempo_CO, vector_posCircuf_CO, 'r')
hold on
plot(vector_tiempo_RK, vector_posCircuf_RK, 'g')
legend({'Tercer Orden', 'Cuarto Orden','Runge-Kutta'})
title('Pendulo Resorte: Comparacion Tiempo-Posicion angular');
xlabel('Tiempo');
ylabel('Posicion angular');