.onLoad <- function(libname, pkgname) {
  ns <- parent.env(environment())
  
  # Save the previous future.globals.maxSize option (if any) so we can
  # restore it on unload -- required by CRAN policy for packages that
  # modify global options.
  if (!exists("xsdm", envir = ns, inherits = FALSE)) {
    old_op <- getOption("future.globals.maxSize")
    assign("xsdm", new.env(), envir = ns)
    assign(".old_future_globals_maxSize", old_op,
           envir = get("xsdm", envir = ns))
  }
  
  op <- options()
  op.xsdm <- list(
    future.globals.maxSize = 8.0 * 1024^3
  )
  toset <- !(names(op.xsdm) %in% names(op))
  if (any(toset)) options(op.xsdm[toset])
}

xsdmStartupMessage <- function()
{
  msg <- c(paste0(
    "              _
__  _____  __| |_ __ ___
\\ \\/ / __|/ _` | '_ ` _ \\
 >  <\\__ \\ (_| | | | | | |
/_/\\_\\___/\\__,_|_| |_| |_|    version ",
    utils::packageVersion("xsdm")),
    "\nType 'citation(\"xsdm\")' for citing this R package in publications.\n"
  )
  
  return(msg)
}

.onAttach <- function(lib, pkg)
{
  # unlock .xsdm variable allowing its modification
  unlockBinding("xsdm", asNamespace("xsdm"))
  # startup message
  msg <- xsdmStartupMessage()
  if(!interactive())
    msg[1] <- paste("Package 'xsdm' version", utils::packageVersion("xsdm"))
  packageStartupMessage(msg)
  invisible()
  
}

.onUnload <- function(libpath) {
  # Restore the option we changed in .onLoad (CRAN policy)
  if (exists("xsdm", envir = parent.env(environment()), inherits = FALSE)) {
    xsdm_env <- get("xsdm", envir = parent.env(environment()))
    if (exists(".old_future_globals_maxSize", envir = xsdm_env, inherits = FALSE)) {
      old_op <- get(".old_future_globals_maxSize", envir = xsdm_env)
      if (!is.null(old_op)) {
        options(future.globals.maxSize = old_op)
      }
    }
  }
  library.dynam.unload("xsdm", libpath)
}
