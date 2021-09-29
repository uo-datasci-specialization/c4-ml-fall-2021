

N = 20

x <- seq(0,1,length=N)
e <- rnorm(N,0,.01)

y.det <- exp((x-0.3)^2) - 1
y     <- y.det + e 


m1 <- lm(y ~ 1 + x)
m2 <- lm(y ~ 1 + x + I(x^2))
m3 <- lm(y ~ 1 + x + I(x^2) + I(x^3))
m4 <- lm(y ~ 1 + x + I(x^2) + I(x^3) + I(x^4))
m5 <- lm(y ~ 1 + x + I(x^2) + I(x^3) + I(x^4) + I(x^5))


ggplot()+
  geom_function(fun = function(x) exp((x-.3)^2)-1)+
  theme_bw()+
  xlab('x')+
  ylab('y')+
  xlim(c(0,1))+
  ylim(c(-0.25,1))+
  geom_line(aes(x=x,y=predict(m5)))

predict(m1)

################################################################################

E  <- vector('list',30)
Y  <- vector('list',30)
M1 <- vector('list',30)
M2 <- vector('list',30)
M3 <- vector('list',30)
M4 <- vector('list',30)
M5 <- vector('list',30)
M6 <- vector('list',30)

x <- seq(0,1,length=N)

for(i in 1:30){
  
  N = 20
  
  E[[i]]  <- rnorm(N,0,.1)
  Y[[i]]  <- exp((x-0.3)^2) - 1 + E[[i]]
  
  M1[[i]] <- lm(Y[[i]] ~ 1 + x)
  M2[[i]] <- lm(Y[[i]] ~ 1 + x + I(x^2))
  M3[[i]] <- lm(Y[[i]] ~ 1 + x + I(x^2) + I(x^3))
  M4[[i]] <- lm(Y[[i]] ~ 1 + x + I(x^2) + I(x^3) + I(x^4))
  M5[[i]] <- lm(Y[[i]] ~ 1 + x + I(x^2) + I(x^3) + I(x^4) + I(x^5))
  M6[[i]] <- lm(Y[[i]] ~ 1 + x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6))
}


p <- ggplot()+
  geom_function(fun = function(x) exp((x-.3)^2)-1)+
  theme_bw()+
  xlab('x')+
  ylab('y')+
  xlim(c(0,1))+
  ylim(c(-0.25,1))

for(i in 1:30){
  p <- p + geom_line(aes_string(x=x,y=predict(M1[[i]])),col='gray')
}


p <- ggplot()+
  geom_function(fun = function(x) exp((x-.3)^2)-1)+
  theme_bw()+
  xlab('x')+
  ylab('y')+
  xlim(c(0,1))+
  ylim(c(-0.25,1))

for(i in 1:30){
  p <- p + geom_line(aes_string(x=x,y=predict(M2[[i]])),col='gray')
}

p <- ggplot()+
  geom_function(fun = function(x) exp((x-.3)^2)-1)+
  theme_bw()+
  xlab('x')+
  ylab('y')+
  xlim(c(0,1))+
  ylim(c(-0.25,1))

for(i in 1:30){
  p <- p + geom_line(aes_string(x=x,y=predict(M6[[i]])),col='gray')
}

y.true <- exp((x-.3)^2)-1

bias1 <- data.frame(x=x,M1=NA,M2=NA,M3=NA,M4=NA,M5=NA,M6=NA)
var1  <- data.frame(x=x,M1=NA,M2=NA,M3=NA,M4=NA,M5=NA,M6=NA)

out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M1[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M1 <- rowMeans(out-Y.true)
var1$M1 <- apply(out-Y.true,1,sd)


out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M2[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M2 <- rowMeans(out-Y.true)
var1$M2 <- apply(out-Y.true,1,sd)


out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M3[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M3 <- rowMeans(out-Y.true)
var1$M3 <- apply(out-Y.true,1,sd)


out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M4[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M4 <- rowMeans(out-Y.true)
var1$M4 <- apply(out-Y.true,1,sd)

out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M5[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M5 <- rowMeans(out-Y.true)
var1$M5 <- apply(out-Y.true,1,sd)

out <- matrix(nrow=20,ncol=30)
for(i in 1:30){
  out[,i] <- predict(M6[[i]])
}

Y.true <- matrix(y.true,nrow=20,ncol=30,byrow=FALSE)
bias1$M6 <- rowMeans(out-Y.true)
var1$M6 <- apply(out-Y.true,1,sd)


