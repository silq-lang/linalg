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

# Parameters
n = 38
k = 20
delta = 1/np.sqrt(2)

coeffs = matrix_inv(2e-4,1.25)

coeffs = (0, 0.6440916868663036, 0, -0.3541805045707604, 0, 0.11830116878566034, 0, 0.03819884190562001, 0, -0.11536693564482327, 0, 0.1235583341461108, 0, -0.08732217825742382, 0, 0.03675763609882863, 0, 0.010106139790378854, 0, -0.039512510809627144, 0, 0.04301217709011747, 0, -0.02859384008965193, 0, 0.012223100711365557, 0, -0.002330957700309945, 0, -0.0016431396778146135, 0, 0.0027433657202594174, 0, -0.0028636962759274838, 0, 0.002684252963086703, 0, -0.0023886229988077283, 0, 0.0020381158711375988, 0, -0.0016718230678934602, 0, 0.0013203591600678285, 0, -0.0010052370129304117, 0, 0.0007385234137214929, 0, -0.0005240206713164282, 0, 0.0003593563986766817, 0, -0.0002383110296661735, 0, 0.00015289934351590785, 0, -9.494417755046869e-5, 0, 5.707578987084306e-5, 0, -3.322321882089972e-5, 0, 1.8751051020353582e-5, 0, -1.0232012922259323e-5, 0, 5.408336817786466e-6, 0, -2.76906103837701e-6, 0, 1.3734470077841647e-6, 0, -6.602330449782954e-7, 0, 3.078777668711377e-7, 0, -1.3941975655493673e-7, 0, 6.140337212388968e-8, 0, -2.6262483811675786e-8, 0, 1.0723724047219927e-8, 0, -4.011101150326175e-9, 0, 1.3015250884972519e-9, 0, -3.484454829549003e-10, 0, 7.384951885029212e-11, 0, -1.188159515334675e-11, 0, 1.355522953521026e-12, 0, -8.988160612141234e-14, 0, -7.373606450640998e-16, 0, 9.32790931179535e-16, 0, -1.1289433970916299e-16, 0, 7.506989391164725e-18, 0, -2.925705047986179e-19, 0, 5.5854975256448585e-21, 0, -2.4625323432507497e-25, 0, -1.3062508123826883e-24, 0, 0)
x_vals = np.linspace(-1, 1, 2000)
y_poly = np.array([cheby_eval(coeffs, x).real for x in x_vals])

y_inv = (0.5/1.25)*np.where(np.abs(x_vals) > 1e-1, 1/x_vals, np.nan)

plt.figure(figsize=(10, 6))
plt.plot(x_vals, y_poly, label='Polynomial Approximation')
plt.plot(x_vals, y_inv, label='1/x', linestyle='--')

plt.xlabel('x')
plt.ylabel('y')
plt.title('Chebyshev-based Sign Approximation vs 1/x')
plt.grid(True)
plt.legend()
plt.show()