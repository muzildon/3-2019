library('shiny')       # загрузка пакетов
library('data.table')

df <- data.table(read.csv('data_movies_2018.csv', 
                          stringsAsFactors = F))

# размещение всех объектов на странице
shinyUI(
    # создать страницу с боковой панелью
    # и главной областью для отчётов
    pageWithSidebar(
        # название приложения:
        headerPanel('Бюджет фильмов за 2018 год на портале kinopoisk'),
        # боковая панель:
        sidebarPanel(
            sliderInput('Rating.range', 'Оценка IMDB:',
                        min = min(df$IMDb.mark), max = max(df$IMDb.mark), value = c(min(df$IMDb.mark), max(df$IMDb.mark))),
            
            sliderInput('Time.range', 'Продолжительность:',
                        min = min(df$Time), max = max(df$Time), value = c(min(df$Time), max(df$Time))),
            sliderInput(               # слайдер: кол-во интервалов гистограммы
              'int.hist',                       # связанная переменная
              'Количество интервалов гистограммы:', # подпись
              min = 2, max = 10,                    # мин и макс
              value = floor(1 + log(50, base = 2)), # базовое значение
              step = 1)                             # шаг
        ),
        # главная область
        mainPanel(
            # текстовый объект для отображения
            textOutput('text1'),
            textOutput('text2'),
            textOutput('text3'),
            textOutput('text4'),
            # гистограммы переменных
            plotOutput('hist')
            )
        )
    )