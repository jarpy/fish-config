function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    echo

    # User
    set_color $fish_color_user
    echo -n (whoami)
    set_color $base2

    echo -n '@'

    # Host
    set_color $fish_color_host
    echo -n (prompt_hostname)
    set_color $base2

    echo -n ' '

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    #echo -n $PWD
    set_color $base2

    __fish_git_prompt

    # Virtualenv
    if [ -n "$VIRTUAL_ENV" ]
      set_color green
      echo -n " 🐍"
      echo -n (basename (dirname $VIRTUAL_ENV))
      set_color $base2
    end

    # Kubectl
    if command -s kubectl > /dev/null
      set_color blue
      echo -n " ☸️ "
      echo -n (kubectl config current-context | cut -c 1-16)
      set_color $base2
    end

    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    echo -n '$ '
    set_color $base2
end
