source("./calc_max_tax_savings.R")


function(input, output,session) {
  
  v <- reactiveValues()
  
  observeEvent(input$AB,{
    req(input$income1,input$income2,input$relief)
    v$calculatedValue <- calc_max_tax_savings(income1 = input$income1, income2 = input$income2, relief = input$relief)
  })
  observeEvent(input$reset, {
    v$calculatedValue <- NULL
  })  
  output$max <- renderText({
    paste(v$calculatedValue$max)
  })
  output$table <- DT::renderDataTable({
    v$calculatedValue$table
  })
  output$plot <- renderPlot({
    if (!is.null(v$calculatedValue$table)) {
      plot(v$calculatedValue$table)
    }
  })
  output$summary1 <- renderText({
    if (!is.null(v$calculatedValue$table)) {
      HTML(
        paste("<h4><b>Relief to be claimed by Person 1</b></h4>",
              "<h4>Range: (",min(v$calculatedValue$table$'Relief to be claimed by Person 1'),
              ",",max(v$calculatedValue$table$'Relief to be claimed by Person 1'),")",
              "<br/>",
              "Midpoint Value:",round(median(v$calculatedValue$table$'Relief to be claimed by Person 1'),0),
              "</h4>"
        )
      )}
  })
  output$summary2 <- renderText({
    if (!is.null(v$calculatedValue$table)) {
      HTML(
        paste("<h4><b>Relief to be claimed by Person 2</b></h4>",
              "<h4>Range: (",min(v$calculatedValue$table$'Relief to be claimed by Person 2'),
              ",",max(v$calculatedValue$table$'Relief to be claimed by Person 2'),")",
              "<br/>",
              "Midpoint Value:",round(median(v$calculatedValue$table$'Relief to be claimed by Person 2'),0),
              "</h4>"
        )
      )}
  })
  output$scenario <- renderText({
    if (!is.null(v$calculatedValue$table)) {
      HTML(
        paste("<br/>",
              "<h4><b>Endpoint Scenario</b></h4>",
              "<h4><b>Option 1:</b> Person 1 claims relief of $","<code>",min(v$calculatedValue$table$'Relief to be claimed by Person 1'),"</code>",
              "<br/>",
              HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),
              HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),
              "Person 2 claims relief of $","<code>",max(v$calculatedValue$table$'Relief to be claimed by Person 2'),"</code>",
              "</h4>",
              "<h4><b>Option 2:</b> Person 1 claims relief of $","<code>",max(v$calculatedValue$table$'Relief to be claimed by Person 1'),"</code>",
              "<br/>",
              HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),
              HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),HTML('&nbsp;'),
              "Person 2 claims relief of $","<code>",min(v$calculatedValue$table$'Relief to be claimed by Person 2'),"</code>",
              "</h4>",
              "<br/>",
              "<h4><b>Midpoint Scenario</b></h4>",
              "<h4>Person 1 claims relief of $","<code>",round(median(v$calculatedValue$table$'Relief to be claimed by Person 1'),0),"</code>",
              "<br/>",
              "Person 2 claims relief of $","<code>",round(median(v$calculatedValue$table$'Relief to be claimed by Person 2'),0),"</code>",
              "</h4>"
        )
      )}
  })
}