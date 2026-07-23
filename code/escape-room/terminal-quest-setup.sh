#!/usr/bin/env bash
# =====================================================================
#  OPERATION ROOT ACCESS — EXTENDED EDITION
#  A longer, harder Git Bash escape room with red herrings.
#  Run once:   bash terminal-quest-setup.sh
# =====================================================================

set -e

ROOT="terminal-quest"

if [ -d "$ROOT" ]; then
  echo "A '$ROOT' folder already exists here."
  read -p "Delete it and rebuild? (y/n) " confirm
  if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
    rm -rf "$ROOT"
  else
    echo "Aborting. Rename or move the existing folder and try again."
    exit 1
  fi
fi

mkdir -p "$ROOT"
cd "$ROOT"
echo "Building OPERATION ROOT ACCESS — Extended Edition ..."

# =====================================================================
# ROOT
# =====================================================================
cat > README.md << 'EOF'
# OPERATION ROOT ACCESS — Extended Edition

Command lost contact with a field unit. A rogue system codenamed ECHO
has scattered eight verified code fragments across this filesystem, and
planted a large amount of false information to slow down whoever comes
looking. Some files lie. Some folders lead nowhere. Some scripts are
traps.

Your job: get through all nine rooms, tell the real signal from the
noise, and reach the vault.

## Rules

- Work entirely from the shell. No shortcuts, no file explorers.
- Each room has a README.txt with your OBJECTIVE — not the exact
  command. Figure out the command yourself (you've covered everything
  you need in the session).
- If you are properly stuck, every room hides a `.hint.txt` file. You
  already know how to reveal hidden files. Use hints sparingly — this
  is meant to take a while.
- Once you believe you've completed a room's objective, run:

      ./check.sh

  It will tell you if you're right, give you a CODE FRAGMENT, and tell
  you (in general terms) where to head next.

## Start

    cd 01-orientation
    cat README.txt
EOF

mkdir -p 00-do-not-open
cat > 00-do-not-open/warning.txt << 'EOF'
You weren't supposed to find this room.
There's nothing here for you. Go to 01-orientation instead.
    — ECHO
EOF

# =====================================================================
# ROOM 1 — ORIENTATION
# =====================================================================
mkdir -p 01-orientation

cat > 01-orientation/README.txt << 'EOF'
ROOM 1 — ORIENTATION

Command left several "signal" files in this room. At least two of them
are fakes planted by ECHO. Only one is genuine.

OBJECTIVE:
- Find all the signal files (they won't all be visible with a plain
  directory listing).
- Work out which single one is genuine.
- Copy that one genuine signal, exactly, into a new file in this room
  called verified-signal.txt.
- Prove your own identity by creating a file called agent-id.txt
  containing your name.
- Then run ./check.sh
EOF

cat > 01-orientation/.signal-alpha.txt << 'EOF'
SIGNAL LOG — ALPHA
Status: UNVERIFIED
This does not look right. Recommend disregarding.
EOF

cat > 01-orientation/.signal-bravo.txt << 'EOF'
SIGNAL LOG — BRAVO
Status: VERIFIED — GENUINE SIGNAL CONFIRMED

Copy this exact file's contents into verified-signal.txt in this room,
then create agent-id.txt with your name in it, then run ./check.sh
EOF

cat > 01-orientation/.signal-charlie.txt << 'EOF'
SIGNAL LOG — CHARLIE
Status: CORRUPTED
Unreadable. Ignore this transmission.
EOF

cat > 01-orientation/.hint.txt << 'EOF'
HINT:
  ls -la                        (reveals every hidden .signal-*.txt file)
  cat .signal-alpha.txt
  cat .signal-bravo.txt
  cat .signal-charlie.txt
Only .signal-bravo.txt says "VERIFIED — GENUINE SIGNAL CONFIRMED".
  cp .signal-bravo.txt verified-signal.txt
  echo "Your Name" > agent-id.txt
  ./check.sh
EOF

cat > 01-orientation/check.sh << 'EOF'
#!/usr/bin/env bash
ok=true
if [ ! -s agent-id.txt ]; then
  echo "- agent-id.txt missing or empty."
  ok=false
fi
if [ ! -f verified-signal.txt ] || ! grep -q "GENUINE SIGNAL CONFIRMED" verified-signal.txt; then
  echo "- verified-signal.txt doesn't contain the genuine, verified signal yet."
  ok=false
fi
if [ "$ok" = true ]; then
  echo ""
  echo "Identity confirmed. Genuine signal isolated."
  echo "CODE FRAGMENT 1: FALCON"
  echo ""
  echo "Next: there's a relay station somewhere nearby with several"
  echo "corridors. Only one leads anywhere real."
fi
EOF
chmod +x 01-orientation/check.sh

# =====================================================================
# ROOM 2 — THE RELAY MAZE
# =====================================================================
mkdir -p 02-the-maze/north-corridor
mkdir -p 02-the-maze/south-corridor/sub-passage
mkdir -p 02-the-maze/east-wing/annex
mkdir -p 02-the-maze/relay-access/junction-1/junction-2/junction-3/junction-4

cat > 02-the-maze/README.txt << 'EOF'
ROOM 2 — THE RELAY MAZE

There are several corridors leading out of this room. Most are dead
ends. One eventually reaches a working relay station, several
directories deep, holding a map.

OBJECTIVE:
- Explore the corridors and find the real one. Read anything you find
  along the way — dead ends usually say so.
- Once you find the relay map, bring a copy of it back to THIS room
  (02-the-maze), naming your copy relay-confirmed.txt.
- Then run ./check.sh (from this room)
EOF

cat > 02-the-maze/north-corridor/dead-end.txt << 'EOF'
Dead end. Nothing here. Try a different corridor.
EOF

cat > 02-the-maze/south-corridor/dead-end.txt << 'EOF'
This looks promising but it isn't. Keep exploring the sub-passage
if you don't believe us.
EOF

cat > 02-the-maze/south-corridor/sub-passage/also-nothing.txt << 'EOF'
Also nothing. This whole corridor is a dead end. Try elsewhere.
EOF

cat > 02-the-maze/east-wing/annex/decoy-map.txt << 'EOF'
RELAY MAP (UNOFFICIAL COPY — DO NOT USE)

This map has been tampered with. The coordinates below are wrong.
CODE FRAGMENT: WRONG1

If you use this one, check.sh in room 2 will not accept it.
EOF

cat > 02-the-maze/relay-access/junction-1/junction-2/junction-3/junction-4/relay-map.txt << 'EOF'
OFFICIAL RELAY MAP — VERIFIED

CODE FRAGMENT 2: 9F2X

Copy this file back to the 02-the-maze room as relay-confirmed.txt,
then run ./check.sh from there.
EOF

cat > 02-the-maze/.hint.txt << 'EOF'
HINT:
The real path is:
  relay-access/junction-1/junction-2/junction-3/junction-4/relay-map.txt

From inside that deepest folder:
  cp relay-map.txt ../../../../relay-confirmed.txt

Then from 02-the-maze:
  ./check.sh
EOF

cat > 02-the-maze/check.sh << 'EOF'
#!/usr/bin/env bash
if [ -f relay-confirmed.txt ] && grep -q "9F2X" relay-confirmed.txt; then
  echo ""
  echo "Relay reached. Genuine map recovered."
  echo "CODE FRAGMENT 2: 9F2X"
  echo ""
  echo "Next: a nearby archive room has some housekeeping that needs"
  echo "doing before anyone will let you further in."
elif [ -f relay-confirmed.txt ]; then
  echo "That file doesn't match. You may have copied the decoy map."
  echo "Keep exploring the other corridors."
else
  echo "No relay-confirmed.txt here yet. Find the real relay map first."
fi
EOF
chmod +x 02-the-maze/check.sh

# =====================================================================
# ROOM 3 — THE ARCHIVE (file ops)
# =====================================================================
mkdir -p 03-the-archive/archive

cat > 03-the-archive/README.txt << 'EOF'
ROOM 3 — THE ARCHIVE

This room is a mess of draft files, only one of which is the official
record — check manifest.txt to find out which one. Everything else
listed as clutter should be cleared out.

OBJECTIVE (per manifest.txt):
- Identify the official record and rename it to drop its "-OLD" suffix.
- Keep a backup copy of the renamed file inside the existing archive/
  folder.
- Remove every file with a .tmp extension — it's all clutter.
- Create a new, empty folder called final for future filings.
- Then run ./check.sh
EOF

cat > 03-the-archive/manifest.txt << 'EOF'
FILING MANIFEST

Official record: mission-report-OLD.txt
  -> rename to mission-report.txt, keep a backup in archive/

Everything ending in .tmp is clutter and should be removed.

Ignore mission-report-v1.txt and mission-report-DRAFT2.txt — these are
earlier drafts, already superseded, and are not the official record.
EOF

cat > 03-the-archive/mission-report-OLD.txt << 'EOF'
Official mission report. This is the real one — see manifest.txt.
EOF

cat > 03-the-archive/mission-report-v1.txt << 'EOF'
Early draft. Superseded. Not the official record.
EOF

cat > 03-the-archive/mission-report-DRAFT2.txt << 'EOF'
Second draft. Also superseded. Not the official record.
EOF

cat > 03-the-archive/cache-file.tmp << 'EOF'
Temporary clutter.
EOF

cat > 03-the-archive/notes-scrap.tmp << 'EOF'
More temporary clutter.
EOF

cat > 03-the-archive/build-output.tmp << 'EOF'
Even more temporary clutter.
EOF

cat > 03-the-archive/.hint.txt << 'EOF'
HINT:
  mv mission-report-OLD.txt mission-report.txt
  cp mission-report.txt archive/
  rm *.tmp
  mkdir final
  ./check.sh
EOF

cat > 03-the-archive/check.sh << 'EOF'
#!/usr/bin/env bash
ok=true
[ -f mission-report.txt ] || { echo "- mission-report.txt not found."; ok=false; }
[ -f mission-report-OLD.txt ] && { echo "- mission-report-OLD.txt still exists (should have been renamed)."; ok=false; }
[ -f archive/mission-report.txt ] || { echo "- archive/mission-report.txt not found."; ok=false; }
[ -f mission-report-v1.txt ] || echo "  (mission-report-v1.txt was a decoy — fine either way, manifest said ignore it)"
if ls *.tmp >/dev/null 2>&1; then
  echo "- .tmp clutter files still present."
  ok=false
fi
[ -d final ] || { echo "- final/ folder not found."; ok=false; }

if [ "$ok" = true ]; then
  echo ""
  echo "Archive in order."
  echo "CODE FRAGMENT 3: CIPHER7"
  echo ""
  echo "Next: field intercepts have been piling up nearby. Several"
  echo "transmissions claim to hold a password. Only one has actually"
  echo "been cryptographically verified."
fi
EOF
chmod +x 03-the-archive/check.sh

# =====================================================================
# ROOM 4 — NEEDLE IN THE HAYSTACK (grep)
# =====================================================================
mkdir -p 04-needle-in-haystack/intercepted/batch-01
mkdir -p 04-needle-in-haystack/intercepted/batch-02
mkdir -p 04-needle-in-haystack/intercepted/batch-03

cat > 04-needle-in-haystack/README.txt << 'EOF'
ROOM 4 — NEEDLE IN THE HAYSTACK

Dozens of intercepted transmissions are stored under intercepted/.
Several of them claim to contain "the password" — these are decoys.
Only one transmission has actually been cryptographically verified.

OBJECTIVE:
- Search the CONTENTS of these files (not just their names) for a
  verification marker.
- Once you find the one genuine, verified transmission, save its
  password into a new file in THIS room called found-clue.txt.
- Then run ./check.sh
EOF

decoy_words=(COBALT ONYX GARNET PEWTER IVORY JASPER SLATE UMBER)
i=0
for f in intercepted/batch-01/msg-01.txt intercepted/batch-01/msg-02.txt intercepted/batch-01/msg-03.txt \
         intercepted/batch-02/msg-04.txt intercepted/batch-02/msg-05.txt \
         intercepted/batch-03/msg-06.txt intercepted/batch-03/msg-07.txt intercepted/batch-03/msg-08.txt; do
  word="${decoy_words[$i]}"
  cat > "04-needle-in-haystack/$f" << EOF
INTERCEPTED TRANSMISSION
Status: UNVERIFIED
PASSWORD: $word
EOF
  i=$((i+1))
done

for f in intercepted/batch-01/chatter-01.txt intercepted/batch-02/chatter-02.txt intercepted/batch-03/chatter-03.txt; do
  cat > "04-needle-in-haystack/$f" << 'EOF'
INTERCEPTED TRANSMISSION
Routine chatter. Weather report, supply levels, nothing of interest.
EOF
done

cat > 04-needle-in-haystack/intercepted/batch-02/verified-intercept.txt << 'EOF'
INTERCEPTED TRANSMISSION
Status: VERIFIED
PASSWORD: AMBER
EOF

cat > 04-needle-in-haystack/.hint.txt << 'EOF'
HINT:
  grep -ril "verified" intercepted/
This finds the one file whose Status line says VERIFIED (case
insensitive, searched recursively, filenames only). Open that one file
and read the password inside it, then:
  echo "AMBER" > found-clue.txt
  ./check.sh
EOF

cat > 04-needle-in-haystack/check.sh << 'EOF'
#!/usr/bin/env bash
if [ -f found-clue.txt ] && grep -qi "AMBER" found-clue.txt; then
  echo ""
  echo "Verified password recovered."
  echo "CODE FRAGMENT 4: AMBER"
  echo ""
  echo "Next: somewhere in a sprawling data archive, ECHO buried one"
  echo "genuine fragment among several fakes with similar filenames."
else
  echo "Not quite. Make sure found-clue.txt contains the password from"
  echo "the file whose status is actually VERIFIED, not one of the"
  echo "unverified decoys."
fi
EOF
chmod +x 04-needle-in-haystack/check.sh

# =====================================================================
# ROOM 5 — THE VANISHING FILE (find + wildcards)
# =====================================================================
mkdir -p 05-vanishing-file/data/archive-77/sector-3
mkdir -p 05-vanishing-file/data/archive-12/sector-9/cell-4
mkdir -p 05-vanishing-file/data/archive-45

cat > 05-vanishing-file/README.txt << 'EOF'
ROOM 5 — THE VANISHING FILE

Somewhere below data/ is a set of files, all named starting with
"secret-", scattered across several unrelated-looking folders. You
don't know the exact location. Multiple exist — only one is real.

RULE FOR IDENTIFYING THE GENUINE ONE:
  The real fragment is exactly six characters long, all uppercase,
  and starts with the letter O.

OBJECTIVE:
- Locate every file matching that naming pattern, wherever it is.
- Work out which one satisfies the rule above.
- Save just that fragment into found-fragment.txt in THIS room.
- Then run ./check.sh
EOF

cat > 05-vanishing-file/data/archive-77/sector-3/secret-beta.txt << 'EOF'
FRAGMENT CANDIDATE: comet04
(lowercase — does not satisfy the rule)
EOF

cat > 05-vanishing-file/data/archive-12/sector-9/cell-4/secret-gamma.txt << 'EOF'
FRAGMENT CANDIDATE: MIRAGE9
(seven characters — does not satisfy the rule)
EOF

cat > 05-vanishing-file/data/archive-45/secret-omega.txt << 'EOF'
FRAGMENT CANDIDATE: OSPREY
(six uppercase characters, starts with O — this one satisfies the rule)
EOF

cat > 05-vanishing-file/.hint.txt << 'EOF'
HINT:
  find data -name "secret-*.txt"
This lists all three candidate files. Read each one. Only
secret-omega.txt (in data/archive-45/) satisfies the rule: six
uppercase letters starting with O.
  echo "OSPREY" > found-fragment.txt
  ./check.sh
EOF

cat > 05-vanishing-file/check.sh << 'EOF'
#!/usr/bin/env bash
if [ -f found-fragment.txt ] && grep -q "OSPREY" found-fragment.txt; then
  echo ""
  echo "Correct fragment isolated."
  echo "CODE FRAGMENT 5: OSPREY"
  echo ""
  echo "Next: a locked door ahead has two access scripts sitting next"
  echo "to it. Only one is legitimate."
else
  echo "Not yet. Find every file named secret-*.txt under data/, then"
  echo "work out which one is six uppercase letters starting with O."
fi
EOF
chmod +x 05-vanishing-file/check.sh

# =====================================================================
# ROOM 6 — THE LOCKED DOOR (chmod, decoy script)
# =====================================================================
mkdir -p 06-locked-door

cat > 06-locked-door/README.txt << 'EOF'
ROOM 6 — THE LOCKED DOOR

There are two programs in this room. One is a genuine access script.
The other is a decoy planted to waste your time. Both currently look
runnable from a plain directory listing — look closer.

OBJECTIVE:
- Work out which script is genuine.
- Get it into a runnable state, and run it.
- It will hand you the next code fragment directly.
EOF

cat > 06-locked-door/quick-unlock.sh << 'EOF'
#!/usr/bin/env bash
echo ""
echo "ACCESS DENIED."
echo "Nice try — this is not the real access script."
echo "Look for a script that ISN'T already executable. That's the real one."
echo ""
EOF
chmod +x 06-locked-door/quick-unlock.sh

cat > 06-locked-door/real-unlock.sh << 'EOF'
#!/usr/bin/env bash
echo ""
echo "Access granted."
echo "CODE FRAGMENT 6: VIPER42"
echo ""
echo "Next: an old transmission log needs decoding — but be precise,"
echo "some alerts in it are red herrings disguised as the real thing."
EOF
chmod 644 06-locked-door/real-unlock.sh

cat > 06-locked-door/.hint.txt << 'EOF'
HINT:
  ls -l
Look at the permission bits on each script. quick-unlock.sh already
has execute permission (x) — that's suspicious for something sitting
in a "locked" room. real-unlock.sh does not have execute permission
yet, which is exactly what you'd expect from something still locked.
  chmod +x real-unlock.sh
  ./real-unlock.sh
EOF

# no check.sh needed — real-unlock.sh self-reveals the fragment

# =====================================================================
# ROOM 7 — SIGNAL INTERCEPT (pipes, grep -w, wc, redirects)
# =====================================================================
mkdir -p 07-signal-intercept

cat > 07-signal-intercept/README.txt << 'EOF'
ROOM 7 — SIGNAL INTERCEPT

transmission-log.txt contains a mix of alert types. Some lines contain
the word ERROR. Some contain ERROR_HANDLED (already resolved — doesn't
count) or WARNING_ERROR_RECOVERY (a different alert entirely — also
doesn't count). A naive search will overcount.

OBJECTIVE:
- Count only the lines containing the standalone alert word ERROR —
  not lines where ERROR is just part of a longer word.
- Save that exact number into a new file in this room called
  answer.txt (the file should contain nothing but the number).
- Then run ./check.sh
EOF

cat > 07-signal-intercept/transmission-log.txt << 'EOF'
INFO connection established
INFO heartbeat ok
WARNING signal weak
ERROR checksum mismatch
INFO retrying
ERROR_HANDLED checksum mismatch resolved
INFO retrying
WARNING_ERROR_RECOVERY signal weak, recovering
INFO heartbeat ok
ERROR timeout on channel 3
INFO reconnected
WARNING buffer near full
ERROR_HANDLED timeout resolved
INFO heartbeat ok
ERROR unexpected packet
INFO closing session
WARNING signal weak
ERROR checksum mismatch
ERROR_HANDLED already logged
INFO session closed
ERROR final relay failure
INFO end of log
EOF

cat > 07-signal-intercept/.hint.txt << 'EOF'
HINT:
Plain grep "ERROR" also matches ERROR_HANDLED and
WARNING_ERROR_RECOVERY, which is wrong. You need a word-boundary
search. Check the flags available to grep (man grep, or grep --help
in Git Bash) for an option that matches whole words only.

  grep -w -c "ERROR" transmission-log.txt > answer.txt
  ./check.sh
EOF

cat > 07-signal-intercept/check.sh << 'EOF'
#!/usr/bin/env bash
actual=$(grep -w -c "ERROR" transmission-log.txt)
if [ -f answer.txt ] && [ "$(cat answer.txt | tr -d '[:space:]')" = "$actual" ]; then
  echo ""
  echo "Signal decoded correctly."
  echo "CODE FRAGMENT 7: ECHO99"
  echo ""
  echo "Next: an old radio archive holds one final coordinate, buried"
  echo "somewhere near the very end of a very long transcript."
else
  echo "Not quite. Watch out for ERROR_HANDLED and"
  echo "WARNING_ERROR_RECOVERY — they contain the word ERROR but"
  echo "aren't genuine ERROR alerts. You may be overcounting."
fi
EOF
chmod +x 07-signal-intercept/check.sh

# =====================================================================
# ROOM 8 — FIELD RADIO (head/tail)
# =====================================================================
mkdir -p 08-field-radio

{
  n=1
  while [ "$n" -le 148 ]; do
    printf "MSG %03d: routine chatter, nothing of note\n" "$n"
    n=$((n+1))
  done
  echo "MSG 149: final coordinates received — CODE FRAGMENT 8: NOVA07"
  echo "MSG 150: channel closed, end of transcript"
} > 08-field-radio/transmission-archive.txt

cat > 08-field-radio/README.txt << 'EOF'
ROOM 8 — FIELD RADIO

transmission-archive.txt is a very long transcript. Most of it is
routine chatter. The final coordinates were broadcast in the
second-to-last message before the channel went dead — not the very
last line, the one just before it.

OBJECTIVE:
- Isolate exactly that one message (and nothing else) without
  scrolling through the whole file by eye.
- Save just that single line into a new file in this room called
  isolated-message.txt
- Then run ./check.sh
EOF

cat > 08-field-radio/.hint.txt << 'EOF'
HINT:
You want the second line from the end of a very long file. Two
commands can each give you part of what you need — chain them:

  tail -n 2 transmission-archive.txt | head -n 1 > isolated-message.txt
  ./check.sh
EOF

cat > 08-field-radio/check.sh << 'EOF'
#!/usr/bin/env bash
expected=$(tail -n 2 transmission-archive.txt | head -n 1)
if [ -f isolated-message.txt ] && grep -q "NOVA07" isolated-message.txt; then
  echo ""
  echo "Coordinates isolated."
  echo "CODE FRAGMENT 8: NOVA07"
  echo ""
  echo "Next: you have all eight fragments. Head to the vault."
else
  echo "Not yet. You need the second-to-last line only — not the last"
  echo "line, and not the whole file. Try combining head and tail."
fi
EOF
chmod +x 08-field-radio/check.sh

# =====================================================================
# BONUS ROOM — ENVIRONMENT VARIABLES (optional, not required for vault)
# =====================================================================
mkdir -p bonus-clearance-check

cat > bonus-clearance-check/README.txt << 'EOF'
BONUS ROOM — CLEARANCE CHECK (optional, not required to finish)

Field agents with elite clearance authenticate using a personal access
code that is never written to any file — because files can be found
with ls, grep or find. Instead it lives only in the shell's
environment for the session.

OBJECTIVE:
- Create a permanent environment variable called AGENT_CODE with the
  value RAVEN9, defined in your shell's configuration file so it's
  set every time you open a terminal.
- Open a brand new terminal window (so the change actually takes
  effect), navigate back to this room, and run ./check.sh from there.
EOF

cat > bonus-clearance-check/.hint.txt << 'EOF'
HINT:
Add this line to ~/.bashrc (Git Bash) or ~/.zshrc (macOS zsh):
  export AGENT_CODE=RAVEN9
Save the file, close your terminal completely, open a new one, cd back
to this room, then run ./check.sh
EOF

cat > bonus-clearance-check/check.sh << 'EOF'
#!/usr/bin/env bash
if [ "$AGENT_CODE" = "RAVEN9" ]; then
  echo ""
  echo "Elite clearance confirmed."
  echo "BONUS ACHIEVEMENT UNLOCKED: Ghost Protocol"
  echo ""
else
  echo "AGENT_CODE isn't set in this session yet. Make sure you added"
  echo "it to your shell config AND opened a brand new terminal."
fi
EOF
chmod +x bonus-clearance-check/check.sh

# =====================================================================
# ROOM 9 — THE VAULT
# =====================================================================
mkdir -p 09-vault

cat > 09-vault/README.txt << 'EOF'
ROOM 9 — THE VAULT

You should have eight CODE FRAGMENTS by now, collected in the order
you found them.

OBJECTIVE:
- Combine all eight into one passphrase, separated by hyphens, in the
  order you collected them.
- Save it into a new file in this room called passphrase.txt.
- Then run ./unlock-vault.sh
EOF

cat > 09-vault/unlock-vault.sh << 'EOF'
#!/usr/bin/env bash
EXPECTED="FALCON-9F2X-CIPHER7-AMBER-OSPREY-VIPER42-ECHO99-NOVA07"

if [ ! -f passphrase.txt ]; then
  echo "No passphrase.txt found. Create it first — see README.txt"
  exit 1
fi

given=$(cat passphrase.txt | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
expected_clean=$(echo "$EXPECTED" | tr -d '[:space:]')

if [ "$given" = "$expected_clean" ]; then
  cat top-secret.txt
else
  echo ""
  echo "Access denied. That passphrase doesn't match."
  echo "Check the order and spelling of your eight fragments."
fi
EOF
chmod +x 09-vault/unlock-vault.sh

cat > 09-vault/top-secret.txt << 'EOF'

   ██████████████████████████████████
   █                                █
   █      VAULT UNLOCKED             █
   █      MISSION COMPLETE           █
   █                                █
   ██████████████████████████████████

Well done, Agent. Along the way you had to: reveal hidden files,
build relative paths through a maze of decoys, triage files by
reading a manifest, search file contents (not just names) for a
verification marker, hunt for a file by wildcard among lookalikes,
diagnose which of two scripts was actually locked, count precisely
with grep -w to avoid false matches, and slice a single line out of a
150-line file with head and tail.

That's most of what a shell is for. Go forth and automate something.

EOF

echo ""
echo "Done. The quest is ready in ./$ROOT"
echo "Learners should:  cd $ROOT   then   cat README.md"
