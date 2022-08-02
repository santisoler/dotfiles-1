if [ -f ~/.bash/variables.sh ]; then
    source ~/.bash/variables.sh
fi

# Start ssh-agent automatically if it hasn't been started alredy
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" > /dev/null
fi

# Setup and activate the conda package manager
__conda_setup="$('$HOME/bin/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/bin/conda/etc/profile.d/conda.sh" ]; then
        . "$HOME/bin/conda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/bin/conda/bin:$PATH"
    fi
fi
unset __conda_setup
if [ -f "$HOME/bin/conda/etc/profile.d/mamba.sh" ]; then
    . "$HOME/bin/conda/etc/profile.d/mamba.sh"
fi

if [ -f ~/.bash/prompt.sh ]; then
    export PROMPT_SHOW_PYTHON=true
    source ~/.bash/prompt.sh
fi

if [ -f ~/.bash/aliases.sh ]; then
    source ~/.bash/aliases.sh
fi

if [ -f ~/.bash/functions.sh ]; then
    source ~/.bash/functions.sh
fi

if [ -f ~/.bash/extra.sh ]; then
    source ~/.bash/extra.sh
fi

# Activate the default conda environment
if [ -f environment.yml ]; then
    cenv environment.yml
fi
