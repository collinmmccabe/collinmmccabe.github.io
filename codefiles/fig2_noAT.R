mutex<-read.csv("mutex_betas_noAT.csv")
clcu<-mutex$close_cur
clst<-mutex$close_soct
nccu<-mutex$nonc_cur
ncst<-mutex$nonc_soct
cc<-hist(clcu,breaks=100)
cs<-hist(clst,breaks=100)
nc<-hist(nccu,breaks=100)
ns<-hist(ncst,breaks=100)

pdf(file="fig2_rev2.pdf", width=3.3, height=3.3, fonts="Times", pointsize=9)

mat <- matrix(c(5,6,0,1,3,7,2,4,8), 3)
layout(mat, c(1,3,3), c(4.5,4.5,1))
par(family="Times", ps=9)

#
par(mar=c(2,2,1,1))
plot(cs, ylim=c(0, max(cs$counts)), col=(c(rep('indianred1', sum(cs$mids<0)),rep('darkblue', sum(cs$mids>0)))), border=(c(rep('indianred1', sum(cs$mids<0)),rep('darkblue', sum(cs$mids>0)))), xlim=range(min(cs$breaks), max(cs$breaks)), main="", xlab="", xaxt="n", yaxt="n")
axis(2, cex.axis=1.35)
axis(1, cex.axis=1.35)
abline(v=0, lty=2)
text(0.36,600, family="Times", font=2, cex=1.5, col='darkblue', "98.0%")
#
par(mar=c(2,2,1,1))
plot(cc, ylim=c(0, max(cc$counts)), col=(c(rep('indianred1', sum(cc$mids<0)),rep('darkblue', sum(cc$mids>0)))), border=(c(rep('indianred1', sum(cc$mids<0)),rep('darkblue', sum(cc$mids>0)))), xlim=range(min(cc$breaks), max(cc$breaks)), main="", ylab="", xlab="", xaxt="n", yaxt="n")
axis(2, cex.axis=1.35)
axis(1, cex.axis=1.35)
abline(v=0, lty=2)
text(0.185,1400, family="Times", font=2, cex=1.5, col='darkblue', "36.5%")
#
par(mar=c(2,2,1,1))
plot(ns, ylim=c(0, max(ns$counts)), col=(c(rep('indianred1', sum(ns$mids<0)),rep('darkblue', sum(ns$mids>0)))), border=(c(rep('indianred1', sum(ns$mids<0)),rep('darkblue', sum(ns$mids>0)))), xlim=range(min(ns$breaks), max(ns$breaks)), main="", xlab="Social Transmission", xaxt="n", yaxt="n")
axis(2, cex.axis=1.35)
axis(1, cex.axis=1.35)
abline(v=0, lty=2)
text(0.36,750, family="Times", font=2, cex=1.5, col='darkblue', "65.5%")
#
par(mar=c(2,2,1,1))

# ylim max is set to the max count for the bins - col is color of bars, border is color of border around bars (2 is red, 4 is blue) - number of bins to color is determined by counting number of bin greater or less than 0 {sum(nc$mids<|>0)} - xlim range is set by determining the min and max of the values in the distribution
plot(nc, ylim=c(0,max(nc$counts)), col=(c(rep('indianred1',sum(nc$mids<0)),rep('darkblue',sum(nc$mids>0)))), border=(c(rep('indianred1',sum(nc$mids<0)),rep('darkblue',sum(nc$mids>0)))), xlim=range(min(nc$breaks),max(nc$breaks)), main="", ylab="", xlab="Exploration", xaxt="n", yaxt="n")
axis(2, cex.axis=1.35)
axis(1, cex.axis=1.35)   

# this code makes the dotted vertical line
abline(v=0, lty=2)

text(0.38,900, family="Times", font=2, cex=1.5, col='darkblue', "92.9%")

par(mar=c(0,0,0,0))

plot.new()
text(0.25,0.5,"Socially Contagious\nParasites", srt=90, font=2, cex=1.35)
text(0.85,0.5,"Frequency", srt=90, cex=1.35)

plot.new()
text(0.25,0.5,"Environmentally Transmitted\nParasites", srt=90, font=2, cex=1.35)
text(0.85,0.5,"Frequency", srt=90, cex=1.35)

plot.new()
text(0.5,0.25,"Social Transmission", font=2, cex=1.35)
text(0.5,0.85,"Correlation Coefficient", cex=1.35)

plot.new()
text(0.5,0.25,"Exploration", font=2, cex=1.35)
text(0.5,0.85,"Correlation Coefficient", cex=1.35)

dev.off()