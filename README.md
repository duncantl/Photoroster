
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
dim(ros)
```

##  `getPhoto()`

```
img = getPhoto("123456789")
class(img) # raw
```


## `fetchPhotos()`

```r
imgs = fetchPhotos(ros)
imgs = fetchPhotos(ros, outDir = "Images")
imgs = fetchPhotos(sids = vectorOfSIDs, outDir = "Images")
```


## `mkPhotoSheet()`

```r
mkPhotoSheet(ros, "mySheetl.xlsx")
```
