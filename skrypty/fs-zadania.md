# Model Fellegi-Sunter - Zadania do samodzielnego rozwiązania

---

## Zadanie 1: Podstawowe obliczenie prawdopodobieństwa

### Dane:
**Rekord A:** Piotr Wiśniewski, M, 1978-12-03, Kraków  
**Rekord B:** Piotr Wiśniewski, M, 1978-12-03, Krakow

### Parametry modelu:
| Pole | mᵢ | uᵢ |
|------|----|----|
| Imię | 0.95 | 0.01 |
| Nazwisko | 0.98 | 0.003 |
| Płeć | 0.99 | 0.5 |
| Data ur. | 0.99 | 0.004 |
| Miasto | 0.92 | 0.02 |

**Prawdopodobieństwo wstępne:** P(M) = 0.0002

### Polecenia:
1. Określ wektor porównań γ
2. Oblicz wagi dla każdego pola
3. Oblicz końcowe prawdopodobieństwo dopasowania
4. Zinterpretuj wynik

---

## Zadanie 2: Analiza wpływu błędów na wynik

### Dane:
**Rekord A:** Maria Kowalczyk, K, 1985-07-15, 85071512345  
**Rekord B:** Marta Kowalczyk, K, 1985-07-15, 85071512345

### Parametry modelu:
| Pole | mᵢ | uᵢ |
|------|----|----|
| Imię | 0.88 | 0.015 |
| Nazwisko | 0.96 | 0.002 |
| Płeć | 0.99 | 0.5 |
| Data ur. | 0.99 | 0.003 |
| PESEL | 0.995 | 0.0000005 |

**Prawdopodobieństwo wstępne:** P(M) = 0.0001

### Polecenia:
1. Oblicz prawdopodobieństwo dopasowania
2. Jak zmieniłby się wynik, gdyby imiona były identyczne?
3. Która zmiana ma większy wpływ: błąd w imieniu czy w nazwisku?

---

## Zadanie 3: Porównanie dwóch par rekordów

### Para A:
**Rekord A1:** Jan Nowak, M, 1990-01-10, Warszawa  
**Rekord A2:** Jan Nowak, M, 1990-10-01, Warszawa

### Para B:
**Rekord B1:** Anna Zielińska, K, 1975-03-22, 75032245678  
**Rekord B2:** Anna Zielińska, K, 1975-03-22, 75032245679

### Parametry modelu:
| Pole | mᵢ | uᵢ |
|------|----|----|
| Imię | 0.93 | 0.008 |
| Nazwisko | 0.97 | 0.0025 |
| Płeć | 0.99 | 0.5 |
| Data ur. | 0.98 | 0.003 |
| Miasto/PESEL | 0.95/0.995 | 0.015/0.0000002 |

**Prawdopodobieństwo wstępne:** P(M) = 0.00015

### Polecenia:
1. Oblicz prawdopodobieństwo dopasowania dla pary A
2. Oblicz prawdopodobieństwo dopasowania dla pary B
3. Która para ma większe prawdopodobieństwo dopasowania i dlaczego?
4. Jaki jest wpływ różnych typów błędów na wynik?

---
