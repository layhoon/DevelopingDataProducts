require(shiny)

varnames <- c(
  'Number of Pregnancies' = 'npreg',
  'Plasma Glucose Concentration' = 'glu',
  'Diastolic Blood Pressure' = 'bp',
  'Triceps Skin Fold Thickness' = 'skin',
  'Body Mass Index' = 'bmi',
  'Diabetes Pedigree Function' = 'ped',
  'Age' = 'age',
  'Type' = 'type')


shinyUI(
  navbarPage(
    "Diabetic Risk Classification",
    tabPanel(
      "Classification",
      fluidPage(
        wellPanel(fluidRow(
          column(6, textOutput("fit1"), br(), verbatimTextOutput("prediction1")),
          column(6, textOutput("fit2"), br(), verbatimTextOutput("prediction2")),
          tags$head(tags$style("#prediction1{font-style: bold;}")),
          tags$head(tags$style("#prediction2{font-style: bold;}"))
        )),
        hr(),
        fluidRow(
          column(3, sliderInput("npreg", "Number of Pregnancies", min=0, max=14, value=0)),
          column(3, plotOutput("density_npreg", height="120px")),
          column(3, sliderInput("bmi", "Body Mass Index", min=18, max=48, value=18, step=0.1)),
          column(3, plotOutput("density_bmi", height="120px"))
        ),
        fluidRow(
          column(3, sliderInput("glu", "Plasma Glucose Concentration", min=56, max=199, value=56)),
          column(3, plotOutput("density_glu", height="120px")),
          column(3, sliderInput("ped", "Diabetes Pedigree Function", min=0.080, max=2.290, value=0.080, step=0.005)),
          column(3, plotOutput("density_ped", height="120px"))
        ),
        fluidRow(
          column(3, sliderInput("bp", "Diastolic Blood Pressure", min=38, max=110, value=38)),
          column(3, plotOutput("density_bp", height="120px")),
          column(3, sliderInput("age", "Age", min=21, max=63, value=21)),
          column(3, plotOutput("density_age", height="120px"))
        ),
        fluidRow(
          column(3, sliderInput("skin", "Triceps Skin Fold Thickness", min=7, max=99, value=7)),
          column(3, plotOutput("density_skin", height="120px"))
        ),
        hr()
      )
    ),
    tabPanel(
      "Feature Plot",
      fluidPage(
        wellPanel(fluidRow(
          column(6, selectInput("x", "X Axis Variable", varnames)),
          column(6, selectInput("y", "Y Axis Variable", varnames))
        )),
        fluidRow(
          plotOutput("plot", height="400px")
        )
      )
    ),
    tabPanel("About",mainPanel(includeMarkdown("README.md")))
  )
)