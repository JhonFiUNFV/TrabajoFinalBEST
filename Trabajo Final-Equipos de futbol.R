install.packages("rvest")
install.packages("RSelenium")
install.packages("robotstxt")
library(rvest)
library(RSelenium)
library(robotstxt)


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

table(cha$Equipo)

grafico1<-ggplot(cha, aes(x = Departamento, y = Puntos)) + 
  geom_line(aes(color = `Ciudad`), size = 1) +
  theme_minimal()
ggplotly(grafico1)

grafico1<-ggplot(data=cha, aes(x=Departamento, y=Puntos, fill=Ciudad)) + 
  geom_bar(stat="identity", position="dodge")
ggplotly(grafico1)







url <- "https://dechalaca.com/informes/estadisticas/tabla-acumulada-1966-2020"
valuation_col <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="main"]/div/div[4]/iframe')

valuation_data <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@class="data lastcolumn"]')



URL <- "https://dechalaca.com/informes/estadisticas/tabla-acumulada-1966-2020"


library(robotstxt)
paths_allowed("https://docs.google.com/spreadsheets/u/0/d/1wUo3SxGlQy9UYNUz3p1Q1H2xOofRnAFuNf86aqTeGKU/pub?amp;single=true&amp;gid=0&amp;range=A1:F118&amp;output=html")
