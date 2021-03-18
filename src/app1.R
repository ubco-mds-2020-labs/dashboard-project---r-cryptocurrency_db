library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(ggplot2)
library(plotly)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

app$layout(
    dbcContainer(
        list(
            dccGraph(id='plot-area'),
            dccDropdown(
                id='col-select',
                options = msleep %>%
                    colnames %>%
                    purrr::map(function(col) list(label = col, value = col)), 
                value='bodywt')
        )
    )
)

app$callback(
    output('plot-area', 'figure'),
    list(input('col-select', 'value')),
    function(xcol) {
        p <- ggplot(msleep) +
            aes(x = awake,
                y = sleep_total,
                color = vore,
                text = name) +
            geom_point() +
            scale_x_log10() +
            ggthemes::scale_color_tableau()
        ggplotly(p)
    }
)

app$run_server(debug = T)