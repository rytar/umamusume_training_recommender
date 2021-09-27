# ライブラリ
library(keras)

# 新たなウマ娘情報
# 長距離差しウマ、グループは6になるはず
new_data <- c("A", "G", "G", "F", "B", "A", "G", "F", "A", "C")
new_data <- t(as.matrix(new_data))
alphabet <- c('A', 'B', 'C', 'D', 'E', 'F', 'G')
A_Gto1_7 <- function(a) (1:7)[alphabet == a]
new_data <- t(as.matrix(sapply(new_data, A_Gto1_7)))

ms <- read.csv("../data/ms.csv", row.names = 1)
m <- ms[1,]
s <- ms[2,]

new_data <- scale(new_data, center = m, scale = s)

# ニューラルネットによる分類
model <- load_model_hdf5("../model/model.h5")

pred <- as.array(model %>% predict(new_data) %>% k_argmax()) + 1
print(pred)

# 育成目標の提示
target <- read.csv("../data/target_status.csv", row.names = 1)

print(target[pred, ])
