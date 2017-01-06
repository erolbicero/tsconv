#' Formats output from computeTimeSeriesStatistics for use in reproducible research output
#'
#' @param TSTable an xts vector or timeseries matrix OR the resulting data.frame output from computeTimeSeriesStatistics
#' @param benchmark an optional benchmark for use with an xts TSTable object (ignored if TSTable is a data.frame)
#'
#' @return a formatted kable table
#'
#' @examples
#' none
#'
#' 
#' @export
formatTSTable <- function(TSTable, benchmark = NA){

  if(class(TSTable)[1] == "xts"){resultTable <- computeTimeSeriesStatistics(linearReturnMatrix = TSTable, benchmark = benchmark)
  } else {
    resultTable <- TSTable
  }
percentRows <- c(1,2,3,6,8,9,10,11,12)
numberRows <- 1:nrow(resultTable)
numberRows <- numberRows[!(numberRows %in% percentRows)]
resultTable[percentRows,] <- round(resultTable[percentRows,],4)*100
resultTable[numberRows,] <- round(resultTable[numberRows,],2)

for(n in 1:ncol(resultTable)){
resultTable[,n]<- as.character(resultTable[,n])
resultTable[percentRows,n]<- paste0(resultTable[percentRows,n],"%")
}

return(knitr::kable(resultTable, digits = 2))
}