library(MovingBubbles)
library(shiny)
library(ggsci)

load("data.RData")
colordf1 <- data.frame(key = unique(dat$package),
                       color = c(ggsci::pal_igv()(51), ggsci::pal_igv()(9)))

# Define UI 
ui <- fluidPage(
  # setting style
  tags$style("
             pre {white-space: pre;
             background: #f7f7f7;}
             .well {background-color: #FFFFFF;
             border-width: 0;}
             .container-fluid {padding-left: 0px;}"),
  img(src = "logo_CyberAgent_01.png", width = "150px", 
      height = "131px", align = "left"),  #109*95
   tags$div(class = "header",
            tags$h1(("MovingBubbles : Animated d3 bubble chart")),
            tags$h3("Vipavee Trivittayasil (Cyberagent, Inc.)"),
            tags$br()
   ),
   # Sidebar
   sidebarLayout(
      sidebarPanel(
        # tags$style(".well {background-color: #FFFFFF;
        #            border-width: 0;}"),
        h3("Introduction"),
        p("Animated d3 bubbles chart was developed to offer an alternative 
          way of plotting time-series data with many samples in a more 
          intuitive way. MovingBubbles package provides a method to add 
          second and third information dimensions to the bubble chart by 
          means of animation and color. The quantity each bubble represents 
          is proportional to the bubble area. The package uses d3 library 
          (Bostock et al., 2011) for plotting and htmlwidgets framework 
          (Vaidyanathan et al., 2017) to bridge Javascript and R."),
        h3("Demo script"),
        htmlOutput("demo_scripts"),
        h3("Website"),
        p("package: ", tags$a(href = "https://github.com/chengvt/MovingBubbles", "https://github.com/chengvt/MovingBubbles")),
        p("demo scripts: ", tags$a(href = "https://github.com/chengvt/user2018", "https://github.com/chengvt/user2018"))
      ),
      
      # Show a plot
      mainPanel(
         h3("Demo: Top 20 daily downloads of R packages via CRAN", align = "center"),
         MovingBubblesOutput("bubbles", height = "500px")
      )
   )
)

# Define server
server <- function(input, output) {
   
   output$bubbles <- renderMovingBubbles({
     MovingBubbles(dat, 
                   key = "package",
                   frame = "date",
                   value = "downloads",
                   color = colordf1)
   })
   
   output$demo_scripts <- renderUI({
     tags$pre(suppressWarnings(readChar("demo_scripts.R", file.info("demo_scripts.R")$size)))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

