
$$ f(x,y) = sin(\frac{x^2}{2} - \frac{y^2}{4}) \times cos(2x - e^y) $$
  
  We can take the first-order derivative of this function with respect to $x$ while treating $y$ as a constant, or we can take the first-order derivative of this function with respect to $y$ while treating $x$ as a constant. Without knowing anything about the rules of taking derivatives, you can find them using the `derivative()` function from the `calculus` package. 

```{r, echo = TRUE,class.source='klippy',warning=FALSE,message=FALSE,class.source = 'fold-show'}

derivative(f = 'sin(x^2/2 - y^2/4)*cos(2*x - exp(y))', 
           var = 'x', 
           order = 1)


derivative(f = 'sin(x^2/2 - y^2/4)*cos(2*x - exp(y))', 
           var = 'y', 
           order = 1)

```

Below are the partial derivatives of this function with respect to $x$ and $y$.

$$ \frac{\partial f(x,y)}{\partial x} = \left ( x \times cos(\frac{x^2}{2} - \frac{y^2}{4}) \times cos(2x - e^y) \right ) - \left ( 2 \times sin(\frac{x^2}{2} - \frac{y^2}{4}) \times sin(2x - e^y) \right ) $$
  
  $$ \frac{\partial f(x,y)}{\partial y} =  \left ( sin(\frac{x^2}{2} - \frac{y^2}{4}) \times sin(2x - e^y) \times e^y \right ) - \left ( \frac{y}{2} \times cos(\frac{x^2}{2} - \frac{y^2}{4}) \times cos(2x - e^y) \right )$$
  
  Note that we use $\partial$ symbol instead of $d$ to differentiate that these are partial derivatives.

### Gradient

The first-order derivative of a single variable function indicates the slope of a tangent line that touches to that function at a particular point. Then, how do we interpret the partial derivatives? It is best to visualize this to get a glimpse of it. Below are how this function looks like in 3D. I also added a counterplot to represent the same shape in 2D.

```{r,fig.align='center',class.source='klippy',message=FALSE,warning=FALSE,fig.width=8,fig.height=8}

grid     <- expand.grid(x=seq(-.5,3,.01),y=seq(-.5,2,.01))
grid$z   <- sin(grid[,1]^2/2 - grid[,2]^2/4)*cos(2*grid[,1] - exp(grid[,2]))

plot_ly(grid,
        x = ~x,
        y = ~y,
        z = ~z,
        marker = list(color = ~z,
                      colorscale = 'YlGnBu',
                      showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis=list(range = c(3,-.5)),
                      yaxis=list(range = c(2,-.5))))

```

```{r,fig.align='center',class.source='klippy',message=FALSE,warning=FALSE,fig.width=8,fig.height=8}

grid     <- expand.grid(x=seq(-.5,3,.01),y=seq(-.5,2,.01))
grid$z   <- sin(grid[,1]^2/2 - grid[,2]^2/4)*cos(2*grid[,1] - exp(grid[,2]))

plot_ly(grid,
        x = ~x, 
        y = ~y,
        z = ~z,
        type='contour',
        colors = 'YlGnBu',
        showscale=TRUE,
        reversescale =T)

```

Now, suppose that we dropped you with a helicopter on this surface and your coordinates are $x = 0.1$ and $y = 0.3$. The partial derivatives with respect to $x$ and with respect $y$ would be equal to 0.065 and -0.035, respectively. 

```{r, echo = TRUE,class.source='klippy',warning=FALSE,message=FALSE,class.source = 'fold-show'}

gradient(f = 'sin(x^2/2 - y^2/4)*cos(2*x - exp(y))', 
         var = c(x=.1,y=.3))

```

If we add the gradient values with respect to $x$ and with respect to $y$ to tthe original coordinates of $x$ and $y$, then the new coordinates gives the direction with the largest slope at $(x,y)$ towards the maximum. In the graph below, the filled dot is (0.1, 0.3) and open circle is (0.1 + 0.0089, 0.3 - 0.0397). The direction from the filled dot to the open circle gives the largest slope towards the maximum (steepest ascent).Or, if you want to reach to the maximum, it is the best next step.

```{r,fig.align='center',class.source='klippy',message=FALSE,warning=FALSE,fig.width=8,fig.height=8}

a <- 0.1
b <- 0.3

der <- derivative(f = 'sin(x^2/2 - y^2/4)*cos(2*x - exp(y))', 
                  var = c(x=a,y=b), 
                  order = 1)

grid     <- expand.grid(x=seq(-.5,3,.01),y=seq(-.5,2,.01))
grid$z   <- sin(grid[,1]^2/2 - grid[,2]^2/4)*cos(2*grid[,1] - exp(grid[,2]))

plot_ly(grid,
        x = ~x, 
        y = ~y,
        z = ~z,
        type='contour',
        colors = 'YlGnBu',
        showscale=TRUE,
        reversescale =T) %>%
  add_trace(x = a, 
            y = b, 
            type = 'scatter',
            mode = 'markers',
            marker = list(color = 'black',size=5)) %>%
  add_trace(x = a+der[1], 
            y = b+der[2], 
            type = 'scatter',
            mode = 'markers',
            symbols = c('x'),
            marker = list(color = 'black',size=5,symbol = 'circle-open'))
```

*Note*. We here assume that we are searching for the maximum. If we are searching for a minimum, then the open circle would be (0.1  - 0.0089, 0.3 + 0.0397) and provide the direction with the largest slope towards the minimum (steepest descent).


The dimensions of gradient depends on the number of inputs in a function. Suppose $f$ is a function with $n$ inputs, then the gradient of this function will be a column vector with length $n$. 

$$ y = f(x_1,x_2,...,x_n) $$
  $$ \Delta f = f'(x_1,x_2,...,x_n) = \begin{bmatrix} \frac{\partial y} {\partial x_1} \\ \frac{\partial y} {\partial x_2} \\ ... \\ \frac{\partial y} {\partial x_n} \end{bmatrix} $$

### Hessian

If we take the first-order partial derivatives from a multivariate function and take derivative again with respect to each variable, then we obtain the second-order partial derivatives. The Hessian matrix is a way of organizing the second-order partial derivatives. These derivatives can get very complex and tedious to do by hand, so we will rely on third-party packages to do the actual work.

For instance, consider the function used in the previous section.

$$ f(x,y) = sin(\frac{x^2}{2} - \frac{y^2}{4}) \times cos(2x - e^y) $$

We foun its first-order partial derivative with respect to $x$ as the following..

$$ \frac{\partial f(x,y)}{\partial x} = \left ( x \times cos(\frac{x^2}{2} - \frac{y^2}{4}) \times cos(2x - e^y) \right ) - \left ( 2 \times sin(\frac{x^2}{2} - \frac{y^2}{4}) \times sin(2x - e^y) \right ) $$

$\frac{\partial f(x,y)}{\partial x}$ is a function itself, so we can take its derivative with respect to $x$ and $y$. 


$$\frac{\partial f^2(x,y)}{\partial x^2} = \frac{\partial}{\partial x} \left ( \frac{\partial f(x,y)}{\partial x}  \right )$$

```{r, echo = TRUE,class.source='klippy',warning=FALSE,message=FALSE,class.source = 'fold-show'}


fprime.x <- '(x*cos(x^2/2 - y^2/4)*cos(2*x - exp(y)))-(2*sin(x^2/2 - y^2/4)*sin(2*x - exp(y)))'

derivative(f = fprime.x, 
           var = 'x', 
           order = 1)

```

This gets pretty ugly! I simplified it for you.

$$\frac{\partial f^2(x,y)}{\partial x^2} = cos(\frac{x^2}{2} - \frac{y^2}{4}) - $$






a <- recipe(Recidivism_Arrest_Year2 ~ ., data = d_tr) %>%
     step_indicate_na(all_of(nominal),all_of(ordinal),all_of(binary),all_of(numeric),all_of(props)) %>%
     step_zv(all_numeric()) %>%
     step_impute_mean(all_of(numeric),all_of(props)) %>%
     step_impute_mode(all_of(nominal),all_of(ordinal),all_of(binary)) %>%
     step_logit(all_of(props)) %>%
     step_ns(all_of(numeric),all_of(props),deg_free=3) %>%
     step_normalize(paste0(numeric,'_ns_1'),
                    paste0(numeric,'_ns_2'),
                    paste0(numeric,'_ns_3'),
                    paste0(props,'_ns_1'),
                    paste0(props,'_ns_2'),
                    paste0(props,'_ns_3')) %>%
     step_dummy(all_of(nominal),all_of(ordinal),all_of(binary),one_hot=TRUE) %>%
     prep() %>%
     juice

b <- recipe(Recidivism_Arrest_Year2 ~ ., data = d_te) %>%
     step_indicate_na(all_of(nominal),all_of(ordinal),all_of(binary),all_of(numeric),all_of(props)) %>%
     step_zv(all_numeric()) %>%
     step_impute_mean(all_of(numeric),all_of(props)) %>%
     step_impute_mode(all_of(nominal),all_of(ordinal),all_of(binary)) %>%
     step_logit(all_of(props)) %>%
     step_ns(all_of(numeric),all_of(props),deg_free=3) %>%
     step_normalize(paste0(numeric,'_ns_1'),
                    paste0(numeric,'_ns_2'),
                    paste0(numeric,'_ns_3'),
                    paste0(props,'_ns_1'),
                    paste0(props,'_ns_2'),
                    paste0(props,'_ns_3')) %>%
     step_dummy(all_of(nominal),all_of(ordinal),all_of(binary),one_hot=TRUE) %>%
     prep() %>%
     juice




cv_elastic <- caret::train(x = as.matrix(a[,3:167]),
                           y = factor(a$Recidivism_Arrest_Year2),
                           method = "glmnet",
                           family = 'binomial',
                           trControl = trainControl(method = "cv", number = 10),
                           type.measure = 'ROC',
                           tuneLength = 10)

cv_elastic$bestTune

elastic.fit <- glmnet(x = as.matrix(a[,3:167]), 
                      y = factor(a$Recidivism_Arrest_Year2), 
                      alpha  = cv_elastic$bestTune$alpha, 
                      lambda = cv_elastic$bestTune$lambda,
                      family = "binomial")

pred <- predict(elastic.fit,as.matrix(b[,3:167]))
pred <- exp(pred)/(1+exp(pred))

auc_roc(preds = pred[,1],
        actuals=b$Recidivism_Arrest_Year2)


mean((pred[,1]-b$Recidivism_Arrest_Year2)^2)


mean((pred[which(b$Gender_F==1),1]-b[which(b$Gender_F==1),]$Recidivism_Arrest_Year2)^2)

mean((pred[which(b$Gender_M==1),1]-b[which(b$Gender_M==1),]$Recidivism_Arrest_Year2)^2)




