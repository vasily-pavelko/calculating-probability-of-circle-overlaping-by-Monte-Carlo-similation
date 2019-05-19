#To calculate probability of monoclonality perform replicate 10000 times
ProbOfMonoclonality <- mean(replicate (10000, {
  #number of colonies in well
  N <- 25
  # (x,y) coordinate of centre. In square with area pi*34.8
  x <- runif (N, 0, 10)
  y <- runif (N, 0, 10)
  #Beta distribution  with alpha = 9.849032, beta = 99.940056
  r <- rbeta(N, 9.849032,  99.940056)
  C <- cbind(x,y,r)

#function which check if two random colonies overlap in matrix N x 3
func.c2 <- function(i,j) {
  (C[i,1]-C[j,1])^2+(C[i,2]-C[j,2])^2 <= (C[i,3]+C[j,3])^2
}
#dp - matrix to fill with results of tested colonies
dp <- matrix(ncol = N, nrow = N)
  for (i in c(1:N)) {
  dp[i,] <- func.c2(i, )
  }
sum((colSums(dp)-1) == 0)/N
  }
))
