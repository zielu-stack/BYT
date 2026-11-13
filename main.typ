#import "styles/szablon.typ": *

#show: dokumentacja.with(
  tytul: "System informatyczny uczelni „KTAJP”",
  podtytul: "Analiza wymagań i model przypadków użycia",
  uczelnia: "Polsko-Japońska Akademia Technik Komputerowych",
  wydzial: "Wydział Informatyki",
  zespol: (
    (indeks: "s00000", imie: "Imię Nazwisko"),
    (indeks: "s00001", imie: "Imię Nazwisko"),
    (indeks: "s00002", imie: "Imię Nazwisko"),
    (indeks: "s00003", imie: "Imię Nazwisko"),
    (indeks: "s00004", imie: "Imię Nazwisko"),
  ),
  data: datetime(year: 2026, month: 11, day: 13),
)

#spis-tresci()
#spis-diagramow()


= Opis dziedziny problemu

== Wypowiedź klienta

#cytat-klienta[
  Uczelnia „KTAJP” określiła swoje wymagania odnoszące się do systemu
  informatycznego, który pomógłby w produkcji vibecoderów. W systemie powinny
  być przechowywane dane osobowe i kontaktowe potencjalnych vibecoderów oraz
  ich ulubiony LLM. Każdy kandydat powinien mieć swój dziennik przechowujący
  oceny, osiągnięcia i (przede wszystkim) opłaty oraz (rzadziej) stypendia.
  System potrzebuje posiadać też ogólny plan zajęć oraz indywidualny,
  dopasowany do każdego studenta i pracownika akademickiego. Pracownik
  akademicki powinien mieć dane osobowe, wypłatę (opcjonalnie). Ma możliwość
  wprowadzenia zmiany w swoim indywidualnym planie. Zmiana powinna mieć swój
  status (oczekująca, przyjęta, odrzucona), zleceniodawcę zmiany oraz termin
  i zajęcia, których dotyczy. Może też wystawić ocenę, zmienić ją i usunąć.
  Zmiany aprobuje użytkownik-dziekanat, o uprawnieniach rozszerzających
  uprawnienia pracownika akademickiego. System powinien działać.
]

= Wymagania funkcjonalne

= Wymagania niefunkcjonalne

= Diagram przypadków użycia

#diagram(
  image("images/use_case_model.pdf", width: 90%),
  caption: [Przypadki użycia systemu],
)
