#' Exasol JDBC Connection
#'
#' ...
#'
#' @export
jdbc <- function(args = NULL, host, user = 'sys', password, schema = 'public', ...) {
  args <- merge_list(args, as.list(environment()))

  jdbcDriver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = 'exa'), 'jdbc/exajdbc.jar'),
    identifier.quote = '\"'
  )

  jdbcConnection <- dbConnect(
    jdbcDriver,
    infuse("jdbc:exa:{{host}};schema={{schema}};user={{user}};password={{password}}", args)
  )

  return(jdbcConnection)
}


#' @export
query <- function(con, sql, ...) {
  require(data.table)
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)
  res <-
    if ('JDBCConnection' %in% class(con)) RJDBC::dbGetQuery(con, q)
    else stop('Unsupported connection')
  data.table(res)
}

merge_list <- function (x, y, ...){
  if (length(x) == 0) return(y)
  if (length(y) == 0) return(x)
  i = match(names(y), names(x))
  i = is.na(i)
  if (any(i)) x[names(y)[which(i)]] = y[which(i)]
  return(x)
}
