#MATRIX A 
#Each row as diff car model, three col as three features 
#engine power, torque, efficiency 
#car 1: 1,2,3
#car 2: 4,5,6
my_vector<-c(1,2,3,4,5,6)

A<-matrix(my_vector,nrow = 2,ncol = 3,byrow = TRUE)
print("matrix A (Car Features:")
print(A)


#weights of contribution facts of each features toward two performance scores 
#1:speed score 
#2economy score
#engine power w 1  speed 0  econ
#torque w 2  speed 3  econ 
# fuel eff w 4 speed 5 econ 

B <- matrix(c(1, 0, 2, 3, 4, 5), nrow = 3, ncol = 2, byrow = TRUE)
print("Matrix B (Feature Weights):")
print(B)


#mult matrix A by B to get perform scores 

C<-A%*%B
print("matrix C (Calc perform scores):")
print(C)

colnames(C) <- c("SpeedScore", "EconomyScore")

#flip over diagonal to creat plots/why not 

tA <- t(A)
print("Transpose of Matrix A (Features as Rows):")
print(tA)

install.packages(c("ggplot2", "reshape2"))

cat("Car 1 Speed Score:", C[1, 1], "\n")
cat("Car 1 Economy Score:", C[1, 2], "\n")
cat("Car 2 Speed Score:", C[2, 1], "\n")
cat("Car 2 Economy Score:", C[2, 2], "\n")

rownames(C)<-c("Car 1","Car 2")
colnames(C)<-c("SpeedScore","EconomyScore")

df_scores<-as.data.frame(C)
df_scores$Car<-row.names(df_scores)
print("Data Frame of Performance Scores:")
print(df_scores)

install.packages("reshape2")
library(reshape2)
df_melted <- melt(df_scores, id.vars = "Car", variable.name = "ScoreType", value.name = "Score")
print("Reshaped Data for Plotting:")
print(df_melted)

install.packages("ggplot2")
library(ggplot2)
p <- ggplot(df_melted, aes(x = Car, y = Score, fill = ScoreType)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Car Performance Comparison", x = "Car Model", y = "Performance Score", fill = "Score Type") +
  theme_minimal()
print(p)










