# Daitch-Mokotoff SOUNDEX dla języka polskiego
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
  
  # Polskie połączenia spółgłosek
  text <- str_replace_all(text, "RZ", "R")
  text <- str_replace_all(text, "CH", "H")
  text <- str_replace_all(text, "SZ", "S")
  text <- str_replace_all(text, "CZ", "C")
  text <- str_replace_all(text, "DZ", "D")
  text <- str_replace_all(text, "DŻ", "D")
  text <- str_replace_all(text, "DŹ", "D")
  
  return(text)
}

# Implementacja Daitch-Mokotoff SOUNDEX
daitch_mokotoff_soundex <- function(name) {
  if (is.na(name) || name == "") return("")
  
  # Normalizacja
  name <- normalize_polish(name)
  
  # Tablica kodowania Daitch-Mokotoff (dostosowana do polskiego)
  coding_table <- list(
    # Samogłoski
    "A" = "0", "E" = "0", "I" = "0", "O" = "0", "U" = "0", "Y" = "0",
    
    # Spółgłoski
    "B" = "7", "P" = "7",
    "C" = "4", "K" = "4", "Q" = "4",
    "D" = "3", "T" = "3",
    "F" = "8", "V" = "8", "W" = "8",
    "G" = "5", "J" = "1",
    "H" = "5",
    "L" = "9",
    "M" = "6", "N" = "6",
    "R" = "9",
    "S" = "4", "Z" = "4",
    "X" = "44"
  )
  
  # Podział na znaki
  chars <- strsplit(name, "")[[1]]
  
  # Pierwsza litera zachowywana
  result <- chars[1]
  prev_code <- ""
  
  # Przetwarzanie pozostałych liter
  for (i in 2:length(chars)) {
    char <- chars[i]
    
    # Pobierz kod dla znaku
    code <- coding_table[[char]]
    if (is.null(code)) code <- ""
    
    # Dodaj kod jeśli różny od poprzedniego i nie jest zerem
    if (code != "" && code != "0" && code != prev_code) {
      result <- paste0(result, code)
      prev_code <- code
    } else if (code == "0") {
      prev_code <- ""  # Samogłoski resetują poprzedni kod
    }
  }
  
  # Uzupełnij zerami do 6 znaków lub obetnij
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

# Generowanie kodów SOUNDEX
codes <- soundex_vector(polish_names)

# Wyniki
results_df <- data.frame(
  Nazwisko = polish_names,
  SOUNDEX = codes,
  stringsAsFactors = FALSE
)

print("Wyniki Daitch-Mokotoff SOUNDEX dla polskich nazwisk:")
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