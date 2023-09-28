

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' Internal helper class for dealing with byte sequences
#' 
#' @import R6
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ByteStream <- R6::R6Class(
  "ByteStream",
  
  public = list(
    
    #' @field vec vector of bytes
    #' @field idx current index within self$vec
    vec = NULL,
    idx = NULL,
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' Initialise
    #' @param vec vector of bytes. will be cast to integer
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    initialize = function(vec) {
      self$vec = as.integer(vec)
      self$idx = 1L
      invisible(self)
    },
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' Advance the indxe pointer without returning the value
    #' @param i number of bytes to advance
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    advance = function(i) {
      self$idx <- self$idx + i
      invisible(self)
    },
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' Consume bytes and return the values
    #' @param n number of bytes to consume
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    consume = function(n) {
      res <- self$vec[self$idx + seq_len(n) - 1L]
      self$advance(n)
      res
    },
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Consume 2 bytes and interpret as a little-endian integer
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    consume_len2 = function() {
      res <- self$vec[self$idx] + 256L * self$vec[self$idx + 1L]
      self$advance(2)
      res
    },
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Consume 4 bytes and interpret as a little-endian integer
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    consume_len4 = function() {
      res <- 
        self$vec[self$idx     ] + 
        self$vec[self$idx + 1L] * 256L + 
        self$vec[self$idx + 2L] * 256L * 256L + 
        self$vec[self$idx + 3L] * 256L * 256L * 256L
      self$advance(4)
      res
    },
    
    
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #' @description Have we reached/exceeded the length of the bytestream
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    eos = function() {
      self$idx > length(self$vec)
    }
    
  )
)


if (FALSE) {
  resp0x31 <- x <- c(
    0x02, 0x02, 0x2a, 0x00, 0x00, 0x00, 0x31, 0x00, 0xff, 
    0xff, 0xff, 0xff, 0x0a, 0x00, 0x03, 0x03, 0xcf, 0xe5, 0x03, 0x00, 
    0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x03, 0x02, 0x0a, 0x00, 0x03, 
    0x04, 0xf3, 0x00, 0x03, 0x37, 0x2f, 0x00, 0x03, 0x38, 0x37, 0x00, 
    0x03, 0x05, 0x22, 0x00, 0x03, 0x35, 0x00, 0x00, 0x03, 0x36, 0x01, 
    0x00, 0x02, 0x02, 0x02, 0x00, 0x00, 0x00, 0x62, 0x00, 0xff, 0xff, 
    0xff, 0xff, 0xcf, 0xe5, 0x02, 0x02, 0x2a, 0x00, 0x00, 0x00, 0x31, 
    0x00, 0xad, 0xde, 0x34, 0x12, 0x0a, 0x00, 0x03, 0x03, 0xcf, 0xe5, 
    0x03, 0x00, 0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x03, 0x02, 0x0a, 
    0x00, 0x03, 0x04, 0xf3, 0x00, 0x03, 0x37, 0x2f, 0x00, 0x03, 0x38, 
    0x37, 0x00, 0x03, 0x05, 0x22, 0x00, 0x03, 0x35, 0x00, 0x00, 0x03, 
    0x36, 0x01, 0x00
  )
  
  resp0x81 <- x <- c(
    0x02, 0x02, 0x2a, 0x00, 0x00, 0x00, 0x31, 0x00, 0xff, 
    0xff, 0xff, 0xff, 0x0a, 0x00, 0x03, 0x03, 0xd1, 0xe5, 0x03, 0x00, 
    0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x03, 0x02, 0x0a, 0x00, 0x03, 
    0x04, 0xf3, 0x00, 0x03, 0x37, 0x2f, 0x00, 0x03, 0x38, 0x37, 0x00, 
    0x03, 0x05, 0x22, 0x00, 0x03, 0x35, 0x00, 0x00, 0x03, 0x36, 0x02, 
    0x00, 0x02, 0x02, 0x02, 0x00, 0x00, 0x00, 0x62, 0x00, 0xff, 0xff, 
    0xff, 0xff, 0xd1, 0xe5, 
    
    0x02, 
    0x02,
    0x00, 0x00, 0x00, 0x00, 
    0x81, 
    0x00, 
    0x02, 0x00, 0x00, 0x00
  )

}


