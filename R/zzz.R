.onLoad <- function(libname, pkgname){
  require(rJava)
  require(RJDBC)
  require(infuser)

	# Set options
	options(java.parameters="-Xmx2g")

	# Java info
  .jinit()
  message('Java version: ', .jcall("java/lang/System", "S", "getProperty", "java.version"))

	# Hack to get knitr engines to work!
	setMethod('dbGetRowCount', 'JDBCResult',
		def = function(res, ...) Inf,
		valueClass = 'numeric'
	)
}
