setwd("/Rdir/multi_rphylo")

###
With ddply :) - thanks Randi!
###

library("geiger")
library("caper")
library("plyr")

iterations = 1000
twomulti_data <- read.csv("simple_2multi.csv")
simpletree<-read.nexus("simpletree.nex")

write(c("iteration","beta","std error","t-value","p-value","R-squared","adjusted R-squared","lambda"), "output.txt", ncolumns=8, append=FALSE, sep="\t")

for (i in 1:iterations)
{
	subd_data <- ddply(twomulti_data, .(species), function(x) {x[sample(nrow(x), 1),]})
	
	row.names(subd_data) <- subd_data$species

	primate <- comparative.data(phy = simpletree, data = subd_data, names.col = species, vcv = TRUE)
	model.pgls<-pgls(group ~ trait, data = primate, lambda='ML')
	
	write(c(i,summary(model.pgls)$coefficients[2,1],summary(model.pgls)$coefficients[2,2],summary(model.pgls)$coefficients[2,3],summary(model.pgls)$coefficients[2,4],summary(model.pgls)$r.squared,summary(model.pgls)$adj.r.squared,summary(model.pgls)$param[2]), "output.txt", ncolumns=8, append=TRUE, sep="\t")
}
