library(shiny)

shinyServer(function(input, output) {
    data <- reactive({
        set.seed(2019-12-14)
        n <- input$sliderN
        dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   exp = rexp,
                   lnorm = rlnorm,
                   rnorm)
        dist(n)
    })
    output$distPlot <- renderPlot({
        df <- data()
        tmp <- density(df, kernel=c("gaussian"))

        hist(df, prob = TRUE, ylim = c(0, max(tmp$y)), 
             col = "deepskyblue", 
             xlab = NA, main = NA)
        lines(density(df), lwd = 4, col = "darkblue")
        abline(v = mean(df), lwd = 2, col = "deepskyblue4")
        abline(v = median(df), lwd = 2, col = "chartreuse4")
        abline(v = tmp$x[tmp$y==max(tmp$y)], lwd = 2, col = "brown")
        legend("topright", legend = c("Mean", "Median", "Mode"), 
               lty = c(1,1,1), lwd = c(2,2,2), 
               col = c("deepskyblue4", "chartreuse4", "brown"), bty = "n")
    })
    output$txtdist <-renderText({
        txt <- switch(input$dist,
                       norm = "Normal Distribution",
                       unif = "Uniform Distribution",
                       exp = "Exponential Distribution",
                       lnorm = "Log-normal Distribution",
                       "Normal Distribution")
        txtdist <- paste("Histogram of ", txt)
        txtdist
    })
    output$table1 <- renderTable({
        library(e1071)
        df <- data()
        den <- density(df, kernel=c("gaussian"))
        
        Mean <- round(mean(df),2)
        Median <- round(median(df),2)
        Mode <- round(den$x[den$y==max(den$y)],2)
        SD <- round(sd(df),2)
        
        Dmode <- round(max(den$y),2)
        Dist <- round(Mode - mean(df), 2)
        Skew <- round(skewness(df),2)
        Kurt <- round(kurtosis(df),2)
        
        table1 <- data.frame(Mean, Median, Mode, SD, 
                             Dmode, Dist, Skew, Kurt)
        colnames(table1) = c("Mean", "Median", "Mode", 
                             "Std Deviation", "Density at Peak", 
                             "Dist from Mean to Mode", 
                             "Skewness", "Kurtosis")
        table1
    })
})
