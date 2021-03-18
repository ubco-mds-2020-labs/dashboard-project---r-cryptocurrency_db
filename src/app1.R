library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

app$layout(
    htmlDiv(
        list(
            dccInput(id='widget-1'),
            dccInput(id='widget-4'),
            htmlDiv(id='widget-2'),
            htmlDiv(id='widget-3')
        )
    )
)

app$callback(
    list(output('widget-2', 'children'),
         output('widget-3', 'children')),
    list(input('widget-1', 'value'),
         input('widget-4', 'value')),
    function(input_value, input_value2) {
        return(list(input_value, input_value2))
    })

app$run_server(debug = T)