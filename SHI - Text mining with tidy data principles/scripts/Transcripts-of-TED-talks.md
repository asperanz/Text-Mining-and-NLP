---
title: "Transcripts of TED talks"
author: "Alessandro Speranza"
date: "9/16/2021"
output:
  html_document:
    keep_md: yes
    number_sections: yes
    toc: yes
    toc_float:
      collapsed: no
---

#text_mining
#ggplot2
#tidyverse

[A-Quick-How-to-On-Labelling-Bar-Graphs-in-ggplot2.md]




```r
library(tidyverse)
library(curl)
library(tidytext)
library(ggrepel)
library(ggalt)
library(here)
library(funModeling)
```

# Get data directly for Julia Silge repository on github (used this method)

```r
ted_talks <- readRDS(gzcon(url("https://github.com/juliasilge/learntidytext/raw/master/data/ted_talks.rds")))

# IMPORTANT!
# 1. ted_talks.rds is a compressed file, so it's neccesary to decompress it using gzcon
# 2. BE CAREFULL! Use the Download button url (dx-click on Download and then Copy link address) to retrieve data: https://github.com/juliasilge/learntidytext/raw/master/data/ted_talks.rds
# NOT use the web page url where the file is located: https://github.com/juliasilge/learntidytext/blob/master/data/ted_talks.rds
```

# Get data from file sytem after having downloaded the rds file from github

```r
# Using the here() package & readr::read_rds function (SUGGESTED)
ted_talks2 <-readr::read_rds(here("SHI - Text mining with tidy data principles", "data", "ted_talks.rds"), refhook = NULL)

# Using relative path (NOT SUGGESTED)
ted_talks2 <-readRDS("./SHI - Text mining with tidy data principles/data/ted_talks.rds") # using readRDS
ted_talks3 <-readr::read_rds("./SHI - Text mining with tidy data principles/data/ted_talks.rds", refhook = NULL) # using readr::read_rds
```

# Look at data

```r
# glimpse `ted_talks` to see what is in the data set
glimpse(ted_talks)
```

```
## Rows: 992
## Columns: 3
## $ talk_id <dbl> 1, 7, 53, 66, 92, 96, 49, 86, 71, 94, 54, 55, 58, 41, 65, 46, ~
## $ text    <chr> "Thank you so much, Chris. And it's truly a great honor to hav~
## $ speaker <chr> "Al Gore", "David Pogue", "Majora Carter", "Ken Robinson", "Ha~
```

# How to tidy text data

```r
tidy_talks <- ted_talks %>% 
  unnest_tokens(word, text, token = "words") # word is the new field which contains the token (single word in this case)
```

# Tokenize to bigrams

```r
ted_bigrams <- ted_talks %>% 
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

ted_bigrams
```

```
## # A tibble: 2,004,350 x 3
##    talk_id speaker bigram     
##      <dbl> <chr>   <chr>      
##  1       1 Al Gore thank you  
##  2       1 Al Gore you so     
##  3       1 Al Gore so much    
##  4       1 Al Gore much chris 
##  5       1 Al Gore chris and  
##  6       1 Al Gore and it's   
##  7       1 Al Gore it's truly 
##  8       1 Al Gore truly a    
##  9       1 Al Gore a great    
## 10       1 Al Gore great honor
## # ... with 2,004,340 more rows
```

# Most common TED talk words

```r
tidy_talks %>% 
  count(word, sort = TRUE)
```

```
## # A tibble: 41,303 x 2
##    word      n
##    <chr> <int>
##  1 the   93853
##  2 and   67710
##  3 to    57089
##  4 of    52313
##  5 a     49129
##  6 that  39019
##  7 in    34728
##  8 i     32793
##  9 you   30013
## 10 is    28569
## # ... with 41,293 more rows
```

# Removing stop words

```r
get_stopwords(language = "en", source = "snowball")
```

```
## # A tibble: 175 x 2
##    word      lexicon 
##    <chr>     <chr>   
##  1 i         snowball
##  2 me        snowball
##  3 my        snowball
##  4 myself    snowball
##  5 we        snowball
##  6 our       snowball
##  7 ours      snowball
##  8 ourselves snowball
##  9 you       snowball
## 10 your      snowball
## # ... with 165 more rows
```

```r
# IMPORTANT: to see in the Console Greek characters digit:  Sys.setlocale("LC_ALL","Greek")
# with this setting I can see English characters in the console as well.
# To come back to the original settings digit: Sys.setlocale("LC_ALL","English")

# To get stopwords in Greek
# get_stopwords(language = "el", source = "stopwords-iso")

tidy_talks %>% 
  anti_join(get_stopwords()) %>% # anti_join works like the SQL MINUS and takes implicitly the column 'word' as key for the join
  count()
```

```
## Joining, by = "word"
```

```
## # A tibble: 1 x 1
##        n
##    <int>
## 1 958132
```

# Visualize top words - Prepare data

```r
tidy_talks %>%
  # remove stop words
  anti_join(get_stopwords()) %>%
  count(word, sort = "TRUE")  %>%
  slice_max(n, n = 20) %>% 
  mutate(word = reorder(word, n)) %>% 
  # put `n` on the x-axis and `word` on the y-axis
  ggplot(aes(word, n)) +
  geom_col()
```

```
## Joining, by = "word"
```

![](Transcripts-of-TED-talks_files/figure-html/visualize_top_words_prepare_data-1.png)<!-- -->

```r
# My version

top_words <- tidy_talks %>%
  # remove stop words
  dplyr::anti_join(tidytext::get_stopwords()) %>%
  # convert the word variable to factor and consider just the first 20 levels based on their occurrences
  # "Other" is included at the end (21st level)
  dplyr::mutate(word = forcats::fct_lump(word, n = 20)) %>%
  # count the number of word occurrences
  dplyr::count(word, sort =  TRUE) %>% 
  # Reorder factor levels by number and then invert the order for plotting reasons
  dplyr::mutate(word = forcats::fct_rev(forcats::fct_inorder(word))) %>%
  # exclude the word "Other" (N.B. the level "Other" remains)
  dplyr::filter(word != "Other")
```

```
## Joining, by = "word"
```

```r
glimpse(top_words)
```

```
## Rows: 20
## Columns: 2
## $ word <fct> can, one, like, people, now, just, going, know, think, see, laugh~
## $ n    <int> 9522, 7995, 7739, 7123, 6756, 6701, 5633, 5467, 4981, 4760, 4707,~
```

```r
# factor levels()
levels(top_words$word)
```

```
##  [1] "go"       "years"    "way"      "world"    "things"   "us"      
##  [7] "time"     "get"      "really"   "laughter" "see"      "think"   
## [13] "know"     "going"    "just"     "now"      "people"   "like"    
## [19] "one"      "can"      "Other"
```

```r
# --->>>> Fare la versione con group by and summarise() e usare ungroup
```

# Visualize top words - Plotting data

```r
# Top words using a barchart
ggplot(top_words, aes(x = n, y = word)) +
  geom_col(fill = 'steelblue') +
  theme_minimal()
```

![](Transcripts-of-TED-talks_files/figure-html/visualize_top_words_plotting_data-1.png)<!-- -->

```r
# Top words using a lollipop
ggplot(top_words, aes(x = n, y = word)) +
  ggalt::geom_lollipop(horizontal = TRUE,
                       point.colour = "steelblue",
                       point.size = 5,
                       color = "#2c3e50",
                       size = 1) +
  ggplot2::labs(x = "frequency", y = "words",
       title = "Top 20 Words Ranking",
       subtitle = "Most 20 common TED talk words",
       caption = "Source: https://www.ted.com/talks") +
  ggplot2::theme_minimal()
```

![](Transcripts-of-TED-talks_files/figure-html/visualize_top_words_plotting_data-2.png)<!-- -->

```r
# 1. mettere in grassetto gli axis lables, togliere le linee orizzonatali aggiungere totali | percentuali
```

# Compare TED talk vocabularies

```r
tidy_talks_compare <- tidy_talks %>%
  filter(speaker %in% c("Jane Goodall", "Temple Grandin")) %>%
  # remove stop words
  anti_join(get_stopwords()) %>%
  # count with two arguments
  count(speaker, word) %>%
  group_by(word) %>%
  filter(sum(n) > 10) %>%
  ungroup() %>%
  pivot_wider(names_from = "speaker", values_from = "n", values_fill = 0) 
```

```
## Joining, by = "word"
```

```r
# Rifare la group by a modo mio
```

# Visualize vocabulary comparison

```r
tidy_talks_compare %>% 
  ggplot(aes(`Jane Goodall`, `Temple Grandin`)) +
  geom_abline(color = "gray50", size = 1, alpha = 0.8, lty = 2) +
  # use the special ggrepel geom for nicer text plotting
  geom_text_repel(aes(label = word)) +
  coord_fixed()
```

![](Transcripts-of-TED-talks_files/figure-html/visualize_vocabulary_comparison-1.png)<!-- -->

