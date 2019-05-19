#to calculate probability of monoclonality 
ProbOfMonoclonality <- mean(replicate (10000, {
  N <- 419
  x <- runif (N, 0, 3.1416*17.5)
y <- runif (N, 0, 3.1416*17.5)
r <- rbeta(N, 9.849032,  99.940056)
C <- cbind(x,y,r)

#function which check if two random colonies overlap in matrix N x 3
func.c2 <- function(i,j) {
  (C[i,1]-C[j,1])^2+(C[i,2]-C[j,2])^2 <= (C[i,3]+C[j,3])^2
}
dp <- matrix(ncol = N, nrow = N)
  for (i in c(1:N)) {
  dp[i,] <- func.c2(i, )
  }
sum((colSums(dp)-1) == 0)/N
  }
))
