library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(
    htmlDiv(
        list(
            dccInput(id='widget-1'),
            htmlDiv(id='widget-2')
        )
    )
)

app$callback(
    list(output('widget-2', 'children')),
    list(input('widget-1', 'value')),
    function(input_value) {
        return(list(input_value))  # Would also work without `return()`
    })

app$run_server(debug = T)