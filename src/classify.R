# 元データ
original_data <- read.csv("../data/umamusume_parameter.csv")

# 必要な情報の抽出
necessary_data <- original_data[19:28]

# アルファベットを数字に変換
alphabet <- c('A', 'B', 'C', 'D', 'E', 'F', 'G')
A_Gto1_7 <- function(a) (1:7)[alphabet == a]
necessary_data <- apply(necessary_data, c(1, 2), A_Gto1_7)

# 行の名前をつけておく
name_data <- original_data[, 2]

conflict_names <- c("エアグルーヴ", "エルコンドルパサー", "グラスワンダー", "トウカイテイオー", "マチカネフクキタル", "マヤノトップガン", "メジロマックイーン")
for (name in conflict_names)
  name_data[name_data == name] <- c(paste(name, '1'), paste(name, '2'))

row.names(necessary_data) <- name_data

# 階層的クラスタリング
# d <- dist(necessary_data, method = "euclidean")
# cluster <- hclust(d, method = "ward.D")
# par(family = "HiraKakuProN-W3")
# plot(cluster, hang = -1)

# 適正による分類
set.seed(0)
k <- 6
cluster <- kmeans(necessary_data, centers = k)
result <- tapply(names(cluster$cluster), cluster$cluster, unique)
print(result)

# 分類データの保存
get_cluster_number <- function(x) (1:k)[sapply(result, function(l) x %in% l)]
class <- sapply(row.names(necessary_data), get_cluster_number)
dataset <- cbind(class, necessary_data)

write.csv(dataset, "../data/dataset.csv")