# PhasePlaneBasics
<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![R-CMD-check](https://github.com/bloniaszp/phasePlaneBasics/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/bloniaszp/phasePlaneBasics/actions/workflows/R-CMD-check.yml)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

<!-- badges: end -->


**PhasePlaneBasics** is an R package providing functions to visualize two-dimensional dynamical systems through phase arrows and nullclines. It includes functions to help students, educators, and researchers quickly understand the behavior of differential equations by plotting trajectories and identifying critical points. It's light weight and allows for quickly generating phase planes with minimal code.

---

## Table of Contents

1. [Features](#features)  
2. [Installation](#installation)
3. [Functions](#functions) 
4. [Usage](#usage)  
   - [Quick Example](#quick-example)  
   - [Phase Arrows](#phase-arrows)  
   - [Nullclines](#nullclines)  
5. [License](#license)  
6. [Acknowledgments](#acknowledgments)  

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

## Usage

After installation, load the package as usual:

```r
library(PhasePlaneBasics)
```

---

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
# Load the package
library(PhasePlaneBasics)

# Define the Morris-Lecar model function
morrislecar <- function(V, W, parms = NULL) {
  # Define parameters
  g_L  <- 2;    g_Ca <- 4;    g_K  <- 8;     phi  <- 0.04
  cap  <- 20;   V_1  <- -1.2; V_2  <- 18;    V_3  <- 2
  V_4  <- 30;   V_L  <- -60;  V_Ca <- 120;   V_K  <- -84
  I    <- 0

  # Return the equations
  c(
    (1 / cap) * (I - g_Ca * 0.5 * (1 + tanh((V - V_1) / V_2)) * (V - V_Ca)
                 - g_K * W * (V - V_K)
                 - g_L * (V - V_L)),
    phi * (0.5 * (1 + tanh((V - V_3) / V_4)) - W) *
         cosh((V - V_3) / (2 * V_4))
  )
}

# Define plot limits for the phase plane
xlims <- c(-80, 40) # Voltage range
ylims <- c(-0.2, 1.2) # Recovery variable range

```

## Phase Arrows
To visualize the vector field:

```r

# Create a phase plane with phase arrows
phasearrows(
  fun   = morrislecar,
  xlims = xlims,
  ylims = ylims,
  resol = 30, # Grid resolution
  col   = "black" # Arrow color
)

```

## Nullclines
To overlay nullclines on the same plot, simply call:

```r

# Overlay nullclines on the phase plane
nullclines(
  fun   = morrislecar,
  xlims = xlims,
  ylims = ylims,
  resol = 150, 
  add   = TRUE 
)

legend(
  "topright", legend = c("V nullcline", "W nullcline"),
  col = c("blue", "forestgreen"), lty = 1, cex = 0.8
)

```

### Acknowledgments
- Daniel Kaplan for the original pplane.r script.
- S. Ellner for modifications in support of Dynamic Models in Biology.

--- 

## License

This project is licensed under the terms of the **GPL-3 License**.
