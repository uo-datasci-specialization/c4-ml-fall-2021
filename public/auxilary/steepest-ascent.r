
R = 200

iter     <- matrix(NA,nrow=R,ncol=2)
iter[1,] <- c(-.3,-.1)

for(i in 2:R){
  
  der <- gradient(f = 'sin(x^2/2 - y^2/4)*cos(2*x - exp(y))', 
                    var = c(x=iter[i-1,1],y=iter[i-1,2]))
  
  iter[i,] <- iter[i-1,] + 0.1*der
}

grid     <- expand.grid(x=seq(-.5,3,.01),y=seq(-.5,2,.01))
grid$z   <- sin(grid[,1]^2/2 - grid[,2]^2/4)*cos(2*grid[,1] - exp(grid[,2]))

p <- plot_ly(grid,
        x = ~x, 
        y = ~y,
        z = ~z,
        type='contour',
        colors = 'YlGnBu',
        showscale=FALSE,
        reversescale =T) %>%
  add_trace(x = iter[1,1], 
          y = iter[1,2], 
          type = 'scatter',
          mode = 'markers',
          marker = list(color = 'black',size=5),
          showlegend=FALSE)
  
for(i in 2:100){
  
  p <- p %>%
    add_trace(x = iter[i,1], 
              y = iter[i,2], 
              type = 'scatter',
              mode = 'markers',
              marker = list(color = 'black',size=5,symbol = 'circle-open'),
              showlegend=FALSE) %>%
    add_segments(x = iter[i-1,1], 
                 y = iter[i-1,2],
                 xend = iter[i,1],
                 yend = iter[i,2],
              showlegend=FALSE)
  
}


grid     <- expand.grid(x=seq(-.5,3,.01),y=seq(-.5,2,.01))
grid$z   <- sin(grid[,1]^2/2 - grid[,2]^2/4)*cos(2*grid[,1] - exp(grid[,2]))

p <- plot_ly(grid,
        x = ~x,
        y = ~y,
        z = ~z,
        marker = list(color = ~z,
                      colorscale = 'YlGnBu',
                      showscale = TRUE)) %>%
  add_markers() %>%
  layout(scene = list(xaxis=list(range = c(3,-.5)),
                      yaxis=list(range = c(2,-.5)))) %>%
  add_trace(x = iter[1,1], 
            y = iter[1,2], 
            z = sin(iter[1,1]^2/2 - iter[1,2]^2/4)*cos(2*iter[1,1] - exp(iter[1,2])),
            type = 'scatter3d',
            mode = 'markers',
            marker = list(color = 'black',size=20),
            showlegend=FALSE)


for(i in 2:100){
  
  p <- p %>%
    add_trace(x = iter[i,1], 
              y = iter[i,2], 
              z = sin(iter[i,1]^2/2 - iter[i,2]^2/4)*cos(2*iter[i,1] - exp(iter[i,2])),
              type = 'scatter3d',
              mode = 'markers',
              marker = list(color = 'black',size=20),
              showlegend=FALSE)
  
}


