#' Set up exasol connection
#'
#' ...
#'
#' @export
exasol <- function(user = 'sys', password = 'exasol', host = 'localhost', port = 8563L, ...) {
  args <- as.list(environment())

  # ODBC Driver
  args$driver <- file.path(
    system.file(package = packageName()),
    switch(
      Sys.info()['sysname'],
      'Darwin' = 'odbc/lib/darwin/x86_64/libexaodbc-io418sys.dylib'  # Mac OS
    )
  )

  conn_string <- infuse('Driver={{driver}};UID={{user}};PWD={{password}};EXAHOST={{host}}:{{port}}', args)
  odbcDriverConnect(conn_string, ...)
}

#' @export
query <- function(conn, sql, ...) {
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)
  sqlQuery(conn, q)
}


