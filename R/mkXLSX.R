mkPhotoSheet =
function(ros, out = "participation.xlsx", dir = "Images")
{
    r = ros
    d = r[, c("Student ID", "Last Name", "First Name")]

    file = file.path(dir, paste0(d$"Student ID", ".png"))
    w = file.exists(file)

    library(openxlsx)
    wb = createWorkbook("Participation Grade")
    addWorksheet(wb, "Participation")
    writeData(wb, 1, d)

    rows = seq(1, nrow(d)) + 1L
    wd = 272
    ht = 272
    fac = 3

    z = invisible(mapply(function(img, idx)
                        insertImage(wb, 1, img, startRow = idx, startCol = 4, width = wd*fac, height = ht*fac, units = "px"),
                  file[w],
                  rows[w]))

    setRowHeights(wb, 1, rows, ht)
    setColWidths(wb, 1, 1:3, c(20, 75, 20))
    if(length(out) && !is.na(out)) {
        saveWorkbook(wb, out, overwrite = TRUE)
        out
    } else
        wb
}

