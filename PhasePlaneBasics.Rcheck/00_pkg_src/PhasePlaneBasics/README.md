# PhasePlaneBasics
![R-CMD-check](https://github.com/bloniaszp/phasePlaneBasics/workflows/R-CMD-check/badge.svg)  
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

**PhasePlaneBasics** is an R package providing functions to visualize two-dimensional dynamical systems through phase arrows and nullclines. It includes functions to help students, educators, and researchers quickly understand the behavior of differential equations by plotting trajectories and identifying critical points. It's light weight and allows for quickly generating phase planes with minimal code.

---

## Table of Contents

1. [Features](#features)  
2. [Installation](#installation)  
3. [Usage](#usage)  
   - [Quick Example](#quick-example)  
   - [Phase Arrows](#phase-arrows)  
   - [Nullclines](#nullclines)  
4. [Functions](#functions)  
5. [Contributing](#contributing)  
6. [License](#license)  
7. [Acknowledgments](#acknowledgments)  

---

## Features

- **Phase Arrows**: Generate arrows or “vector fields” showing the direction of state-space flow in a 2D system.  
- **Nullclines**: Plot the lines where $\dot{x} = 0$ or $\dot{y} = 0$, helping visualize equilibria and system behavior.  
- **Easy Integration**: Pass in any user-defined function `fun(x, y, parms)` that returns `c(dx/dt, dy/dt)`.  
- **Customizable**: Tweak resolution, color, and plot appearance.  
---

## Installation

You can install **PhasePlaneBasics** directly from GitHub using **`devtools`**:

```r
# install.packages("devtools") # if needed
devtools::install_github("bloniaszp/phasePlaneBasics")
```

## Quick Example
Below is a quick demonstration using the morrislecar function. This function simulates a simple two-dimensional neural model:

```r
morrislecar <- function(V, W, parms = NULL) {
  g_L  <- 2;    g_Ca <- 4;    g_K  <- 8;     phi  <- 0.04
  cap  <- 20;   V_1  <- -1.2; V_2  <- 18;    V_3  <- 2
  V_4  <- 30;   V_L  <- -60;  V_Ca <- 120;   V_K  <- -84
  I    <- 0

  c(
    (1 / cap) * (I - g_Ca * 0.5 * (1 + tanh((V - V_1) / V_2)) * (V - V_Ca)
                 - g_K * W * (V - V_K)
                 - g_L * (V - V_L)),
    phi * (0.5 * (1 + tanh((V - V_3) / V_4)) - W) *
         cosh((V - V_3) / (2 * V_4))
  )
}
```


# PhasePlaneBasics

## Usage

After installation, load the package as usual:

```r
library(PhasePlaneBasics)
```

## Functions

### `phasearrows`
Creates a grid of arrows (vector field) for a 2D system.

#### Parameters:
- `fun`: Function `(x, y, parms)` returning `c(dx, dy)`.
- `xlims, ylims`: Plot bounds.
- `resol`: Grid resolution.
- `col`: Color of arrows.
- `add`: If `TRUE`, adds to an existing plot.
- `parms`: Additional parameters for `fun`.
- `jitter`: Adds random noise to the grid points.

---

### `nullclines`
Plots the curves where 𝑑𝑥/𝑑𝑡 = 0 or 𝑑𝑦/𝑑𝑡 = 0.

#### Parameters:
- `fun`: Function `(x, y, parms)` returning `c(dx, dy)`.
- `xlims, ylims`: Plot bounds.
- `resol`: Grid resolution for contour detection.
- `add`: If `TRUE`, adds to an existing plot.
- `parms`: Additional parameters for `fun`.

---

## Quick Example
Below is a quick demonstration using the morrislecar function. This function simulates a simple two-dimensional neural model:

```r
morrislecar <- function(V, W, parms = NULL) {
  g_L  <- 2;    g_Ca <- 4;    g_K  <- 8;     phi  <- 0.04
  cap  <- 20;   V_1  <- -1.2; V_2  <- 18;    V_3  <- 2
  V_4  <- 30;   V_L  <- -60;  V_Ca <- 120;   V_K  <- -84
  I    <- 0

  c(
    (1 / cap) * (I - g_Ca * 0.5 * (1 + tanh((V - V_1) / V_2)) * (V - V_Ca)
                 - g_K * W * (V - V_K)
                 - g_L * (V - V_L)),
    phi * (0.5 * (1 + tanh((V - V_3) / V_4)) - W) *
         cosh((V - V_3) / (2 * V_4))
  )
}
```

## Phase Arrows
To visualize the vector field:

```r

phasearrows(
  fun    = morrislecar, 
  xlims  = c(-80, 40), 
  ylims  = c(-0.2, 1.2), 
  resol  = 30,
  col    = "black"
)

```

## Nullclines
To overlay nullclines on the same plot, simply call:

```r

nullclines(
  fun    = morrislecar,
  xlims  = c(-80, 40),
  ylims  = c(-0.2, 1.2),
  resol  = 150,
  add    = TRUE
)

```

### Acknowledgments
- Daniel Kaplan for the original pplane.r script.
- S. Ellner for modifications in support of Dynamic Models in Biology.

--- 

## License

This project is licensed under the terms of the **GPL-3 License**.
