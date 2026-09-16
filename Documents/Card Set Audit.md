# Card Set Audit — v0.5.70

Cross-check of `docs/index.html` (74 cards) against the Advanced Kingdoms
v1.56 rules, the Expanded Kingdoms rules, and `Expanded Kingdoms Card
Reference.md`. Rule numbers below refer to the AK official rules doc.

## Scope — what could NOT be verified

**Card text fidelity against official AK v1.56 is unverified.** No
card-text source for Advanced Kingdoms exists in this repo or in Dropbox.
`Advanced Kingdoms - Official Rules (MTG Salvation).md` documents the *rules*
(roles, setup, Rules 1–9) but contains no individual card text. The only
card-level source on disk is `Expanded Kingdoms Card Reference.md`, which maps
art files to names but gives no ability text either.

To close this gap, one of the following is needed:
- the official v1.56 "Full version" / "Card Fronts Only" PDFs from the forum thread, or
- a scrape of the MTG Salvation thread.

Everything below is verified against what *is* on disk.

---

## 1. Classification mismatches

`Expanded Kingdoms Card Reference.md` marks these as **"Unchanged"** — meaning
they are current Advanced Kingdoms cards — but the viewer classifies them
otherwise:

| Card | Reference says | Viewer has it as | Should be |
|---|---|---|---|
| The Gambler | Renegade, Unchanged | `card-variant` | `card-original` |
| The Witch | Renegade, Unchanged | `card-variant` | `card-original` |
| The Jester | Renegade, Unchanged | `card-ek` only | `card-original` |

Consequence: three canonical AK cards are hidden behind the "Variants" and
"Expanded Kingdoms" filters. A player filtering to **Advanced Kingdoms** sees
an incomplete official set.

Note this also breaks the clean "5 per non-King role" symmetry — the AK
Renegade slot currently shows 5 (Champion, Cultist, Mimic, Sellsword, Straw
Man), so if Gambler/Witch/Jester are genuinely canonical, the Renegade pool is
8 and either the reference doc or the viewer is wrong about which five ship.
**This one needs your call, not a code fix.**

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
- The same doc points at `C:\Users\Kriis\...` paths and a `claude.ai/artifact/...`
  viewer URL. Both are stale; the live viewer is
  https://wernercd.github.io/Kingdoms/
- `workflow.md` lists the live site as `.../kingdoms/` (lowercase), which
  **404s**. The correct URL is `.../Kingdoms/`.

## 4. Legacy card flagged for removal upstream

`The Executioner` is still present in the EK set, but the Expanded Kingdoms
changelog (2018-07-22) records it as **removed — "no counterplay"**. Keep it
as legacy if you like, but it should carry a "removed upstream" note so nobody
puts it in a deck.

---

# Variant card review (37 cards)

## A. Rules-breaking — fix before these see play

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

1. **A1** — High King / Warden King missing Assassins (game-breaking, trivial fix)
2. **A2, A3** — Martyr King and Avenger are non-functional as written
3. **A6 + §2** — duplicate ability and the two "The Champion" cards
4. **A4, A5** — Usurper self-contradiction, Jack designation
5. **§1** — Gambler / Witch / Jester classification (needs your ruling)
6. **B** and **C** — balance and wording passes
