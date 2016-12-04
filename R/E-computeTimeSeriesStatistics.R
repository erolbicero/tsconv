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
computeTimeSeriesStatistics <- function(
 linearReturnMatrix
, benchmark = NA
, portfolioName = "Portfolio"
, benchmarkName = "Benchmark"
, riskFreeRate = 0
){

scalingFactor <-
switch(xts::periodicity(linearReturnMatrix)$scale
        , daily = 252
        , weekly = 52
        , monthly = 12
        , quarterly = 4
        , yearly = 1
      )

portfolioStatistics <-
rbind(
  PerformanceAnalytics::Return.annualized(R = linearReturnMatrix
                                        , scale = scalingFactor
                                        )
, PerformanceAnalytics::StdDev.annualized(x = linearReturnMatrix
                                          , scale = scalingFactor
                                        )
, PerformanceAnalytics::SemiDeviation(R = linearReturnMatrix)*sqrt(scalingFactor)

, PerformanceAnalytics::SharpeRatio.annualized(R = linearReturnMatrix, scale = scalingFactor, Rf = riskFreeRate)
, PerformanceAnalytics::AdjustedSharpeRatio(R = linearReturnMatrix, scale = scalingFactor, Rf = riskFreeRate)
, PerformanceAnalytics::AverageDrawdown(R = linearReturnMatrix)
, PerformanceAnalytics::AverageRecovery(R = linearReturnMatrix)
, `VaR 95` = PerformanceAnalytics::VaR(R = linearReturnMatrix, p = 0.95, method = "historical")
, `VaR 99` = PerformanceAnalytics::VaR(R = linearReturnMatrix, p = 0.99, method = "historical")
, `ETL 95` = PerformanceAnalytics::ETL(R = linearReturnMatrix, p = 0.95, method = "historical")
, `ETL 99` = PerformanceAnalytics::ETL(R = linearReturnMatrix, p = 0.99, method = "historical")
, `Worst Loss` = if(ncol(linearReturnMatrix) > 1){t(data.frame(apply(linearReturnMatrix,2, min ,na.rm = TRUE)))} else {min(linearReturnMatrix)}
, PerformanceAnalytics::skewness(x = linearReturnMatrix)
, PerformanceAnalytics::kurtosis(x = linearReturnMatrix)
)

#using hard-coded numbers is not ideal, but it's a quick-fix
if(ncol(linearReturnMatrix) == 1){
  rownames(portfolioStatistics)[5] <- paste0("Adjusted Sharpe ratio (Risk free = ",riskFreeRate,")")
  rownames(portfolioStatistics)[8:11] <- c("VaR 95", "VaR 99", "ETL 95", "ETL 99")
  rownames(portfolioStatistics)[12] <- c("Worst Loss")
  rownames(portfolioStatistics)[13:14] <- c("Skewness", "Excess Kurtosis")
}

if(!is.na(unique(benchmark)[1])){
  portfolioStatistics <-
    rbind(portfolioStatistics
      , `Information Ratio` =  sapply(linearReturnMatrix
                , function(x){
                           PerformanceAnalytics::InformationRatio(Ra = x, Rb = benchmark, scale = scalingFactor)
                            }
                            )
    )
}

return(portfolioStatistics)

}
