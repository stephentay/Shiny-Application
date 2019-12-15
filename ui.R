library(shiny)

shinyUI(fluidPage(
    titlePanel("Distribution Models"),
    sidebarLayout(
        # Inputs from users
        sidebarPanel(
            #Documentation
            h3("Getting Started"),
            p("This app allows you to explore and understand four types of probability distributions. This is how you can start:", style = "color:blue"),
            p("1. Use the slider to choose the number of random datapoints you want.", style = "color:blue"),
            p("2. Then select the distribution model you want to generate.", style = "color:blue"),
            p("That's it! A histogram and a summary of the data will be generated on the right.", style = "color:blue"),
            
            sliderInput("sliderN",
                        "Number of Random Numbers to be Plotted:",
                        2, 1000, value = 100),
            radioButtons("dist",
                         "Choose a Distribution Model:",
                         c("Normal" = "norm",
                           "Uniform" = "unif",
                           "Exponential" = "exp",
                           "Log-normal" = "lnorm"))
        ),
        # Display outputs
        mainPanel(
            h3(textOutput("txtdist")),
            plotOutput("distPlot"),
            h3("Distribution Summary"),
            fluidRow(
                column(8,
                    tableOutput("table1")))
        )
    )
))
