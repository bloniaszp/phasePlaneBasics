#' Create phase arrows
#'
#' This function creates phase arrows within a phase plane. It assumes that you
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
#' It calculates x' and y' at a grid of points and draws small arrows.
#'
#' @param fun A function of two variables \code{(x, y)} (plus optional \code{parms})
#'   that returns a vector \code{c(dx/dt, dy/dt)}.
#' @param xlims A numeric vector \code{c(xmin, xmax)} specifying plot range for x.
#' @param ylims A numeric vector \code{c(ymin, ymax)} specifying plot range for y.
#' @param resol Resolution of the grid. Default is 25.
#' @param col Arrow color. Default is "black".
#' @param add Logical. If \code{FALSE}, a new plot is created; if \code{TRUE}, arrows
#'   are added to an existing plot.
#' @param parms Optional list of parameters to pass to \code{fun}.
#' @param jitter Logical. If \code{TRUE}, jitter the grid points slightly for a
#'   less “striped” pattern of arrows.
#'
#' @return Called for its side effect of drawing arrows on a plot.
#' @export
#'
#' @examples
#' \dontrun{
#'   # Example usage with the morrislecar function:
#'   phasearrows(morrislecar, xlims=c(-100, 50), ylims=c(0,1), resol=25)
#' }
phasearrows <- function(fun, xlims, ylims, resol = 25,
                                 col = 'black', add = FALSE,
                                 parms = NULL, jitter = FALSE) {
  if (!add) {
    plot(1, xlim = xlims, ylim = ylims, type = 'n', xlab = "x", ylab = "y")
  }
  x <- matrix(seq(xlims[1], xlims[2], length = resol),
              byrow = TRUE, nrow = resol, ncol = resol)
  y <- matrix(seq(ylims[1], ylims[2], length = resol),
              byrow = FALSE, nrow = resol, ncol = resol)
  npts <- resol * resol

  if (jitter) {
    xspace <- abs(diff(xlims)) / (resol * 10)
    yspace <- abs(diff(ylims)) / (resol * 10)
    x <- x + matrix(runif(npts, -xspace, xspace), nrow = resol, ncol = resol)
    y <- y + matrix(runif(npts, -yspace, yspace), nrow = resol, ncol = resol)
  }

  z <- fun(x, y, parms)
  z1 <- matrix(z[1:npts], resol, resol)
  z2 <- matrix(z[(npts + 1):(2 * npts)], resol, resol)

  maxx <- max(abs(z1))
  maxy <- max(abs(z2))
  dt <- min(abs(diff(xlims)) / maxx, abs(diff(ylims)) / maxy) / resol

  lens <- sqrt(z1^2 + z2^2)
  lens2 <- lens / max(lens)

  arrows(c(x),
         c(y),
         c(x + dt * z1 / (lens2 + 0.1)),
         c(y + dt * z2 / (lens2 + 0.1)),
         length = 0.04, col = col)
}
