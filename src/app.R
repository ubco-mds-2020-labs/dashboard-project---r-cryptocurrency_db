library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
plotly::ggplotly

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

#Read data
structure <- read_csv("/Volumes/UBC/Block5/551/Project_MDS/dashboard-project---r-cryptocurrency_db/data/raw_data/structure.csv")
price <- read_csv("/Volumes/UBC/Block5/551/Project_MDS/dashboard-project---r-cryptocurrency_db/data/processed_data/price.csv")


#Manipulate data on the go
structure_bitcoin <- structure[structure$Name == 'bitcoin',]
structure_rest <- structure[structure$Name != 'bitcoin',]

#Creating variables are needed
structure_rest_name <- structure_rest$Name

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
                        htmlH5('Market Cap (Billion USD)')
                    )
                ),
                dbcCol(
                    list(
                        htmlH5('Volume (Million)')
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
                        htmlH6('# of transaction on the lastest day')
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'red', 'background' = 'black')
        ),

        # Row about values of  bitcoin
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlH6('Bitcoin')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestOpen)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestClose)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$L7D)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$L30D)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestMarketCap_inB)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestVolume_inM)
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'green', 'background' = 'black')
        ),
        # Row about values of  rest of the currencies || Need to work on dropdown and respective values
        dbcRow(
            list(
                dbcCol(
                    list( 
                        dccDropdown(
                            id='currencylist',
                            options = structure_rest$Name %>% purrr::map(function(col) list(label = col, value = col)),
                            value='neo')
                           
                        )
                ),
                dbcCol(
                    list(
                        htmlH6(id='Open')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestClose)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$L7D)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$L30D)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestMarketCap_inB)
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(structure_bitcoin$LatestVolume_inM)
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'green', 'background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlBr()
                    )
                )
            ), style = list('background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlBr()
                    )
                )
            ), style = list('background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        htmlH4("Time series graph")
                    )
                )
            ), style = list('text-align' = 'center', 'color' = 'purple', 'background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        dccGraph(id='time-series1')
                    ), style = list('background' = 'black')
                )
            )
        )
        
)
)
)



# Call back

app$callback(
    output('time-series1', 'figure'), #dccGraphID
    list(input('currencylist', 'value')), #dccDropdownID
    function(xcol) {
        price_x <- subset(price, Name == 'bitcoin' | Name == xcol)
        p <- ggplot(price_x) +
            aes(x = New_date1,
                y = Open,
                color = Name,
                fill = Name) +
            geom_line()
        return(ggplotly(p))
    }
)

app$callback(
    list(output('Open','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z <- subset(structure_rest, Name == xcol)
        z <- structure_rest_z$LatestOpen
        z
    }
)

app$run_server(debug = T)