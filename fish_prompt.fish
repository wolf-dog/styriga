# Styriga settings
__styriga_set_default styriga_default_user ''
__styriga_set_default styriga_default_hostname 'localhost'

__styriga_set_default styriga_color_connection_separator 'normal'

__styriga_set_default styriga_color_user 'blue'
__styriga_set_default styriga_color_user_root 'red'

__styriga_set_default styriga_color_hostname 'green'
__styriga_set_default styriga_color_hostname_separator 'normal'

__styriga_set_default styriga_color_pwd 'blue'

__styriga_set_default styriga_color_prompt_char 'yellow'
__styriga_set_default styriga_color_prompt_char_failed 'red'

__styriga_set_default styriga_color_time 'brblack'
__styriga_set_default styriga_color_time_failed 'red'

# __fish_git_prompt settings
__styriga_set_default __fish_git_prompt_showupstream 'git'
__styriga_set_default __fish_git_prompt_showdirtystate true
__styriga_set_default __fish_git_prompt_showstashstate true
__styriga_set_default __fish_git_prompt_showuntrackedfiles true

__styriga_set_default __fish_git_prompt_char_upstream_prefix ' '
__styriga_set_default ___fish_git_prompt_char_upstream_ahead '>'
__styriga_set_default ___fish_git_prompt_char_upstream_behind '<'
__styriga_set_default ___fish_git_prompt_char_upstream_diverged 'X'

__styriga_set_default ___fish_git_prompt_char_stateseparator ' '
__styriga_set_default ___fish_git_prompt_char_dirtystate '+'
__styriga_set_default ___fish_git_prompt_char_invalidstate '!'
__styriga_set_default ___fish_git_prompt_char_stagedstate '^'
__styriga_set_default ___fish_git_prompt_char_untrackedfiles '?'
__styriga_set_default ___fish_git_prompt_char_stashstate '$'
__styriga_set_default ___fish_git_prompt_char_cleanstate ''

__styriga_set_default __fish_git_prompt_color_bare 'red'
__styriga_set_default __fish_git_prompt_color_merging 'red'
__styriga_set_default __fish_git_prompt_color_branch 'blue'
__styriga_set_default __fish_git_prompt_color_dirtystate 'red'
__styriga_set_default __fish_git_prompt_color_stagedstate 'green'
__styriga_set_default __fish_git_prompt_color_stashstate 'blue'
__styriga_set_default __fish_git_prompt_color_untrackedfiles 'red'
__styriga_set_default __fish_git_prompt_color_invalidstate 'red'

#
# left prompt
#
function __styriga_connection --argument-names user
  set -l connection (__styriga_user $user)(__styriga_hostname)

  if [ -z $connection ]
    echo ''
    return
  else
    echo $connection(__styriga_colorize ':' $styriga_color_connection_separator)
  end
end

function __styriga_user --argument-names user
  set -l color

  if [ $user = $styriga_default_user ]
    echo ''
    return
  else if [ $user = 'root' ]
    set color $styriga_color_user_root
  else
    set color $styriga_color_user
  end

  echo (__styriga_colorize $user $color)
end

function __styriga_hostname
  set -l hostname (command hostname -s)

  if [ $hostname = $styriga_default_hostname ]
    echo ''
    return
  else
    echo (__styriga_colorize '@' $styriga_color_hostname_separator)(__styriga_colorize $hostname $styriga_color_hostname)
  end
end

function __styriga_pwd --argument-names user
  set -l pwd (command pwd)

  echo (__styriga_colorize (command echo $pwd | string replace "/home/$user" '~') $styriga_color_pwd)
end

function __styriga_prompt_char --argument-names user last_status
  set -l char
  set -l color
  set -l background_color

  if [ $user = 'root' ]
    set char '#'
  else
    set char '$'
  end

  if [ $last_status -eq 0 ]
    set color $styriga_color_prompt_char
  else
    set color $styriga_color_prompt_char_failed
  end

  echo (__styriga_colorize $char $color)' '
end

#
# right prompt
#
function __styriga_git_status
  echo (__fish_git_prompt '%s')
end

function __styriga_time --argument-names last_status
  set -l color

  if [ $last_status -eq 0 ]
    set color $styriga_color_time
  else
    set color $styriga_color_time_failed
  end

  echo ' '(__styriga_colorize '['(date +%T)']' $color)
end

function __styriga_right_prompt
   echo (__styriga_git_status)(__styriga_time $__styriga_last_status)
end

function __styriga_pad_right --argument-names right left
  set -l right_length (__styriga_strip_non_printable_chars $right | wc -c)
  set -l left_length (__styriga_strip_non_printable_chars $left | wc -c)
  set -l pad_length (math $COLUMNS - $left_length - $right_length + 2)
  echo -n (printf '%-'$pad_length's%s' ' ' $right)
end

#
# main
#
function fish_prompt
  set -g __styriga_last_status $status
  set -l user (command whoami)
  set -l left_prompt (__styriga_connection $user)(__styriga_pwd $user)
  set -l right_prompt (__styriga_pad_right (__styriga_right_prompt) $left_prompt)

  echo -e $left_prompt$right_prompt"\n"(__styriga_prompt_char $user $__styriga_last_status)
end

