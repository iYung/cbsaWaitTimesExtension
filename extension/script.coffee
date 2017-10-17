data = new Array()

selectedData = new Array()

#Functions that get/manipulate/print data
getRowData = (element, record) -> 
    if element.contents().length > 0
        do element
            .contents()
            .filter "br"
            .remove
        element.contents().each ->
            getRowData $(this), record
    else
        record.push do element.text

sortDataByName = (data, ascending) ->
    if ascending
        do data.sort().reverse
    else
        do data.sort
    return data
    
sortDataByTravellers = (data, ascending) ->
    data.sort (a, b) ->
        bValue = aValue = -1 
        if a[3].indexOf(" minutes") >= 0
            aValue = parseInt a[3].replace " minutes", ""
        else if a[3].indexOf(" minute") >= 0
            aValue = parseInt a[3].replace " minute", ""
        if b[3].indexOf(" minutes") >= 0
            bValue = parseInt b[3].replace " minutes", ""
        else if b[3].indexOf(" minute") >= 0
            aValue = parseInt b[3].replace " minute", ""
        n = aValue - bValue
        if n != 0
            return n
        else if a[0] > b[0]
            return -1
        else if a[0] < b[0]
            return 1
        else
            return 0
    if ascending
        do data.reverse
    return data
            
sortDataByCommercial = (data, ascending) ->
    data.sort (a, b) ->
        bValue = aValue = 0 
        if a[2].indexOf(" minutes") >= 0
            aValue = parseInt a[2].replace " minutes", ""
        else if a[2].indexOf(" minute") >= 0
            aValue = parseInt a[2].replace " minute", ""
        if b[2].indexOf(" minutes") >= 0
            bValue = parseInt b[2].replace " minutes", ""
        else if b[2].indexOf(" minute") >= 0
            aValue = parseInt b[2].replace " minute", ""
        n = aValue - bValue
        if n != 0
            return n
        else if a[0] > b[0]
            return -1
        else if a[0] < b[0]
            return 1
        else
            return 0
    if ascending
        do data.reverse
    return data
    
printRows = (rows) ->
    do $("tbody tr").empty
    rows.forEach (row) ->
        $ "tbody"
            .prepend "<tr><th><b>" + row[0] + "</b><br>" + row[1] + "<br></th><td>" + row[2] + "</td><td>" + row[3] + "</td><td>" + row[4] + "</td></tr>"

#Startup code, makes headers clickable, adds search bar, and runs data grabbing function          
$ "thead > tr > th"
    .each ->
        $(this).attr "id", $(this).text().replace " ", ''

$ "tbody > tr" 
    .each -> 
        record = new Array()
        getRowData $(this), record
        data.push record
        
selectedData = data

$ "#bwttaf caption"
    .append "<br><input id='nameSearch' placeholder='Search offices'></input>"
    
$("#nameSearch").keyup ->
    searchKey = do $(this).val().toLowerCase
    if searchKey != ""
        selectedData = data.filter (row) ->
            console.log row[0].toLowerCase().search(searchKey)
            return row[0].toLowerCase().search(searchKey) != -1
        printRows sortDataByTravellers selectedData, false
    else
        selectedData = data
        printRows sortDataByTravellers selectedData, false
    
#Header functions        
$("#CBSAOffice").on "click", ->
    ascending = true
    $("#CommercialFlow").text "Commercial Flow"
    $("#TravellersFlow").text "Travellers Flow"
    if do $(this).text == "CBSA Office ▼"
        $(this).text "CBSA Office ▲"
    else
        ascending = false
        $(this).text "CBSA Office ▼"
    printRows sortDataByName selectedData, ascending
    console.log "Office clicked!"

$("#CommercialFlow").on "click", ->
    ascending = true
    $("#CBSAOffice").text "CBSA Office"
    $("#TravellersFlow").text "Travellers Flow"
    if do $(this).text == "Commercial Flow ▼"
        $(this).text "Commercial Flow ▲"
    else
        ascending = false
        $(this).text "Commercial Flow ▼"
    printRows sortDataByCommercial selectedData, ascending
    console.log "Commercial Flow!"

$("#TravellersFlow").on "click", ->
    ascending = true
    $("#CBSAOffice").text "CBSA Office"
    $("#CommercialFlow").text "Commercial Flow"
    if do $(this).text == "Travellers Flow ▼"
        $(this).text "Travellers Flow ▲"
    else
        ascending = false
        $(this).text "Travellers Flow ▼"
    printRows sortDataByTravellers selectedData, ascending
    console.log "Travellers Flow!"

#startup code to set intial state
do $("#TravellersFlow").click
    
console.log data