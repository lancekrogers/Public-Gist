## PS1 for python
```bash
# Get current Python version dynamically
python_version() {
    pyv="$(python --version 2>&1)"
    echo "${pyv}"
}

# Check if the current directory is a git repository
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Custom PS1 with colors
export PS1="\[\e[0;36m\]\u@\h \[\e[0;33m\]\w\[\e[0;35m\] \$(python_version)\[\e[0;32m\]\$(parse_git_branch)\[\e[0m\] $ "
```

### V2

```bash
parse_git_branch() {
    # Get the current Git branch name
    local branch=$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/\1/p')
    # Use grep to check for the format "TICKET-<number>"
    if [[ $branch =~ TICKET-[0-9]+ ]]; then
        echo "($branch)"
    fi
}

parse_git_branch() {
    # Capture the output of "git branch" and find the current branch
    local branch=$(git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/\1/p')
    # Use grep with a regex to extract the ticket number pattern from the branch name
    local ticket=$(echo $branch | grep -o 'TICKET-[0-9]\+')
    if [ ! -z "$ticket" ]; then
        echo " ($ticket)"
    fi
}

export PS1="\[\e[0;36m\]\u@\h \[\e[0;33m\]\w\[\e[0;34m\]\$(parse_git_branch)\[\e[0m\] $ "
```

---
