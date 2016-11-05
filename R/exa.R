#' Exasol JDBC Connection
#'
#' Set connection parameters in `file` or pass them as arguments to this function.
#'
#' @param file connection file (defaults to '~/.exa' if no other arguments are provided)
#' @param host host, e.g. 'localhost:8563'
#' @param schema schema (default: 'public')
#' @param user user (default: 'sys')
#' @param password password
#'
#' @export
exa_jdbc <- function(file = NULL, ...) {
  dots <- list(...)

  msg <- function(x) message('Read parameters from ', x, ' ...')

  if (is.null(file) && length(dots) == 0) {
    # if no arguments, then try to read arguments from ~/.exa
    file <- getOption('exa.connection_file')
    dots <- yaml::yaml.load_file(file)
    msg(file)
  } else if (!is.null(file)) { # read arguments from file, if provided
    dots <- yaml::yaml.load_file(file)
    msg(file)
  }

  driver <- JDBC(
    driverClass = 'com.exasol.jdbc.EXADriver',
    classPath = file.path(system.file(package = 'exa'), 'jdbc/exajdbc.jar'),
    identifier.quote = '\"'
  )
  con <- dbConnect(
    driver,
    infuse('jdbc:exa:{{host}};schema={{schema|public}};user={{user|sys}};password={{password}}', dots)
  )

  return(con)
}

#' Query Exasol database
#'
#' @param .con connection
#' @param .sql sql query
#' @param ... use infuser to provide arguments to the sql query
#'
#' @export
exa_query <- function(.con, .sql, ...) {
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(.sql, NULL) else infuse(.sql, ...)
  RJDBC::dbGetQuery(.con, q)
}

#' @export
jdbc <- function(...) {
  .Deprecated('exa_jdbc')
  exa_jdbc(...)
}

#' @export
query.JDBCConnection <- function(...) {
  .Deprecated('exa_query')
  exa_query(...)
}
