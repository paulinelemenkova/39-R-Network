# Важные примечания:
# Здесь создаем flowchart-диаграмму структурной иерархии работы, т.е. какие главные классы методов использовались в работе (всего 12, иерархия 1 уровня), и какие типы методов (всего 100, иерархия 2 уровня). Напр., класс "ГИС-Анализ", а в нем типы работ: "проекции", "визуализация", "картография", "простр. анализ", и т.д.). Класс "Корреляции", а в нем типы работ: "k-means Clustering", "Correlogramms", "Dendrograms", "Double-Y-Axis" и т.п.
# создаем связи между всеми узлами (связи идут по ID, здесь: 12 главных узлов 1 уровня иерархии - центров букетов (1:12), с 1 по 12 - связи между иерархиями 1-го уровня (между собой), далее с 13 по 111  - узлы 2 уровня иерархии, лепестков. от 1 уровня них идут связи к каждому узлу 2 уровня. 
# все узлы (обоих уровней) хранятся в одной таблице вместе (здесь: nodes.csv). 
# таблица имеет 2 столбца: ID и names. 
# 2-я таблица (connections.csv) содержит связи, т.е. напр. от уровня 1 к под-уровням 13,14,15,16 и т.д. От уровня 2 - к его подуровням и т.д. 
# Всего имеем 2 таблицы csv. Здесь: nodes и connections.  
# В столбце weight таблицы connections указываем значимость связей (здесь: важность работ, по 5-балльной шкале)

library("igraph")

nodes <- read.table("nodes.csv", header = T, sep = ",", stringsAsFactors = FALSE)
connections <- read.table("connections.csv", header = T, sep = ",", stringsAsFactors = FALSE)

net <- graph_from_data_frame(connections, directed = F, vertices = nodes)
#V(net)$color <- "orange"
#V(net)$label <- "name" 
V(net)$size <- 10
E(net)$arrow.mode <- 0
vertex.label= nodes$name

library(RColorBrewer)
coul = brewer.pal(8, "Set1") 

plot(net, vertex.label= nodes$name,
	vertex.color = coul,
	vertex.size=4, 
	vertex.label.font = 1,
	vertex.label.cex = .6,
	vertex.label.dist = 3.0,
	vertex.frame.color = 'blue')





 
 



