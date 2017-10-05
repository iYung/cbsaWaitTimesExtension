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

$ "tbody > tr" 
    .each -> 
        record = new Array()
        getRowData $(this), record
        data.push record
    console.log data
        
