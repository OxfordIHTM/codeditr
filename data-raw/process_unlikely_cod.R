

icd11_unlikely_cod <- rvest::read_html(x = "data-raw/value_sets.html") |>
  rvest::html_elements("li") |>
  rvest::html_text() |>
  stringr::str_split(pattern = " ", n = 2) |>
  lapply(FUN = function(x) { names(x) <- c("code", "title"); x }) |>
  dplyr::bind_rows() |>
  dplyr::mutate(
    code = ifelse(
      stringr::str_detect(code, pattern = "^.{2}[0-9]{1}"),
      code, NA_character_
    ),
    title = ifelse(
      stringr::str_detect(code, pattern = "^.{2}[0-9]{1}"),
      title, paste(code, title)
    )
  )

usethis::use_data(icd11_unlikely_cod, compress = "xz")

## ICD 10 unlikely causes of death ----

icd_10_guide <- pdftools::pdf_text("data-raw/ICD10Volume2_en_2019.pdf")


icd10_unlikely_cod <- icd_10_guide |>
  (\(x) x[238:255])() |>
  stringr::str_split(pattern = "\n") |>
  lapply(
    FUN = function(x) ifelse(
      stringr::str_detect(
        string = x,
        pattern = "List of conditions unlikely to cause death|INTERNATIONAL CLASSIFICATION OF DISEASES|[0-9]{3}|Code|HIV|SP3"
      ),
      "", x
    ) |>
      (\(x) x[x != ""])() |>
      stringr::str_trim(side = "left") |>
      stringr::str_replace_all(pattern = "–", replacement = "-") |>
      stringr::str_replace_all(pattern = ", ", replacement = ",")
  )


icd10_unlikely_cod[[2]] <- icd10_unlikely_cod[[2]] |>
  (\(x) c(x[1:23], paste(x[24], x[25]), x[26:27]))() |>
  (\(x) c(x[1:24], paste(x[25], x[26])))()

icd10_unlikely_cod[[3]] <- icd10_unlikely_cod[[3]] |>
  (\(x)
    c(x[1:2], paste(x[3], x[4]), x[5:7], paste(x[8], x[9]),
      x[10:11], paste(x[12], x[13]), paste(x[14], x[15]), x[16:27])
  )()

icd10_unlikely_cod[[4]] <- icd10_unlikely_cod[[4]] |>
  (\(x) c(x[1], paste(x[2], x[3]), x[4:9], paste(x[10], x[11]), x[12:27]))()

icd10_unlikely_cod[[5]] <- icd10_unlikely_cod[[5]] |>
  (\(x) c(x[1:17], paste(x[18], x[19]), x[20:25]))()

icd10_unlikely_cod[[7]] <- icd10_unlikely_cod[[7]] |>
  (\(x) c(x[1:14], paste(x[15], x[16]), x[17:25]))()

icd10_unlikely_cod[[9]] <- icd10_unlikely_cod[[9]] |>
  (\(x) c(x[1:17], paste(x[18], x[19]), x[20], paste(x[21], x[22]), x[23:26]))()

icd10_unlikely_cod[[10]] <- icd10_unlikely_cod[[10]] |>
  (\(x) c(x[1:21], paste(x[22], x[23]), x[24:27]))()

icd10_unlikely_cod[[13]] <- icd10_unlikely_cod[[13]] |>
  (\(x) c(x[1:6], paste(x[7], x[8]), x[9:25]))()

icd10_unlikely_cod[[14]] <- icd10_unlikely_cod[[14]] |>
  (\(x)
    c(paste(x[1], x[2]), x[3:6], paste(x[7], x[8]), x[9:11],
      paste(x[12], x[13]), x[14:20], paste(x[21], x[22]), paste(x[23], x[24]),
      paste(x[25], x[26]), paste(x[27], x[28]),
      paste(x[29], icd10_unlikely_cod[[15]][1]))
  )()

icd10_unlikely_cod[[15]] <- icd10_unlikely_cod[[15]] |>
  (\(x)
    c(paste(x[2], x[3]), paste(x[4], x[5]), paste(x[6], x[7]), x[8],
      paste(x[9], x[10]), x[11:15], paste(x[16], x[17]), x[18:22],
      paste(x[23], x[24]), x[25:28])
  )()

icd10_unlikely_cod[[16]] <- icd10_unlikely_cod[[16]] |>
  (\(x) c(x[1:19], paste(x[20], x[21]), x[22:25], paste(x[26], x[27])))()

icd10_unlikely_cod[[17]] <- icd10_unlikely_cod[[17]] |>
  (\(x)
    c(x[1:11], paste(x[12], x[13]), x[14:16], paste(x[17], x[18]),
      paste(x[19], x[20]), x[21:27])
  )()

icd10_unlikely_cod[[18]] <- icd10_unlikely_cod[[18]] |>
  (\(x) c(x[1:11], paste(x[12], x[13]), x[14], paste(x[15], x[16]), x[17]))()

icd10_unlikely_cod <- lapply(
  X = icd10_unlikely_cod,
  FUN = stringr::str_split,
  pattern = " ",
  n = 2,
  simplify = TRUE
) |>
  (\(x) do.call(rbind, x))() |>
  data.frame() |>
  dplyr::rename_with(.fn = function(x) c("code", "title"))

icd10_unlikely_cod$code[45] <- paste0(
  icd10_unlikely_cod$code[45], icd10_unlikely_cod$code[46]
)

icd10_unlikely_cod$code[75] <- paste0(
  icd10_unlikely_cod$code[75], icd10_unlikely_cod$code[76]
)

icd10_unlikely_cod$code[212] <- paste0(
  icd10_unlikely_cod$code[212], icd10_unlikely_cod$code[213]
)

icd10_unlikely_cod$code[399] <- paste0(
  icd10_unlikely_cod$code[399], icd10_unlikely_cod$code[400]
)

icd10_unlikely_cod$code[409] <- paste0(
  icd10_unlikely_cod$code[409], icd10_unlikely_cod$code[410]
)

icd10_unlikely_cod <- icd10_unlikely_cod |>
  dplyr::filter(title != "") |>
  dplyr::mutate(title = stringr::str_trim(title)) |>
  tibble::tibble()

usethis::use_data(icd10_unlikely_cod, overwrite = TRUE, compress = "xz")
