# Card Set Audit — v0.5.83

Cross-check of `docs/index.html` (80 cards) against the Advanced Kingdoms
v1.56 rules, the Expanded Kingdoms rules, and `Expanded Kingdoms Card
Reference.md`. Rule numbers below refer to the AK official rules doc.

## Method

Every card in `docs/index.html` was diffed field-by-field against the `.md`
sidecars in `images-ak/`, `images-ek/` and `images-v/`, matching on card name
**and** `**Badge:**`, comparing role tag, every section label and body, and
flavour text under whitespace/punctuation normalisation.

> **Tooling note.** Until v0.5.80 the extractor matched `card-sec-label">` and
> so silently skipped any section whose label carried a `style` attribute. Only
> three sections in the whole set are styled — `No Jack Present` on both Jack
> cards and `If You Are Jack` on Kill Jack — all on house variants, so no AK or
> EK result was affected. Fixed to `card-sec-label[^>]*>`; those sections are
> now generated and verified like any other.

## Result: the viewer is a faithful translation

| Set | `.md` sources | Cards in viewer | Text mismatches |
|---|---|---|---|
| Advanced Kingdoms | 21 | 21 | **0** |
| Expanded Kingdoms | 18 | 18 (after this fix) | **0** |

No card text, role tag, victory condition or flavour line differs from its
source. Earlier apparent diffs were artefacts of tag-stripping — the markup
uses `<br/>` and `</ul>` where text appeared to run together, and it renders
correctly.

**The 41 house variants now have sidecars too** (`images-v/`, plus The Gambler
and The Witch in `images-ek/` beside their art). All 76 cards in the viewer now
round-trip against a canonical source: AK 21/21, EK 18/18, Variant 41/41.

## 1. Fixed — two EK cards were missing from the viewer

`images-ek/` documents 18 EK role cards; the viewer had 16.

| Card | Role | Now placed in |
|---|---|---|
| **The Gunslinger** | Bandit (EK) | Assassins section, `card ca card-ek` |
| **The Gladiator** | Renegade (EK) | Renegades section, `card cr card-ek` |

Both added in v0.5.71 with text taken verbatim from their sidecars. Note these
are genuinely distinct cards from the AK ones that reuse their art —
`The Gunslinger` is not `The Marksman`, and `The Gladiator` is not `The Giant`.

## 1b. Correction — `Expanded Kingdoms Card Reference.md` is wrong

That doc marks **The Gambler**, **The Witch** and **The Jester** as
"Unchanged", implying they are current Advanced Kingdoms cards. The `.md`
sidecars — which are authoritative — say otherwise:

| Card | Reference doc claims | Sidecar badge | Viewer | Verdict |
|---|---|---|---|---|
| The Gambler | AK, unchanged | `Variant` | `card-variant` | **viewer correct** (since renamed **The Oddsmaker**) |
| The Witch | AK, unchanged | `Variant` | `card-variant` | **viewer correct** (since renamed **The Hexweaver**) |
| The Jester | AK, unchanged | `EK` | `card-ek` | **viewer correct** |

The viewer was right and the reference doc is stale. `Expanded Kingdoms Card
Reference.md` should be corrected or retired; the sidecars supersede it.

## 1c. House cards renamed off real deck names (v0.5.76)

Three house variants carried names belonging to cards in the real decks, which
made the badge the only thing telling them apart:

| Was | Now | Collided with |
|---|---|---|
| The Paladin | **The Confessor** | EK Knight, added 2018-07-22 |
| The Witch | **The Hexweaver** | EK Renegade |
| The Gambler | **The Oddsmaker** | EK Renegade |

Their sidecars moved to `images-v/`. The EK art they had been reusing
(`images-ek/3The Gambler.jpg`, `4The Witch.jpg`) stays as reference material
but no longer has a sidecar, because the cards it depicts are the *Expanded
Kingdoms* originals, which this set does not carry.

## 1d. Additions and rules alignment (v0.5.77)

**Four new house variants**, chosen to fill gaps the forum reading exposed:

| Card | Role | Fills |
|---|---|---|
| **The Turncoat** | Knight | No defection card existed, despite EK’s Queen (7p, could join either team) and AK’s Sellsword establishing the archetype |
| **The Inquisitor** | Assassin | Role-information play |
| **The Quartermaster** | Bandit | The only Bandit a teammate’s death does **not** defeat — answers the faction fragility the errata highlights |
| **The Broker** | Renegade | Renegade was the thinnest variant pool; engages "teammate", which the errata made load-bearing |

**Quick Ref player counts** now carry 8p and 9p from the official v1.56 table
(the tile previously stopped at 7p, omitting the two largest counts), plus an
unofficial 4-player line drawn from the community proposal and EK’s own 4p rules.

**A residual hole in the official errata.** The Sellsword reads *"That player
becomes your teammate"* — singular — while Rule 2 defines teammates by role
type. If Bandit A hires him, Bandit B could still be required to eliminate him
to satisfy "all non-teammates are eliminated", which trips A’s Defeat, which
then trips B’s. A new **Teammates** tile states that a hired player joins the
whole faction, closing it.

**EK’s The Assassin vs Rule 5.** Its ability claimed to not use the stack and
to be unresponddable — the only card in the set contradicting Rule 5, which
says role abilities *do* use the stack. Errata’d to use the stack; it keeps the
Rule 5 protection against being targeted, countered or exiled.

## 1e. Layout normalised (v0.5.83)

The 80 cards used **27 different section orders**. Every card now uses the
same four slots, always in this order:

| Slot | Absorbs |
|---|---|
| **Victory** | Victory, Bonus Victory |
| **Defeat** | Defeat |
| **Announce** | Announce, Reveal, Royal Decree, Warden’s Judgment, Accuse |
| **Special** | Special, Setup, Passive, Curse, Restriction, Aggression, Warning, Next Upkeep, Flip Reference, If You’re Jack, If No Jack |

Absorbed headings survive as bold lead-ins inside their slot, so no wording
was lost — a King now reads `Special: **Setup:** Keep this card face up…`.

**"Announce" was kept rather than renamed to "Reveal".** Rule 4 defines it
(*"To Announce, turn your face-down role card face up…"*), 32 official AK/EK
cards use it, and the rules docs and Quick Ref both depend on it. The 12 house
cards that said "Reveal" were renamed to Announce instead.

> **Consequence to watch:** with Setup folded into Special, a King’s starting
> life now appears in the last section rather than the first. Promoting Setup
> back to its own leading slot is a one-line change to the slot map.

### Two pre-existing gaps this surfaced

- **The Imposter** (EK) has **no Victory condition at all** — its sections were
  `Accuse > Special` before and `Announce > Special` now. A role card with no
  win condition cannot be played as written.
- **The Usurper** (variant) has only a Victory section, because the v0.5.72
  rewrite folded everything into it.

## 2. Duplicate card names

| Name | Instances | Severity |
|---|---|---|
| The King | AK King + EK King | Benign — same role, two eras |
| **The Champion** | AK **Renegade** + variant **Knight** | **Collision** |

Two entirely different cards share the name "The Champion" across different
factions. Rename the variant Knight (suggestion: **The Vanguard**).

## 3. Stale documentation

- `Expanded Kingdoms Card Reference.md` claims the viewer has "art watermarks
  embedded". It does not — `docs/index.html` contains **zero** `<img>` tags and
  no `url()` backgrounds. Cards are drawn with CSS sigils and gradients.
- The same doc points at `C:\Users\Kriis\...` paths, an `images/` folder that
  no longer exists (now `images-ak/` and `images-ek/`), and a
  `claude.ai/artifact/...` viewer URL. All stale; the live viewer is
  https://wernercd.github.io/kingdoms/
- `workflow.md`’s lowercase `.../kingdoms/` link is now **correct again** — the
  repository was renamed to lowercase `kingdoms`, so Pages serves that path.

## 4. Legacy card flagged for removal upstream

`The Executioner` is still present in the EK set, but the Expanded Kingdoms
changelog (2018-07-22) records it as **removed — "no counterplay"**. Keep it
as legacy if you like, but it should carry a "removed upstream" note so nobody
puts it in a deck.

---

# Variant card review (37 cards)

## ✓ Applied in v0.5.72

These were fixed in the viewer and in the `images-v/` sidecars:

| # | Card(s) | Change |
|---|---|---|
| A1 | The High King, The Warden King | Added "Assassins," to Victory |
| A2 | The Martyr King | Overrides Knight Defeat; gates Assassin Victory |
| A3 | The Avenger | Replaces Knight Defeat; delays Assassin Victory |
| A4 | The Usurper | Rewritten to mirror The Rightful Heir |
| A5 | Jack's Guard, Kill Jack | ~~Added a Jack designation Setup rule~~ — **reverted in v0.5.80**: both cards already carried a `No Jack Present` section, so the added Setup line duplicated and contradicted it. Jack's Guard's fallback ("you are a standard Knight") was replaced with a secret sworn patron instead. |
| A6 | The Knight → **The Shieldbearer** | Renamed; ability was copied verbatim from The Marksman, replaced with a rally effect |
| §2 | The Champion (Knight) → **The Vanguard** | Resolves the name clash with the AK Renegade |
| C1 | The Infiltrator | Table-talk rule → mechanical 2-life penalty |
| C2 | The Gambler | Throne defined as "the King is alive at game end" |
| C3 | The Poisoner | Restated in Rule 5 terms |
| C4 | The Bounty Hunter | Teammate targets made explicitly legal |

**Still open — balance tuning, needs a ruling** (B1 Cursed Crown maths, B2
Weakened King starting life, B3 Bloodthirsty unwinnable case, B4 Ancient King
blanking The Paladin, B5 Fool + Warmonger forced loss, B6 solo-win cards
colliding, B7 Arsonist threshold, B8 Pacifist griefing). These change game
balance rather than fix contradictions, so they are left as written below.

## A. Rules-breaking — original findings

### A1. The High King and The Warden King omit Assassins from Victory
Both read: *"All Bandits and/or Renegades are eliminated."*
Every other King card (Cursed Crown, Warmonger, Weakened, Martyr,
Bloodthirsty, Ancient) correctly reads *"All **Assassins**, Bandits and/or
Renegades."*

Assassins are present at **every** player count (2 at 5–7 players, 3 at 8–9).
At 5 players the setup is 1 King / 1 Knight / 2 Assassins / 1 Renegade and
there are **no Bandits at all** — so a High King wins the instant the single
Renegade dies, with both Assassins alive and untouched. The game ends before
it starts.

**Fix:** add "Assassins," to both. Near-certainly a copy-paste omission.

### A2. The Martyr King cannot function as written
It says the game continues after the King dies and "Knights retain their win
condition." But every Knight card's Defeat is *"The King is eliminated"*, and
Rule 3 makes a met Defeat condition **immediate elimination**. The Knights die
with him, so there is nobody left to win posthumously.

**Fix — add explicitly:**
> While this card is face up, Knights' Defeat condition is replaced with
> "You are eliminated." Assassin Victory additionally requires that all
> Knights be eliminated.

Without that second sentence the Assassins have already met Victory the
instant the King died (Rule 3, first to meet wins) and the game is over anyway.

### A3. The Avenger has the same Rule 3 collision
"When the King is eliminated, Announce immediately — the game does not end"
fights both the standard Knight Defeat *and* the Assassins' already-satisfied
Victory.

**Fix:** state that it replaces the standard Knight Defeat, and that
*"Assassin Victory does not resolve until the end of your next turn."*

### A4. The Usurper contradicts itself
The Victory line says you **win**; the effect says your life becomes 50, you
take the King's role, and **the game continues**. Those are mutually
exclusive, and it leaves open which King card you inherit.

`The Rightful Heir` (AK, official) already solves this cleanly — mirror it:
> When you eliminate the King, reveal this card. You gain the King role card
> and gain 10 life. The game continues under your reign; you now win under the
> King's Victory condition.

Also: setting life to a flat 50 mid-game is a far bigger swing than the Heir's
+10. Recommend +10.

### A5. The Jack cards need a designation rule
`Jack's Guard` and `Kill Jack` both key off *"the player known at this table as
Jack."* If no one is named Jack the cards are blank; if Jack is the King the
two cards silently become a second Knight and a free Assassin ally.

**Fix:** add a Setup line — *"At game start, the players designate one player
as Jack. If no player is so named, the player to the King's left is Jack."*
Plus a note that `Kill Jack`'s immediate win intentionally overrides Rule 3's
shared-win timing.

### A6. "The Knight" is a duplicate ability with a colliding name
Its Announce is **verbatim** The Marksman's (AK Assassin): *"Creatures lose
hexproof and shroud until end of turn. Deal damage to up to three targets
equal to the highest mana value among permanents you control."*

An Assassin's kit on a Knight card, named after the role itself. Give it a
distinct name and ability.

## B. Balance

### B1. The Cursed Crown inverts its own intent
+20 life (60 total) but 3 unpreventable life per upkeep. That is net-negative
after ~7 of your turns — punishing exactly the long game the King is trying to
reach, and rewarding a fast one.
**Suggestion:** *"lose 3 life at each of your upkeeps until the first player is
eliminated,"* or scale it: *"lose 1 life for each surviving enemy."*

### B2. The Weakened King starts below the table
30 life when everyone else has 40, while being the one public, priority target.
The +10-per-elimination payoff arrives *after* the window in which he dies.
**Suggestion:** start at 40 and keep the +10 scaling.

### B3. The Bloodthirsty King can become mathematically unwinnable
Victory requires a personal kill. If his Knight cleans up the last enemy, no
legal win remains — and eliminating a Knight himself triggers the standard
penalty (lose if you would win that turn). At 5 players there are only 3
enemies to farm.
**Suggestion:** add a fallback — *"If no enemies remain and you have no
personal kill, you win at the beginning of your next end step."*

### B4. The Ancient King blanks The Paladin
"Cannot gain life from any source except this role card's own effects" — but
the card has **no** life-gaining effects, so the exception clause is dead text.
Worse, `The Paladin`'s entire once-per-game is "grant the King 10 life," and
`The Royal Guard` and the AK `Priestess` interaction also degrade.
**Suggestion:** *"except from Knight role cards."* Keeps the drawback, keeps
the Knights playable.

### B5. The Fool + The Warmonger King is a forced loss
`The Fool` face-up **compels** the King to attack him every attack step, and
others may not block or redirect. Killing him makes the King lose.
`The Warmonger` King **must** attack each combat or lose 5 life. Paired, the
King has no legal line to survive.
**Suggestion:** give the King an out — *"the King may decline this attack by
losing 3 life"* — and/or ban the pairing in setup.

### B6. Four solo-win cards can land on the same team
`The Blade`, `The Lone Wolf` (Assassins), `The Last Bandit`, `The Arsonist`
(Bandits) all win alone at their team's expense. Assassins number 2–3 and
Bandits 2–3 per game, so two solo-winners on one faction is likely — and that
faction simply cannot coordinate.
**Suggestion:** cap at **one solo-win card per faction per game**, enforced at
deal time.

### B7. The Arsonist's alternate win is a token-deck freebie
"More non-land permanents than any other surviving player" is trivial for any
go-wide deck, and "when any victory condition is met" doesn't say whose.
**Suggestion:** use an absolute threshold (e.g. 15+ non-land permanents) and
specify it checks only when *another* player's Victory triggers.

### B8. The Pacifist is griefable by accident
Victory is voided if he "ever damage[s] the King directly." Goad, redirects,
damage-doubling, or a symmetrical board wipe (Blasphemous Act) all void it
without his consent — and any opponent who figures out his role can void it
deliberately.
**Suggestion:** narrow to *intentional* damage — *"a spell or ability you
control that targets the King, or combat damage from your attacking
creatures."*

## C. Clarity and enforceability

### C1. The Infiltrator legislates table talk
*"Players may not publicly name you as Assassin… political accusations against
you are void"* is a social rule, unenforceable mid-game, and it suppresses the
accusation-and-bluff loop that is the whole point of the format.
**Suggestion:** make it mechanical — *"The first time each turn a player names
you as an Assassin, they lose 2 life."*

### C2. The Gambler's binary prediction has undefined outcomes
Throne (King's side wins) vs Shadow (King eliminated) doesn't cover a game
ending with the King **alive** but a Renegade or Arsonist winning.
**Suggestion:** define Throne as *"the King is alive at game end."*

### C3. The Poisoner vs Rule 5
"This effect cannot be removed" is fine, but say so in rules language: the
mark is a role-card effect and per Rule 5 cannot be targeted, countered, or
exiled. As written, players will argue about enchantment-removal analogies.

### C4. The Bounty Hunter may be forced to hunt a teammate
Nothing stops the secret target from being a fellow Assassin.
**Suggestion:** state the intent either way — either *"you may name a
teammate; this is intentional"* or allow a one-time re-name on reveal.

---

## Priority order

0. ~~Two EK cards missing from the viewer~~ — **fixed in v0.5.71**
1. **A1** — High King / Warden King missing Assassins (game-breaking, trivial fix)
2. **A2, A3** — Martyr King and Avenger are non-functional as written
3. **A6 + §2** — duplicate ability and the two "The Champion" cards
4. **A4, A5** — Usurper self-contradiction, Jack designation
5. **B** and **C** — balance and wording passes
