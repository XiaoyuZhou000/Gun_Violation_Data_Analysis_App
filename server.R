library(ggplot2)
library(plotly)
library(bslib)
library(dplyr)
library(sf)
library(tmap)
library(tmaptools)
library(leaflet)
library(shiny)
library(bslib)
library(DT)
library(maps)

# Data source: https://www.gunviolencearchive.org/children-killed

# Load Data

children_killed <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-BE2/main/children_killed_2.csv?token=GHSAT0AAAAAABQI6W57NIK3724TAQ4OGQUOYRLY3HQ")

tab_2_option <- c('Killed', 'Injured')

# Data Calculation

as.Date(children_killed$Date)

sum_year <- children_killed %>% 
  mutate(year = str_sub(Date, 0, 4)) %>% 
  group_by(year, State)

# Server function

server <- function(input, output) {
  
  url <- a("Children Killed Dataset", href="https://www.gunviolencearchive.org/children-killed")
  
  # Tab 1 
  
  output$Plot1 <- renderPlotly({
    
    # filter specific data
    
    sum_year <- sum_year %>% 
      mutate(annual_kill = sum(Killed)) %>% 
      filter(State %in% input$inputplot1)
    
    # The Plot
    
    plot_1 <- ggplot(data = sum_year) +
      geom_line(mapping = aes(x = year, y = annual_kill, color = State, group = 1))+
      geom_point(mapping = aes(x = year, y = annual_kill, color = State, text = paste0('State: ', State, '\n', 'Year: ', year,'\n', 'Children killed annually: ', annual_kill, ' children')), size = 0.5)+
      labs(title = 'Annually Death for Each State 2014-2021', x = 'Year', y = 'Annually Children killed ')+
      scale_colour_discrete("State")
      
    # Plotly the Plot 1
      
    my_plotly_plot_1 <- ggplotly(plot_1, tooltip = c('text'))
    
    return(my_plotly_plot_1)
    
  })


  # Tab 2
  
  state_shape <- map_data("state")

  killed_group <- children_killed %>%
    group_by(State) %>%
    summarise(Children_killed = sum(Killed), Children_injured = sum(Injured)) %>%
    rename(region=State) 
  
  killed_group$region = tolower(killed_group$region)
  
  killed_map <- left_join(state_shape, killed_group, by="region")
  
  killed_map <- killed_map %>% 
    rename('Killed' = Children_killed, 'Injured' = Children_injured)
  
  tab_2_option <- c('Killed', 'Injured')
  
  blank_theme <- theme_bw() +
    theme(
      axis.line = element_blank(),        
      axis.text = element_blank(),        
      axis.ticks = element_blank(),  
      axis.title = element_blank(),    
      plot.background = element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      panel.border = element_blank()    
    )
  
  #Plot 
  
  output$Plot2 <- renderPlotly({
    req()
    
    tab_2_option <- c('Killed', 'Injured')
    
    plot_2 <- ggplot(killed_map, aes(x=long, y=lat, group=group))+
      geom_polygon(aes_string(fill=input$sel_item), color="white")+
      scale_fill_viridis_c(option='C')+
      scale_colour_discrete(paste0('Children ', input$sel_item))+
      labs(title = 'Distribution Map of Children Killed/Injured (US)')+
      blank_theme
  
  my_plotly_plot_2 <- ggplotly(plot_2)
  
  return(my_plotly_plot_2)
  
  })
  
  # Tab 3
  
  output$Plot3 <- renderPlotly({
    
    # filter specific data
    
    dates <- children_killed$Date
    children_killed <- mutate(children_killed, "Year"=str_sub(dates, 0, 4))
    children_killed_by_year <- children_killed %>% 
      group_by(Year) %>% 
      summarize(death_in_a_year_grey=sum(Killed))
    children_killed_by_year <- children_killed_by_year %>% 
      mutate(growth=death_in_a_year_grey-lag(death_in_a_year_grey)) %>% 
      mutate(rate_pct=(growth/((death_in_a_year_grey-growth))*100))
    
    children_killed_by_year_2014_2021 <- children_killed_by_year %>% 
      filter(((Year>=input$start_year[1])&(Year<=input$start_year[2])))
    
    
    
    # The Plot
    
    plot_3 <- ggplot(data=children_killed_by_year_2014_2021, aes(x=Year))  + 
      geom_col(mapping = aes(y=death_in_a_year_grey, text = paste0('Year: ', Year, '\n', 'Annual Death: ', death_in_a_year_grey)), fill="grey")  + 
      geom_point(mapping=aes(y = rate_pct*10, text = paste0('Year: ', Year, '\n', 'Growth Rate: ', round(rate_pct, digits = 3), '%')), colour = "Red")  + 
      geom_line(mapping = aes(x=Year, y=rate_pct*10, group=1), color="blue") + 
      scale_y_continuous(sec.axis = sec_axis(~.*0.1, name = "Annual death rate (Blue) (%)")) + 
      labs(title='Annual death and death rate vs. Year', y="Annual Death (%)")
      
      # Plotly the Plot 3
      
      my_plotly_plot_3 <- ggplotly(plot_3, tooltip = c('text'))
    
    return(my_plotly_plot_3)
    
  })
}
