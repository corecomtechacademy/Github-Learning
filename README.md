# GitHub Learning Session: Basic Commands

A quick reference guide to the Git and GitHub commands you'll use most often. Perfect for beginners just getting started!

### Clone a repository
Download a copy of a remote repository to your computer.
```bash
git clone https://github.com/username/repository.git
```

## Everyday Commands

### Check status
See what's changed, staged, or untracked.
```bash
git status
```

### Add changes
Stage files so they're ready to be committed.
```bash
git add filename.txt      # add a specific file
git add .                 # add all changed files
```

### Commit changes
Save your staged changes with a message describing what you did.
```bash
git commit -m "Add a short, clear description of the change"
```

### Push changes
Upload your commits to the remote repository (e.g., GitHub).
```bash
git push origin main
```

### Pull changes
Download and merge changes from the remote repository.
```bash
git pull origin main
```

## Branching

### Create a new branch
```bash
git branch feature-name
```

### Switch to a branch
```bash
git checkout feature-name
```

### Create and switch in one step
```bash
git checkout -b feature-name
```

### Merge a branch
Merge changes from another branch into your current branch.
```bash
git merge feature-name
```

## Viewing History

### See commit history
```bash
git log
```

### See a short summary of history
```bash
git log --oneline
```

### See changes before committing
```bash
git diff
```
## Working with Remotes

### Check your remote connections
```bash
git remote -v
```

### Add a remote repository
```bash
git remote add origin https://github.com/username/repository.git
```

## Quick Workflow Summary

A typical day-to-day flow looks like this:

1. `git pull` — get the latest changes
2. Make your edits
3. `git add .` — stage your changes
4. `git commit -m "message"` — save your changes
5. `git push` — upload to GitHub

## Helpful Tips

- Commit often, with clear and short messages
- Pull before you push to avoid conflicts
- Use branches to work on new features without affecting the main code
- Run `git status` frequently — it's your best friend for knowing what's going on

---
*Happy coding! 🎉*