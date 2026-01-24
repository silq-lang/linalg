import numpy as np
from scipy.special import iv
from numpy.polynomial.chebyshev import Chebyshev
import matplotlib.pyplot as plt

def perf_coeffs(k, n):
    m = (n-1)//2 + 1
    factor = 2 * k * np.exp(-k**2 / 2) / np.sqrt(np.pi)
    v = np.zeros(n+1)
    for j in range(m):
        v[2*j+1] += ((-1)**j)*(iv(j,(k**2)/2)+iv(j+1,(k**2)/2))/(2*j+1)
    v *= factor
    return v

def eval_cheb(coeffs, x):
    x = np.asarray(x)
    b_next = np.zeros_like(x)
    b_curr = np.zeros_like(x)
    
    for c in reversed(coeffs[1:]):
        b_new = 2*x*b_curr - b_next + c
        b_next, b_curr = b_curr, b_new
    
    return b_curr*x - b_next + coeffs[0]


def perf_shifted_eval(coeffs, delta, x):
    x_scaled = (x - delta)/2
    return eval_cheb(coeffs, x_scaled)

def poly_eval(coeffs, x):
    r = coeffs[-1]
    for c in reversed(coeffs[:-1]):
        r = r * x + c
    return r

# --------------------------
# Example usage and plot
k = 20
n = 49
delta = -1/np.sqrt(2)
x_values = np.linspace(-1, 1, 2000)

coefs=(-0.991985, 0, -3.35111, 0, 218.97, 0, -5403.73, 0, 67423.7, 0,
 -491119, 0, 2.25989e+06, 0, -6.81504e+06, 0, 1.32994e+07, 0,
 -1.44936e+07, 0, -479360, 0, 3.25462e+07, 0, -6.36823e+07, 0,
 7.12533e+07, 0, -5.21879e+07, 0, 2.45563e+07, 0, -6.03504e+06, 0,
 -387983, 0, 813508, 0, -241098, 0, 19672.1, 0, 3508.98, 0,
 -504.724, 0, -28.0812, 0, -0.200763, 0)




y_values = poly_eval(coefs, x_values) 


plt.figure(figsize=(8,5))
plt.plot(x_values, y_values, label='perf_shifted difference')
plt.xlabel('x')
plt.ylabel('Value')
plt.grid(True)
plt.legend()
plt.show()