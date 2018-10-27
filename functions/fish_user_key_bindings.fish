function fish_user_key_bindings
  fzf_key_bindings
end

function jarpy-fzf-cd-home
  cd $HOME
  fzf-cd-widget
end
bind \eg jarpy-fzf-cd-home
