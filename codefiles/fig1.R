tots<-read.csv("totp_totc.csv")
tpara<-tots$tot_para
tcult<-tots$tot_cult
taxon_s<-tots$taxon_shape
taxon_c<-tots$taxon_col

pdf(file="fig1.pdf", width=6.85, height=7, fonts="Times", pointsize=9)

mat <- matrix(c(1,0,2,2), 2)
layout(mat, c(3.55,3.3), c(3.55,3.45))
par(family="Times", pointsize=9)

par(mar=c(5,5,1,1), family="Times", lheight=1)
plot(tpara~tcult, pch=taxon_s, ylab=NA, xlab=NA, col=taxon_c, bty="l")
mtext("(a)", side = 3, line = 0, adj = -0.15, font=3)
mtext(side=2, "parasite species richness\n(sampling effort controlled)", line=2.5)
mtext(side=1, "total behaviour richness\n(sampling effort controlled)", line=3.5)
legend(x=.86, y=-.21, legend=c("Strepsirhines","Tarsiids","Platyrrhines","Cercopithecoids","Hominoids"), pch=c(1,5,2:4), col=c(1,6,2:4))
mod1<-lm(tpara~tcult)
abline(mod1)




#------------------------------------------------------------#
#                   trait_phylo_plot.r                       #
# - Code to graph a phylogeny with tip labels corresponding  #
# - to values for a certain trait for each taxon.            #
#                                             ~Collin McCabe #
#------------------------------------------------------------#

# Install or load required packages
is_installed <- function(mypkg) { is.element(mypkg, installed.packages()[,1]) }
load_or_install <- function(package_names)
{
  for(package_names in package_names)
  {
    if(!is_installed(package_names))
    {
      install.packages(package_names,repos="http://cran.us.r-project.org")
    }
    library(package_names,character.only=TRUE,quietly=TRUE,verbose=FALSE)
  }
}
lib.list <- c("ape","geiger")
load_or_install(lib.list)

# Set working directory to current location of this R script
# setwd("~/Documents/RESEARCH/ACTIVE PROJECTS/Behavior & Parasites/Manuscript/Figures/trait_phylo_plot")

# Read in example data for both the data to be graphed and the tree to be plotted (should be included in same )
dat <-read.csv("genusdata.csv")
row.names(dat)<-dat$genus
gen <-read.nexus("genustree.nex")

# Make sure that the genus names in the data set match up with what is in the tree
name.check(gen, dat)
dat[match(gen$tip.label, dat$genus),] -> sortdat


par(family="Times", pointsize=9, mar=c(0,0,0,1.5))


# Plot the tree, with a notable label.offset so that we can fit in our grey-scale tip boxes
plot(gen, font = 1, label.offset = 10, x.lim=c(1.3,108), cex=1.22)

# Tip labels are the boxes displayed on the graph; these lines can be fiddled with to get intended results, pch changes shape of labels, either col (color) or cex (size) of tip labels can take inputs for each species (like col does in this code).  Offset adjustment (adj), can be used to made spacing look better.
tiplabels(pch = 15, col = grey(1-sortdat$para8), cex = 2.4, adj = 2.8)
tiplabels(pch = 15, col = grey(1-sortdat$cult8), cex = 2.4, adj = 6.9)

# This is the text above the greyscale boxes to differntiate between the two columns of tip labels; depending on the tree that you're plotting, you may have to adjust the x and y 
text(x=76.5, y=49.8, "PSR | BR", font=2, cex=1.22)
text("(b)", x=3, y=50.35, font=3, cex=1.22)

# The next three lines place taxonomic labels on branches leading to certain groups; srt command is string rotation, so srt=90 means rotate each of the labels by 90 degrees.
points(x=5, y=43, pch=46, cex=20, col='white')
points(x=38, y=25, pch=46, cex=20, col='white')
points(x=47, y=8, pch=46, cex=20, col='white')
points(x=47, y=13, pch=46, cex=20, col='white')
points(x=25, y=31, pch=46, cex=20, col='white')
text(x=5.1, y=43, "Strepsirhines", srt=90, font=2, cex=1.22)
text(x=38, y=25, "Platyrrhines", srt=90, font=2, cex=1.22)
text(x=47, y=6, "Cercopithecoids", srt=90, font=2, cex=1.22)
text(x=47, y=13, "Hominoids", srt=90, font=2, cex=1.22)
text(x=25, y=31, "Tarsiids", srt=90, font=2, cex=1.22)

dev.off()