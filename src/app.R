library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(tidyverse)
library(readr)
library(ggplot2)
library(plotly)
library(dplyr)
plotly::ggplotly

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

#Read data
structure <- read_csv("/Volumes/UBC/Block5/551/Project_MDS/dashboard-project---r-cryptocurrency_db/data/raw_data/structure.csv")
price <- read_csv("/Volumes/UBC/Block5/551/Project_MDS/dashboard-project---r-cryptocurrency_db/data/processed_data/price.csv")
price_OHLC <- select(price, Open,High,Low,Close,Name,New_date1)
price_rest <- subset(price, Name != 'bitcoin' & Name != 'bitcoin_cash')


#Manipulate data on the go
structure_bitcoin <- structure[structure$Name == 'bitcoin',]
structure_rest <- structure[structure$Name != 'bitcoin',]

#Creating variables are needed
structure_rest_name <- structure_rest$Name


# Individual tab content
tab1_content = 
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
                            value='ethereum')
                           
                        )
                ),
                dbcCol(
                    list(
                        htmlH6(id='Open')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(id='Close')
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(id="L7D")
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(id="L30D")
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(id="MarketCap")
                    )
                ),
                dbcCol(
                    list(
                        htmlH6(id="Volume")
                    )
                )

            ), style = list('text-align' = 'center', 'color' = 'pink', 'background' = 'black')
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
                        htmlH2("Volume graph")
                    )
                )
            ), style = list('text-align' = 'center', 'color' = 'purple', 'background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        dccGraph(id='vol1')
                    ), style = list('background' = 'black')
                )
            )
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        #dccGraph(id='time-series1')
                    ), style = list('background' = 'black')
                )
            )
        )

        
)
)






tab2_content = 
    dbcContainer(
        list(
        dbcRow(
            list(
                dbcCol(
                    list(
                        dccDropdown(id='OHLC',
                            options = list(list(label = "Open : Opening price on the given day", value = "Open"),
                                           list(label = "High : Highest price on the given day", value = "High"),
                                           list(label = "Low : Lowest price on the given day", value = "Low"),
                                           list(label = "Close : Closing price on the given day", value = "Close")),
                            value = 'Close'
                        )
                    )
                )
            ), style = list('text-align' = 'center', 'color' = 'purple', 'background' = 'black')
        ),
        dbcRow(
            list(
                dbcCol(
                    list(
                        dccGraph(id='group1',
                        style=list("height"=800))
                    ), style = list('background' = 'black')
                )
            )
        )       
)
)


tab3_content = 
dbcContainer(
    list(
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
                    htmlBr()
                )
            )
        ), style = list('background' = 'black')
    ),
    dbcRow(
        list(
            dbcCol(
                list(
                    htmlH1("Buy and Sell cryptocurrency"),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlH4("Fast and secure way to purchase or exchange cryptocurrencies"),
                    htmlBr(),
                    htmlH6("Share your email address to subscribe to our weekly updates and investment tips"),
                    htmlBr(),
                    htmlBr(),
                    dbcRow(
                        list(
                            dbcCol(
                                list(
                                    dbcInput(placeholder="Type something...", type="text")
                                )
                            ),
                            dbcCol(
                                list(
                                   dbcButton("→", color="light", className="mr-1") 
                                )
                            )
                        )
                    ),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlBr()
                )
            ),
            dbcCol(
                list(
                    htmlH3("Send"),
                    dccDropdown(
                        id="moderncurrency",
                        #"USD", "EUR", "GBP", "YEN", "INR", "CAD", "SGD"
                        options = list(list(label = "US Dollar", value = "USD"),
                               list(label = "Canadian Dollar", value = "CAD"),
                               list(label = "Euro", value = "EUR"),
                               list(label = "Pound Sterling", value = "GBP"),
                               list(label = "Singapore Dollar", value = "SGD"),
                               list(label = "Japanese Yen", value = "YEN"),
                               list(label = "Indian Rupees", value = "INR")),
                        value = 'CAD'
                    ),
                    htmlBr(),
                    dccInput(id="moderncurrency1",type='number', placeholder=0),

                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlH3("Receive"),
                    #"bitcoin", "dash", "bitcoin_cash", "bitconnect", "ethereum", "iota", "litecoin", 
                    #"monero", "nem", "neo", "numeraire", "omisego", "qtum", "ripple", "stratis", "waves"
                    dccDropdown(
                        id="crypto",
                        options = list(list(label = "bitcoin", value = "bitcoin"),
                               list(label = "dash", value = "dash"),
                               list(label = "bitcoin_cash", value = "bitcoin_cash"),
                               list(label = "bitconnect", value = "bitconnect"),
                               list(label = "ethereum", value = "ethereum"),
                               list(label = "ethereum_classic", value = "ethereum_classic"),
                               list(label = "iota", value = "iota"),
                               list(label = "litecoin", value = "litecoin"),
                               list(label = "monero", value = "monero"),
                               list(label = "nem", value = "nem"),
                               list(label = "neo", value = "neo"),
                               list(label = "numeraire", value = "numeraire"),
                               list(label = "omisego", value = "omisego"),
                               list(label = "qtum", value = "qtum"),
                               list(label = "ripple", value = "ripple"),
                               list(label = "stratis", value = "stratis"),
                               list(label = "waves", value = "waves")),
                        value = 'dash'
                    ),
                    htmlBr(),
                    htmlDiv(id='crypto1'),

                    dbcButton("Buy now", color="light", className="mr-1")
                )
            )
        )
    )
)
)


tab4_content = 
    dbcContainer(
        list(
        dbcRow(
            list(
                dbcCol(
                    list(
                        dccGraph(id="quartile1",
                        style=list("height"=400))
                    )
                )
            )
        )
        )
    )





        








# all tabs content
tabs = htmlDiv(
  list(
    htmlH2("Cryptocurrency Reporting Dashboard"),
    dbcTabs(
      list(
        dbcTab(children=list(
          htmlBr(),
          tab1_content
        ), 
        label="Overview"
       ),
       dbcTab(children=list(
          htmlBr(),
          tab2_content
        ), 
        label="DeepDive"
       ),
       dbcTab(children=list(
          htmlBr(),
          tab3_content
        ), 
        label="Buy & Sell"
       ),
       dbcTab(children=list(
          htmlBr(),
          tab4_content
        ), 
        label="Sample"
       )
      )
    )
  ),style = list('color' = 'yellow', 'background' = 'black')
)


# final layout
app$layout(
  dbcContainer(
    list(
      htmlBr(),
      tabs
    )
  )
)


# Call back

app$callback(
    output('vol1', 'figure'), #dccGraphID
    list(input('currencylist', 'value')), #dccDropdownID
    function(xcol) {
        price_x <- subset(price, Name == 'bitcoin' | Name == xcol) # Should we change the below graph to adjust the source?
        p1 <- ggplot(price) +
            aes(x = New_date1,
                y = Volume/1000000,
                color = Name,
                fill = Name) +
                geom_smooth() 
        px1 <- p1 + theme(axis.title.x = element_blank())
        
        return(ggplotly(px1))
    }
)

app$callback(
    output('group1', 'figure'), #dccGraphID
    list(input('OHLC', 'value')), #dccDropdownID
    function(ycol) {
        options(repr.plot.width = 10, repr.plot.height = 300)
        p2 <- ggplot(price_OHLC, aes(x = New_date1, y = !!sym(ycol), col = Name)) + geom_line()
        px2 <- p2 + facet_wrap(~Name, scales = "free", ncol = 3) + theme_minimal() + theme(legend.position="none") + ylab("Price (USD)")
        return(ggplotly(px2))
    }
)

app$callback(
    output('quartile1', 'figure'), #dccGraphID
    list(input('OHLC', 'value')), #dccDropdownID
    function(ycol) {
        options(repr.plot.width = 10, repr.plot.height = 300)
        p3 <- ggplot(price_rest, aes(Name, RollingAvg7_Close, color=Name)) + geom_point() + geom_boxplot()
        px3 <- p3 + theme_minimal() + theme(legend.position="none") + ylab("Price (USD)")
        return(ggplotly(px3))
    }
)




app$callback(
    output('crypto1', 'children'), #dccGraphID
    list(input('moderncurrency1', 'value'),
         input('moderncurrency', 'value'),
         input('crypto', 'value')), #dccDropdownID
    function(moderncurrency1, moderncurrency, crypto){
        values <- c(1.0, 0.84, 0.72, 109.04, 72.53, 1.24, 1.34, 0.000017, 0.0048253, 0.0020147, 0.1984127, 0.0006391, 0.7633588, 00054969, 0.0049655, 1.333333, 0.0267165, 0.0252717, 0.1776199, 0.157779, 2.1276596, 1.0869565, 0.102146 ) #Moderen currency (to currency)
        names(values) <- c("USD", "EUR", "GBP", "YEN", "INR", "CAD", "SGD", "bitcoin", "dash", "bitcoin_cash", "bitconnect", "ethereum", "iota", "litecoin", "monero", "nem", "neo", "numeraire", "omisego", "qtum", "ripple", "stratis", "waves") #Moderen currency name (to currency name)
        v1 = round((values[crypto]/values[moderncurrency])/moderncurrency1,5)
        return(v1)
}
)


app$callback(
    list(output('Open','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z1 <- subset(structure_rest, Name == xcol)
        z1 <- structure_rest_z1$LatestOpen
        return(list(z1))
    }
)

app$callback(
    list(output('Close','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z2 <- subset(structure_rest, Name == xcol)
        z2 <- structure_rest_z2$LatestClose
        return(list(z2))
    }
)

app$callback(
    list(output('L7D','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z3 <- subset(structure_rest, Name == xcol)
        z3 <- structure_rest_z3$L7D
        return(list(z3))
    }
)

app$callback(
    list(output('L30D','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z4 <- subset(structure_rest, Name == xcol)
        z4 <- structure_rest_z4$L30D
        return(list(z4))
    }
)

app$callback(
    list(output('MarketCap','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z5 <- subset(structure_rest, Name == xcol)
        z5 <- structure_rest_z5$LatestMarketCap_inB
        return(list(z5))
    }
)

app$callback(
    list(output('Volume','children')),
    list(input('currencylist','value')),
    function(xcol) {
        structure_rest_z6 <- subset(structure_rest, Name == xcol)
        z6 <- structure_rest_z6$LatestVolume_inM
        return(list(z6))
    }
)



app$run_server(debug = T)