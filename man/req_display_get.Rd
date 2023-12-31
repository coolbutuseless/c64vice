% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/requests.R
\name{req_display_get}
\alias{req_display_get}
\title{Gets the current screen in a requested bit format.}
\usage{
req_display_get()
}
\value{
name list of metainformation including 'img' which contains the 
        colour indices at each memory location.
\describe{
  \item{len}{length of the fields before the display buffer}
  \item{dwidth, dheight}{Raw size of the returned matrix of pixels}
  \item{xoff, yoff}{Offset within the image to the actual screen pixels}
  \item{width, height}{dimensions of screen pixels starting at position (xoff, yoff)}
  \item{bpp}{bits per pixel}
  \item{img}{raw vector of colour at each pixel.}
}
}
\description{
This function returns a matrix which includes the screen capture including
a generous border on each side.
}
\seealso{
[req_palette_get()]
}
