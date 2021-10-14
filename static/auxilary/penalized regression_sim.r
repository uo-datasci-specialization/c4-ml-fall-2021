
set.seed(09282021)

N = 200

x <- seq(0,1,length=N)

x

e <- rnorm(N,0,.1)

e

y <- exp((x-0.3)^2) - 1 + e

y

plot(x,y)




d <- data.frame(x=x,y=y)

d$x2 <- d$x^2
d$x3 <- d$x^3
d$x4 <- d$x^4
d$x5 <- d$x^5
d$x6 <- d$x^6


###############################################################################

train <- d[seq(1,100,2),]
test  <- d[seq(2,100,2),]

mod <- lm(y ~ 1 + x + x2 + x3 + x4 + x5 + x6,
          data = train)
mod

mod <- lm(y ~ 1 + x + x2 + x3 + x4,
          data = train)
mod


predict(mod)
summary(mod)

pred <- predict(mod,newdata = test)

sqrt(mean((pred-test$y)^2))

pred <- predict(mod,newdata = train)

sqrt(mean((pred-train$y)^2))



#############################################################################


ridge <- cv.glmnet(x = as.matrix(train[,c('x','x2','x3','x4','x5','x6')]),
                   y = as.numeric(train$y),
                   alpha = 0,
                   family='gaussian')

plot(ridge, main = "Ridge penalty\n\n")


ridge$lambda.min  

coef(ridge,ridge$lambda.min)


ridge.fit <- glmnet(x = as.matrix(train[,c('x','x2','x3','x4','x5','x6')]), 
                    y = as.numeric(train$y), 
                    alpha = 0, 
                    lambda = ridge$lambda.min,
                    family = "gaussian")


pred <- predict(ridge.fit,as.matrix(train[,c('x','x2','x3','x4','x5','x6')]))


sqrt(mean((pred[,1]-train$y)^2))



pred <- predict(ridge.fit,as.matrix(test[,c('x','x2','x3','x4','x5','x6')]))

sqrt(mean((pred[,1]-test$y)^2))


#############################################################################


lasso <- cv.glmnet(x = as.matrix(train[,c('x','x2','x3','x4','x5','x6')]),
                   y = as.numeric(train$y),
                   alpha = 1,
                   family='gaussian')

plot(lasso, main = "lasso penalty\n\n")


lasso$lambda.min  

coef(lasso,lasso$lambda.min)



lasso.fit <- glmnet(x = as.matrix(train[,c('x','x2','x3','x4','x5','x6')]), 
                    y = as.numeric(train$y), 
                    alpha = 0, 
                    lambda = lasso$lambda.min,
                    family = "gaussian")


pred <- predict(lasso.fit,as.matrix(train[,c('x','x2','x3','x4','x5','x6')]))


sqrt(mean((pred[,1]-train$y)^2))



pred <- predict(lasso.fit,as.matrix(test[,c('x','x2','x3','x4','x5','x6')]))

sqrt(mean((pred[,1]-test$y)^2))



















