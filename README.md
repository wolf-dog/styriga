# Styriga

`Styriga` is a semi-minimalistic fish theme.

![](http://to-mega-therion.net/assets/media/styriga.png)

## Installation

### [Fisherman](https://fisherman.github.io/)

```fish
$ fisher wolf-dog/styriga
```

### [Oh My Fish!](https://github.com/oh-my-fish/oh-my-fish)

```fish
$ omf install wolf-dog/styriga
```

## Features

- Top aligned right prompt
- Hide username when you are logged in as the default user
- Hide hostname when you are logged in to the default host
- Displays Git status (via [__fish_git_prompt.fish](https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_git_prompt.fish))
- Indicates that you are logged in as root
- Warns when previous command failed
- Displays current time
- Character colors are fully customizable

## Configuration
Put these commands in your `.config/fish/config.fish`.

```fish
# hide username when you are logeed in as the default user
set -g styriga_default_user 'wolf-dog'
# hide hostname when you are logged in to the default host
set -g styriga_default_hostname 'localhost'

# colors
set -g styriga_color_connection_separator 'normal'

set -g styriga_color_user 'blue'
set -g styriga_color_user_root 'red'

set -g styriga_color_hostname 'green'
set -g styriga_color_hostname_separator 'normal'

set -g styriga_color_pwd 'blue'

set -g styriga_color_prompt_char 'yellow'
set -g styriga_color_prompt_char_failed 'red'

set -g styriga_color_time 'brblack'
set -g styriga_color_time_failed 'red'
```

### Git status

Styriga uses `__fish_git_prompt.fish` to display Git status.  
So it can be customized as shown below.

```fish
set -g __fish_git_prompt_showdirtystate false
set -g ___fish_git_prompt_char_dirtystate '🍣'
```

For more details, see [__fish_git_prompt.fish](https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_git_prompt.fish).
