require(plot3D)

# Notes 1 - Linear Algebra


png(file = here('static','notes','images','2dvec.png'),
     width = 400,
     height = 400)

arrows2D(x0=0,y0=0,x1=3,y1=5, 
         lwd = 1, 
         bty ="n", 
         xlim = c(-10, 10), ylim = c(-10, 10))


arrows2D(x0=0,y0=0,x1=-2,y1=8, 
         lwd = 1, 
         bty ="n", 
         add=TRUE)

abline(h =0, v = 0, lty = 2)

points2D(x=0, y=0, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)

text2D(x=3.35, y=5.35, c("(3,5)"),add=TRUE)
text2D(x=-2.35, y=8.35, c("(-2,8)"),add=TRUE)

text2D(x=1.55, y=3.2, labels = expression(bold('a'[1])),add=TRUE)

text2D(x=-1, y=5, labels = expression(bold('a'[2])),add=TRUE)

dev.off()



png(file = here('static','notes','images','3dvec.png'),
    width = 400,
    height = 400)

arrows3D(x0 = 0, y0=0, z0=0, x1=3, y1=5, z1=8, 
         lwd = 1, d = 3, 
         bty ="g",
         xlim=c(0,10),
         ylim=c(0,10),
         zlim=c(0,10),
         phi = 10,
         theta=50,
         ticktype = "detailed")

arrows3D(x0 = 0, y0=0, z0=0, x1=6, y1=8, z1=2, 
         lwd = 1, d = 3, 
         bty ="g",add=TRUE)

points3D(3, 5, 8, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)

text3D(3.2, 5, 8, c("(3,5,8)"),add=TRUE, colkey = FALSE)
text3D(6.2, 8, 2, c("(6,8,2)"),add=TRUE, colkey = FALSE)

text3D(x=2, y=2.5, z=4, labels = expression(bold('b'[1])),add=TRUE)

text3D(x=4, y=4, z=1, labels = expression(bold('b'[2])),add=TRUE)

dev.off()

#rect3D(x0 = -10, y0 = 0, z0 = -10, 
#       x1 = 10,z1 = 10, 
#       add = TRUE,
#       bty = "g", facets = TRUE, 
#       border = "black", col ="white", alpha=0.1,
#       lwd = 1, lty=2)

#rect3D(x0 = 0, y0 = -10, z0 = -10, 
#       y1 = 10,z1 = 10, 
#       add = TRUE,
#       bty = "g", facets = TRUE, 
#       border = "black", col ="white", alpha=0.1,
#       lwd = 1, lty=2)



png(file = here('static','notes','images','2dvec2.png'),
    width = 400,
    height = 400)

arrows2D(x0=0,y0=0,x1=4,y1=6, 
         lwd = 1, 
         bty ="n", 
         xlim = c(-10, 10), ylim = c(-10, 10))


arrows2D(x0=0,y0=0,x1=-6,y1=4, 
         lwd = 1, 
         bty ="n", 
         add=TRUE)

abline(h =0, v = 0, lty = 2)

points2D(x=0, y=0, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)

text2D(x=4.35, y=6.35, c("(4,6)"),add=TRUE)
text2D(x=-6.35, y=4.35, c("(-6,4)"),add=TRUE)

text2D(x=1.55, y=3.2, labels = expression(bold('x')),add=TRUE)

text2D(x=-3, y=3.2, labels = expression(bold('y')),add=TRUE)

dev.off()



png(file = here('static','notes','images','2dvec3.png'),
    width = 400,
    height = 400)

arrows2D(x0=0,y0=0,x1=4,y1=6, 
         lwd = 1, 
         bty ="n", 
         xlim = c(-10, 10), ylim = c(-10, 10))


arrows2D(x0=0,y0=0,x1=-2,y1=8, 
         lwd = 1, 
         bty ="n", 
         add=TRUE)

abline(h =0, v = 0, lty = 2)

points2D(x=0, y=0, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)

text2D(x=4.6, y=6.5, c("(4,6)"),add=TRUE)
text2D(x=-2.5, y=6, c("(-2,8)"),add=TRUE)

text2D(x=1.55, y=3.2, labels = expression(bold('x')),add=TRUE)

text2D(x=-1.5, y=4, labels = expression(bold('y')),add=TRUE)

dev.off()





library("rgl")

plot3d(x = -30,
       y = 15,
       z = 25,
       size=1, 
       type="s",
       xlim=c(-40,40), 
       ylim=c(-40,40),
       zlim=c(-40,40),
       xlab="X",ylab="Y",zlab="Z")

x <- seq(-20,20,1)
y <- seq(-20,20,1)

z <- matrix(ncol=length(x),nrow=length(y))

for(i in 1:nrow(z)){
  for(j in 1:ncol(z)){
    z[i,j] = 1.5*x[i]+0.5*y[j]+4
  }
}


surface3d(x=x,
          y=y,
          z=z,
          col="grey", alpha=.2)




library("rgl")

plot3d(x = 0,
       y = 0,
       z = 0,
       size=1, 
       type="s",
       xlim=c(-100,100), 
       ylim=c(-100,100),
       zlim=c(-100,500),
       xlab="X",ylab="Y",zlab="Z")

x <- seq(-20,20,1)
y <- seq(-20,20,1)

z <- matrix(ncol=length(x),nrow=length(y))

for(i in 1:nrow(z)){
  for(j in 1:ncol(z)){
    z[i,j] = x[i] ^2 + 2*y[j] - 5 
  }
}


surface3d(x=x,
          y=y,
          z=z,
          col="grey", alpha=.2)





