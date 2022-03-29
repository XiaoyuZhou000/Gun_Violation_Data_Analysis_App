# Load packages

library(dplyr)
library(stringr)
library(ggplot2)
library(tidyverse)
library(scales)
library(plotly)
library(ggcharts)
library(bslib)
library(colourpicker)
library(sf)
library(tmap)
library(tmaptools)
library(leaflet)
library(DT)
library(maps)


# source any data from `server.R`

source('server.R')

# Any changes to the dataset


# Intro Tab

intro_tab <- tabPanel(
  'Introduction',
  fluidPage(
    
      tags$h1(class = 'h1', 'Go Go (Go Over, Guns Over)'),
      
      tags$hr(),
      
      tags$h2(class = 'h2', 'Purpose'),
      
      tags$p(class = 'p', 'We would like to focus on the phenomenon of gun violence happening to children in America and analyze the data to discover the cause and effect of gun violence happening to the children.'),
    
      tags$hr(),
    
      tags$h2(class = 'h2', 'Methods'),
    
      tags$p(class = 'p', 'In this project, we used the data that was gathered by the', strong('Gun Violence Archive'), tagList("(Dataset URL: ", url, ')'), 'It is collected using incidents provided by law enforcements, news media, and governments. We are asking important questions such as how has gun violence affected children\'s lives across the United states? What are the trends of gun violence to children across America, and how does the number of children died and injured due to gun violence vary from state to state.'),
    
      tags$br(),
      
      tags$p(class = 'p','Therefore, in this project, we are using these data to understand how gun violence affects children varies from state to state, the annual number of children died in gun violence vs the death rate of children deceased from gun violence from year to year, and number of children died due to gun violences in different states on the United States map.'),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Implication and Limitations'),
    
    tags$p(class = 'p', 'It is important to note that this data is collected using what is reported and accessible to the collector, it is possible for it to have missing datas, inconsistencies, and not all gun violences to children are being recorded and televised.'),
    
    tags$p(class = 'p',' A serious question worth considering when going through our project is that this is all real cases that happened to real people and families, there could only be more but no less children death due to gun violence, what does this mean? These are all implications and limitations that needs to be keep in mind when viewing our project.'),
  
    tags$img(src = 'https://raw.githubusercontent.com/info-201b-wi22/final-project-BE2/main/Introduction.jpeg?token=GHSAT0AAAAAABQI6W56ILITGKETKMPVGPXUYRSSQRQ', width = 1300, hight = 800)
))

# Plot Tab 1

plot_sidebar_1 <- sidebarPanel(
  
  selectInput(
    inputId = "inputplot1",
    label = 'Select State(s)',
    choices = sum_year$State,
    selected = "Washington",
    multiple = TRUE)
  
)

plot_main_1 <- mainPanel(
  plotlyOutput(outputId = 'Plot1')
)

plot_tab_1 <- tabPanel(
  'Annual Death',
  fluidPage(
    
            tags$h1(class = 'h1', 'How many children has been killed ...'),
            
            tags$hr(),
            
            tags$br(),
            
            sidebarLayout(
              plot_sidebar_1,
              plot_main_1),
            
            tags$hr(),
  
            tags$h2(class = 'h2', 'Chart Insight'),
  
            tags$ul( class = 'p',
              tags$li("Annual variation from state to state is not significant and the data is relatively balanced."), 
              tags$li("It is clear that some states have much higher numbers than others, such as Florida, Texas, and California."), 
              tags$li("Some states have not had a year (in years) without a child being killed in a shooting. Like Hawaii, Wyoming, Vermont, Delaware, etc."),
              tags$li('Moststates have annual figures that mean that shootings continue to threaten children lives to some degree.')
            ),
  
            tags$hr(),
  
            tags$h2(class = 'h2', 'Chart Purpose'),
                    
            tags$p(class = 'p', 'By aggregating the state-level data of the gun violence and sorted it by year, we can analyze the changes (increase and decreases) of gun violence throughout those years and see the trend clearly by showing the line. This allows us to identify the key state that having more incidents than others, as well as the trends of incidents across the state, which allows us to explore more deeply on what factors bringing these kind of result.')
            
  )
)

# Plot Tab 2

plot_sidebar_2 <- sidebarPanel(
  
  selectInput(inputId = "sel_item",
              label = "Choose to plot",
              choices = tab_2_option,
              selected = ''
)
)
  
plot_main_2 <- mainPanel(
  plotlyOutput(outputId = 'Plot2')
)

plot_tab_2 <- tabPanel(
  'Map',
  fluidPage(
    
    
    tags$h1(class = 'h1', 'Where are those children getting hurt ...'),
    
    tags$hr(),
    
    tags$br(),
    
            sidebarLayout(
              plot_sidebar_2,
              plot_main_2),
    
    tags$hr(),
            
  tags$h2(class = 'h2', 'Chart Purpose'),

  tags$p(class = 'p', 'We came up with the amount of total death by combining the number of children killed by gun violence across the United States from 2014 to 2021. By comparing the color in each state and the region, we want to analyiz whether the gun shooting issue was based on the region, or was based on the law of each state that whether carrying a gun with you is legal or illegal.')
  )
)

# Plot Tab 3

plot_sidebar_3 <- sidebarPanel(
  
  sliderInput(
    inputId="start_year", 
    label = "Year Range (from to end):", 
    min=2014, 
    value=c(2015,2018), 
    max=2021
    )
  
)

plot_main_3 <- mainPanel(
  plotlyOutput(outputId = 'Plot3')
)

plot_tab_3 <- tabPanel(
  'Death Rate',
  fluidPage(
    
    tags$h1(class = 'h1', 'Is it out of control ...'),
    
    tags$hr(),
    
            sidebarLayout(
              plot_sidebar_3,
              plot_main_3),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Chart Purpose'),
    
    tags$p(class = 'p','We came up with the amount of annual death by combining the number of children killed by gun violence across the United States from 2014 to 2021. By comparing the number of deaths with the previous year, we get the growth rate. Analyzing child deaths over time allows us to explore whether child violence increases over time. We can also delve into the causes of the ups and downs in growth rates.')
            
  )
)

# Conclusion Tab

sum_tab <- tabPanel(
  'Conclusion',
  fluidPage(
    
    tags$h1(class = 'h1', 'What We Learn From It...'),
    
    tags$hr(),
    
    tags$p(class = 'p', "Data can be clearly conveyed with a short graph that encapsulates all the information when data visualization tools is used for reporting. This makes the relationships in the data easier to understand, and is also more effective than using confusing reports or spreadsheets. By choosing different widgets, we can also see clearer comparisons and get a more complete view of the data within a short period of time."),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Chart 1 Insight'),
    
    tags$br(),

    tags$p(class = 'p', 'The first plot illustrates the number of children killed by gun violence in each state each year. By aggregating the state-level data on gun violence and sorting it by year, we can analyze the changes (increase and decreases) of gun violence throughout those years and see the trend, demonstrating by the line. This enables us to identify the key state that has more incidents than others. It also allows us to identify the trends of incidents across the state, which allows us to explore more deeply what factors bring these kinds of results.'),
   
     tags$br(),
    
    tags$p(class = 'p', "On the graph, we can see that some states display shockingly high levels of data, and this is the case for Texas and Florida. The data curve seems to 'override' the data of other states. Therefore, children residing in these states have a higher risk factor and should exercise caution when choosing where to live. On the other hand, some states have way less death in comparison, others just have very little data points year-round, and some states do not have any data points whatsoever (no child deaths). Data may have been generated based on differences in the population base of Hawaii, Vermont, and Wyoming, among others, indicating that some areas are safer than others."),

     tags$br(),
     
     tags$p(class = 'p', 'As this chart illustrates, it is clear that many States has experienced children tragically dying from shootings, which is indescribably traumatizing for their families. The best way to prevent gun violences is to reside in safer areas of the country, and understand more about the statistics relating to gun violence. Children should not grow up in a world in which they fear there will be no tomorrow. Guns should protect, not attack.'),
    
    tags$hr(),

    tags$h2(class = 'h2', 'Chart 2 Insight'),
    
    tags$ul(class = 'p',
            tags$li("The overall cases in South region was more than the cases from the North region."), 
            tags$li("Texas has the highest number of cases through 2014-2021."), 
            tags$li("The east coast region has the higher total death number than that in the west coast.")
    ),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Chart 3 Insight'),
    
    tags$ul(class = 'p',
            tags$li("The overall number of child deaths from gun violence is on the rise from 2014-2021."), 
            tags$li("Only one year, which is 2018, saw a negative increase in the number of child deaths, while all others showed positive increases from 2014-2021."), 
            tags$li("The year 2020, with a growth rate of more than 20 percent, was also the highest ever."),
            tags$li('The year 2021, with a death number of more than 400 children, was also the highest ever.')
    ),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Summarize What We Got'),
    
    tags$p(class = 'p', 'Our analysis revealed overall Gun shooting situation including total death number, increasing rate of death number in each year, total death number and tendency chart in each state and map distribution .There are 19169166 total cases confirmed all over the world from 2014 to 2021. Across the data, Texas has the highest number of number through the entire US. Total deaths in the south were larger than those in the north, and total deaths on the West Coast were smaller than total deaths on the East Coast. The number of deaths is related to the legality of the gun. By taking close look to all those data for different states, we see Texas and Florida had relatively higher number of children killed than other states. Also, some of those states do not have children killed for certain years. Some states have not had a year (in years) without a child being killed in a shooting. Like Hawaii, Wyoming, Vermont, Delaware, etc. The number of gun violence incidents and the number of children had been killed in gun violence incidents increased from 2014 to 2021, but there is a decrease in 2018. Regionally speaking, the rate of death went up steadily throughout most places in the United States. Especially in the NorthEast in The only year the rate went down significantly was in the West Region of United States in 2018. According to the data, the United States had the highest number of gun violence deaths among children in 2021 and the lowest killed in 2018. The highest increasing rate in deaths occurred in 2020 and the lowest in 2018 which is the only year of negative growth.'),
    
    tags$hr(),
    
    tags$h2(class = 'h2', 'Insights and implications'),
    
    tags$p(class = 'p', 'In this project, we observed some unexpectedly high number of children killed by gun violence. From these graphs, we can learn that overall, the number of children killed by gun each year is steadily rising. We would like to raise awareness from using this application for people to understand the consequences of gun violence and how it is negatively impacting our society. Although this project is a useful tool for people to visualize the impact of gun violence to children in America, but it is also important to note that these are not just hard cold statistics. Numbers does not tell the a story, or what happened to the deceased children. To reiterate, behind these data points are real lives being taken away, and there are grieving families behind every one of those points.')
  )
)

ui <- navbarPage(
  'Go Go (Go Over, Guns Over)',
  tags$style(
    "li a {
        font-size: 15px;
        font-weight: bold;
    }
    .p {
      color: #2e2d2d;
        font-size: 17px;
      border-radius: 3px;
    }
    .h1 {
      color: #a23327;
        font-size: 30px;
      border-radius: 3px;
    }
    .h2 {
      color: #c64a3a;
        font-size: 20px;
      border-radius: 3px;
    }
    "
  ),
  intro_tab,
  plot_tab_1,
  plot_tab_2,
  plot_tab_3,
  sum_tab
)