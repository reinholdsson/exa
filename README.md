
Example in R:

    library(exa)
    db <- jdbc(host = 'localhost:8563', user = 'sys', schema = 'public', password = '****')
    query(db, 'select 1')
    query(db, "select '{{label}}'", label = 'hej')  # see also https://github.com/Bart6114/infuser
    
Another approach is to first add a connection object to `.Rprofile`, e.g. `.exa <- exa::jdbc(...)`.

And then use the connection directly in rmarkdown (knitr engine):

  ```{sql, connection = .exa}
  select 1
  ```

See also http://rmarkdown.rstudio.com/authoring_knitr_engines.html
