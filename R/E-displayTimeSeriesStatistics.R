#' display portfolio risk and return statistics
#'
#' @param linearReturnMatrix a linear return xts matrix
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
displayTimeSeriesStatistics <- function(
 linearReturnMatrix
, benchmark = NA
, portfolioName = "Portfolio"
, benchmarkName = "Benchmark"
, riskFreeRate = 0
){


print(computeTimeSeriesStatistics( linearReturnMatrix = linearReturnMatrix
                                   , benchmark = benchmark
                                   , portfolioName = portfolioName
                                   , benchmarkName = benchmarkName
                                   , riskFreeRate = riskFreeRate
                                  )
      )

}
