**Install**

    devtools::install_github('reinholdsson/exa')

**How to use**

First, put exasol connection parameters in `~/.exa`, e.g.

    host: localhost:8563
    user: sys
    password: some_password
    schema: public

Then in R, run:

    library(exa)
    db <- exa_jdbc()  
    exa_query(db, 'select 1')
    exa_query(db, "select '{{label}}'", label = 'hej')  # see infuser package
    
See also examples provided in `/examples`, on how to use this package with rmarkdown and knitr engines.
