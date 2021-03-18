library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

app$layout(
    dbcContainer(
        list(    
        # Row about all Open USD, Close USD etc
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlH5('')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Open Val (USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Close Val (USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Average L7 (USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Average L30 (USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Market Cap (USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Volume (units)')
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'cyan', 'background' = 'black')
        ),

        # Row about all definations
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlH6('')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Opening price on the latest day')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Closing price on the latest day')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Average price of the last 7 days')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Average price of the last 30 days')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Market capitalization')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6('Volume of transaction on the lastest day')
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'red', 'background' = 'black')
        )
    )
)
)

app$run_server(debug = T)