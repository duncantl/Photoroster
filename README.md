
# Photoroster

This package makes queries UC Davis' Photoroster Web system
to get

+ a course roster
+ a student's photo
+ the photos of all students in a course

It can also arrange the photos into a spreadsheet, along with the students' names and SIDs.


##  `getRoster()`

```r
ros = getRoster("STA 141B A", "202503")
```
returns a data.frame with a row for each student in the course.

##  `getPhoto()`

```
img = getPhoto("123456789")
class(img) # raw
```


## `fetchPhotos()`

```r
imgs = fetchPhotos(ros)
```
returns a list of `raw` vectors, one for each student in the roster.

```r
imgs = fetchPhotos(ros, outDir = "Images")
```
saves each image to the `Images` directory as `<sid>.png`
and returns the names of the files.

```r
imgs = fetchPhotos(sids = vectorOfSIDs, outDir = "Images")
```
allows us to specify the SIDs directly rather than via a roster data.frame.


## `mkPhotoSheet()`

```r
mkPhotoSheet(ros, "mySheetl.xlsx")
```
