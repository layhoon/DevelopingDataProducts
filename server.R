require(shiny)
require(markdown)
require(MASS)
require(caret)
require(e1071)
require(randomForest)


data("Pima.tr")
data("Pima.te")
varnames <- c(
  'Number of Pregnancies' = 'npreg',
  'Plasma Glucose Concentration' = 'glu',
  'Diastolic Blood Pressure' = 'bp',
  'Triceps Skin Fold Thickness' = 'skin',
  'Body Mass Index' = 'bmi',
  'Diabetes Pedigree Function' = 'ped',
  'Age' = 'age',
  'Type' = 'type')
types <- levels(Pima.tr$type)


set.seed(111)
fit1 <- randomForest(type~., data=Pima.tr, importance=TRUE)
pred1 <- predict(fit1, newdata=Pima.te)
acc1 <- signif(confusionMatrix(Pima.te$type, pred1)$byClass[8]*100, 3)


set.seed(111)
fit2 <- glm(type~., data=Pima.tr, family=binomial())
fit2 <- step(fit2, direction = "backward")
pred2 <- predict(fit2, newdata=Pima.te, type='response')
pred2 <- factor(ifelse(pred2<0.5, 1, 2), labels=c('No', 'Yes'))
acc2 <- signif(confusionMatrix(Pima.te$type, pred2)$byClass[8]*100, 3)


palette(c('blue', 'red'))
palette(adjustcolor(palette(), alpha = 0.5))


plotDensity <- function(var, cursor){
  d1 <- density(Pima.tr[Pima.tr$type=='No', var])
  d2 <- density(Pima.tr[Pima.tr$type=='Yes', var])
  par(mar = c(3, 0, 0, 0))
  plot(d1, type='n', main='', xlab='', ylab='', yaxt='n',
    xlim=range(d1$x, d2$x), ylim=range(d1$y, d2$y), cex.axis=0.8)
  lines(d1, col=palette()[1])
  lines(d2, col=palette()[2])
  abline(v = cursor, lwd=2)
  legend('topright', bty = 'o', lwd = c(3, 3), cex=0.6, col=palette(), legend=types)
}


shinyServer(
  function(input, output, session){
    
    newcase <- reactive({
      data.frame(
        npreg = input$npreg,
        glu = input$glu,
        bp = input$bp,
        skin = input$skin,
        bmi = input$bmi,
        ped = input$ped,
        age = input$age
      )
    })
    
    output$plot <- renderPlot({
      par(mar = c(5, 5, 1, 1))
      plot(Pima.tr[,input$x], Pima.tr[,input$y], col=Pima.tr$type,
        xlab=names(which(varnames == input$x)), ylab=names(which(varnames == input$y)),
        pch=19, cex=2, cex.lab=1.5)
      legend('topright', bty ='o', lwd=c(5, 5), col=palette(), legend=types)
    })
    
    output$density_npreg <- renderPlot({
      plotDensity('npreg', input$npreg)
    })
    output$density_glu <- renderPlot({
      plotDensity('glu', input$glu)
    })
    output$density_bp <- renderPlot({
      plotDensity('bp', input$bp)
    })
    output$density_skin <- renderPlot({
      plotDensity('skin', input$skin)
    })
    output$density_bmi <- renderPlot({
      plotDensity('bmi', input$bmi)
    })
    output$density_ped <- renderPlot({
      plotDensity('ped', input$ped)
    })
    output$density_age <- renderPlot({
      plotDensity('age', input$age)
    })
    
    output$fit1 <- renderText({
      paste("By Random Forest (", acc1, "% Accuracy)", sep="")
    })
    output$fit2 <- renderText({
      paste("By Logistic Regression (", acc2, "% Accuracy)", sep="")
    })
    output$prediction1 <- renderText({
      paste(predict(fit1, newdata=newcase()))
    })
    output$prediction2 <- renderText({
      paste(ifelse(predict(fit2, newdata=newcase())<0.5, "No", "Yes"))
    })
  }
)