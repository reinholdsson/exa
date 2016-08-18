#' @export
jdbc <- function(file = NULL, ...) {
  dots <- list(...)

  msg <- function(x) message('Read parameters from ', x, ' ...')

  if (is.null(file) && length(dots) == 0) { # if no arguments, then try to read arguments from ~/.exa
    file <- file.path(path.expand('~'), '.exa')
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

#' @export
query <- function(con, sql, ...) {
  dots <- list(...)
  q <- if (length(dots) == 0) infuse(sql, NULL) else infuse(sql, ...)
  RJDBC::dbGetQuery(con, q)
}

#' @export
