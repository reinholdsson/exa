#' Set up exasol connection
#'
#' ...
#'
exasol <- function(user = 'sys', password = 'exasol', host = 'localhost', port = 8563L) {

  args <- as.list(environment())

  # ODBC Driver
  args$driver <- file.path(
    system.file(package = packageName()),
    switch(
      Sys.info()['sysname'],

      # Mac OS
      'Darwin' = 'odbc/lib/darwin/x86_64/libexaodbc-io418sys.dylib'
    )
  )

  conn_string <- infuse('Driver={{driver}};UID={{user}};PWD={{password}};EXAHOST={{host}}:{{port}}', args)
  odbcDriverConnect(conn_string)

}
