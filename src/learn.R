# ライブラリ
# install.packages("keras", dependencies = T)
library(keras)
# install_keras()
library(neuralnet)
library(tidyverse)
library(magrittr)

# データセット
data <- read.csv("../data/dataset.csv", row.names = 1)
dataset <- as.matrix(data)
dimnames(dataset) <- NULL

# 8割を学習データ、2割をテストデータとする
set.seed(0)
ind <- sample(2, nrow(dataset), replace = T, prob = c(0.8, 0.2))

X_train <- dataset[ind == 1, 2:11]
Y_train <- to_categorical(dataset[ind == 1, 1] - 1)
X_test <- dataset[ind == 2, 2:11]
Y_test <- to_categorical(dataset[ind == 2, 1] - 1)

m <- apply(X_train, 2, mean)
s <- apply(X_train, 2, sd)
ms <- rbind(m, s)
colnames(ms) <- names(data[2:11])
write.csv(ms, "../data/ms.csv")

X_train <- scale(X_train, center = m, scale = s)
X_test <- scale(X_test, center = m, scale = s)

# モデルの学習
model <- keras_model_sequential()
model %>%
  layer_dense(units = 6,
              activation = "softmax",
              input_shape = c(10))

summary(model)

model %>% compile(loss = "categorical_crossentropy",
                  optimizer = "adam",
                  metrics = "accuracy")

history <-
  model %>% fit(X_train,
                Y_train,
                epochs = 200,
                batch_size = 4,
                validation_split = 0.3)

# 結果の検証
print(history)

pred <- as.array(model %>% predict(X_test) %>% k_argmax())
print(pred)
print(as.array(Y_test %>% k_argmax()))

model %>% evaluate(X_test, Y_test)

# モデルの保存
save_model_hdf5(model, "../model/model.h5")
