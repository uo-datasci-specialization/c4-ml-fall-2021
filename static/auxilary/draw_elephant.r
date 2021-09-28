
# Parameters (complex numbers)

  p1 <- 50-30i
  p2 <- 18+8i
  p3 <- 12-10i
  p4 <- -14-60i

  Cx <- c(0,50i,18i,12,0,-14)
  Cy <- c(0,-60-30i,8i,-10i,0,0)

# t, parameter that can be interpreted as the elapsed time while going along
# the path of the contour
  
  t <- seq(0,2*pi,length.out = 1000)

# X-coordinates
  
  x <- c()
  
  A <- c(0,0,0,12,0,-14)  # Real part of Cx
  B <- c(0,50,18,0,0,0)   # Imaginary part of Cx
  
  for(i in 1:length(t)){
    k <- 0:5
    x[i] <- sum(A*cos(k*t[i]) + B*sin(k*t[i])) # Eq 1
  }
  
# Y-coordinates
  
  y <- c()
  
  A <- c(0,-60,0,0,0,0)     # Real part of Cy
  B <- c(0,-30,8,-10,0,0)   # Imaginary part of Cy
  
  for(i in 1:length(t)){
    k <- 0:5
    y[i] <- sum(A*cos(k*t[i]) + B*sin(k*t[i])) # Eq 2
  }
  
# Function to draw the elephant

  plot(y,-x,type='l')
  
  