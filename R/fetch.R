fetchPhotos =
function(ros = readxl(mostRecent("^Roster"), skip = 8),
         con = mkPHCon(),
         sids = ros$"Student ID",
         outDir = NA
        )
{
    imgs = lapply(sids, getPhoto, con = con)
    names(imgs) = sids
    
    w = !sapply(imgs, is.null)

    if(length(outDir) && !is.na(outDir)) {
        file = file.path(outDir, paste0(sids, ".png"))
        mapply(writeBin, imgs[w], file[w])
        invisible(file)
    } else
        invisible(imgs)    
}

if(FALSE) {
    url0 = "https://photorosters.ucdavis.edu/profile.cfm?sid="
    urls = paste0(url0, sids)

    docs = lapply(urls, function(u) try(getURLContent(u, curl = con)))
    names(docs) = sids

    docs = lapply(docs, htmlParse)
    src = lapply(docs, function(doc) getNodeSet(doc, "//img/@src[starts-with(., 'data:image')]"))

    w = sapply(src, length) > 0
    imgs = list()
    imgs[w] = lapply(src[w], decodeImage)
    names(imgs) = sids
    

}



