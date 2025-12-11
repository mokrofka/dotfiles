if status is-interactive
  # Commands to run in interactive sessions can go here

  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end

end

# turn off fish greetings
set -g fish_greeting ""

# promt in terminal: > path
function fish_prompt
  set_color --bold yellow
  echo -n '> '
  set_color cyan
  echo -n (prompt_pwd) ''
  set_color normal
end

# runs sway on startup
if test -z "$WAYLAND_DISPLAY" -a -n "$XDG_VTNR" -a "$XDG_VTNR" -eq 1
  exec sway
end

# preffered editor
set -x EDITOR vscodium

alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'

