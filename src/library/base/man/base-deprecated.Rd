% File src/library/base/man/base-deprecated.Rd
% Part of the R package, https://www.R-project.org
% Copyright 1995-2024 R Core Team
% Distributed under GPL 2 or later

\name{base-deprecated}
\encoding{UTF-8}
\alias{base-deprecated}
%------ Eventually move entries to ---->> ./base-defunct.Rd
%------ NOTE:  ../R/Deprecated.R   must be synchronized with this!
\title{Deprecated Functions in Package \pkg{base}}
%------ PLEASE: put \alias{.} here for EACH !
\alias{is.R}
\alias{as.data.frame.raw}
\alias{as.data.frame.logical}
\alias{as.data.frame.integer}
\alias{as.data.frame.numeric}
\alias{as.data.frame.complex}
\alias{as.data.frame.factor}
\alias{as.data.frame.ordered}
\alias{as.data.frame.Date}
\alias{as.data.frame.difftime}
\alias{as.data.frame.POSIXct}
\alias{as.data.frame.noquote}
\alias{as.data.frame.numeric_version}
\description{
  These functions are provided for compatibility with older versions of
  \R only, and may be defunct as soon as the next release.

%% for example 'Spotfire® Enterprise Runtime for R' aka TERR or 'pqR'
  \code{is.R} tests if it is not running under historical dialects of S
  (including S-PLUS), but cannot exclude other (including future)
  programs claiming compatibility with \R.  Its historical definition
  was
\preformatted{
  exists("version") && !is.null(vl <- version$language) && vl == "R"
}
  which always evaluates to \code{TRUE} in \R.

  The 12 \code{as.data.frame.<cls>} methods have been informally deprecated
  already for \R 4.3.z (via environment variable \env{R_CHECK_AS_DATA_FRAME_EXPLICIT_METHOD},
  but also in package checks) and formally from \R 4.4.0.
  They are replaced typically by \code{\link{as.data.frame}()} or possibly \code{as.data.frame.vector()}.
}
\usage{
is.R()

as.data.frame.raw     (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.logical (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.integer (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.numeric (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.complex (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.factor  (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.ordered (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.Date    (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.difftime(x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.POSIXct (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.noquote (x, row.names=NULL, optional=FALSE, ..., nm=deparse1(substitute(x)))
as.data.frame.numeric_version(x, row.names=NULL, optional=FALSE, ...,
                              nm=deparse1(substitute(x)))
}

\details{
  Deprecated
  functions in standard packages other than the base package are listed in
  \code{help("pkg-deprecated")}, where \samp{pkg} is replaced by the
  name of the package.
}
\seealso{
  \code{\link{Deprecated}}
}
\keyword{internal}
\keyword{misc}
