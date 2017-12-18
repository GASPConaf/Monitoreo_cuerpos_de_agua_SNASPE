#  Monitoreo de cuerpos de agua en el Sistema Nacional de Áreas Silvestres Protegidas (SNASPE)
>*Autores: Ignacio Díaz Hormazábal y Diego Valencia D.*  
*Versión: v.1*   
*Fecha: octubre 2017*

El presente código R permite el reporte de resultados del monitoreo de cuerpos de Agua. Esta primera versión genera un gráfico que resume el cambio temporal en extensión del cuerpos de agua como se muestra a continuación:


![alt text](https://github.com/GapConaf/Monitoreo_cuerpos_de_agua/blob/master/Imagen1.png "Logo Title Text 1")

El código esta enlazado a la base de datos actualizada para cada uno de los cuerpos de agua dentro de SNASPE, por ahora la busqueda particular no es intuitiva, sin embargo, se esta trabajando en una versión interactiva con busqueda por región y unidad.  

Para seleccionar un cuerpo de agua primero 

**Codigo de regiones**

+ 0_Arica
+ 1_Tarapaca
+ 2_Antofagasta
+ 3_Atacama
+ 5_Valparaiso
+ 6_Ohiggins
+ 7_Maule
+ 8_Biobio
+ 9_Araucania
+ 14_LosRios
+ 10_LosLagos
+ 11_Aysen
+ 12_Magallanes

Por ejemplo:  
~~~
region<-"0_Arica" 
~~~
