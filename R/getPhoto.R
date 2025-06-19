library(RCurl)
library(XML)

getPhoto =
    #
    #  imgs = fetchPhotos(sids = rr$Student[1:3],  con = con)
    # 
    #
function(sid, con = mkPHCon(...),
#         term = "202503",
#         course = "STA 141B A02",
         verbose = FALSE, ...)
{
    tt =  getForm("https://photorosters.ucdavis.edu/profile.cfm",
                    # "https://photorosters.ucdavis.edu/prerequisites/profile.cfm",
                 sid = sid, #  term = term, course = course, pageSize = "*",
                 curl = con)

   doc = htmlParse(tt)
   src = getNodeSet(doc, "//div[contains(@class, 'profile-snapshot')]//img/@src")

   if(length(src) == 0)
       return(NULL)

   decodeImage(src[[1]])
}


decodeImage =
function(x)
{
    y = gsub("^data:image/png;base64,", "", x)
    base64Decode(y, mode = "raw")
}

