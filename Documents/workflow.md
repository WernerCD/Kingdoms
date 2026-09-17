# MTG Kingdoms Card Viewer — Development Workflow

## Files

| File | Purpose |
|------|---------|
| `C:/Users/Kriis/Dropbox/MTG/advanced-kingdoms-card-viewer.html` | **THE working copy** — what you open in the browser |
| `C:/Users/Kriis/Dropbox/MTG/kingdoms-cards-fronts.pdf` | Single-sided printable PDF |
| `C:/Users/Kriis/Dropbox/MTG/kingdoms-cards-doublesided.pdf` | Double-sided print PDF |
| `C:/Users/Kriis/Dropbox/MTG/deploy-kingdoms.ps1` | Deploy script → pushes to GitHub Pages |
| `https://wernercd.github.io/kingdoms/` | Live public site |

## Claude's Edit Workflow

1. **Scratchpad** — Claude edits in its cloud session scratchpad (`advanced-kingdoms-v54.html`). All changes happen here first.
2. **Bump version** — Update `<span class="nav-version">YYYY.MM.DD-NN</span>` on **every** published change. Format: date plus that day's release number.
3. **Copy to outputs** — `cp scratchpad/... /mnt/user-data/outputs/advanced-kingdoms-card-viewer.html`
4. **SendUserFile** — delivers the file to the chat; returns a `file_uuid`.
5. **device_commit_files** — use the `file_uuid` (NOT `stagedPath`) to write to Dropbox:
   ```
   devicePath: C:/Users/Kriis/Dropbox/MTG/advanced-kingdoms-card-viewer.html
   fileUuid: <from SendUserFile result>
   ```
   **Critical:** always use `fileUuid`, never `stagedPath` — the staged path has a caching bug that commits stale versions.

## Card Classes & Filter System

| CSS class | Filter button | Meaning |
|-----------|--------------|---------|
| `card-original` | Advanced Kingdoms | Core AK cards |
| `card-ek` | Expanded Kingdoms | EK-only cards |
| `card-variant` | Variants | House rule / variant cards |
| `card-special` | Specials | Cards with unique cross-table rules (Jack's Guard, Kill Jack) |

Special cards also carry their role class (`card cn`, `card cr`, etc.) and any other applicable class (`card-variant`).

## Symbol Chip System

Card text uses `{X}` notation which JS converts to styled inline chips at page load:

| Notation | Renders as | CSS class |
|----------|-----------|-----------|
| `{T}` | Gold circle with rotated T | `.sym-tap` |
| `{2}` / `{N}` | Dark circle with number | `.sym-generic` |
| `{C}` | Silver circle with ◆ | `.sym-colorless` |
| `{3 life}` | Red pill with 3♥ | `.sym-life` |

The processor runs on every `.card-sec-text` element on DOMContentLoaded.

## Versioning Convention

- Format: `YYYY.MM.DD-NN` — e.g. `2026.09.17-01`
- `NN` counts the releases within that date, starting at `01`
- Same day, next number; new day, back to `01`
- Lives in two places in `docs/index.html`, which must move together: the
  `.nav-version` badge and the `.card::after` print watermark
- Superseded `v0.MAJOR.PATCH`, which ran to v0.5.84 on 2026-09-17

## PDF Generation

Scripts live in the Claude session scratchpad (regenerate if session expires):
- `make_pdf_single.py` — single-sided, 9 cards/page → `kingdoms-cards-fronts.pdf`
- `make_pdf_double.py` — duplex pairs → `kingdoms-cards-doublesided.pdf`

Both use Playwright (headless Chromium) + BeautifulSoup. Run in Claude's cloud environment; output committed to Dropbox via `device_commit_files`.

## Deploy to GitHub Pages

User runs manually on their machine:
```powershell
C:/Users/Kriis/Dropbox/MTG/deploy-kingdoms.ps1
```

## Session Continuity Notes

- The scratchpad path changes each session: always check the session system reminder for the current path.
- After a context compression, Claude re-reads the scratchpad file to restore state.
- The workflow doc in the project (`claude/workflow.md`) is the durable reference.
