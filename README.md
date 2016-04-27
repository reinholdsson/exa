
library(exa)

jc <- exa_jdbc(host = 'localhost', user = 'sys', password = '****')
exa_query(jc, 'select 1')

oc <- exa_odbc(host = 'localhost', user = 'sys', password = '****') # currently only works on MacOS
exa_query(oc, 'select 1')

