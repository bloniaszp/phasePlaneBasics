#' Create phase arrows
#'
#' This function creates phase arrows within a phase plan. 
#' It assumes that you have a differential equation or system of DEs
#' of the following form:
#' 
#' morrislecar=function(V,W,parms){
#' g_L=2; g_Ca=4; g_K=8; phi=0.04;
#' cap=20; V_1=-1.2; V_2=18; V_3=2;
#' V_4=30; V_L=-60; V_Ca=120; V_K=-84;
#' I=0;
#' c((1/cap)*(I - g_Ca*0.5 * (1 + tanh((V - V_1) / V_2))*(V-V_Ca)- g_K*W*(V-V_K)-g_L*(V-V_L)),
#'  phi*(0.5 * (1 + tanh((V - V_3) / V_4)) - W)*cosh((V - V_3) / (2 * V_4)))
#' } 
#' 
#'Modified from the original script pplane.r written by Daniel Kaplan,
#' Dept. of Mathematics, Macalester College, kaplan@macalester.edu 
#'
#' Modifications by S. Ellner for use in connection with the textbook
#' Dynamic Models in Biology by S.P. Ellner and J. Guckenheimer,
#' Princeton University Press (2006)  
#'
#' Further Modifications by PF. Bloniasz for use in connection with Math 1808
#' Biomathematics at Bowdoin College. The code has been condensed to only have
#' phase planes and nullclines. This script is being used under the presumption of 
#' Fair Use copyright law for educational purposes. Questions should be directed to
#' patrick.bloniasz@gmail.com


#' @export
phasearrows_Math1808 <- function(fun,xlims,ylims,resol=25, col='black', add=F,parms=NULL,jitter=FALSE) {
  if (add==F) {
    plot(1,xlim=xlims, ylim=ylims, type='n',xlab="x",ylab="y");
  }
  x <- matrix(seq(xlims[1],xlims[2], length=resol), byrow=T, resol,resol);
  y <- matrix(seq(ylims[1],ylims[2], length=resol),byrow=F, resol, resol);
  npts <- resol*resol;
  if(jitter) {
    xspace <- abs(diff(xlims))/(resol*10);
    yspace <- abs(diff(ylims))/(resol*10);
    x <- x + matrix(runif(npts, -xspace, xspace),resol,resol);
    y <- y + matrix(runif(npts, -yspace, yspace),resol,resol);
  }
  z <- fun(x,y,parms);
  z1 <- matrix(z[1:npts], resol, resol);
  z2 <- matrix(z[(npts+1):(2*npts)], resol, resol);
  maxx <- max(abs(z1));
  maxy <- max(abs(z2));
  dt <- min( abs(diff(xlims))/maxx, abs(diff(ylims))/maxy)/resol;
  lens <- sqrt(z1^2 + z2^2);
  lens2 <- lens/max(lens); 
  arrows(c(x), c(y), c(x+dt*z1/((lens2)+.1)), c(y+dt*z2/((lens2)+.1)),length=.04, col=col);
}

#' Create nullclines for the phase plan
#'
#' This function creates nullclines within a phase plan. 
#' It assumes that you have a differential equation or system of DEs
#' of the following form:
#' morrislecar=function(V,W,parms){
#' g_L=2; g_Ca=4; g_K=8; phi=0.04;
#' cap=20; V_1=-1.2; V_2=18; V_3=2;
#' V_4=30; V_L=-60; V_Ca=120; V_K=-84;
#' I=0;
#' c((1/cap)*(I - g_Ca*0.5 * (1 + tanh((V - V_1) / V_2))*(V-V_Ca)- g_K*W*(V-V_K)-g_L*(V-V_L)),
#'  phi*(0.5 * (1 + tanh((V - V_3) / V_4)) - W)*cosh((V - V_3) / (2 * V_4)))
#' } 
#' 
#' #'Modified from the original script pplane.r written by Daniel Kaplan,
#' Dept. of Mathematics, Macalester College, kaplan@macalester.edu 
#'
#' Modifications by S. Ellner for use in connection with the textbook
#' Dynamic Models in Biology by S.P. Ellner and J. Guckenheimer,
#' Princeton University Press (2006)  
#'
#' Further Modifications by PF. Bloniasz for use in connection with Math 1808
#' Biomathematics at Bowdoin College. The code has been condensed to only have
#' phase planes and nullclines. This script is being used under the presumption of 
#' Fair Use copyright law for educational purposes. Questions should be directed to
#' patrick.bloniasz@gmail.com

#' @export
nullclines_Math1808 <- function(fun,xlims, ylims, resol=250, add=F,parms=NULL) {
  x <- matrix(seq(xlims[1],xlims[2], length=resol), byrow=F, resol,resol);
  y <- matrix(seq(ylims[1],ylims[2], length=resol),byrow=T, resol, resol);
  npts = resol*resol;
  z <- fun(x,y,parms);
  z1 <- matrix(z[1:npts], resol, resol);
  z2 <- matrix(z[(npts+1):(2*npts)], resol, resol);
  contour(x[,1],y[1,],z1,levels=c(0), drawlabels=F,add=add, col="blue");
  contour(x[,1],y[1,],z2,levels=c(0), drawlabels=F,add=T, col="forestgreen"); 
  title(main="Blue=x nullcline, Green=y nullcline",cex=0.35); 
}