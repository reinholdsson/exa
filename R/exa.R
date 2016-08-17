#' @export
jdbc <- function(...) {
  driver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = 'exa'), 'jdbc/exajdbc.jar'),
    identifier.quote = '\"'
  )
  con <- dbConnect(
    driver,
    infuse('jdbc:exa:{{host}};schema={{schema|public}};user={{user|sys}};password={{password}}', list(...))
  )
  return(con)
}

#' @export
query <- function(con, sql, ...) {
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)
  RJDBC::dbGetQuery(con, q)
}
