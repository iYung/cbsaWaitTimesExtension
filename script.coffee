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
        
sortDataByTravellers = () ->
    data.sort (a, b) ->
        bValue = aValue = 0 
        if a[3].indexOf(" minutes") >= 0
            aValue = parseInt a[3].replace " minutes", ""
        if b[3].indexOf(" minutes") >= 0
            bValue = parseInt b[3].replace " minutes", ""
        return aValue - bValue

$ "tbody > tr" 
    .each -> 
        record = new Array()
        getRowData $(this), record
        data.push record
    do sortDataByTravellers
    console.log data
        
