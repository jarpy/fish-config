source (dirname (status --current-filename))/solarized.fish

set -g fish_prompt_pwd_dir_length 4
set -g __fish_git_prompt_showdirtystate true
set -g __fish_git_prompt_showstashstate true
set -g __fish_git_prompt_char_stashstate "*"
set -g __fish_git_prompt_showuntrackedfiles true
set -g __fish_git_prompt_showupstream true
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_char_stagedstate "+"
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_char_dirtystate "~"
set -g __fish_git_prompt_color_dirtystate red
set -g __fish_git_prompt_char_untrackedfiles "?"
set -g __fish_git_prompt_color_untrackedfiles yellow
set -g __fish_git_prompt_char_conflictedstate "!"
set -g __fish_git_prompt_char_cleanstate "="
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_invalidstate red

set -x fish_color_valid_path

set -x VIRTUAL_ENV_DISABLE_PROMPT true

set -x FZF_DEFAULT_COMMAND "fd --type file"
set -x FZF_ALT_C_COMMAND "fd --hidden --type d . $HOME"
set -x FZF_ALT_C_OPTS "--preview='exa --all --long --color=always {}' --preview-window=up:60%"

set -x FZF_CTRL_T_COMMAND "fd --hidden . $HOME"
set -x FZF_CTRL_T_OPTS "--preview='bat --color=always {}' --preview-window=up:80%"

set -x FZF_TMUX_HEIGHT 100%

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"


if test -n "$TMUX"
  set -x FZF_TMUX 1
end

eval (direnv hook fish)

alias ll='exa -l'

alias vi=vim
#alias et='emacsclient --tty'
alias ec='code'
alias ee='emacsclient --no-wait'
#set -x EDITOR 'emacsclient --tty'

set -x EDITOR 'code --wait'

function cdf
  cd (fzf-dir $argv[1])
end

alias k='kubectl'
alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kdp='kubectl describe pod'
alias kdelp='kubectl delete pod'
alias ktail='kubectl logs --tail=10 --follow'

#ps -eo comm,user | egrep -q '^ssh-agent.+jarpy$'; or ssh-agent
#ln -sf (find /tmp/ssh-* -user $USER -name 'agent.*' 2>/dev/null) $HOME/.ssh/ssh_auth_sock
#set -x SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock

# Emacs ansi-term fix
# REF: https://github.com/fish-shell/fish-shell/issues/1907
function fish_title; end

# VSCode
if test "$TERM_PROGRAM" = "vscode"
  set --export LANG "en_AU.UTF-8"
  set --export EDITOR "code --wait"
end

# X11 entrypoint
if test "$XDG_VTNR" = "1" -a "$TERM" = "linux"
  set --erase VAULT_TOKEN
  set --erase RELEASE_NAME
  set --erase TERM
  exec startx
end

### source ~/src/elastic/infra/ve3/bin/activate.fish

# Make sure globals don't block these universals.
# NOTE: This should be fixed in Fish 3.1
# REF: https://github.com/fish-shell/fish-shell/pull/6218
#set -ge LLAMA_RELEASE
#set -ge RELEASE_NAME

function __direnv_export_eval --on-event fish_prompt;
  eval ("/usr/local/bin/direnv-2.18.2" export fish);
end
