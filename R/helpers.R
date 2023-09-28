


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Take a screenshot 
#' 
#' @param keep_border keep the borders as part of the screenshot. 
#"        Default: TRUE
#' 
#' @return raster
#' @importFrom grDevices as.raster
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
take_screenshot <- function(keep_border = TRUE) {
  resp <- req_palette_get() |> send_req()
  pal  <- resp$body$pal
  
  resp <- req_display_get() |> send_req(parse_response = TRUE)
  
  snap <- resp$body
  w <- snap$dwidth
  h <- snap$dheight
  
  mat <- pal[snap$img + 1] # lookup colours in palette
  mat <- t(matrix(mat, w, h))
  
  # subset out just the screen. 
  # gets tricky as the screenshot is of a large area, but the 
  # cropped area (specified by widht/height/xoff/yoff) is purely
  # the area without borders.
  
  if (keep_border) {
    border_width  <- 31
    border_height <- 35
  } else {
    border_width  <- 0
    border_height <- 0
  }
  
  # cols <- snap$xoff + seq_len(snap$width ) - 1
  # rows <- snap$yoff + seq_len(snap$height) - 1
  # mat2 <- mat[rows, cols]
  # plot(as.raster(mat2), interpolate = FALSE)
  
  cols <- snap$xoff - border_width  + seq_len(snap$width  + 2 * border_width ) - 1
  rows <- snap$yoff - border_height + seq_len(snap$height + 2 * border_height) - 1
  mat2 <- mat[rows, cols]
  # plot(as.raster(mat2), interpolate = FALSE)
  
  
  as.raster(mat2)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Take a screenshot and save as PNG file
#' 
#' @inheritParams take_screenshot
#' @param filename PNG filename
#' @param scale scale factor applied to image before saving. defualt: 4
#' 
#' @importFrom graphics par 
#' @importFrom grDevices dev.off png
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
save_screenshot <- function(filename, scale = 4, keep_border = TRUE) {
  ras <- take_screenshot(keep_border = keep_border)
  png(filename, scale * ncol(ras), scale * nrow(ras))
  oldpar <- par(mar = c(0, 0, 0, 0))
  on.exit(par(oldpar))
  plot(ras, ann = FALSE, interpolate = FALSE)
  dev.off()
  
  invisible()
}


if (FALSE) {
  
  # ras <- as.raster(t(mat/15))
  ras <- take_screenshot()
  oldpar <- par(mar = c(0, 0, 0, 0))
  plot(ras, ann = FALSE)
  par(oldpar)
  

  
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Run a PRG given as a numeric vector or a filename
#' 
#' @param prg filename or raw/numeric vector
#' @param ... extra arguments passed to \code{send_req()}
#' 
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
run_prg <- function(prg, ...) {
  
  if (is.numeric(prg) || is.integer(prg)) {
    prg <- as.raw(prg)
  } else if (is.raw(prg)) {
    # all good
  } else if (is.character(prg)) {
    prg <- paste0(readLines(prg), collapse = "\n")
  } else {
    stop("Not a prg I understand")
  }
  
  address <- bytes_to_int32(prg[1:2])
  code    <- prg[-c(1:2)]
  
  req_memory_set(code, address) |> send_req()
  
  if (address == 0x0801) {
    cmd <- "RUN\r" 
  } else {
    cmd <- paste("SYS", address, "\r")
  }
  resp <- req_keyboard_feed(cmd) |> send_req(...)
  
  invisible(resp)
}





if (FALSE) {
  
  prg <- as.raw(c(0x00, 0xc0, 0xee, 0x20, 0xd0, 0xee, 0x21, 0xd0, 0x4c, 
                  0x00, 0xc0))
  
  run_prg(prg)
  
  req_reset() |> send_req()
}






