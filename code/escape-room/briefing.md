# Operation Root Access

## Incoming transmission...

Command has lost contact with a field unit. The last thing they sent
before the line went dead was a single corrupted file and a warning:
a rogue system, codenamed **ECHO**, has taken control of the
filesystem they were operating in.

ECHO didn't destroy anything. It's worse than that - it hid things.
Genuine files sit next to convincing fakes. Real paths lead to dead
ends planted to waste time. At least one "helpful" script is a trap.

Command has pieced together that **eight verified code fragments**
are still recoverable, scattered across the system. Recover all
eight, in order, and you can unlock the vault and complete the
mission.

You're the agent being sent in. Your only tool is the shell.

## The rules

- Everything happens in Git Bash - no file explorer, no shortcuts,
  no peeking at files outside the terminal.
- Each room (folder) gives you an **objective**, not a command. You
  already know enough from the session to work out what command does
  the job - that's the point.
- Not everything you find is genuine. Read things properly before you
  trust them.
- Once you think you've completed a room, run:

  ```
  ./check.sh
  ```

  It will confirm whether you're right, hand you a code fragment if
  you are, and point you toward the next room in general terms.

- **If you get properly stuck:** every room has a hidden hint file.
  You already know how to reveal hidden files - that's your first
  task, after all. Use hints sparingly. This is meant to take a
  while, and figuring it out is most of the point.

## Before you start

Write down each code fragment as you collect it, in order. You'll
need all eight, combined into one passphrase, to unlock the vault at
the end.

## Starting the mission

You'll have been given a file called `terminal-quest-setup.sh`.

1. Open **Git Bash**.
2. Navigate to the folder where you saved `terminal-quest-setup.sh`.
   For example, if it's in your Downloads folder:

   ```
   cd ~/Downloads
   ```

3. Run the setup script. This builds the entire mission - every room,
   every file, every hidden clue - inside a new folder:

   ```
   bash terminal-quest-setup.sh
   ```

4. Move into the mission folder it just created, and read your first
   briefing:

   ```
   cd terminal-quest
   cat README.md
   ```

That's it. From here on, the terminal is the only interface you get.

Good luck, Agent.
