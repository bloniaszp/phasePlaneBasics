#' Create nullclines for the phase plane
#'
#' This function creates nullclines within a phase plane. It assumes that you
#' have a differential equation or system of DEs of the following form:
#'
#' \code{morrislecar <- function(V, W, parms) {
#'   g_L = 2; g_Ca = 4; g_K = 8; phi = 0.04;
#'   cap = 20; V_1 = -1.2; V_2 = 18; V_3 = 2;
#'   V_4 = 30; V_L = -60; V_Ca = 120; V_K = -84;
#'   I = 0;
#'   c(
#'     (1 / cap) * (I - g_Ca * 0.5 * (1 + tanh((V - V_1) / V_2)) * (V - V_Ca)
#'                  - g_K * W * (V - V_K) - g_L * (V - V_L)),
#'     phi * (0.5 * (1 + tanh((V - V_3) / V_4)) - W) *
#'          cosh((V - V_3) / (2 * V_4))
#'   )
#' }}
#'
#' It calculates points (x, y) where dx/dt = 0 and/or dy/dt = 0, and draws
#' contour lines for those solutions.
#'
#' @param fun A function of two variables \code{(x, y)} (plus optional \code{parms})
#'   that returns a vector \code{c(dx/dt, dy/dt)}.
#' @param xlims A numeric vector \code{c(xmin, xmax)} specifying plot range for x.
#' @param ylims A numeric vector \code{c(ymin, ymax)} specifying plot range for y.
#' @param resol Resolution of the grid. Default is 250.
#' @param add Logical. If \code{FALSE}, a new plot is created; if \code{TRUE},
#'   nullclines are added to an existing plot.
#' @param parms Optional list of parameters to pass to \code{fun}.
#'
#' @return Called for its side effect of drawing nullcline contours on a plot.
#' @importFrom graphics contour title
#' @export
#'
#' @examples
#' # Example usage with the morrislecar function:
#' # nullclines(morrislecar, xlims = c(-100, 50), ylims = c(0, 1), resol = 250)
nullclines <- function(fun, xlims, ylims, resol = 250,
                       add = FALSE, parms = NULL) {

  # Create a grid of (x, y) values
  x <- matrix(seq(xlims[1], xlims[2], length = resol),
              nrow = resol, ncol = resol, byrow = FALSE)
  y <- matrix(seq(ylims[1], ylims[2], length = resol),
              nrow = resol, ncol = resol, byrow = TRUE)
  npts <- resol * resol

  # Evaluate the function across this grid
  z <- fun(x, y, parms)
  z1 <- matrix(z[1:npts], resol, resol)
  z2 <- matrix(z[(npts + 1):(2 * npts)], resol, resol)

  # Draw the zero-contours
  contour(x[, 1], y[1, ], z1, levels = c(0), drawlabels = FALSE,
          add = add, col = "blue")
  contour(x[, 1], y[1, ], z2, levels = c(0), drawlabels = FALSE,
          add = TRUE, col = "forestgreen")

  title(main = "Blue=x nullcline, Green=y nullcline", cex.main = 0.8)
}
