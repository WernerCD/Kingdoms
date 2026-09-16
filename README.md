# Kingdoms — a hidden-role Commander variant

**Live card viewer:** https://wernercd.github.io/Kingdoms/ · **Card audit & variant review:** [`Documents/Card Set Audit.md`](Documents/Card%20Set%20Audit.md)

Start here. This explains what this repo is, how the rule sets relate, and
where everything lives.

## The lineage

Three layers stack, each assuming the one beneath it:

1. **Magic: The Gathering** — the base card game.
   → `Documents/MTG Core Rules & How to Play.md`
2. **Commander / EDH** — the multiplayer format Kingdoms is played on top of
   (100-card singleton, commander, 40 life, commander-damage rule).
   → `Documents/Commander Rules & Game Instructions.md`
3. **Kingdoms** — a hidden-role variant layered over a normal Commander game.
   Every player draws a secret role card with its own Victory and Defeat
   conditions and a once-per-game ability.

## Which Kingdoms ruleset is canonical

**Advanced Kingdoms v1.56 is the current, canonical ruleset.** It is the
target that everything else is being merged into.

→ `Documents/Advanced Kingdoms - Official Rules (MTG Salvation).md`
→ Source thread: https://www.mtgsalvation.com/forums/the-game/commander-edh/818991-advanced-kingdoms-edh-variant-feedback-welcome
→ Author: WaRgUnNeR · v1.56

**Expanded Kingdoms is the older, superseded version.** It is retained for
reference and for its card art, and its unique roles are being folded into
the Advanced Kingdoms set.

→ `Documents/Expanded Kingdoms - Original Rules (MTG Salvation).md`
→ Source thread: https://www.mtgsalvation.com/forums/the-game/commander-edh/667501-expanded-kingdoms-a-new-edh-variant
→ Author: Insertcleverphrasehere2 · last updated 2018-07-22

### The renaming trap

EK and AK use the same two words for different factions. This is the single
most common source of confusion:

| Expanded Kingdoms (old) | Border | Advanced Kingdoms v1.56 (current) |
|---|---|---|
| King | — | King |
| Knight | Green | Knight |
| **Bandits** | Red | **Assassins** |
| **Nobles** | Blue | **Bandits** |
| Renegade | Black | Renegade |

So an EK card labelled "Bandit" is an AK **Assassin**, and an EK "Noble" is an
AK **Bandit**. In the viewer the EK cards keep their original labels but are
coloured by their *modern* faction, which is why an EK "Bandit" renders in
Assassin red.

## Card sets in the viewer

76 cards total, filterable by the buttons in the nav:

| Filter | CSS class | Count | What it is |
|---|---|---|---|
| Advanced Kingdoms | `card-original` | 21 | Canonical v1.56 cards |
| Expanded Kingdoms | `card-ek` | 18 | Legacy EK-only roles |
| Variants | `card-variant` | 37 | House-rule cards (not official) |
| Specials | `card-special` | 2 | Cross-table cards (Jack's Guard, Kill Jack) |

`card-special` is additive — those cards also carry `card-variant` and their
role class.

The Advanced Kingdoms set has exactly **five character variants per non-King
role** (5 Knights, 5 Assassins, 5 Bandits, 5 Renegades, 1 King), which matches
the v1.56 rules text.

## Where things live

| Path | What |
|---|---|
| `docs/index.html` | The card viewer — GitHub Pages serves this |
| `docs/*.pdf` | Print-ready card PDFs (fronts, double-sided) |
| `Documents/` | This documentation and the rules references |
| `images-ak/` | Advanced Kingdoms card art + `.md` card text (25 files) |
| `images-ek/` | Expanded Kingdoms Cockatrice art + `.md` card text (45 files) |
| `images-v/` | House variant `.md` card text (35 files, no art yet) |
| `deploy-kingdoms.ps1` | Windows deploy script |

**Live site:** https://wernercd.github.io/Kingdoms/
Note the capital **K** — GitHub Pages paths are case-sensitive and the
lowercase form 404s.

### About the art folders

Each `.jpg` has a matching `.md` sidecar holding that card's text, role, badge
and sigil. **The `.md` files are the source of truth for card text** — the
viewer is generated to match them, so fix the `.md` first.

The `**Badge:**` field in each sidecar says which set the card belongs to
*today*, which matters because EK art is reused for cards that were promoted
into Advanced Kingdoms. Ten cards in `images-ek/` carry `Badge: AK` (Priestess,
Schemer, Necromancer, Wizard, Kingslayer, Queen, Cultist, Sellsword) and two
carry `Badge: Variant` (The Gambler, The Witch). Trust the badge, not the
folder.

- `images-ak/` — 21 AK role cards + 3 War Bear tokens + 1 Game Setup card
- `images-ek/` — EK role cards, 4 tokens, 4 EK rules/intro cards, and 9
  duplicate 960px renders (`960*`)
- `images-v/` — sidecars for the 35 house variants that have no art of their
  own. **The Gambler** and **The Witch** are deliberately absent: they are
  `Badge: Variant` but reuse EK art, so their sidecars stay in `images-ek/`
  next to their `.jpg`. One card, one sidecar.

`docs/index.html` does **not** embed any of this art — it draws cards with CSS
sigils and gradients instead. The art is reference material only.

## Versioning and deploy

Version lives in two places in `docs/index.html` and both must move together:
the `.nav-version` badge and the `.card::after` print watermark.

Bump the patch digit on every published change (`v0.MAJOR.PATCH`); bump major
for a structural redesign. See `Documents/workflow.md` for the full deploy procedure.
