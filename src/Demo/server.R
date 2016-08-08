#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

 library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   observeEvent(input$action,{
  output$text1 <- renderTable({Search(input$query)}) 
   })
  
})

setwd("C:/Users/Moawd/OneDrive/Documents/Data")
install.packages("readxl")
library(readxl)
install.packages("stringr")
library(stringr)

##### 07/31 for real data
try_1 <-  read_excel("Search Functionality.xlsx")#,header = TRUE,sep=",")
head(try_1)

### not grep
Search<-function(keyword){
  re_name<- (str_extract(try_1[,2], "\\D[aA-zZ aA-zZ]+"))
  key<- toupper(unlist(strsplit(keyword, " ")))
  # key_use<-paste(key,collapse="|")
  index_1<-rep(FALSE, nrow(try_1))
  rel_point<-rep(0, nrow(try_1))
  for (i in 1:nrow(try_1)) {
    table_index<- toupper(c(unlist(strsplit(as.character(re_name[i]), " ")),as.character(unlist(strsplit(as.character(try_1[i,5]), "\\, |\\,| ")))))
    if (sum(table_index %in% key) > 0) {
      index_1[i]<-TRUE
      rel_point[i]<-sum(table_index %in% key)*20+(sum(table_index %in% key)/length(unlist(strsplit(as.character(re_name[i]), " "))))*30
      if(table_index[1] %in% key){
        rel_point[i]<-rel_point[i]+10
      }
    }
    if (length(key)==1 & !is.na(grep(key,table_index)[1])){
      index_1[i]<-TRUE
      rel_point[i]<-length(grep(key,table_index))
      if (length(key)==length(unlist(strsplit(as.character(re_name[i]), " ")))){
        rel_point[i]<-rel_point[i]+20
      }
      if (grep(key,table_index)[1]==1 ){
        rel_point[i]<-rel_point[i]+10
      }
    } else{
      for (j in 1:length(key)) {
        if (sum(grep(key[j],table_index)) > 0) {
          index_1[i]<-TRUE
          rel_point[i]<-rel_point[i]+(length(grep(key[j],table_index))/length(unlist(strsplit(as.character(re_name[i]), " "))))*30
        }
        if(table_index[1] %in% key[j]){
          rel_point[i]<-rel_point[i]+10
        }
      }
    }
  }
  num<-sum(index_1)
  result_or<-order(rel_point,decreasing=TRUE)
  return(head(try_1[result_or,][c(2,4)],num))
}

