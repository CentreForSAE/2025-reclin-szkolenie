library(stringr)

# Funkcja pomocnicza do normalizacji polskich znaków
normalize_polish <- function(text) {
  text <- toupper(text)
  # Zamiana polskich znaków diakrytycznych na odpowiedniki bez nich
  text <- str_replace_all(text, "Ą", "A")
  text <- str_replace_all(text, "Ć", "C")
  text <- str_replace_all(text, "Ę", "E")
  text <- str_replace_all(text, "Ł", "L")
  text <- str_replace_all(text, "Ń", "N")
  text <- str_replace_all(text, "Ó", "O")
  text <- str_replace_all(text, "Ś", "S")
  text <- str_replace_all(text, "Ź", "Z")
  text <- str_replace_all(text, "Ż", "Z")
  return(text)
}

# Funkcja do kodowania Daitch-Mokotoff Soundex
daitch_mokotoff_soundex <- function(name) {
  if (is.na(name) || name == "") return("")
  
  name <- normalize_polish(name)
  
  # Tablica kodowania zgodna z Daitch-Mokotoff Soundex
  # Format: list(wzór, kod_na_początku, kod_przed_samogłoską, kod_w_innych_sytuacjach)
  coding_table <- list(
    list("SCHTSCH", "2", "4", "4"),
    list("SCHTCH", "2", "4", "4"),
    list("SCHTSH", "2", "4", "4"),
    list("SHTCH", "2", "4", "4"),
    list("SHCH", "2", "4", "4"),
    list("SHTSH", "2", "4", "4"),
    list("STCH", "2", "4", "4"),
    list("STSCH", "2", "4", "4"),
    list("STRZ", "2", "4", "4"),
    list("STRS", "2", "4", "4"),
    list("STSH", "2", "4", "4"),
    list("SZCZ", "2", "4", "4"),
    list("SZCS", "2", "4", "4"),
    list("TCH", "4", "4", "4"),
    list("TTCH", "4", "4", "4"),
    list("TTSCH", "4", "4", "4"),
    list("TSCH", "4", "4", "4"),
    list("TSH", "4", "4", "4"),
    list("ZDZ", "2", "4", "4"),
    list("ZDZH", "2", "4", "4"),
    list("ZHDZH", "2", "4", "4"),
    list("CHS", "5", "54", "54"),
    list("CK", "5", "45", "45"),  # Zakładamy CK jako K (5) lub TSK (45)
    list("CZ", "4", "4", "4"),
    list("CS", "4", "4", "4"),
    list("CSZ", "4", "4", "4"),
    list("CZS", "4", "4", "4"),
    list("DRZ", "4", "4", "4"),
    list("DRS", "4", "4", "4"),
    list("DS", "4", "4", "4"),
    list("DSH", "4", "4", "4"),
    list("DSZ", "4", "4", "4"),
    list("DZ", "4", "4", "4"),
    list("DZH", "4", "4", "4"),
    list("DZS", "4", "4", "4"),
    list("EI", "0", "1", "NC"),
    list("EJ", "0", "1", "NC"),
    list("EY", "0", "1", "NC"),
    list("EU", "1", "1", "NC"),
    list("FB", "7", "7", "7"),
    list("IA", "1", "NC", "NC"),
    list("IE", "1", "NC", "NC"),
    list("IO", "1", "NC", "NC"),
    list("IU", "1", "NC", "NC"),
    list("KH", "5", "5", "5"),
    list("KS", "5", "54", "54"),
    list("MN", "", "66", "66"),
    list("NM", "", "66", "66"),
    list("OI", "0", "1", "NC"),
    list("OJ", "0", "1", "NC"),
    list("OY", "0", "1", "NC"),
    list("RZ", "4", "4", "4"),  # Zakładamy RZ jako ZH (4)
    list("RS", "4", "4", "4"),  # Zakładamy RS jako ZH (4)
    list("SCH", "4", "4", "4"),
    list("SH", "4", "4", "4"),
    list("SHT", "2", "43", "43"),
    list("SCHT", "2", "43", "43"),
    list("SCHD", "2", "43", "43"),
    list("ST", "2", "43", "43"),
    list("SZT", "2", "43", "43"),
    list("SHD", "2", "43", "43"),
    list("SZD", "2", "43", "43"),
    list("SD", "2", "43", "43"),
    list("SZ", "4", "4", "4"),
    list("TRZ", "4", "4", "4"),
    list("TRS", "4", "4", "4"),
    list("TS", "4", "4", "4"),
    list("TTS", "4", "4", "4"),
    list("TTSZ", "4", "4", "4"),
    list("TC", "4", "4", "4"),
    list("TZ", "4", "4", "4"),
    list("TTZ", "4", "4", "4"),
    list("TZS", "4", "4", "4"),
    list("TSZ", "4", "4", "4"),
    list("UI", "0", "1", "NC"),
    list("UJ", "0", "1", "NC"),
    list("UY", "0", "1", "NC"),
    list("ZD", "2", "43", "43"),
    list("ZHD", "2", "43", "43"),
    list("ZH", "4", "4", "4"),
    list("ZS", "4", "4", "4"),
    list("ZSCH", "4", "4", "4"),
    list("ZSH", "4", "4", "4"),
    list("A", "0", "NC", "NC"),
    list("B", "7", "7", "7"),
    list("C", "4", "4", "4"),  # Zakładamy C jako CZ (4), ale może być K (5) lub TZ (4)
    list("D", "3", "3", "3"),
    list("E", "0", "NC", "NC"),
    list("F", "7", "7", "7"),
    list("G", "5", "5", "5"),
    list("H", "5", "5", "NC"),
    list("I", "0", "NC", "NC"),
    list("J", "1", "1", "1"),  # Zakładamy J jako Y (1), ale może być DZH (4)
    list("K", "5", "5", "5"),
    list("L", "8", "8", "8"),
    list("M", "6", "6", "6"),
    list("N", "6", "6", "6"),
    list("O", "0", "NC", "NC"),
    list("P", "7", "7", "7"),
    list("Q", "5", "5", "5"),
    list("R", "9", "9", "9"),
    list("S", "4", "4", "4"),
    list("T", "3", "3", "3"),
    list("U", "0", "NC", "NC"),
    list("V", "7", "7", "7"),
    list("W", "7", "7", "7"),
    list("X", "5", "54", "54"),
    list("Y", "1", "NC", "NC"),
    list("Z", "4", "4", "4")
  )
  
  # Sortowanie tablicy kodów według długości wzorców (od najdłuższych)
  coding_table <- coding_table[order(sapply(coding_table, function(x) nchar(x[[1]])), decreasing = TRUE)]
  
  # Funkcja sprawdzająca, czy znak jest samogłoską
  is_vowel <- function(char) {
    char %in% c("A", "E", "I", "O", "U", "Y")
  }
  
  # Inicjalizacja wyniku
  result <- ""
  prev_code <- ""
  i <- 1
  name_len <- nchar(name)
  
  # Przetwarzanie nazwy
  while (i <= name_len) {
    matched <- FALSE
    for (entry in coding_table) {
      pattern <- entry[[1]]
      pattern_len <- nchar(pattern)
      if (i + pattern_len - 1 <= name_len && substr(name, i, i + pattern_len - 1) == pattern) {
        # Określenie kontekstu
        if (i == 1) {
          code <- entry[[2]]  # Początek nazwy
        } else if (i + pattern_len <= name_len && is_vowel(substr(name, i + pattern_len, i + pattern_len))) {
          code <- entry[[3]]  # Przed samogłoską
        } else {
          code <- entry[[4]]  # Inna sytuacja
        }
        if (code != "NC" && code != "") {
          if (code != prev_code) {
            result <- paste0(result, code)
            prev_code <- code
          }
        } else if (code == "NC") {
          prev_code <- ""
        }
        i <- i + pattern_len
        matched <- TRUE
        break
      }
    }
    if (!matched) {
      i <- i + 1  # Przejdź do następnego znaku, jeśli nie znaleziono dopasowania
    }
  }
  
  # Uzupełnienie zerami do 6 znaków lub obcięcie
  if (nchar(result) < 6) {
    result <- str_pad(result, 6, "right", "0")
  } else {
    result <- substr(result, 1, 6)
  }
  
  return(result)
}

# Funkcja do przetwarzania wektora nazwisk
soundex_vector <- function(names) {
  sapply(names, daitch_mokotoff_soundex, USE.NAMES = FALSE)
}

# Przykłady użycia
polish_names <- c("Kowalski", "Kowalsky", "Kowaliski", 
                  "Nowak", "Novak", "Nowakowski",
                  "Wiśniewski", "Wisniewski", "Wiśniewsky",
                  "Wójcik", "Wojcik", "Wojtczyk",
                  "Lewandowski", "Levandowski")

# Generowanie kodów Soundex
codes <- soundex_vector(polish_names)

# Wyniki
results_df <- data.frame(
  Nazwisko = polish_names,
  SOUNDEX = codes,
  stringsAsFactors = FALSE
)
print("Wyniki Daitch-Mokotoff Soundex dla polskich nazwisk:")
print(results_df)

# Grupowanie podobnych nazwisk
cat("\nGrupowanie podobnych nazwisk:\n")
grouped <- split(results_df$Nazwisko, results_df$SOUNDEX)
for (code in names(grouped)) {
  if (length(grouped[[code]]) > 1) {
    cat("Kod", code, ":", paste(grouped[[code]], collapse = ", "), "\n")
  }
}

# Funkcja do wyszukiwania podobnych nazwisk
find_similar <- function(target_name, name_list) {
  target_code <- daitch_mokotoff_soundex(target_name)
  list_codes <- soundex_vector(name_list)
  
  similar_indices <- which(list_codes == target_code)
  return(name_list[similar_indices])
}

# Przykład wyszukiwania
cat("\nWyszukiwanie nazwisk podobnych do 'Kowalski':\n")
similar_to_kowalski <- find_similar("Kowalski", polish_names)
print(similar_to_kowalski)