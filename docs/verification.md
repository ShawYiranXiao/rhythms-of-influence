# Archival packaging verification

Checked on 2026-10-07:

- All seven `.pde` files and the three published aggregate CSV files are byte-identical to the supplied project folder.
- All four SQL query bodies match the author’s original course forum post. Only provenance comments were added.
- Daily dates are valid and unique; all genre values are nonnegative integers.
- All monthly and yearly genre cells reconcile to daily sums.
- The repository contains no database credentials or bundled third-party library binaries.

## Runtime status and known issues

The Processing application is not installed in the inspected packaging environment, so the sketch has not been compiled or interactively re-tested here. The library versions documented in the README were read from the original local library metadata.

The original date fields parse integers without guarding against nonnumeric input. Use numeric input; other text can cause an exception. Keyboard shortcuts are also handled while editing fields. Festival annotations remain unverified historical entries, including a 2024 entry outside the date axis. These behaviors are preserved in this archival edition and have not been silently corrected.
