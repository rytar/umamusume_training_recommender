# classify.Rの実行が必須
source("./classify.R")

# データ
teamrace_data <- read.csv("../data/umamusume_team_race_status.csv", row.names = 1)

# 各クラスタの目標ステータス
avg1 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`1`,], 2, mean)
avg2 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`2`,], 2, mean)
avg3 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`3`,], 2, mean)
avg4 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`4`,], 2, mean)
avg5 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`5`,], 2, mean)
avg6 <- apply(teamrace_data[row.names(teamrace_data) %in% result$`6`,], 2, mean)

status <- round(rbind(avg1, avg2, avg3, avg4, avg5, avg6))

write.csv(status, "../data/target_status.csv")