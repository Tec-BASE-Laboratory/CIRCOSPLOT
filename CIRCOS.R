#Instalación de librerías
packages <- c("circlize","colorspace")
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
#Selecciona la ruta al folder donde esten tus datos en formato BEDGRAPH (2 archivos mínimo).
setwd("~/Your/Path")
circo_initial <- read.table(file.choose(), header = FALSE)
circo_final <- read.table(file.choose(), header = FALSE)
colnames(circo_initial)<- c('chr','start','end','value')
colnames(circo_final)<- c('chr','start','end','value')
bed_list<- list(circo_initial,circo_final)

#Escoge la paleta de colores que te guste dependiendo de la cantidad de archivos que tengas. Se guarda el hexcode para posteriores consultas.
pal <- choose_palette()
mypal<- c(pal(2)) #en caso de tener mas archivos ajustar el numero a la cantidad que tengas.
write.table(mypal, file = "Hexcodes_circo.txt", sep = "\t",
            row.names = TRUE, col.names = "Códigos Hexadecimal")

#Creación del circosplot. Se pueden ajustar los parámetros dependiendo de los cromosomas, visualización,etc. Si se añaden más funciones, solo asegurarse de limpiar el circos (circos.clear()) y manter dev.off al último.
circos.clear()
png(filename = "TuNombreDelArchivo.png", width = 1280, height = 1001, res = 175)
circos.initializeWithIdeogram(chromosome.index = c("chr1", "chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10","chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19","chr20","chr21","chr22","chrX"))
circos.genomicRainfall(bed_list,ylim = c(-1,8), pch = 20, cex = 0.3, col = mypal) 
circos.genomicDensity(bed_list[[1]], col = mypal[1], track.height = 0.1)
circos.genomicDensity(bed_list[[2]], col = mypal[2], track.height = 0.1)
legend("bottomleft", pch = 20, legend = c('INDENTIFICADOR_1','IDENTIFICADOR_2'), col = mypal) 
dev.off()

