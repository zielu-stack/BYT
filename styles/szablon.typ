// --- 1. Kolory i kroje pisma -----------------------------------------------

#let granat = rgb("#1B4F8A") // kolor wiodący: nagłówki, akcenty
#let szary = rgb("#5F6B7A") // tekst drugorzędny: pagina, podpisy
#let linia = rgb("#D5DCE5") // cienkie linie, ramki tabel
#let bursztyn = rgb("#B45309") // uwagi, statusy
#let czerwien = rgb("#B42318") // ryzyka

#let serif = ("Libertinus Serif", "Times New Roman")
#let sans = ("Inter", "Segoe UI", "DejaVu Sans")
#let mono = ("JetBrains Mono", "DejaVu Sans Mono")


// --- 2. Wyróżnianie w tekście ----------------------------------------------

// Mała plakietka z identyfikatorem.
#let plakietka(tekst, kolor: granat) = box(
  fill: kolor.lighten(90%),
  stroke: 0.5pt + kolor.lighten(55%),
  inset: (x: 4pt, y: 1pt),
  outset: (y: 2.5pt),
  radius: 2pt,
  text(font: mono, size: 0.82em, fill: kolor.darken(12%), tekst),
)

#let wym(id) = plakietka(id) //  #wym("FR-04")
#let stan(s) = plakietka(s, kolor: bursztyn) //  #stan[oczekująca]

// Nazwa aktora systemu:  #aktor[Dziekanat]
#let aktor(nazwa) = text(font: sans, size: 0.92em, weight: "semibold", fill: granat, nazwa)


// --- 3. Wyróżnianie blokowe ------------------------------------------------

// Ramka z kolorowym paskiem po lewej. Trzy gotowe warianty niżej.
#let ramka(etykieta, kolor, tresc) = block(
  width: 100%,
  fill: kolor.lighten(94%),
  stroke: (left: 3pt + kolor),
  inset: 11pt,
  above: 1.3em,
  below: 1.3em,
)[
  #text(font: sans, size: 8.5pt, weight: "bold", fill: kolor.darken(12%))[#upper(etykieta)]
  #v(-0.45em)
  #tresc
]

#let info(tresc) = ramka("Informacja", granat, tresc)
#let uwaga(tresc) = ramka("Uwaga", bursztyn, tresc)
#let ryzyko(tresc) = ramka("Ryzyko", czerwien, tresc)

// Dosłowna wypowiedź klienta — materiał źródłowy, którego nie redagujemy.
#let cytat-klienta(tresc) = block(
  width: 100%,
  fill: rgb("#F5F7FA"),
  stroke: (left: 3pt + szary),
  inset: 13pt,
  above: 1.3em,
  below: 1.3em,
  text(style: "italic", tresc),
)

// Jaskrawy znacznik niedokończonej roboty.
// Przed oddaniem w dokumencie nie powinno zostać ani jedno #dopisac.
#let dopisac(tresc) = box(
  fill: rgb("#FFE8A3"),
  stroke: 1pt + rgb("#C59000"),
  inset: (x: 5pt, y: 2pt),
  outset: (y: 3pt),
  radius: 2pt,
)[
  #text(font: sans, size: 8.5pt, weight: "bold", fill: rgb("#7A5800"))[DO UZUPEŁNIENIA]
  #h(4pt)
  #text(size: 0.92em, tresc)
]

// --- 4. Diagramy i tabela wymagań ------------------------------------------

// Tabela wymagań. Podajesz podpis i listę wymagań, numery wstawiają się same
// — dopisanie wymagania w środku nie zmusza do przenumerowania reszty.
//
//   #tabela-wymagan("Wymagania funkcjonalne", (
//     [Użytkownik loguje się loginem i hasłem.],
//     [Użytkownik wylogowuje się z systemu.],
//   ))
#let tabela-wymagan(podpis, wymagania) = figure(
  table(
    columns: (auto, 1fr),
    align: (center + horizon, left),
    table.header([Lp.], [Wymaganie]),
    ..wymagania.enumerate(start: 1).map(((nr, tresc)) => ([#nr], tresc)).flatten()
  ),
  caption: podpis,
)

// Diagram UML. Własny `kind` sprawia, że diagramy mają osobną numerację
// i osobny spis — nie mieszają się ze zwykłymi obrazkami.
#let diagram(tresc, caption: none) = figure(
  tresc,
  caption: caption,
  kind: "diagram",
  supplement: [Diagram],
)

// Zastępnik grafiki, której jeszcze nie ma — dokument kompiluje się bez pliku.
#let miejsce-na-grafike(opis, wysokosc: 7cm) = block(
  width: 100%,
  height: wysokosc,
  stroke: (paint: szary.lighten(30%), thickness: 1pt, dash: "dashed"),
  radius: 4pt,
  inset: 14pt,
  align(center + horizon)[
    #text(font: sans, size: 9.5pt, weight: "semibold", fill: szary)[MIEJSCE NA GRAFIKĘ]
    #v(0.3em)
    #text(size: 9.5pt, fill: szary, opis)
  ],
)


// --- 5. Spisy --------------------------------------------------------------

#let spis-tresci() = outline(title: [Spis treści], depth: 3)
#let spis-diagramow() = outline(title: [Spis diagramów], target: figure.where(kind: "diagram"))
#let spis-tabel() = outline(title: [Spis tabel], target: figure.where(kind: table))

// --- 6. Strona tytułowa i reguły całego dokumentu --------------------------

#let dokumentacja(
  tytul: "",
  podtytul: "",
  przedmiot: "",
  uczelnia: "",
  wydzial: "",
  grupa: "",
  prowadzacy: "",
  zespol: (), // lista par: (indeks, imię i nazwisko)
  data: datetime.today(),
  miejscowosc: "Warszawa",
  body,
) = {
  // tekst podstawowy
  set text(font: serif, size: 11pt, lang: "pl")
  set par(justify: true, leading: 0.68em, spacing: 1.15em)
  set page(paper: "a4", margin: (top: 3cm, rest: 2.5cm))

  // nagłówki: numeracja 1.1.1, bezszeryfowo, na granatowo
  set heading(numbering: "1.1.")
  show outline: set heading(numbering: none) // spisy bez numeru rozdziału

  let rozmiary = (19pt, 13.5pt, 11.5pt)
  show heading: it => {
    if it.level == 1 { pagebreak(weak: true) } // rozdział od nowej strony
    block(above: if it.level == 1 { 0em } else { 1.4em }, below: 0.45em)[
      #text(font: sans, size: rozmiary.at(it.level - 1, default: 11pt), weight: "bold", fill: granat)[
        #if it.numbering != none [#context counter(heading).display() #h(0.5em)]
        #it.body
      ]
    ]
    if it.level == 1 {
      line(length: 100%, stroke: 0.9pt + granat.lighten(45%))
      v(0.7em)
    }
  }

  // w spisie treści rozdziały wytłuszczone, podrozdziały zwykłe
  show outline.entry.where(level: 1): strong

  // tabele: nagłówek na jasnym granacie, cienka siatka
  set table(
    stroke: 0.5pt + linia,
    inset: (x: 8pt, y: 6pt),
    fill: (kolumna, wiersz) => if wiersz == 0 { granat.lighten(90%) },
  )
  show table.cell.where(y: 0): set text(font: sans, weight: "semibold", size: 9.5pt, fill: granat)
  show table: set text(size: 9.8pt)

  // podpisy i kod
  show figure.caption: set text(size: 9pt, fill: szary)
  show raw: set text(font: mono, size: 0.88em)

  // ------------------- strona tytułowa -------------------
  page(numbering: none)[
    #set align(center)
    #set par(justify: false)

    #text(font: sans, size: 12pt, weight: "semibold", fill: granat)[#upper(uczelnia)]
    #v(-0.4em)
    #text(font: sans, size: 10pt, fill: szary)[#wydzial]
    #v(0.5em)
    #line(length: 100%, stroke: 1.2pt + granat)

    #v(5cm)

    #text(font: sans, size: 10pt, weight: "medium", fill: szary, tracking: 2pt)[
      #upper[Dokumentacja projektowa]
    ]
    #v(0.9em)
    #text(font: sans, size: 23pt, weight: "bold")[#tytul]
    #v(0.6em)
    #text(font: sans, size: 13pt, fill: szary)[#podtytul]
    #v(0.9em)
    #line(length: 40%, stroke: 0.8pt + granat.lighten(40%))

    #v(1.4cm)

    #text(size: 10pt, fill: szary)[#grupa]

    #v(1.2cm)

    #text(font: sans, size: 9.5pt, weight: "semibold", fill: szary, tracking: 1.2pt)[
      #upper[Zespół projektowy]
    ]
    #v(0.6em)
    #grid(
      columns: (auto, auto),
      column-gutter: 14pt,
      row-gutter: 6pt,
      align: (right, left),
      ..zespol.map(osoba => (text(font: mono, size: 9pt, fill: szary, osoba.indeks), osoba.imie)).flatten()
    )

    #v(1fr)
    #text(size: 10pt, fill: szary)[
      #miejscowosc, #data.display("[day].[month].[year]")
    ]
  ]

  // ------------------- pozostałe strony -------------------
  set page(
    header: {
      set text(font: sans, size: 8.5pt, fill: szary)
      tytul
      v(-0.6em)
      line(length: 100%, stroke: 0.5pt + linia)
    },
    footer: context {
      set text(font: sans, size: 8.5pt, fill: szary)
      align(center)[
        #counter(page).display("1 / 1", both: true)
      ]
    },
  )
  counter(page).update(1)

  body
}
