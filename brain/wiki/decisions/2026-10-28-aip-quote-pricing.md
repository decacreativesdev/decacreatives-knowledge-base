---
type: decision
status: superseded
date: 2026-10-28
updated: 2026-10-28
sources:
  - ../../sources/2026/10/2026-10-28-note-aip-quote-pricing.md
  - ../../sources/2026/10/2026-10-28-note-hourly-rate.md
  - ../../sources/2026/10/2026-10-24-aip-quote-brief.md
  - ../../sources/2026/10/2026-10-28-note-aip-quote-v2.md
---

# AIP quote pricing

**Superseded in part 2026-10-28** by [AIP quote v2](2026-10-28-aip-quote-v2.md): the core price is now USD 1,815 fixed, replacing the USD 1,120-1,660 range below. The rate, WP Care and the reasoning still stand.

**Decision:** quote the [Auto Industrial Paints website](../projects/auto-industrial-paints-website.md) now, before the [open questions](2026-10-28-aip-quote-open-questions.md) are answered. Decided by [Joshua Clifford Reyes](../people/joshua-clifford-reyes.md) on 2026-10-28. [pricing note](../../sources/2026/10/2026-10-28-note-aip-quote-pricing.md)

| Item | Price |
|---|---|
| Rate | USD 20 per hour ([rate note](../../sources/2026/10/2026-10-28-note-hourly-rate.md)) |
| Core build, 12 line items | 56-83 hours = USD 1,120-1,660 |
| Optional: form, mega menu, cookie banner, WCAG audit, extra round | priced separately, USD 20-200 each |
| WP Care | USD 40 per site per month, up to 2 hours included, extra at USD 20/h, no email support |

**Why:**

- **Quote now:** Camille needs the cost to pitch, and the [brief](../../sources/2026/10/2026-10-24-aip-quote-brief.md) is specific enough. Each open question became a written assumption; anything that could swing the price became an optional item rather than padding the core.
- **Rate:** the operator's own rate as a Filipino freelance WordPress developer. Amounts are hours x rate, no markup.
- **Hours:** Claude Code's estimate from the brief and the HTML mockups, not from past studio jobs. To be checked once the Figma arrives.
- **WP Care USD 40:** built from about 2 hours of monthly work (updates 0.75, backups 0.25, security 0.25, performance 0.25, report 0.5) at USD 20. Lower would make a month with a broken update unpaid; the 2-hour cap keeps it from becoming open-ended support. Camille resells it with her own fee to Australian clients. USD 35 per site is a sound fallback if she asks for a discount for her ~5 sites. A first figure of USD 50 from general market ranges was dropped in favour of pricing from the operator's rate.

**Line-by-line reasoning:** the repo's [quote rationale](../../../repos/auto-industrial-paints/docs/quote.md) has the why for every line, and `quote.csv` beside it has the line items.

Back to [Decisions](README.md).
