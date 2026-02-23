import math
import numpy as np

def helper_Lfrac(n: int, x: float, a: float) -> float:
    """Compute mathcal{L}_n(x; a)"""
    alpha = (1+a)/(2*(1-a))
    l1 = (x + (1-a)/(1+a)) / alpha
    l2 = (x**2 + (1-a)/(1+a) * x / 2 - 1/2) / alpha**2
    if n == 1:
        return l1
    for _ in range(3, n+1):
        l1, l2 = l2, x * l2 / alpha - l1 / (4 * alpha**2)
    return l2

def helper_P(x: float, n: int, a: float) -> float:
    """Compute values of the polynomial P_(2n-1)(x; a)"""
    return (1 - (-1)**n * (1+a)**2 / (4*a) * helper_Lfrac(n, (2 * x**2 - (1 + a**2))/(1-a**2), a))/x

def poly(d: int, a: float) -> np.polynomial.Chebyshev:
    """Returns Chebyshev polynomial for optimal polynomial
    Args:
    d (int): odd degree
    a (float): 1/kappa for range [a,1]"""
    if d % 2 == 0:
        raise ValueError("d must be odd")
    coef = np.polynomial.chebyshev.chebinterpolate(
        helper_P, d, args=((d+1)//2, a))
    coef[0::2] = 0 # force even coefficients exactly zero
    return np.polynomial.Chebyshev(coef)

def error_for_degree(d: int, a: float) -> float:
    """Returns the poly error for degree d and a=1/kappa"""
    if d % 2 == 0:
        raise ValueError("d must be odd")
    n = (d+1)//2
    return (1-a)**n / (a * (1+a)**(n-1))

def mindegree_for_error(epsilon: float, a: float) -> int:
    """Returns the minimum degree d for a poly with error epsilon, a=1/kappa"""
    n = math.ceil((np.log(1/epsilon) + np.log(1/a) + np.log(1+a))
                / np.log((1+a) / (1-a)))
    return 2*n-1


kappa = 4
target_epsilon = 0.1
a = 1/kappa
d = mindegree_for_error(target_epsilon, a)
polynomial = poly(d, a)
# actual error could be smaller than target_epsilon as d is integer
actual_epsilon = error_for_degree(d, a)
print("Degree {} polynomial achieving error {} in [{},1]:".format(d, actual_epsilon, a))
print(polynomial)