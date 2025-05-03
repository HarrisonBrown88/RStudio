pkgs <- c("reshape2", "ggplot2")
installed <- pkgs %in% installed.packages()[, "Package"]
if (any(!installed)) install.packages(pkgs[!installed])
lapply(pkgs, library, character.only = TRUE)

A <- matrix(c(1, 2, 3,
              4, 5, 6),
            nrow = 2, ncol = 3, byrow = TRUE)
rownames(A) <- c("Car 1", "Car 2")
colnames(A) <- c("Power", "Torque", "Efficiency")

B <- matrix(c(1, 0,
              2, 3,
              4, 5),
            nrow = 3, ncol = 2, byrow = TRUE)
rownames(B) <- c("Power", "Torque", "Efficiency")
colnames(B) <- c("SpeedScore", "EconomyScore")

C <- A %*% B

df_scores <- as.data.frame(C)
df_scores$Car <- rownames(df_scores)

df_melted <- reshape2::melt(
  df_scores,
  id.vars = "Car",
  variable.name = "ScoreType",
  value.name = "Score"
)

print("Performance Scores:")
print(df_scores)

ggplot2::ggplot(df_melted, aes(x = Car, y = Score, fill = ScoreType)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Car Performance Comparison",
    x = "Car Model",
    y = "Performance Score",
    fill = "Score Type"
  ) +
  theme_minimal()

cor_value <- cor(
  df_scores$SpeedScore,
  df_scores$EconomyScore,
  use = "complete.obs",
  method = "pearson"
)
print(paste(
  "Pearson correlation (Speed vs. Economy):",
  round(cor_value, 3)
))

df_scores$TradeOff <- df_scores$SpeedScore / df_scores$EconomyScore

print("TradeOff Ratios (Speed / Economy):")
print(df_scores[, c("Car", "TradeOff")])

df_sorted <- df_scores[order(df_scores$TradeOff, decreasing = TRUE), ]
print("Cars sorted by TradeOff ratio:")
print(df_sorted)
