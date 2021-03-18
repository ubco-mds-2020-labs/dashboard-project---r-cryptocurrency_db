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
                        dccGraph(id='group1')
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
                        options = list(list(label = "USD", value = "USD"),
                               list(label = "CAD", value = "CAD")),
                        value = 'CAD'
                    ),
                    dccInput(id="moderncurrency1",type='number', placeholder=0),
                    #dccInput(id='moderncurrency1'),
                    #htmlDiv(id='crypto1'),
                    htmlBr(),
                    htmlBr(),
                    htmlBr(),
                    htmlH3("Receive"),
                    dccDropdown(
                        id="crypto",
                        options = list(list(label = "bitcoin", value = "bitcoin"),
                               list(label = "dash", value = "dash")),
                        value = 'dash'
                    ),
                    htmlDiv(id='crypto1'),

                    dbcButton("Buy now", color="light", className="mr-1")
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
       )
      ),
    )
  ),style = list('color' = 'yellow', 'background' = 'pink')
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
        price_x <- subset(price, Name == 'bitcoin' | Name == xcol)
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
    function(xcol) {
        p2 <- ggplot(price, aes(x = New_date1, y = Close, col = Name)) + geom_line()
        px2 <- p2 + facet_wrap(~Name, scales = "free", ncol = 3) + theme_minimal() + theme(legend.position="none") + ylab("Price (USD)")
        px2 <- px2 
        return(ggplotly(px2) %>% layout(legend = list(orientation = 'h', y= -0.3)))
    }
)




app$callback(
    output('crypto1', 'children'), #dccGraphID
    list(input('moderncurrency1', 'value'),
         input('moderncurrency', 'value')), #dccDropdownID
#    function(moderncurrency1, moderncurrency, crypto){
#        values <- c(1.0, 0.84, 0.72, 109.04, 72.53, 1.24, 1.34, 0.000017, 0.0048253, 0.0020147, 0.1984127, 0.0006391, 0.7633588, 00054969, 0.0049655, 1.333333, 0.0267165, 0.0252717, 0.1776199, 0.157779, 2.1276596, 1.0869565, 0.102146 ) #Moderen currency (to currency)
#        names(values) <- c("USD", "EUR", "GBP", "YEN", "INR", "CAD", "SGD", "bitcoin", "dash", "bitcoin_cash", "bitconnect", "ethereum", "iota", "litecoin", "monero", "nem", "neo", "numeraire", "omisego", "qtum", "ripple", "stratis", "waves") #Moderen currency name (to currency name)
 #       v1 = (values[crypto]/values[moderncurrency])/moderncurrency1
 #       return(25)
        function(input_value, moderncurrency) {
            x <- input_value*2
            return(list(x))
#    })
}
)

#app$callback(
#    list(output('crypto1', 'children')),
#    list(input('moderncurrency1', 'value')),
#    function(input_value) {
#        return(list(input_value))  # Would also work without `return()`
 #   })


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