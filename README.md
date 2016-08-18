**How to use**

First, put connection parameters in `~/.exa` (yaml format), e.g.

    host: localhost:8563
    user: sys
    password: some_password
    schema: public

Then run:

    library(exa)
    db <- jdbc()  
    query(db, 'select 1')
    query(db, "select '{{label}}'", label = 'hej')  # see infuser package
    
See also examples provided in `/examples`, on how to use exa connection with rmarkdown and knitr engines.
