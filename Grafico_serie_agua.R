####################################################################
######   Grafica de tendecia temporal espejos de agua SNASPE #######
####################################################################

## Autor: Ignacio Diaz-Hormazabal.
## Fecha: octubre 2017.
## Fuente cuerpos de agua: Global Surface Water Mapping Layers v1 (GSW).Pekel et al. 2016.
## Fuente precipitacion: Producto CHIRPS v.2. del Climate Hazards Group (CHG).
## No requiere librerias adicionales.


## Codigo de regiones

# 0_Arica
# 1_Tarapaca
# 2_Antofagasta
# 3_Atacama
# 5_Valparaiso
# 6_Ohiggins
# 7_Maule
# 8_Biobio
# 9_Araucania
# 14_LosRios
# 10_LosLagos
# 11_Aysen
# 12_Magallanes

##################################
######### Indicar region #########

region<-"0_Arica" 


### Setear espacio de trabajo
mypath <-paste("C:/Data/",region,sep="")
namereg<-gsub('.*_(.*)/','\\1',mypath)
setwd(mypath)
table <- list.files(path=mypath, pattern=glob2rx("l*.csv"), full.names=T)
name1<-gsub('.*/(.*)','\\1',table)
name2<-gsub('.*_(.*).csv','\\1',name1)


############################################################################
######### Indicar numero correlativo del espejo de agua ####################

### para consultar nombre de laguna escribir en consola: table

laguna<-1  

## leer datos
mydata<-read.table(name1[laguna],sep=',',dec=".",header=T,colClasses = c("character"))
mydata$year<-as.numeric(as.character(substr(mydata$system.time_start,8,63)))
mydata$AreaWater<-gsub(",","",mydata$AreaWater)
mydata$AreaWater<-as.numeric(as.character(mydata$AreaWater))
mydata2<-subset(mydata,mydata$AreaWater>0)
ye<-unique(mydata2$year)
dataFin<-NULL

## Calcular estadisticas
for(i in ye){
  x1<-subset(mydata2,mydata2$year==i)
  maximo<-max(x1$AreaWater)
  media<-mean(x1$AreaWater)
  desvi<-sd(x1$AreaWater)
  N<-sqrt(dim(x1)[1])
  error<-desvi/N
  union<-cbind(ano=i,maximo,media,error)
  dataFin<-as.data.frame(rbind(dataFin,union))
}

dataFin$ano<-as.numeric(as.character(dataFin$ano))
dataFin$maximo<-as.numeric(as.character(dataFin$maximo))
dataFin$media<-as.numeric(as.character(dataFin$media))
dataFin$error<-as.numeric(as.character(dataFin$error))


## Formula para transformar primera letra en mayuscula
scap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}


## Grafica de tendencia de cuerpo de agua

par(mfrow=c(1,1), mar=c(4,5,2,4.9))
par(las=2)
plot(dataFin$ano,dataFin$media*0.01,type="l",col="blue",lty=1,
     xlab="",ylab=expression("Área  km" ^2),lwd=2,xaxt="n",
     xlim=c(min(dataFin$ano),max(dataFin$ano)),ylim=c(0,max(dataFin$maximo*0.01)),
     col.ticks ="black",col.axis ="black",cex.axis=0.8,cex.lab=1,col.lab ="black",
     main=paste("Laguna ",scap(name2[laguna]),sep=""))

axis(1, at = seq(min(dataFin$ano), max(dataFin$ano), by = 1), las=2, cex.axis=0.8)

cord.x<-c(dataFin$ano,rev(dataFin$ano))
cord.y<-c(dataFin$media*0.01 + dataFin$error*0.01,rev(dataFin$media*0.01 - dataFin$error*0.01))
polygon(cord.x,cord.y,col='lightblue1',border=NA)

lines(dataFin$ano,dataFin$media*0.01,type="l",col="dodgerblue",lty=1,ylim=c(0,max(dataFin$maximo*0.01)),
      xlab="",ylab="",lwd=2,xaxt="n",xlim=c(min(dataFin$ano),max(dataFin$ano)))

## Opcional para agregar linea del area maxima

#lines(dataFin$ano,dataFin$maximo*0.01,type="l",col="lightblue",lty=1,ylim=c(0,max(dataFin$maximo*0.01)),
#    xlab="",ylab="",lwd=2,xaxt="n",xlim=c(min(dataFin$ano),max(dataFin$ano)))


## Agregar tendencia de precipitacion anual

pp<- list.files(path=mypath, pattern=glob2rx("pp_*.csv"), full.names=T)
name_pp<-gsub('.*/(.*)','\\1',pp)
setwd(mypath)
pp<-read.table(name_pp,sep=',',dec=".",header=T)
pp$year<-gsub(",","",pp$year)
pp$year<-as.numeric(as.character(pp$year))
pp$clip<-gsub(",","",pp$clip)
pp$clip<-as.numeric(as.character(pp$clip))

## Calcular estadisticas
mean_pp<-mean(pp$clip)
pp$anom<-(pp$clip-mean_pp)
pp$cum<-cumsum(pp$anom)
varline<-pp$clip

## Graficar precipitacion
par(new = T)
plot(varline,type="l",col="blue",lty=2,lwd=1, axes=F, xlab=NA, ylab=NA,ylim=c(0,max(pp$clip)*1.2))
axis(side = 4,col.ticks ="dodgerblue4",col.axis ="dodgerblue4",cex.axis=0.8)

text(par("usr")[2] + 3.6, min(pp$clip)*0.7, srt=90, adj = 0, 
     labels = "Precipitación anual (mm)", xpd = TRUE,col="dodgerblue4")

legend("topright",legend=paste(round(mean_pp,2),"mm/año"),bty="n",cex=0.8)

legend("bottomleft",cex = 0.8,lty=c(1,1,2),lwd=c(2,6,1),col=c("dodgerblue","lightblue1","blue"), 
   legend=c("Área cuerpos de agua","Error estándar","Precipitación anual (mm)"))
