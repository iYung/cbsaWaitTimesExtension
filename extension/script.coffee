data = new Array()

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

sortDataByName = (data) ->
    do data.sort().reverse
    
sortDataByTravellers = (data) ->
    data.sort (a, b) ->
        bValue = aValue = 0 
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
            
sortDataByCommercial = (data) ->
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
		
printRows = (rows) ->
    do $("tbody tr").empty
    rows.forEach (row) ->
        $ "tbody"
            .prepend "<tr><th><b>" + row[0] + "</b><br>" + row[1] + "<br></th><td>" + row[2] + "</td><td>" + row[3] + "</td><td>" + row[4] + "</td></tr>"
    $("tbody th ").css {"text-align": "left", "font-weight": "normal"}

$ "tbody > tr" 
    .each -> 
        record = new Array()
        getRowData $(this), record
        data.push record
    printRows sortDataByTravellers data
    
    console.log data
    
 $ "thead > tr > th"
    .each ->
        $(this).attr "id", $(this).text().replace " ", ''
    
$("#CBSAOffice").on "click", ->
    console.log "Office clicked!"

$("#CommercialFlow").on "click", ->
    console.log "Commercial Flow!"

$("#TravellersFlow").on "click", ->
    console.log "Travellers Flow!"