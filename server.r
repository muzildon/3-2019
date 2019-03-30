library('shiny')       # загрузка пакетов
library('lattice')
library('plyr')
library('data.table')

df <- data.table(read.csv('data_movies_2018.csv', 
                          stringsAsFactors = F))
shinyServer(function(input, output) {
    output$text1 <- renderText({
      paste0('Вы выбрали оценку IMDB с ',
             input$Rating.range[1], ' по ', input$Rating.range[2]
             )
    })
    output$text2 <- renderText({
      paste0('Вы выбрали продолжительность с ',
             input$Time.range[1], ' по ', input$Time.range[2]
             )
    })
    output$text3 <- renderText({
      paste0('Всего фильмов - ', nrow(df)
      )
    })
    # строим гистограммы переменных
    output$hist <- renderPlot({
        # сначала фильтруем данные
        DF <- df[between(df$IMDb.mark, input$Rating.range[1], input$Rating.range[2])]
        DF <- DF[between(DF$Time, input$Time.range[1], input$Time.range[2])]
        
    output$text4 <- renderText({
      paste0('Отобранных фильмов - ', nrow(DF)
             )
      })

        # затем строим график
        histogram( ~ Cost, 
                   data = DF,
                   xlab = '',
                  breaks = seq(min(DF$Cost), max(DF$Cost), 
                               length = input$int.hist + 1)
                   )
    })
})
