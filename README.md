# PhasePlaneBasics
![R-CMD-check](https://github.com/bloniaszp/PhasePlaneBasics/workflows/R-CMD-check/badge.svg)  
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
- **Nullclines**: Plot the lines where \(\dot{x} = 0\) or \(\dot{y} = 0\), helping visualize equilibria and system behavior.  
- **Easy Integration**: Pass in any user-defined function \(\texttt{fun(x, y, parms)}\) that returns \(\texttt{c(dx/dt, dy/dt)}\).  
- **Customizable**: Tweak resolution, color, and plot appearance.  
---

## Installation

You can install **PhasePlaneBasics** directly from GitHub using **`devtools`**:

```r
# install.packages("devtools") # if needed
devtools::install_github("bloniaszp/PhasePlaneBasics")





