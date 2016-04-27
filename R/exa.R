
req_pkg <- function(pkg) if (!require(pkg, character.only = T)) stop(paste(pkg, "package required"), call. = F)

#' Exasol JDBC Connection
#'
#' ...
#'
#' @export
exa_jdbc <- function(host, port = 8563L, user, password, schema = 'public', ...) {
  lapply(c('RJDBC', 'rJava'), req_pkg)
  args <- as.list(environment())

  options(java.parameters = '-Xmx2g')
  .jinit()
  message('Java version: ', .jcall("java/lang/System", "S", "getProperty", "java.version"))

  jdbcDriver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = packageName()), 'jdbc/exajdbc.jar'),
    identifier.quote="\""
  )

  jdbcConnection <- dbConnect(
    jdbcDriver,
    infuse("jdbc:exa:{{host}}:{{port}};schema={{schema}};user={{user}};password={{password}}", args)
  )

  return(jdbcConnection)
}

#' Exasol ODBC Connection
#'
#' ...
#'
#' @export
exa_odbc <- function(host, port = 8563L, user, password, ...) {
  lapply(c('RODBC'), req_pkg)
  args <- as.list(environment())
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
exa_query <- function(con, sql, ...) {
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)

  res <-
    if ('JDBCConnection' %in% class(con)) RJDBC::dbGetQuery(con, q)
    else if ('RODBC' %in% class(con)) RODBC::sqlQuery(con, q)
    else stop('Unsupported connection')

  data.table(res)
}
