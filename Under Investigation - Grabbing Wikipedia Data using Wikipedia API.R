Grabbing Wikipedia Data using Wikipedia API

library(tidyverse)
library(stringi)
library(xml2)

grab_wiki <- function(lang, page) {
  url <- sprintf(
    "https://%s.wikipedia.org/w/api.php?action=parse&format=json&page=%s",
    lang,
    page)
  page_json <- jsonlite::fromJSON(url)$parse$text$"*"
  page_xml <- xml2::read_xml(page_json, asText=TRUE)
  page_text <- xml2::xml_text(xml2::xml_find_all(page_xml, "//div/p"))
  
  page_text <- stringi::stri_replace_all(page_text, "", regex="\\[[0-9]+\\]")
  page_text <- stringi::stri_replace_all(page_text, " ", regex="\n")
  page_text <- stringi::stri_replace_all(page_text, " ", regex="[ ]+")
  page_text <- page_text[stringi::stri_length(page_text) > 10]
  
  return(page_text)
}

penguin <- grab_wiki("en", "penguin")
elvis <- grab_wiki("en", "acdc")
elvis[1:10] # 

# Deconstructing the function

url <- sprintf("https://%s.wikipedia.org/w/api.php?action=parse&format=json&page=%s", "en", "penguin") -- funziona
url2 <- sprintf("https://%s.wikipedia.org/w/api.php?action=parse&format=json&page=%s", "en", "elvis")  -- NON funziona
url3 <- sprintf("https://%s.wikipedia.org/w/api.php?action=parse&format=json&page=%s", "en", "acdc") -- NON funziona