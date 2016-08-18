**How to use**

First, put exasol connection parameters in `~/.exa`, e.g.

    host: localhost:8563
    user: sys
    password: some_password
    schema: public

Then in R, run:

    library(exa)
    db <- jdbc()  
    query(db, 'select 1')
    query(db, "select '{{label}}'", label = 'hej')  # see infuser package
    
See also examples provided in `/examples`, on how to use exa connection with rmarkdown and knitr engines.
