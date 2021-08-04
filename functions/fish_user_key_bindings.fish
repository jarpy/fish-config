function fish_user_key_bindings
  fzf_key_bindings
end

bind \eg fzf-cd-widget

# c-left and c-right for token history.
# Plays nice with vscode.
bind \e\[1\;5D history-token-search-backward
bind \e\[1\;5C history-token-search-forward