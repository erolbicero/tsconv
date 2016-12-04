#' Calculate linear returns for a vector
#'
#' @param timeseriesPriceVector is an xts price vector
#'
#' @return a linear return xts object
#'
#' @examples
#' none
#'
#' @export

#Linear Returns
retVectorL <- function(timeseriesPriceVector)
{
  colIDX <- length(names(timeseriesPriceVector))
  colIDX <- ifelse(colIDX == 0, ncol(timeseriesPriceVector), colIDX)

  result <-
  xts::xts(
    x=(as.double(timeseriesPriceVector[-1,])
       /
         as.double(timeseriesPriceVector[-length(timeseriesPriceVector[, colIDX]),])
    ) - 1
    ,order.by=index(timeseriesPriceVector[-1,])
  )

  return(result)
}
