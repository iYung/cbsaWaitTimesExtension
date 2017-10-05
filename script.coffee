printYoungestChild = (element) -> 
    if element.contents().length > 0
        do element
            .contents()
            .filter "br"
            .remove
        element.contents().each ->
            printYoungestChild $ this
    else
        console.log do element.text

$ "tbody > tr" 
    .each -> 
        printYoungestChild $ this
