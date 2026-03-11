import numpy as np
import math
from scipy.special import iv,comb
from numpy.polynomial.chebyshev import Chebyshev
import matplotlib.pyplot as plt

import math

def bessi0(x: float) -> float:
    ax = abs(x)
    if ax < 3.75:
        y = (x / 3.75) ** 2
        return (
            1.0
            + y * (
                3.5156229
                + y * (
                    3.0899424
                    + y * (
                        1.2067492
                        + y * (
                            0.2659732
                            + y * (0.0360768 + y * 0.0045813)
                        )
                    )
                )
            )
        )
    else:
        y = 3.75 / ax
        return (
            np.exp(ax) / np.sqrt(ax)
        ) * (
            0.39894228
            + y * (
                0.01328592
                + y * (
                    0.00225319
                    + y * (
                        -0.00157565
                        + y * (
                            0.00916281
                            + y * (
                                -0.02057706
                                + y * (
                                    0.02635537
                                    + y * (
                                        -0.01647633
                                        + y * 0.00392377
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )

def besseli_asymptotic(n: int, x: float, terms: int = 6) -> float:
    mu = 4 * n * n
    series = 1.0
    denom = 1.0
    sign = -1.0
    for k in range(1, terms):
        denom *= 8 * x * k
        product = 1.0
        for j in range(1, k + 1):
            product *= mu - (2 * j - 1) ** 2
        series += sign * product / denom
        sign *= -1.0
    return np.exp(x) * series / np.sqrt(2 * math.pi * x)


def besseli_recurrence(n: int, x: float) -> float:
    if n == 0:
        return bessi0(x)
    if x == 0.0:
        return 0.0

    ACC = 40
    BIGNO = 1e10
    BIGNI = 1e-10

    tox = 2.0 / abs(x)
    bip = 0.0
    bi = 1.0
    ans = 0.0

    m = int(2 * (n + math.sqrt(ACC * n)))

    for j in range(m, 0, -1):
        bim = bip + j * tox * bi
        bip = bi
        bi = bim

        if abs(bi) > BIGNO:
            bi *= BIGNI
            bip *= BIGNI
            ans *= BIGNI

        if j == n:
            ans = bip

    ans *= bessi0(x) / bi

    if x < 0.0 and n % 2 == 1:
        ans = -ans

    return ans


def besseli(n: int, x: float) -> float:
    if x > n * n:
        return besseli_asymptotic(n, x)
    else:
        return besseli_recurrence(n, x)

def cheby_sign_func(n: int, k: float):
    m = int(math.floor((n - 1) / 2)) + 1
    fac = 2 * k * math.exp(-(k * k) / 2) / math.sqrt(math.pi)

    v = [0j] * (n + 1)
    z = (k * k) / 2

    for j in range(m):
        v[2 * j + 1] += (
            fac
            * ((-1) ** j) / (2 * j + 1)
            * (besseli(j, z) + besseli(j + 1, z))
        )

    return v

def cheby_to_mon(c):
    n = len(c) - 1
    if n == 0:
        return np.array([c[0]], dtype=complex)
    T = [
        np.array([1.0], dtype=complex),
        np.array([0.0, 1.0], dtype=complex)
    ]
    for j in range(1, n):
        t_curr = T[j]
        t_prev = T[j - 1]
        t_next = np.zeros(j + 2, dtype=complex)
        for k in range(j):
            t_next[k + 1] += 2 * t_curr[k]
            t_next[k] -= t_prev[k]
        t_next[j + 1] += 2 * t_curr[j]
        T.append(t_next)
    a = np.zeros(n + 1, dtype=complex)
    for j in range(n + 1):
        for k in range(j + 1):
            a[k] += c[j] * T[j][k]
    return a

def shifted_coef(p, a, b):
    d = len(p) - 1
    if d == 0:
        return np.array([p[0]], dtype=complex)
    lower = p[1:]
    shifted = shifted_coef(lower, a, b)
    new_coef = np.zeros(d + 1, dtype=complex)
    for j in range(d):
        new_coef[j]     += -a * b * shifted[j]
        new_coef[j + 1] += b * shifted[j]
    new_coef[0] += p[0]
    return new_coef

def sign_func(n, k, delta):
    c_cheb = cheby_sign_func(n, k)
    c_mon = cheby_to_mon(c_cheb)
    return shifted_coef(c_mon, delta,0.5)

def rect_func(n, k, delta):
    p1 = sign_func(n, k, delta)
    p2 = sign_func(n, k, -delta)
    p = np.zeros(n+1, dtype=complex)
    for j in range(n+1):
        p[j] =  0.5*(p2[j] - p1[j])
    """p[0] -= 1"""
    return p

def trunc_lin(n,k,tau):
    p = rect_func(n,k,tau)
    p = np.concatenate(([0], p))
    return p/tau

def poly_eval(coeffs, x):
    r = coeffs[-1]
    for c in reversed(coeffs[:-1]):
        r = r * x + c
    return r

def cheby_eval(c, x):
    b_kplus1 = 0.0
    b_kplus2 = 0.0
    for ck in reversed(c[1:]):
        b_k = 2*x*b_kplus1 - b_kplus2 + ck
        b_kplus2 = b_kplus1
        b_kplus1 = b_k
    return c[0] + x*b_kplus1 - b_kplus2

def chebmul(a, b):
    n = len(a)
    m = len(b)
    res = np.zeros(n + m - 1)
    for i in range(n):
        for j in range(m):
            prod = 0.5 * a[i] * b[j]
            res[i + j] += prod
            res[abs(i - j)] += prod
    return res

def inverse_function(e,kap):
    b = int(np.floor((kap**2)*np.log(kap/e)))
    n = int(np.floor(np.sqrt(b*np.log(4*b/e))))
    print(n,b)
    p = np.zeros(2*n+2)
    for j in range(n+1):
        prefac = 0
        for k in range(j+1,b+1):
            prefac += comb(2*b,b+k)
        p[2*j+1] = 4*((-1)**j)*(2**(-2*b))*prefac
    return p

def matrix_inv(e,kap):
    p = inverse_function(0.5*e,2*kap)
    b = int(np.floor((kap**2)*np.log(kap/e)))
    n = int(np.floor(np.sqrt(b*np.log(4*b/e))))
    ep = np.min(((2*e)/(5*kap),kap/(2*n)))
    nn = int((1/kap)*np.log(1/ep))
    k = (np.sqrt(2)/(0.25/kap))*np.sqrt(np.log(2/np.pi/(ep**2)))
    q = -rect_func(7*nn,k,0.75/2/kap)
    q[0] += 1
    q = chebyshev_coef(q)
    return chebmul((0.5/kap)*p,q)

def chebyshev_coef(p):
    d = len(p) - 1
    a = np.zeros(d + 1, dtype=complex)
    pow2 = 1
    a[0] = 2 * p[0]
    for k in range(1, d + 1):
        fac = p[k] / pow2
        jm = k
        jp = 1
        for j in range(k, -1, -2):
            a[j] += fac
            fac *= jm / jp
            jm -= 1
            jp += 1
        pow2 *= 2
    a[0] /= 2
    return a

kappa = 0.16
eps = 1e-1

n = 3*math.ceil((1.0 / kappa) * math.log(1.0 / eps))
if n % 2 == 0:
    n += 1

k = (math.sqrt(2.0) / kappa) * math.sqrt(math.log(2.0 / (math.pi * eps**2)))

coeffs = chebyshev_coef(trunc_lin(n, k, 0.5))

coeffs = (-0.9406944053139904,4.664754909852983e-18,-0.11829656748483589,-1.3888267497584206e-17,0.1173575264674648,2.464977083150761e-17,-0.11580815946998374,-3.3990013881648235e-17,0.11367162636461652,4.254120403196644e-17,-0.11097957937246915,-5.3846076145646096e-17,0.10777142071214406,6.486320111104793e-17,-0.10409338866548412,-7.642292445368239e-17,0.09999750029418346,8.21083836325036e-17,-0.0955403830410348,-9.444868961160419e-17,0.09078203024563228,1.0392980337696214e-16,-0.08578451711231434,-1.103865737236131e-16,0.08061071385918213,1.175873910312328e-16,-0.07532303167776187,-1.2602687164179693e-16,0.06998223482284052,1.3224718416840573e-16,-0.06464634875879999,-1.3401888080859997e-16,0.059369689980946445,1.393875373220838e-16,-0.054202038108592136,-1.3749212379573483e-16,0.049187965333759166,1.4292253306141493e-16,-0.0443663325394163,-1.4034676535534643e-16,0.039769955608579564,1.4251773178472149e-16,-0.03542543985473661,-1.3510842488299115e-16,0.03135317531952675,1.3094651280321954e-16,-0.02756748108214398,-1.1809666074289144e-16,0.024076882848861336,1.119232553429341e-16,-0.020884505043829014,-9.33226468097789e-17,0.017988556465979997,8.177741797285918e-17,-0.015382887331984894,-6.727460887447381e-17,0.01305759517233344,5.1279576001641504e-17,-0.010999657531032634,-3.753410860942402e-17,0.009193570652049506,2.2677658831494218e-17,-0.007621975205386068,-5.214066245452456e-18,0.006266252482395893,-9.777006068280373e-18,-0.005107077232818952,2.2666275252179852e-17,0.004124916280879751,-3.7572766191856884e-17,-0.003300465104127269,5.002587515708845e-17,0.0026150175557521477,-5.984996391955756e-17,-0.0020507667431346023,7.051634969185082e-17,0.001591037645565408,-7.204509088814614e-17,-0.0012204542873143545,7.348680130609984e-17,0.000925046126391888,-7.550825784889694e-17,-0.0006922997454588785,7.686605268116406e-17,0.0005111629323948833,-7.516712332145601e-17,-0.0003720088269637007,6.664717967233581e-17,0.0002665680167777674,-6.02956825182334e-17,-0.00018783633391374055,4.784503417051174e-17,0.00012996568646059044,-4.114626551994359e-17,-8.814461638264031e-5,2.445113338560436e-17,5.8474468052733943e-5,-1.2880707058535538e-17,-3.7846141297384014e-5,8.773279891711732e-19,2.38214454807229e-5,1.3068256238985072e-17,-1.4522117455896028e-5,-2.564367495767702e-17,8.528658601379017e-6,3.75639237775373e-17,-4.790318138077469e-6,-4.833771397382065e-17,2.5468256295353816e-6,5.625730971597126e-17,-1.2618699496985668e-6,-6.442052046886069e-17,5.678414776647416e-7,6.852466659142596e-17,-2.209977645829325e-7,-7.06375329972809e-17,6.85855134557946e-8)

x_vals = np.linspace(-1, 1, 2000)
y_poly = np.array([cheby_eval(coeffs, x).real for x in x_vals])
y_exact = np.arcsin(x_vals)*(2/np.pi)


plt.figure(figsize=(10, 6))
plt.plot(x_vals, y_poly, label='Polynomial Approximation',color='red')
plt.plot(x_vals, y_exact, '--', label='Exact sign(x)',color='black')

plt.xlabel('x')
plt.ylabel('y')
plt.title('Chebyshev-based Sign Approximation')
plt.grid(True)
plt.legend()
plt.show()