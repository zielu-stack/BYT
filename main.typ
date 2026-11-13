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
#spis-tabel()

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

#tabela-wymagan("Wymagania funkcjonalne", (
  [Użytkownik loguje się loginem i hasłem. Przy błędnych danych system odmawia
    dostępu, nie wskazując, które pole jest niepoprawne.],
  [Użytkownik wylogowuje się, a system unieważnia sesję.],
  [System udostępnia funkcję wyłącznie roli, która ma do niej uprawnienie.],
  [#aktor[Dziekanat] wprowadza dane osobowe, dane kontaktowe i ulubiony LLM
    kandydata.],
  [#aktor[Dziekanat] poprawia dane osobowe i kontaktowe kandydata, studenta
    lub pracownika.],
  [#aktor[Dziekanat] odnajduje osobę po nazwisku lub numerze albumu.],
  [#aktor[Dziekanat] zmienia status kandydata na studenta; system zakłada mu
    dziennik i plan indywidualny.],
  [#aktor[Student] przegląda wyłącznie własny dziennik: oceny, osiągnięcia,
    opłaty i stypendia.],
  [#aktor[Pracownik akademicki] wystawia ocenę za zajęcia, które prowadzi.],
  [#aktor[Pracownik akademicki] zmienia wystawioną przez siebie ocenę.],
  [#aktor[Pracownik akademicki] usuwa wystawioną przez siebie ocenę; operacja
    trafia do dziennika zdarzeń.],
  [#aktor[Pracownik akademicki] dopisuje osiągnięcie do dziennika studenta.],
  [#aktor[Dziekanat] rejestruje opłatę; system przelicza saldo studenta.],
  [#aktor[Dziekanat] przyznaje studentowi stypendium na wskazany okres.],
  [Zalogowany użytkownik przegląda ogólny plan zajęć uczelni.],
  [#aktor[Student] i #aktor[Pracownik akademicki] przeglądają własny plan
    indywidualny.],
  [#aktor[Pracownik akademicki] zgłasza zmianę we własnym planie, podając
    termin i zajęcia. Zmiana otrzymuje status #stan[oczekująca].],
  [#aktor[Dziekanat] nadaje zmianie status #stan[przyjęta] albo
    #stan[odrzucona]. System zapisuje zleceniodawcę zmiany.],
  [#aktor[Dziekanat] prowadzi dane osobowe pracownika akademickiego oraz -
    opcjonalnie - jego wypłatę.],
))


= Wymagania niefunkcjonalne


#tabela-wymagan("Wymagania niefunkcjonalne", (
  [System jest dostępny przez 99,5% czasu w roku akademickim, z oknem
    serwisowym w niedziele od 2:00 do 5:00.],
  [95% żądań zostaje obsłużonych w czasie poniżej 1,5 s przy łączu 10 Mb/s
    i na sprzęcie średniej klasy.],
  [System obsługuje 500 jednoczesnych użytkowników bez przekroczenia czasu
    odpowiedzi z pozycji 2.],
  [Dane osobowe są szyfrowane algorytmem AES-256 w spoczynku, a transmisja
    odbywa się przez TLS 1.3.],
  [Konta o uprawnieniach aktora #aktor[Dziekanat] wymagają drugiego składnika
    uwierzytelniania przy każdym logowaniu.],
  [Kopia zapasowa powstaje co 24 h. Po awarii system odtwarza dane sprzed nie
    więcej niż 24 h w czasie nieprzekraczającym 4 h.],
  [Operacje wystawienia, zmiany i usunięcia oceny trafiają do dziennika
    zdarzeń przechowywanego 12 miesięcy, z identyfikatorem użytkownika
    i znacznikiem czasu.],
  [System realizuje prawo dostępu do danych osobowych i prawo do ich usunięcia
    w ciągu 30 dni od zgłoszenia.],
))

= Diagram przypadków użycia

#diagram(
  image("images/use_case_model.pdf", width: 90%),
  caption: [Przypadki użycia systemu],
)
