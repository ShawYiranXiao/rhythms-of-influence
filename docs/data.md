# Data methods and limitations

## Source and workflow

The original project uses Seattle Public Library circulation and subject data made available through the M259 course database. The recovered SQL references the historical `spl_2016` schema; it is documentation of the extraction, not a guarantee that this database is publicly accessible today.

The original query bodies are preserved from [Yiran Xiao’s January 22, 2024 forum post](https://w2.mat.ucsb.edu/forum/viewtopic.php?f=91&t=388#p2599). The supplied CSV files are retained from the original sketch directory. The queries were not re-executed against a database during packaging, so agreement with the current database is not claimed.

1. Join `subject` and `outraw` on `bibNumber`.
2. Select item types matching `cd`, `dvd`, or `bk`, and Dewey classes beginning with `78`.
3. Filter circulation years to 2015–2023.
4. Count subject keyword matches for ten genres, grouped by date, month, or year.
5. Load the daily CSV into Processing for the interactive visualization.

## What a count means

The SQL uses `COUNT(IF(...))` after joining subject records to circulation records. One circulation event can join to more than one subject record, and a record can match more than one genre. Each number is therefore a count of genre-matching joined rows. It should not be described as a distinct number of loans, users, or items. The sum across genres is not a unique checkout count.

## Temporal coverage

The bundled daily table contains 2,851 recorded dates between **2015-01-02 and 2023-12-12**. The monthly and yearly tables contain 104 and 9 rows respectively. No date duplicates or negative genre counts were found. Every monthly and yearly genre value matches the sum of the corresponding daily values.

The exported tables do not cover every calendar date or month. A missing row is not evidence of zero borrowing. The files alone cannot establish why a date is absent. Use “2015–2023” in project descriptions without claiming uninterrupted daily coverage.

## Visual comparison

Daily values determine the size, opacity, and rotation speed of the radial marks. Each genre has its own scaling maximum in the sketch: rock 800, jazz 400, pop 900, and the remaining genres 200. Equal-looking forms across two genres therefore do not necessarily represent equal counts. The view is most appropriate for exploring changes within a genre.

The festival view and circulation view are mutually exclusive modes, rather than a simultaneous data overlay. Festival entries are hardcoded in the original sketch. Their dates and genre associations need review before supporting any event-specific interpretation. One entry is dated in 2024, outside the 2015–2023 circulation window.

## Interpretation

This is an exploratory visualization, not a causal analysis. Timing alone cannot show that a festival changed library use. Keyword classification, overlapping subjects, coverage gaps, changes in library operations, and the distinct visual scales all limit interpretation.

## Other original material

The fourth SQL query retrieves a July 2021 CD-title case study. That title-level CSV is kept in the local original-materials archive; the visualization only needs the daily aggregate CSV.
