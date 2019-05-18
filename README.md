# Varg

Varg jest językiem obiektowo - funkcyjnym, syntaktycznie podobnym do Haskella i Javy.

## Instalacja i uruchamianie

Aby pobrać najnowszą wersję, warto sprawdzić `git pull`.

Polecenie `make` buduje plik wykonywalny `Varg` (i jego kopię `interpreter`) w bieżącym katalogu, za pomocą systemu `Cabal`. 

Plik uruchomiony bez argumentów domyślnie uruchamia plik `Main.vg`. Plik źródłowy powinien zawierać co najmniej definicję klasy `Main` z funkcją `main` o jednym argumencie `args` typu `List String`, zwracającą `Void`, oraz zaimportowany moduł `Std.List`. Minimalny program wygląda więc następująco:

```
import "Std.Overture"

class Main where
  static function main (args : List String) : Void = 0
```
(ponieważ `Void` jest nadklasą wszystkich obiektów, funkcja `main` może zwracać w ten sposób cokolwiek). 

Aby uruchomić inny plik źródłowy, należy podać jego ścieżkę bez rozszerzenia (np. `Varg examples/1`). Na tym samym poziomie co interpreter powinna się znajdować biblioteka standardowa `Std`. Opcja `-v` uruchamia logi interpretera, opcja `-dN` zmienia głębokość śledzenia stosu w przypadku napotkania błędu wykonania. Domyślną wartością jest `-d20`.

## Funkcjonalność

Na tę chwilę Varg udostępnia standardową arytmetykę liczb całkowitych, zmiennoprzecinkowych, boolowskich, wyrażenia warunkowe, funkcje i definicje rekurencyjne (jedno- i wieloargumentowe) z domknięciami, funkcje anonimowe. 

Obiektowość wspierana jest na razie głównie bez skomplikowanego dziedziczenia (przykład - klasa `String` dziedzicząca po `List Char` w stdlib). Wspierane jest tworzenie typów algebraicznych i polimorficznych, jednak z racji na niezaimplementowane dopasowywanie wzorców, można z nich korzystać jedynie w najprostszych przypadkach (np. klasa `List` z konstruktorem pustym `List.Empty` i `List.Cons`, gdzie można sprawdzać wariant poprzez wyrażenie warunkowe `if this.null then (lista pusta) else (lista niepusta)`). Definicje funkcji wyszukiwane są rekurencyjnie w nadklasach aż do klasy Void, gdzie w ostateczności poszukiwane są natywne metody. Każdy obiekt ma natywną metodę `toString`.

System typów jeszcze nie istnieje, program wykonuje się dopóki nie napotka na błąd (np. dodawanie liczby do funkcji, błąd arytmetyki). Rzuca wówczas wyjątek z danymi śledzenia stosu.

Varg jest językiem leniwym - możliwe jest deklarowanie zmiennych typu `lista = 1:lista`, które są ewaluowane tak daleko, jak trzeba. Aby wymusić ewaluację `:`, np. w celu dobrego otypowania obiektu `String` (operator `:` rzutuje na `List`), należy użyć `:'`.