getRoster =
function(course, term = Gradhub::currentTerm(),
         con = mkPHCon(...),
         format = "xls",
         out = paste0(tempfile(), ".", format),
         ...)
{
    v = getForm("https://photorosters.ucdavis.edu/download.cfm",
                term = term,
                course= course,
                format = format,
                binary = TRUE,
                curl = con)

    Gradhub::savePDF(v, out)
    if(!missing(out)) 
        return(out)

    as.data.frame(readxl::read_excel(out, skip = 8))
}


mkPHCon =
function(cookie = getPHCookie(), ...)
{
    getCurlHandle(cookie = cookie, followlocation = TRUE, ...)
}

getPHCookie =
function()
{
    ff = file.path(c(".", "~"), "phroster.cookie")
    e = file.exists(ff)
    if(!any(e))
        stop("no cookie file found")

    readLines(ff[e][1], warn = FALSE)[1]
}


