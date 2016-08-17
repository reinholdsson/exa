.onLoad <- function(libname, pkgname){
  require(infuser)
  require(rJava)
  require(RJDBC)

	# Set options
	options(java.parameters = '-Xmx2g')

	# Java info
  .jinit()
  message('Java version: ', .jcall('java/lang/System', 'S', 'getProperty', 'java.version'))

	# Fix to get knitr engines to work!
	setMethod('dbGetRowCount', 'JDBCResult',
		def = function(res, ...) Inf,
		valueClass = 'numeric'
	)
}
