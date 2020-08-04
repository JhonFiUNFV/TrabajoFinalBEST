install.packages("rvest")
install.packages("RSelenium")
install.packages("robotstxt")
install.packages("ggplot2")
install.packages("sf")
install.packages("rgdal")
install.packages("RColorBrewer")
install.packages("classInt")
install.packages("sp")
library(sp)
library(rgdal)
library(RColorBrewer)
library(classInt)
library(sf)
library(ggplot2)
library(rvest)
library(RSelenium)
library(robotstxt)
library(readxl)
library(dplyr)
library(tidyr)

############################################################################################
url.chalaca<-"https://docs.google.com/spreadsheets/u/0/d/1wUo3SxGlQy9UYNUz3p1Q1H2xOofRnAFuNf86aqTeGKU/pub?amp;single=true&amp;gid=0&amp;range=A1:F118&amp;output=html"
trs <- read_html(url.chalaca)
trs <- html_nodes(trs, "table")

length(trs)
sapply(trs, class)
sapply(trs, function(x) dim(html_table(x, fill = TRUE)))
cha <- html_table(trs[[1]])
cha <-cha[-1,]
names(cha) <- c("n","Posición","Equipo","Ciudad","Departamento","Puntos","Temporadas")
cha <-cha[-1,]
cha$n <- NULL
cha$Posición=as.numeric(cha$Posición)
cha$Puntos=as.numeric(cha$Puntos)
sapply(cha, class)


table(cha$Departamento)




###################### usando dplyr

# El maximo puntaje de un equipo dentro de un departamento
cha %>%# la BD!
  group_by(Departamento) %>% # agrupala segun...
  summarise(max=max(`Puntos`))%>%# crea una nueva variable
  arrange(desc(max))%>% # reordenala de mayor a menor
  View() # mira la data

# El minimo puntaje de un equipo dentro de un departamento
cha %>%# la BD!
  group_by(Departamento) %>% 
  summarise(min=min(`Puntos`))%>%
  arrange(desc(min))%>%
  View() 

# Numero de equipos profesionales por departamento
cha %>%
  group_by(`Departamento`) %>% 
  summarise(numero=n())%>%
  arrange(desc(numero))%>% 
  View() # mira la data

# Equipos del LIMA Y CALLAO que participaron en el Campeonato Profesional
cha %>%
  filter(`Departamento` %in% c("Lima","Callao") ) %>% 
  group_by(`Departamento`,Equipo, Ciudad) %>% 
  View() # mira la data

# Equipos del CENTRO DEL PERÚ que participaron en el Campeonato Profesional
cha %>%
  filter(`Departamento` %in% c("Ayacucho","Junín","Huánuco","Pasco") ) %>% 
  group_by(`Departamento`,Equipo, Ciudad) %>% 
  View() # mira la data

# Equipos del NORTE DEL PERÚ que participaron en el Campeonato Profesional
cha %>%
  filter(`Departamento` %in% c("Piura","Áncash","La Libertad","Lambayeque","Tumbes","Cajamarca") ) %>% 
  group_by(`Departamento`,Equipo, Ciudad) %>% 
  View() # mira la data

# Equipos del SUR DEL PERÚ que participaron en el Campeonato Profesional
cha %>%
  filter(`Departamento` %in% c("Cusco","Ica","Puno","Tacna","Arequipa") ) %>% 
  group_by(`Departamento`,Equipo, Ciudad) %>% 
  View() # mira la data

# Equipos del ORIENTE que participaron en el Campeonato Profesional
cha %>%
  filter(`Departamento` %in% c("Loreto","San Martín","Ucayali") ) %>% 
  group_by(`Departamento`,Equipo, Ciudad) %>% 
  View() # mira la data


##########################################################crear mapa
dirmapas <- "D:/ECONOMÍA UNFV/IEL/TrabajoFinalBEST"
col<- readOGR(file.choose())
col
plot(col)
box()
col$data

#############################################################

grafico1<-ggplot(cha, aes(x = Departamento, y = Puntos)) + 
  geom_line(aes(color = `Ciudad`), size = 1) +
  theme_minimal()
ggplotly(grafico1)



grafico1<-ggplot(data=cha, aes(x=Departamento, y=Puntos, fill=Ciudad)) + 
  geom_bar(stat="identity", position="dodge")
ggplotly(grafico1)







