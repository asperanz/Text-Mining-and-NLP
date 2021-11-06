library(rmarkdown)

Sys.setenv(RSTUDIO_PANDOC = 'C:/Program Files/RStudio/bin/pandoc')
rmarkdown::render(
  input = "D:/PC3/Operation Ultra/09 - R/Practice & Investigation/Text Mining & NLP (TM&NLP)/SHI - Text mining with tidy data principles/scripts/Transcripts of TED talks.Rmd",
  output_file = "D:/PC3/Operation Ultra/09 - R/Practice & Investigation/Text Mining & NLP (TM&NLP)/SHI - Text mining with tidy data principles/scripts/Transcripts of TED talks.html",
  output_dir = "D:/PC3/Operation Ultra/09 - R/Practice & Investigation/Text Mining & NLP (TM&NLP)/SHI - Text mining with tidy data principles/output"
)