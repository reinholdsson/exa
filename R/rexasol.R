#' Set up exasol connection
#'
#' ...
#'
#' @export
jdbc_exasol <- function(host, port = 8563L, user = 'sys', password = 'exasol', schema = 'public', ...) {
  args <- as.list(environment())

  if (missing(host)) stop("No host specified. Please provide a valid IP or URL.")

  options(java.parameters = '-Xmx2g')

  # Output Java version
  .jinit()
  print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

  jdbcDriver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = packageName()), 'jdbc/EXASolution_JDBC-5.0.14/exajdbc.jar'),
    identifier.quote="\""
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
