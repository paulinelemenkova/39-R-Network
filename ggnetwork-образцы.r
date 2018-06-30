library(ggnetwork)
library(network)
library(sna)
library(statnet.common)

# шаг-1. add categorical and continuous attributes for both edges and vertices. Nodes add a categorical vertex attribute called "family", ("a", "b" or "c"), and a continuous vertex attribute called "importance" (1, 2 or 3). 
n <- network(rgraph(10, tprob = 0.2), directed = FALSE)
n %v% "family" <- sample(letters[1:3], 10, replace = TRUE)
n %v% "importance" <- sample(1:3, 10, replace = TRUE)

# шаг-2. add a categorical edge attribute "type" ("x", "y" or "z") , and a continuous vertex attribute "day"  (1, 2 or 3).
e <- network.edgecount(n)
set.edge.attribute(n, "type", sample(letters[24:26], e, replace = TRUE))
set.edge.attribute(n, "day", sample(1:3, e, replace = TRUE))
 
head(ggnetwork(n))
ggplot(ggnetwork(n))
ggplot(n)
  
# базовый нетворк
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
geom_edges(aes(linetype = type), color = "grey50") +
theme_blank()

# сглаженные линии
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
+ geom_edges(aes(linetype = type), color = "grey50", curvature = 0.1) +
+ theme_blank()

# добавим узлы
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
geom_edges(aes(linetype = type), color = "grey50") +
geom_nodes(aes(color = family, size = importance)) +
theme_blank()

# добавим ярлычки-аннотации к узлам как текст // add node labels
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(color = "black") +
	geom_nodes(color = "black", size = 8) +
	geom_nodetext(aes(color = family, label = LETTERS[ vertex.names ]),
	fontface = "bold") +
	theme_blank()

# другой вариант добавим ярлычки-аннотации к узлам как ярлыки// add node labels
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(color = "black") +
	geom_nodelabel(aes(color = family, label = LETTERS[ vertex.names ]),
	fontface = "bold") +
	theme_blank()
	
# располагаем ярлычки точек сбоку от точек, чтобы не перекрывались // geom_nodetext_repel and geom_nodelabel_repel
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(color = "black") +
	geom_nodelabel_repel(aes(color = family, label = LETTERS[ vertex.names ]),
	fontface = "bold", box.padding = unit(1, "lines")) +
	geom_nodes(color = "black", size = 8) +
	theme_blank()
	
# подписываем ребра-кромки // geom_edgetext and geom_edgelabel
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(aes(linetype = type), color = "grey75") +
	geom_nodes(color = "gold", size = 8) +
	geom_nodetext(aes(label = LETTERS[ vertex.names ])) +
	geom_edgetext(aes(label = day), color = "white", fill = "grey25") +
	theme_minimal() +
	theme(axis.text = element_blank(),
	axis.title = element_blank(),
	panel.background = element_rect(fill = "grey25"),
	panel.grid = element_blank())

# располагаем ярлычки ребер сбоку от ребер, чтобы не перекрывались
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(aes(linetype = type), color = "grey75") +
	geom_nodes(color = "gold", size = 8) +
	geom_nodetext(aes(label = LETTERS[ vertex.names ])) +
	geom_edgetext_repel(aes(label = day), color = "white", fill = "grey25",
	box.padding = unit(1, "lines")) +
	theme_minimal() +
	theme(axis.text = element_blank(),
	axis.title = element_blank(),
	panel.background = element_rect(fill = "grey25"),
	panel.grid = element_blank())

# подгружаем доступную базу данных 
data(emon)emon[[1]]

 ggplot(emon[[1]], aes(x = x, y = y, xend = xend, yend = yend)) +
geom_edges(arrow = arrow(length = unit(6, "pt"), type = "closed")) +
geom_nodes(color = "tomato", size = 4) +
theme_blank()

ggnetwork(emon[[1]], weights = "Frequency")
ggplot(ggnetwork(emon[[1]], arrow.gap = 0.04, by = "Frequency"),
	aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(arrow = arrow(length = unit(6, "pt"), type = "closed"),
	aes(color = Sponsorship)) +
	geom_nodes(aes(color = Sponsorship), size = 4) +
	facet_wrap(~ Frequency) +
	theme_facet()
	
# еще примеры
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
	geom_edges(aes(linetype = type), color = "grey50") +
	geom_nodes(aes(x, y, color = family, size = 1.5 * importance)) +
	geom_nodetext(aes(label = LETTERS[ vertex.names ], size = 0.5 * importance))
	+
	geom_edgetext(aes(label = day), color = "grey25") +
	scale_color_brewer(palette = "Set2") +
	scale_size_area("importance", breaks = 1:3, max_size = 9) +
	theme_blank()

# другой пример	
ggplot(n, aes(x = x, y = y, xend = xend, yend = yend)) +
geom_edges(color = "grey50", alpha = 0.5) +
geom_nodes(aes(x, y, color = family, size = 5.5 * importance), alpha = 0.5)
+
geom_nodes(aes(x, y, color = family, size = 1.5 * importance)) +
scale_color_brewer(palette = "Set1") +
guides(size = FALSE) +
theme_blank()
 