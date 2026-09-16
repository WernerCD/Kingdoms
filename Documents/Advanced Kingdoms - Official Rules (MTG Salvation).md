# Advanced Kingdoms — Official Rules (v1.56)
**Source:** [MTG Salvation Forum Thread](https://www.mtgsalvation.com/forums/the-game/commander-edh/818991-advanced-kingdoms-edh-variant-feedback-welcome)
**Author:** WaRgUnNeR · Latest Version: 1.56

---

## Overview

Advanced Kingdoms is a custom Magic: The Gathering variant based on 'Kingdoms' and largely modified from 'Expanded Kingdoms'. It is a **5+ player format** that uses secret roles with special abilities, played on top of a regular game of Commander. Set in the world of Eldraine.

The biggest difference from normal Kingdoms: each non-King role has **five different character variants** of that role type. Within any game you can never be sure which specific character occupies each role until it is revealed.

---

## Role Types

| Role | Allegiance | Goal |
|------|-----------|------|
| **King** | Public | Survive; last ruler standing |
| **Knights** | King's side | Protect the King; win when he wins |
| **Assassins** | Enemy | Kill the King |
| **Bandits** | Enemy | Be the last players standing |
| **Renegades** | Wild card | Each has different motivations / win conditions |

---

## Player Count Setup

| Players | King | Knights | Bandits | Assassins | Renegades |
|---------|------|---------|---------|-----------|-----------| 
| 5       | 1    | 1       | —       | 2         | 1         |
| 6       | 1    | 1       | 2       | 2         | —         |
| 7       | 1    | 1       | 2       | 2         | 1         |
| 8       | 1    | 1       | 2       | 3         | 1         |
| 9       | 1    | 2       | 3       | 3         | —         |

---

## How To Play

1. Separate role cards into face-down piles by role type. Shuffle each pile.
2. Based on player count (table above), randomly draw the required number from each pile face-down.
3. Shuffle all selected role cards together and deal one face-down to each player.
4. Players look at their role card and **then choose decks**.
5. **Bandit Reveal** (only when Bandits are used): All players close eyes. Bandits open eyes, identify each other, close eyes. All players open eyes.
6. **The King reveals their role card**, takes the first turn, and starts with **+10 life**.

---

## Advanced Kingdom Rules

All regular Commander rules apply unless contradicted by the following:

**Rule 1 — Roles are face-down at game start** (unless the card says otherwise). Players may not show face-down role cards at any time. When eliminated, reveal your role card if it is face-down.

**Rule 2 — Teammates:** Face-up Knights, Assassins, Bandits, and Renegades are **teammates** (not "opponents") with others of the same role type. Face-up Knights and the King are also teammates.

**Rule 3 — Victory and Defeat are role-card only:**
- Non-role abilities may not win the game or stop a player from winning. Cards saying "you win the game" or "you can't win the game" have no effect.
- The first player to meet their Victory condition wins. If multiple players meet simultaneously, they share the win.
- "All [role type] are eliminated" Victory conditions do not require you to be the one who eliminated them — if all players of that type are gone, you win.
- If your Defeat condition is met at any time, you are immediately eliminated.
- Roles with no listed Defeat condition default to: **"You are eliminated."**
- Some roles can be eliminated and still win (e.g., if the King's Victory condition is met after the Knight was eliminated, the Knight also wins).

**Rule 4 — Announce:** To Announce, turn your face-down role card **face-up** to reveal your role and access your character's special ability. Face-up role cards cannot Announce again.

**Rule 5 — Role abilities use the stack** and can be responded to, but **cannot be targeted, countered, or exiled** by spells and abilities.

**Rule 6 — Controlled turns:** If you take control of another player's turn, you may not look at their face-down role card. That player retains control of their role card and **cannot Announce** during that turn.

**Rule 7 — Empty library:** If a player loses from drawing into an empty library, the player who forced that draw (or secondly, who removed the last card) "eliminated" them.

**Rule 8 — Library rescue:** If a player would lose from an empty library and is kept alive by a role ability (e.g., the Cultist), that player may shuffle one of the following into their library: their graveyard, their exile zone, or their hand.

**Rule 9 — Elimination definition:** You "eliminate" a player if an effect you control caused them to lose the game. Valid causes: loss of life, drawing from empty library, commander damage, or poison counters.

---

## King Rules (Specific to the King Role)

- The King **reveals their role card immediately** at game start.
- The King is the **starting player**.
- The King begins with **+10 life** (standard Commander starts at 40, so the King starts at **50 life**).
- The King role is the **only public role** at game start.
- If a Knight eliminates the King, the Knight suffers severe penalties (see The King card for details).
- Standard Commander rules apply for commander damage (21 commander damage from a single commander = loss) and poison (10 poison counters = loss).

---

## Deck Building

No special deck-building restrictions beyond standard Commander rules. The only restriction: **you can only win via your role card's Victory condition.**

---

## Files (Latest Version 1.56)

Available in A4 and Letter sizes, Full version (with role tips on back) and Card Fronts Only version:

- **Full version** — recommended for first-time players; back side of each card has tips, clarifications and strategy notes.
- **Card Fronts Only** — 3 pages; recommended for veterans. Refer to the forum post for rules.

> Note: Cards must be in **identical matching sleeves** so roles remain hidden. To read the back of a Full version card during the game, remove it from the sleeve out of sight.

---

## Errata & Thread Notes

*Gathered from the MTG Salvation thread, 2026-09-16. The thread was opened by
WaRgUnNeR on 2020-09-12 and runs to six posts; **v1.56 is still the latest
version** and the author has posted no revision since.*

### ⚠ Official errata — Bandit Victory condition (WaRgUnNeR, 2021-01-26)

A reader (Spyntbg, 2021-01-23) raised this corner case:

> "What happens if a Bandit becomes teammates with the Sellsword? The Bandit
> would only be able to win by eliminating the Sellsword as they are not a
> bandit, but in doing so would be eliminating a teammate (their defeat
> condition)."

The author confirmed the conflict and issued an errata:

> "The intention of the Sellsword is that he becomes teammates with whomever
> buys him out, so he will join their forces and will not need to be
> eliminated." — change the Bandit's Victory condition to:
> **"All non-teammates are eliminated."**

**✓ Applied in viewer v0.5.76.** All 12 Bandit cards — 5 Advanced Kingdoms
Bandits (Necromancer, Zealot, Giant, Wizard, Stalker) and 7 house variants
(Cutthroat, Raider, Outlaw, Plunderer, Mercenary, Last Bandit, Arsonist) — now
read **"All non-teammates are eliminated"**, in the viewer and in their `.md`
sidecars.

Two follow-on edits were needed:

- **The Last Bandit** stacks *"you are the only surviving Bandit"* on top of the
  Victory line. Fellow Bandits are teammates, so the first clause no longer
  requires their deaths — the card now says so explicitly and keeps the
  outlast requirement as its own condition.
- **The Mercenary** referred to *"when all non-Bandits fall"* in its ability
  text; reworded to match.

> **Note:** the viewer now follows the author’s forum errata rather than the
> printed v1.56 PDFs. Cards printed from the official A4/Letter files will still
> read "All non-Bandits".

### Community proposal — 4-player Advanced Kingdoms (Javy Dreamer, 2024-08-28)

Suggested for league play, **not author-endorsed**: 1 King, 1 Knight,
2 Assassins. The official table still starts at 5 players.

### Thread activity

Play reports are sparse but positive — a 7-player game (Minty Chip, 2024-04-06)
ended in a Champion victory after a complex endgame. Most recent post is
2025-01-19. No card ability text is quoted anywhere in the thread; the card
text lives only in the linked A4/Letter PDFs.
