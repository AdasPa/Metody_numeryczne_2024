import time

def create_matrix(a1, a2, a3, N):
    A = [[0] * N for _ in range(N)]
    for i in range(N):
        for j in range(N):
            if i == j:
                A[i][j] = a1
            elif abs(i - j) == 1:
                A[i][j] = a2
            elif abs(i - j) == 2:
                A[i][j] = a3
    return A

def jacobi(A, b, x0, tol=1e-9, max_iter=50):
    n = len(b)
    x = x0.copy()
    residuals = []
    start_time = time.time()
    for xd in range(max_iter):
        x_new = [0] * n
        for i in range(n):
            sigma = sum(A[i][j] * x[j] for j in range(n) if j != i)
            x_new[i] = (b[i] - sigma) / A[i][i]
        residuals.append(norm_residual(A, b, x))
        if norm_residual(A, b, x_new) < tol:
            break
        x = x_new

    end_time = time.time()
    print("Iteracje metodą Jacobiego: ", xd)
    print("Czas trwania metody Jacobiego: ", end_time - start_time)
    return x, residuals


def gauss_seidel(A, b, x0, tol=1e-9, max_iter=50):
    n = len(b)
    x = x0.copy()
    residuals = []
    start_time = time.time()

    for xd in range(max_iter):
        for i in range(n):
            sigma = sum(A[i][j] * x[j] for j in range(n) if j != i)
            x[i] = (b[i] - sigma) / A[i][i]
        residuals.append(norm_residual(A, b, x))
        if norm_residual(A, b, x) < tol:
            break
    end_time = time.time()
    print("Iteracje metodą Gaussa-Seidla: ", xd)
    print("Czas trwania metody Gaussa-Seidla: ", end_time - start_time)
    return x, residuals


def lu(A, b):
    n = len(A)
    L = [[0.0] * n for _ in range(n)]
    U = [[0.0] * n for _ in range(n)]

    for j in range(n):
        L[j][j] = 1.0

        for i in range(j + 1):
            s1 = sum(U[k][j] * L[i][k] for k in range(i))
            U[i][j] = A[i][j] - s1

        for i in range(j, n):
            s2 = sum(U[k][j] * L[i][k] for k in range(j))
            L[i][j] = (A[i][j] - s2) / U[j][j]

    y = [0.0] * n
    for i in range(n):
        y[i] = b[i] - sum(L[i][k] * y[k] for k in range(i))

    x = [0.0] * n
    for i in range(n - 1, -1, -1):
        x[i] = (y[i] - sum(U[i][k] * x[k] for k in range(i + 1, n))) / U[i][i]

    return x, norm_residual(A, b, x)


def norm_residual(A, b, x):
    n = len(b)
    res = [b[i] - sum(A[i][j] * x[j] for j in range(n)) for i in range(n)]
    return sum(residual ** 2 for residual in res) ** 0.5