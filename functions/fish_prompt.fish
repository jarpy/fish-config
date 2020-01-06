function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if [ $TERM = eterm-color ]
      echo -n (prompt_pwd)
      echo '$ '
      return
    end

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

    # Llama Release
    if [ -n "$RELEASE_NAME" ]
      echo -n " 🦙"
      if [ "$RELEASE_NAME" = "llama-prod" ]
        echo -n "🛑"
        set_color f51
      else
        set_color ecb
      end

      echo -n (echo $RELEASE_NAME | string replace "llama-" "")
      set_color $base2
    end

    # Kubectl
    if command -s kubectl > /dev/null
      echo -n " ☸️ "
      set_color blue
      # Cluster
      echo -n (kubectl config current-context | sed 's/.*_//')
      echo -n "/"
      # Namespace
      echo -n (kubectl config get-contexts | awk '/^*/ {print $5}')
      set_color $base2
    end

    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    echo -n '$ '
    set_color $base2
end
