
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Convert 16bit integer to little endian bytes
#
# e.g. int16_to_bytes(65535) -> c(255,255)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int16_to_bytes <- function(x) {
  stopifnot(
    x >= 0, x <= 65535, length(x) == 1, is.numeric(x)
  )
  
  rvec <- writeBin(as.integer(x), raw(), endian = 'little')
  rvec[1:2]
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Convert 16bit integer to little endian bytes
#
# e.g. int16_to_bytes(65535) -> c(255,255)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int32_to_bytes <- function(x) {
  stopifnot(
    x >= 0, length(x) == 1, is.numeric(x)
  )
  
  rvec <- writeBin(as.integer(x), con = raw(), endian = 'little')
  rvec
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Convert 1-4 bytes into a integer
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
bytes_to_int32 <- function(bytes) {
  if (length(bytes) == 1) {
    bytes
  } else if (length(bytes) == 2) {
    readBin(as.raw(c(bytes, 0, 0)), 'integer', endian = 'little')
  } else if (length(bytes) == 4) {
    readBin(as.raw(bytes), 'integer', endian = 'little')
  } else {
    stop("bytes_to_int32: bad input: ", deparse1(bytes))
  }
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Convert an integer to a 2-digit hex.
# hex(10) -> '0x0a'
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hex <- function(x) {
  sprintf("0x%02x", x)
}

