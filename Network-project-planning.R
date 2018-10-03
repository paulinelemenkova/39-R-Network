# нетворк проектирования работ, недоделано
g3 <- graph( c("GIS Spatial Analysis", "R Programming", "R Programming", "Mathematical Statistics", 
	"Mathematical Statistics", "GIS Spatial Analysis"),
	isolates=c("Data Collection", "Project Planning", "Visualization", "Modeling") )
plot(g3, edge.arrow.size=.5, vertex.color="gold", vertex.size=15, 
	vertex.frame.color="gray", vertex.label.color="black", 
	vertex.label.cex=0.8, vertex.label.dist=2, edge.curved=0.2)
	

############ мат.статистика + ГИС = проект
nodes <- read.table(text = "Id,Label
                            0.0,Data Processing
                            1.0,Project
                            2.0,Spatial GIS Analysis
                            3.0,Statistical Analysis",
             header = TRUE, sep = ",", stringsAsFactors = FALSE)

connections  <- read.table(text = "Source,Target,Weight
                                   1.0,0.0,1.0
                                   2.0,0.0,8.0
                                   3.0,0.0,10.0
                                   3.0,2.0,6.0",
               header = TRUE, sep = ",", stringsAsFactors = FALSE)

net <- graph_from_data_frame(connections, directed = FALSE, vertices = nodes)
V(net)$color <- "orange"
V(net)$label <- "" 
V(net)$size <- 10
E(net)$arrow.mode <- 0

plot(net, vertex.label = V(net)$Label)
