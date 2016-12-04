#' display portfolio risk and return statistics
#'
#' @param linearReturnMatrix a linear return xts matrix
#' @param weightMatrix a weight xts object, with same number of columns as the linearReturnMatrix
#' @param includeConstituents logical, if TRUE, the output will append the unweighted constituents of the portfolio; defaults to FALSE
#' @param benchmark an xts vector of linear returns; if not NA, then will append this to the resulting xts object; defaults to NA (not inlcuded)
#' @param portfolioName a character string, defaults to "Portfolio"
#' @param benchmarkName a character string, used to rename a benchmark that's included; defaults to "Benchmark"
#' @param riskFreeRate a numeric value, presumably greater than 0, small and positive, that's passed to the Sharpe Ratio calculations
#'
#' @return prints summary statistics output including annualized risk, return, Sharpe Ratio, Drawdown, VaR, ETL, Skew, Kurtosis and Information Ratio
#'
#' @examples
#' FUNCTION STILL UNDER DEVELOPMENT
#'
#' @export
displayPortfolioStatistics <- function(
 linearReturnMatrix
, weightMatrix
, includeConstituents = TRUE
, benchmark = NA
, portfolioName = "Portfolio"
, benchmarkName = "Benchmark"
, riskFreeRate = 0
){



  print(computePortfolioStatistics(  linearReturnMatrix = linearReturnMatrix
                                     , weightMatrix = weightMatrix
                                     , includeConstituents = includeConstituents
                                     , benchmark = benchmark
                                     , portfolioName = portfolioName
                                     , benchmarkName = benchmarkName
                                     , riskFreeRate = riskFreeRate
  )
  )

}
