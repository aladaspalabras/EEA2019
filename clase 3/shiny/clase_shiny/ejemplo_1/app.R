#
# - Este es el template que viene por default cuando creamos un shiny. (Nuevo --> Shiny web app)
# - Este archivo siempre se tiene que llamar app.R para que funcione. 
# - Para ejecutar el código podemos presionar "Run App" en el margen superior derecho
#
#   
#

library(shiny)

# Primero definimos un Interfaz de usuario (UI)
ui <- fluidPage(

    # Titulo
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar con slider input para el numero de bins 
    sidebarLayout(                     # nos dice que hay un elemento en el centro y otro al costado
        sidebarPanel(                          # lo que queremos que vaya al costadito
            sliderInput("bins",                # metemos un widget
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Mostramos un grafico con la distribucion
        mainPanel(                            
           plotOutput("distPlot")             # indica que queremos mostrar un gráfico (plot)
        )
    )
)

# Definimos la funcion server
server <- function(input, output) {

    output$distPlot <- renderPlot({          # generamos un output con código dinámico e interactivo
        #  Generamos los bins basados en input$bins del UI
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # Generamos el histograma
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    }) # cada vez que el usuario modifica un input, R vuelve a correr esta porción de código
}

# Ejecutamos la aplicacion. 
shinyApp(ui = ui, server = server)
