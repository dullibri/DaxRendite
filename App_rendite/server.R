library(shiny)
library(dplyr)
library(png)
MAT=read.table('MAT.csv'
               ,stringsAsFactors = F
               ,sep=','
               ,header=T
)[,-c(1)]
img=readPNG('euro.png')
MAT[,1]=as.Date(MAT[,1],format='%Y-%m-%d')
library(png)
shinyServer(function(input, output) {
  output$distPlot2 <- renderPlot({
    x    <- MAT%>%filter(Horizont==input$months)#%>%select(Wert)
    aux.na=!is.na(x$Wert)
    total.nr=sum(aux.na)
    x$Entwicklung[aux.na]=x$Wert[aux.na]/x$Horizont[aux.na]-1
    perc=sum(x$Entwicklung<0,na.rm=T)/total.nr
    mean=mean(x$Wert,na.rm=T)/input$months
    test=0==sum((0>x$Wert/input$months-1),na.rm=T)
    if(test){maintxt="Kein einziger Anleger hat Geld verloren"}else{maintxt=''}
    
    plot(asp=1,NULL
         ,type='n'
         ,bty='n'
         ,ylab=''
         ,xlab=''
         ,xaxt='n'
         ,yaxt='n'
         # ,xlim=c(0,mean+1.8)
         # ,ylim=c(0,mean)
         ,xlim=c(0,7)
         ,ylim=c(0,4)
         ,main=maintxt)
    # text(7,1,paste(round(mean,2),'-fache Auszahlung'))
    rasterImage(img, -.5, 1, 0.5, 2,interpolate=F)
    a=mean^.5
    rasterImage(img, 1.5, 1, 1.5+a, 1+a)
    text(0,0,'1 Euro investiert')
    text(2.5,0,paste('wird zu ',round(mean,2),' Euro',sep=''))
    rect(5,1,6,4,col='green')
    rect(5,1,6,1+3*max(perc,0),col='red')#
    text(5.5,0,paste('Risiko einer neg. Rendite: ',round(max(perc*100,0),2),' %',sep=''))  })
})

# rsconnect::deployApp('C:/Users/dirk.ulbricht/Dropbox/Regelm‰ﬂige Anlage Capital/App_rendite')
