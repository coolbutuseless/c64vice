% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/requests.R
\name{req_resource_get}
\alias{req_resource_get}
\title{Get a resource value from the emulator. See section 6.1 Format of resource files.}
\usage{
req_resource_get(resource)
}
\arguments{
\item{resource}{resource name. See \url{https://vice-emu.sourceforge.io/vice_6.html#SEC84}}
}
\value{
named list of 'type' of value (string or integer) and 'value'
}
\description{
Get a resource value from the emulator. See section 6.1 Format of resource files.
}
