#' Set up exasol connection
#'
#' ...
#'
#' @export
exasol <- function(user = 'sys', password = 'exasol', host = 'localhost', port = 8563L, schema = 'public', ...) {
  args <- as.list(environment())

  options(java.parameters = '-Xmx2g')

  # Output Java version
  .jinit()
  print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

  jdbcDriver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = packageName()), 'jdbc/EXASolution_JDBC-5.0.14/exajdbc.jar')
  )
  jdbcConnection <- dbConnect(
    jdbcDriver,
    infuse("jdbc:exa:{{host}}:{{port}};schema={{schema}};user={{user}};password={{password}}", args)
  )

  return(jdbcConnection)
}

# #' @export
# query <- function(conn, sql, ...) {
#   dots <- list(...)
#   q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)
#   res <- sqlQuery(conn, q)
#   data.table(res)
# }
