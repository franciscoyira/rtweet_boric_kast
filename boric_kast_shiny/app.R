library(shiny)
library(plotly)

ui <- fluidPage(
  # selectizeInput(
  #   inputId = "cities", 
  #   label = "Select a city", 
  #   choices = unique(txhousing$city), 
  #   selected = "Abilene",
  #   multiple = TRUE
  # ),
  plotlyOutput(outputId = "p")
)

server <- function(input, output, session, ...) {
  
  output$p <- renderPlotly({
    tweets_for_plot2 <- readr::read_rds(
      here::here("cache", "tweets_for_plot2.rds")
    )
    
    height <- session$clientData$output_p_height
    width <- session$clientData$output_p_width
    
    plot_ly(
      data = tweets_for_plot2,
      x = ~engagement_count,
      y = ~rank_engagement,
      text = ~abs(engagement_count),
      type = 'bar',
      color = ~screen_name,
      colors = c("red", "blue"),
      orientation = 'h',
      height = height, 
      width = width,
      hovertemplate = paste0(
        "<b>%{text:,.0f}</b> likes and RTs | ",
        format(tweets_for_plot2$created_at, "%b %d"),
        " | @",
        tweets_for_plot2$screen_name,
        "<br><br>",
        str_wrap(tweets_for_plot2$text),
        "<extra></extra>"
      )
    ) %>% 
      layout(barmode = 'overlay',
             title = "Most popular tweets by Chilean presidential candidates",
             yaxis = list(title = "Ranking",
                          autorange="reversed",
                          showgrid=T,
                          autotick = F, tickmode = "array", tickvals = 1:10),
             xaxis = list(title = "Engagement (RTs + Likes)",
                          tickmode = 'array',
                          tickvals = breaks_values_eng,
                          ticktext = labels_k),
             legend = list(title=list(text='<b>Candidate</b>'),
                           orientation = "h",   # show entries horizontally
                           xanchor = "center",  # use center of legend as anchor
                           x = 0.5,
                           y=-0.2),
             hovermode = "closest",
             hoverlabel = list(bgcolor = "#DFDFDF", bordercolor = "black")
      )
  })
}

shinyApp(ui, server)
