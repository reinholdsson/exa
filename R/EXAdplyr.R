
# dplyr methods ------------------------------------------------------------------

#' @export
src_exasol <- function(...) {
  if (!require(dplyr)) stop("Please install dplyr: install.packages('dplyr')")
  con <- jdbc_exasol(...)

  env <- environment()
  EXAConnection <- methods::setRefClass(
    "EXAConnection",
    contains = c("JDBCConnection"),
    where = env
  )
  con <- structure(con, class = c("EXAConnection", "JDBCConnection"))

  dplyr::src_sql("exasol", con)
}


#' @export
#' @rdname src_exasol
tbl.src_exasol <- function(src, from, ...) {
  dplyr::tbl_sql("exasol", src = src, from = from, ...)
}

# DBI methods ------------------------------------------------------------------


#
# setMethod(
#   "dbListFields", signature("src_exasol"),
#   definition = function(conn, name, schema, ...) {
#
#     if (missing(schema)) {
#       ids <- EXAGetIdentifier(name, statement = FALSE)
#       # try to grep schema from stmt
#       if (length(ids)>0) {
#         schema <- ids[[length(ids)]][1]
#         name <- ids[[length(ids)]][2]
#       }
#       if (schema != "" & schema != "\"\"") {
#        # message(paste("Using Schema from statement:", schema))
#       } else {
#          # message(paste("Using connection schema: ", con@current_schema))
#           schema <- con@current_schema
#       }
#     }
#     schema <- processIDs(schema, quotes = "'")
#     name <- processIDs(name, quotes = "'")
#
#     qstr <- paste0("select column_name from exa_all_columns where column_schema = ", schema, " and
#                    column_table = ", name, " order by column_ordinal_position")
#     res <- exa.readData(conn, qstr, ...)
#     return(res$COLUMN_NAME)
#   })
#
# #' @export
# src_desc.src_exasol <- function(con) {
#   info <- dbGetInfo(con$con)
#   host <- if (info$host == "") "localhost" else info$host
#
#   paste0("EXASOL ", info$db.version, " [", info$username, "@",
#          host, ":", info$port, "]")
# }
#
#
#
# db_list_tables.src_exasol <- function(con, schema, ...) {
#   #dbListTables(con$con, schema, ... = ...)
#   "test"
# }
#
#
# #' @export
# db_has_table.src_exasol <- function(con, table, ...) {
#   #dbExistsTable(con$con, table, ...)
# }
#
#
# #' @export
# tbl.src_exasol <- function(src, from, ...) {
#   tbl_sql("exasol", src = src, from = ident(from), ...)
# }
#
# #' @export
# src_translate_env.src_exasol <- function(x) {
#   sql_variant(
#     base_scalar,
#     sql_translator(.parent = base_agg,
#                    n = function() sql("count(*)"),
#                    cor = sql_prefix("corr"),
#                    cov = sql_prefix("covar_samp"),
#                    sd =  sql_prefix("stddev_samp"),
#                    var = sql_prefix("var_samp"),
#                    all = sql_prefix("bool_and"),
#                    any = sql_prefix("bool_or"),
#                    paste = function(x, collapse) build_sql("string_agg(", x, ", ", collapse, ")")
#     ),
#     base_win
#   )
# }
#
# #' @export
# db_explain.EXAConnection <- function(con, ...) {
#   stop("EXPLAIN statement is currently unsupported.")
# }
#
#
# #' @export
# copy_to.src_exasol <- function(dest, df, name = deparse(substitute(df)), ...) {
#   # TODO: tbl/schema identifier handling as in src_exasol
#   df<- as.data.frame(df)
#   dbWriteTable(dest$con, name, df, ...)
#   tbl(dest, name)
# }
