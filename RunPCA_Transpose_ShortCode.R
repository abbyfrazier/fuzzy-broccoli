#EOF analysis on raster data

rm(list=ls())


island_list<-c("ka_","oa_","ma_","bi_")
seas_list<-c("djf_","mam_","jja_","son_")


for (i in 1:4) {
  isl<-island_list[i]
  
  setwd("C:/Work/AbbyF/Oliver/raster_txtfiles/")
  coords<-read.table(paste(isl,"coords.txt",sep=""), header=T)
  
  for (j in 1:4) {
    seas<-seas_list[j]
    
    setwd("C:/Work/AbbyF/Oliver/raster_txtfiles/")
    rasters<-read.table(paste(isl,seas,"rasters_all.txt",sep=""),header=T)
    rasterT<-t(rasters)
    raster.pr<-prcomp(rasterT,center=T,scale=T)
    
    setwd("C:/Work/AbbyF/Oliver/PC_outputs_R_T/")
    prmatrix <- rasterT%*%raster.pr$rotation
    spatial<-data.frame(cbind(coords,raster.pr$rotation))
    #rotation is now spatial series - tack on coordinates so this file can be mapped...testing
    
    write.table(prmatrix, file = paste(isl,seas,"timeseries.csv",sep=""), sep = ",")
    write.table(spatial[,1:12], file = paste(isl,seas,"spatial_pr.csv",sep=""), sep = ",", col.names = T,row.names=F)
    write.table(raster.pr$sdev, file = paste(isl,seas,"sdev_pr.csv",sep=""), sep = ",")

  }
  
}


