library('randomNames') 
NUMOFLINKS = 100
relations = data.frame(source = randomNames(1000,which.names='both'), target = "")
relations = relations[rep(seq_len(nrow(relations)), sample(1:10,nrow(relations), replace=T)),]
relations = relations[sample(nrow(relations),NUMOFLINKS),] 
relations$target = sample(relations$source,nrow(relations), replace = T)
relations = relations[relations[,1]!=relations[,2], ] 
 
# Have a look to the input table !
head(relations)
 
## Plot the graph using the IGRAPH package
library("igraph")
vertices<-data.frame("name" = unique(unlist(relations))) # node names
g = graph.data.frame(relations, directed=F, vertices=vertices) # raw graph

vertices$group = edge.betweenness.community(g)$membership # betweeness centrality for each node for grouping
 
 
plot(g,
     #mark.groups=vertices$group, # group vertices by betweeness indicator (redish blob background)
     layout=layout.auto, 
     vertex.color = vertices$group, # color vertices by edge betweeness
	vertex.label= relations$target,
	vertex.label.dist=4.0, #puts the name labels slightly off the dots
	vertex.label.color='black', #the color of the name labels
	vertex.label.font=1,	
	vertex.label.cex=.75,	#specifies the size of the font of the labels. can also be made to vary
	vertex.frame.color='blue', #the color of the border of the dots 
     vertex.size=5, 
     edge.arrow.size=0.8)

 
