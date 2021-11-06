---
title: "Luftwaffe Airfields 1935-45 (France with Corsica and Channel Islands)"
author: "Alessandro Speranza"
date: "11/6/2021"
output:
  html_document:
    keep_md: yes
    number_sections: yes
    toc: yes
    toc_float:
      collapsed: no
---

#text_mining
#tidyverse
#pdf_data




```r
library(tidyverse)
library(pdftools)
library(funModeling)
library(here)
```

Data Source: [http://ww2.dk/Airfields%20-%20France.pdf]

# Get the pdf document

```r
here_data <- here("PDF_DAT - Luftwaffe Airfields 1935-45 (France with Corsica and Channel Islands)/data") 

# Download from the web the pdf document
utils::download.file("http://ww2.dk/Airfields%20-%20France.pdf", here("PDF_DAT - Luftwaffe Airfields 1935-45 (France with Corsica and Channel Islands)", "data", "Airfields - France.pdf"), mode = "wb")

# Create the vector pdf which contains all the pdf pages
pdf <- pdftools::pdf_text(here("PDF_DAT - Luftwaffe Airfields 1935-45 (France with Corsica and Channel Islands)", "data", "Airfields - France.pdf"))

# See the text of page 5
base::cat(pdf[5]) #cat function concatenates and prints. it's more useful than the simple pdf[5] 
```

```
##                        Luftwaffe Airfields 1935-45
## 
## 
## A
## Abbeville-Drucat (FR) (a.k.a. Le Plessiel) (50 08 30 N – 01 50 43 E)
## General: airfield (Fliegerhorst) in NE France 4 km N of the city, 1.7 km SW
## of the village of Drucat and 1 km S of Le Plessiel.
## History: In existence since 1922 for civil use with runway extended in 1936
## for military purposes. The Luftwaffe further developed the runways and
## dispersal areas in 1941. Used principally by fighters, but none based there
## after Jan 43 in accordance with decisions made to withdraw Luftwaffe assets
## from the coastal sector.
## Dimensions: approx. 2010 x 1100 meters (2,200 x 1,200 yards).
## Surface and Runways: firm grass surface. The Luftwaffe expanded Drucat
## in 1941 and by 1942 there were 3 concrete runways measuring approx.
## 1650 meters (1,800 yards) aligned NW/SE, 1600 meters (1,750 yards)
## aligned NE/SW and 1465 meters (1,600 yards) aligned E/W x c. 50 meters
## (55 yards) each. Had paved assembly areas at N and W ends plus
## connecting taxiways and perimeter tracks. Permanently equipped for
## instrument landings with a flare-path, a beam approach system and all 3
## runways outfitted with permanent illumination and visual Lorenz systems.
## Fuel and Ammunition: had a refueling loop in the North dispersal area with
## bulk storage reportedly off the center of the S boundary. Ammunition
## dumps were believed to be in a small wood at the N end of the landing area
## and off the SE corner.
## Infrastructure: full service and support facilities with at least one medium
## hangar, workshops and administrative buildings. Had a rail spur connection
## with the north dispersal area. Several small barrack huts, but station
## personnel mostly billeted in the villages of Drucat and Le Plessiel, with a few
## others in Abbeville.
## Dispersal: as of Nov 43, 24 large and 10 small aircraft shelters at the N end
## of the airfield, and 12 large at the S end. A few months later, 6 more small
## shelters were added.
## Defenses: by 1 Oct 43, the airfield was protected by a 6-gun and two 4-gun
## heavy Flak positions together with 21 light Flak positions, all of these within
## 3 km of the center of the field. A system of defense trenches with
## numerous machine gun positions surrounded the airfield.
## Satellites and Decoys:
##    Abbeville – Port-le-Grand (50 10 00 N – 01 44 50 E), dummy 7.5 km
## NW of Abbeville-Drucat airfield and 1.6 km N of the village of Port-le-Grand.
## Situated in open agricultural land and fully illuminated.
##    Estrées-les-Crécy (50 15 00 N – 01 57 10 E), decoy c. 13.5 km NNE of
## Abbeville-Drucat airfield. A former French landing ground with replica
## aircraft parked around the landing area that was obstructed with poles and
## wires. However, Estrées-les-Crécy was listed as operational in May 1942
## 
## 
##                                         -3-
```

```r
# Retrieve pdf info about the author, version, etc
info <- pdf_info(here("PDF_DAT - Luftwaffe Airfields 1935-45 (France with Corsica and Channel Islands)", "data", "Airfields - France.pdf"))
```

Proceed with tutorial [https://r-posts.com/how-to-extract-data-from-a-pdf-file-with-r/]
