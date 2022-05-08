source("rfunctions.R")
par(bg = "#f7f7f7")
library('latex2exp')

nameOutPoints="snapshots/v97doseMF/run1/tmp"
for(i in 1:251)
{
	snapshot=i
	if(i<10)
	{
		filename=paste0(nameOutPoints,"00000",snapshot)
	}
	else if(i<100)
	{
		filename=paste0(nameOutPoints,"0000",snapshot)
	}
	else
	{
		filename=paste0(nameOutPoints,"000",snapshot)
	}

	imgfilename=paste0(filename,".jpeg")
	#print(imgfilename)

	table=read.table(filename)
	coord=cbind(table$V2,table$V3)
	species=table$V1
	require(grDevices)
	jpeg(paste0(imgfilename), width = 3, height = 3, units = 'in', res = 300)
	plot.points(coord,species,spch=c(20,20,21),scol=c("red","green","blue"),bg="green",scex=c(0.1,0.1,0.1),
			xlab="x1",ylab="x2",xlim=c(0,1000),ylim=c(0,1000),fg='black', col.axis='black', 
			col.lab='black', col.main='black', col.sub='black')
	dev.off()

}

#Parameters spch, scol, and scex can be defined in both functions to control the symbol type, color, and size of the point of each species
# fg is boxcolor (axis)
#plot.points(coord,species, spch=c(20,20,19,19),scol=c(rgb(0,0,0,alpha=1),rgb(1,0,0,alpha=1),"green","blue"),scex=c(0.1,0.1,0.1,0.1),xlab="x1",ylab="x2",xlim=c(0,30),ylim=c(0,30))
