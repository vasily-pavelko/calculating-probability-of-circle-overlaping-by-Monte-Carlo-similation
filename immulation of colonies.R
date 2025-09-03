library(fitdistrplus)
library(plotrix)
library(readxl)
library(ggplot2)
library(XML)

#with for loop
sheet_list <- excel_sheets("data/clonepix_data.xlsx")
all_sheets <- data.frame(matrix(ncol = ncol(read_xlsx("data/clonepix_data.xlsx", sheet = "Auto637678165240625000")), nrow = 0))
colnames(all_sheets) <- colnames(read_xlsx("data/clonepix_data.xlsx", sheet = "Auto637678165240625000"))
for (i in sheet_list) {
  all_sheets <- rbind(all_sheets, read_xlsx("data/clonepix_data.xlsx", sheet = i))
}
#show unique for every column
uniq <- apply(all_sheets, 2, unique)
str(uniq)
#with apply function
sheet_list <- excel_sheets("data/clonepix_data.xlsx")
all_sheets_list <- list()
for (i in sheet_list) {
  all_sheets_list$i <- i
  all_sheets_list[[i]] <-read_xlsx("data/clonepix_data.xlsx", sheet = i)
}
big_data = do.call(rbind, all_sheets_list)


accept <- subset(all_sheets,  all_sheets$Picked == "True")
dim(accept)
summary(accept$RadiusAverageRMS)
RMS <- as.numeric(gsub(",", ".", accept$RadiusAverageRMS))
summary(RMS)
png('results/Fig2A.png')
hist(RMS, breaks = 100, main = "", 
     xlab = "Average colony radius, mm", ylab = "Frequency of occurrence")
dev.off()
par(new=FALSE)




#model for picked group
png('results/Fig2B.png')
descdist(accept$RadiusAverageRMS, boot = 1000)
dev.off()
#data according to the  cullen and frey graph is lognormal distributed
fit_lognorm <- fitdist(accept$RadiusAverageRMS, "lnorm")

# Skip diagnostic plot for now
fit_lognorm
#estimate  Std. Error
#meanlog -1.5052555 0.007266355
#sdlog    0.1677568 0.005137267

#curve(dlnorm(x, meanlog=fit_lognorm[[1]][1], sdlog=fit_lognorm[[1]][2]), from=0, to=0.4)

png('results/Fig2C.png')
ggplot() +
  geom_histogram(aes(accept$RadiusAverageRMS, y = ..density..), binwidth = .005) +
  stat_function(fun = function(x) dlnorm(x, meanlog=fit_lognorm[[1]][1], sdlog=fit_lognorm[[1]][2]), color = "red",
                size = 1) +
  xlab("Average colony radius, mm") +
  ylab("Frequency of occurrence") +
  ggtitle("")
ggsave('results/Fig2C.png')
dev.off()





#without plot
ProbOfMonoclonality <- mean(replicate (10000, {
  #number of colonies in well
  N <- 45
  # (x,y) coordinate of centre. In square with area pi*34.8
  x <- runif (N, 0, 31)
  y <- runif (N, 0, 31)
  #lognormal distribution  with meanlog = -1.5052555, sdlog  =  0.1677568
  r <- rlnorm(N, meanlog = -1.5052555, sdlog = 0.1677568)
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
  
}))
ProbOfMonoclonality

#with plot - single iteration for visualization
png('results/Fig2D.png')
N <- 45
x <- runif(N, 0, 31)
y <- runif(N, 0, 31)
r <- rlnorm(N, meanlog = -1.5052555, sdlog = 0.1677568)
plot(1:31, type="n", asp = 1, xlim = c(0, 31), ylim = c(0, 31),
     main = "", xlab = "Horizontal coordinates of colony, mm", ylab = "Vertical coordinates of colony, mm")
index <- c(1:N)
for (i in index) {
  draw.circle(x[i], y[i], r[i])
}
dev.off()



#model for custom number of colonies
all_sheets$RadiusAverageRMS <- (as.numeric(gsub(",", ".", all_sheets$RadiusAverageRMS)))
all_sheets$AxisRatio <- (as.numeric(gsub(",", ".", all_sheets$AxisRatio)))
all_sheets$Compactness <- as.numeric(gsub(",", ".", all_sheets$Compactness))
all_sheets$TotalArea <- as.numeric(gsub(",", ".", all_sheets$TotalArea))

all_sheets_gar <- subset(all_sheets, all_sheets$AxisRatio > 0.8)
all_sheets_gar1 <- subset(all_sheets_gar, all_sheets_gar$Compactness > 0.8)
all_sheets_gar2 <- subset(all_sheets_gar1, all_sheets_gar1$TotalArea > 0.05)
#all_sheets_gar3 <- subset(all_sheets_gar2, all_sheets_gar2$TotalArea > 0.02)
# Skip filtered colonies histogram for now
# hist(all_sheets_gar2$RadiusAverageRMS, ...)

# Skip filtered Cullen and Frey plot
# descdist(all_sheets_gar2$RadiusAverageRMS,  boot = 1000)
#data according to the  cullen and frey graph is lognormal distributed
fit_lognorm <- fitdist(all_sheets_gar2$RadiusAverageRMS, "lnorm")

# Skip filtered diagnostic plot
# plot(fit_lognorm)
fit_lognorm
# Skip filtered histogram with fit
# ggplot() + ...



#without plot
ProbOfMonoclonality <- mean(replicate (10000, {
  #number of colonies in well
  N <- 34
  # (x,y) coordinate of centre. In square with area pi*34.8
  x <- runif (N, 0, 31)
  y <- runif (N, 0, 31)
  #lognormal distribution  with 
  r <- rlnorm(N, meanlog = fit_lognorm[[1]][1], sdlog = fit_lognorm[[1]][2])
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
  
}))
ProbOfMonoclonality

# Skip final monte carlo simulation plot
# png('results/final_monte_carlo_simulation.png')
# ...

