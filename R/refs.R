#' references
#' 
#' @export
#' @param codes One or more Fishbase reference numbers, matching the RefNo 
#' field
#' @param fields a character vector specifying which fields (columns) should be 
#' returned. By default, all available columns recognized by the parser are 
#' returned. This option can be used to limit the amount of data transfered 
#' over the network if only certain columns are needed. 
#' @param server base URL to the FishBase API (by default). For SeaLifeBase, 
#' use https://fishbase.ropensci.org/sealifebase
#' @param ... additional arguments to \code{\link[httr]{GET}}
#' @return a tibble (data.frame) of reference data
#' @examples \dontrun{
#' references(codes = 1)
#' references(codes = 1:6)
#' references(codes = 1:6, fields = c('Author', 'Year', 'Title'))
#' }
references <- function(codes=NULL, fields = NULL, server = getOption("FISHBASE_API", FISHBASE_API)){
  dplyr::bind_rows(lapply(codes, function(z) {
    resp <- httr::GET(paste0(server, "/refrens"), 
                      query = list(RefNo = z, 
                                   fields = paste(fields, collapse = ",")),
                      user_agent(make_ua()))
    check_and_parse(resp)
  }))
}

# make_citation <- function(x) {
#   as.list(
#     x[c('Author', 'Year', 'Title', 'Source', 'RefType', 'ShortCitation', 'RefNo')]
#   )
# }
