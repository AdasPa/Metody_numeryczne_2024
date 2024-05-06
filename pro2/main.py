import matplotlib.pyplot as plt
from methods import *
import math
import time

### ZADANIE A ###

#indeks = 193318

a1 = 5 + 3
a2 = a3 = -1
N = 9#18

A = create_matrix(a1, a2, a3, N)
b = [math.sin(n * (3 + 1)) for n in range(N)]
print(A)
print(b)

### ZADANIE B ###

x0 = [0 for _ in range(len(b))]

x_jacobi, residuals_jacobi = jacobi(A, b, x0)
x_gs, residuals_gs = gauss_seidel(A, b, x0)


plt.plot(range(len(residuals_jacobi)), residuals_jacobi, label="Jacobi", linewidth=2)
plt.plot(range(len(residuals_gs)), residuals_gs, label="Gauss-Seidel", linewidth=2)
plt.yscale("log")
plt.xlabel("Numer iteracji")
plt.ylabel("Norma residuum")
plt.title("Zmiana normy residuum w kolejnych iteracjach")
plt.legend()
plt.grid(True)
plt.show()

### ZADANIE 3 ###

a1 = 3
a2 = a3 = -1
N = 918
max_iterations = 100

A_C = create_matrix(a1, a2, a3, N)
b_C = [math.sin(n * (3 + 1)) for n in range(N)]

x_jacobi_C, residuals_jacobi_C = jacobi(A_C, b_C, [0 for _ in range(len(b_C))], max_iter=max_iterations)

x_gs_C, residuals_gs_C = gauss_seidel(A_C, b_C, [0 for _ in range(len(b_C))], max_iter=max_iterations)


plt.plot(residuals_jacobi_C, label='Jacobi', color='blue')
plt.plot(residuals_gs_C, label='Gauss-Seidel', color='red')
plt.yscale('log')
plt.xlabel('Iteracja')
plt.ylabel('Norma residuum')
plt.title('Zmiana normy residuum w kolejnych iteracjach')
plt.legend()
plt.grid(True)
plt.show()

### ZADANIE 4 ###

x_lu_C, resudial_x_lu_C = lu(A_C, b_C)


print("Błąd Jacobi: " + str(residuals_jacobi_C[-1]))
print("Błąd Gauss-Seidel: " + str(residuals_gs_C[-1]))
print("Błąd LU: " + str(resudial_x_lu_C))

### ZADANIE 5 ###

N_values = [10, 20,33, 50,70, 100, 150, 200, 300, 500, 1000]

times_lu = []
times_jacobi = []
times_gauss_seidel = []


for N in N_values:
    A = create_matrix(a1, a2, a3, N)
    b = [math.sin(n * (3 + 1)) for n in range(N)]

    start_time = time.time()
    lu(A, b)
    end_time = time.time()
    times_lu.append(end_time - start_time)

    start_time = time.time()
    jacobi(A, b, [0 for _ in range(len(b))])
    end_time = time.time()
    times_jacobi.append(end_time - start_time)


    start_time = time.time()
    gauss_seidel(A, b, [0 for _ in range(len(b))])
    end_time = time.time()
    times_gauss_seidel.append(end_time - start_time)

plt.plot(N_values, times_lu, label='Faktoryzacja LU')
plt.plot(N_values, times_jacobi, label='Metoda Jacobiego')
plt.plot(N_values, times_gauss_seidel, label='Metoda Gaussa-Seidla')
plt.xlabel('Liczba niewiadomych (N)')
plt.ylabel('Czas wykonania (s)')
plt.title('Zależność czasu wykonania od liczby niewiadomych')
plt.legend()
plt.grid(True)
plt.show()

