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
