source (dirname (status --current-filename))/solarized.fish

set -x fish_prompt_pwd_dir_length 3

set -x __fish_git_prompt_showdirtystate true
set -x __fish_git_prompt_showstashstate true
set -x __fish_git_prompt_showuntrackedfiles true
set -x __fish_git_prompt_showupstream true
set -x __fish_git_prompt_showupstream true
set -x __fish_git_prompt_show_informative_status true

set -x fish_color_valid_path

set -x VIRTUAL_ENV_DISABLE_PROMPT true

if test -n "$TMUX"
    set -x FZF_TMUX 1
end

eval (direnv hook fish)

alias vi=vim
alias e='emacsclient --no-wait'
set -x EDITOR 'emacsclient'

alias k='kubectl'

ps -eo comm,user | egrep -q '^ssh-agent.+jarpy$'; or ssh-agent
ln -sf (find /tmp/ssh-* -user $USER -name 'agent.*' 2>/dev/null) $HOME/.ssh/ssh_auth_sock
set -x SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock

# Emacs ansi-term fix
# REF: https://github.com/fish-shell/fish-shell/issues/1907
function fish_title; end

if test "$XDG_VTNR" = "1" -a "$TERM" = "linux"
    set --erase TERM
    exec startx
end
