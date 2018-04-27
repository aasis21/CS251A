num_samples <- 50000
all_data <- rexp(num_samples, 0.2)
print(mean(all_data))
print(sd(all_data))

to_plot <- data.frame(X = seq(1, num_samples , 1), Y = sort(all_data))
plot(to_plot)

X <- data.frame(X = seq(1, num_samples , 1), Y = all_data)

#split
n <- 100
nr <- nrow(X)
Y = split(X, rep(1:ceiling(nr/n), each=n, length.out=nr))



Z <- rep(0, 500);
#-----------------------------------------------------------------------------------------------------------------------------
all = c(1:500)
for(j in all){
  data = Y[j]
  data <- data.frame(matrix(unlist(data), nrow=100,),stringsAsFactors=FALSE)
  
  
  m = mean(data[,2])
  Z[j] = m
  
  x <- c(1,2,3,4,5)
  if(j %in% x){
    pdata <- rep(0, 100);
    for(i in 1:100){
      val=round(data[i,2], 0);
      if(val <= 100){
        pdata[val] = pdata[val] + 1/ 100; 
      }
    }
    
    xcols <- c(0:99)
    str(pdata)
    str(xcols)
  
    cdata <- rep(0, 100)
  
    cdata[1] <- pdata[1]
  
    for(i in 2:100){
      cdata[i] = cdata[i-1] + pdata[i]
    }
    plot(xcols, pdata, "l", xlab="X", ylab="f(X)")
    plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");
    print(m)
    print(sd(data[,2]))
  }
  
}



#--------------------------------------------------------Z analysis--------------------------------------------------------------------


num_samples <- 500
x <- data.frame(X = seq(1, num_samples , 1), Y = sort(Z))
plot(x)

tab <- table(round(Z))
str(tab)
plot(tab, "h", xlab="Value", ylab="Frequency")

pdata <- rep(0, 100);

for(i in 1:num_samples){
    val=round(Z[i], 0);
    if(val <= 100){
       pdata[val] = pdata[val] + 1/ num_samples; 
    }
}

xcols <- c(0:99)

str(pdata)
str(xcols)

plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

cdata <- rep(0, 100)

cdata[1] <- pdata[1]

for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");
print(" mean of means : ")
print(mean(Z))
print("Std. deviation of various mean ")
print(sd(Z))

print("Mean of whole sample : ")
print(mean(all_data))
print("Std. deviation of whole Sample ")
print(sd(all_data))







































