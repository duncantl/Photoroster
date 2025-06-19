mkPhotoSheet =
function(ros, out = "participation.xlsx", dir = "Images", dims = c(272, 272), scale = 3)
{
    r = ros
    d = r[, c("Student ID", "Last Name", "First Name")]

    file = file.path(dir, paste0(d$"Student ID", ".png"))
    w = file.exists(file)

    #library(openxlsx)
    wb = openxlsx::createWorkbook("Participation Grade")
    openxlsx::addWorksheet(wb, "Participation")
    openxlsx::writeData(wb, 1, d)

    rows = seq(1, nrow(d)) + 1L
    dims = dims*scale

    z = invisible(mapply(function(img, idx)
                          openxlsx::insertImage(wb, 1, img, startRow = idx, startCol = 4,
                                                width = dims[1], height = dims[2], units = "px"),
                  file[w],
                  rows[w]))

    openxlsx::setRowHeights(wb, 1, rows, dims[1])
    openxlsx::setColWidths(wb, 1, 1:3, c(20, 75, 20))
    if(length(out) && !is.na(out)) {
        openxlsx::saveWorkbook(wb, out, overwrite = TRUE)
        out
    } else
        wb
}

