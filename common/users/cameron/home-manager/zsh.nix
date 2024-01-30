{ pkgs, lib, config, osConfig, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    dotDir = ".config/zsh";

    initExtraFirst = ''
[[ $- != *i* ]] && return
    '';

    initExtraBeforeCompInit = ''
mkdir -p ${config.home.homeDirectory}/.cache/zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Corrected %e errors'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' cache-path ${config.home.homeDirectory}/.cache/zsh/zcompcache
zstyle :compinstall filename "${config.home.homeDirectory}/.config/zsh/.zshrc"
    '';

    completionInit = "autoload -Uz compinit && compinit -d ${config.home.homeDirectory}/.cache/zsh/zcompcache";

    history = {
      path = "${config.home.homeDirectory}/.local/state/zsh/history";
      ignoreSpace = true;
    };

    initExtra = ''
typeset -g -A key

key[Home]="''${terminfo[khome]}"
key[End]="''${terminfo[kend]}"
key[Insert]="''${terminfo[kich1]}"
key[Backspace]="''${terminfo[kbs]}"
key[Delete]="''${terminfo[kdch1]}"
key[Up]="''${terminfo[kcuu1]}"
key[Down]="''${terminfo[kcud1]}"
key[Left]="''${terminfo[kcub1]}"
key[Right]="''${terminfo[kcuf1]}"
key[PageUp]="''${terminfo[kpp]}"
key[PageDown]="''${terminfo[knp]}"
key[Shift-Tab]="''${terminfo[kcbt]}"
key[Control-Left]="''${terminfo[kLFT5]}"
key[Control-Right]="''${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "''${key[Home]}"      ]] && bindkey -- "''${key[Home]}"       beginning-of-line
[[ -n "''${key[End]}"       ]] && bindkey -- "''${key[End]}"        end-of-line
[[ -n "''${key[Insert]}"    ]] && bindkey -- "''${key[Insert]}"     overwrite-mode
[[ -n "''${key[Backspace]}" ]] && bindkey -- "''${key[Backspace]}"  backward-delete-char
[[ -n "''${key[Delete]}"    ]] && bindkey -- "''${key[Delete]}"     delete-char
[[ -n "''${key[Up]}"        ]] && bindkey -- "''${key[Up]}"         up-line-or-history
[[ -n "''${key[Down]}"      ]] && bindkey -- "''${key[Down]}"       down-line-or-history
[[ -n "''${key[Left]}"      ]] && bindkey -- "''${key[Left]}"       backward-char
[[ -n "''${key[Right]}"     ]] && bindkey -- "''${key[Right]}"      forward-char
[[ -n "''${key[PageUp]}"    ]] && bindkey -- "''${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "''${key[PageDown]}"  ]] && bindkey -- "''${key[PageDown]}"   end-of-buffer-or-history
[[ -n "''${key[Shift-Tab]}" ]] && bindkey -- "''${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "''${key[Control-Left]}"  ]] && bindkey -- "''${key[Control-Left]}"  backward-word
[[ -n "''${key[Control-Right]}" ]] && bindkey -- "''${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ''${+terminfo[smkx]} && ''${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Configure prompt
setopt prompt_subst
PROMPT_COLORS=""
PROMPT_PREFIXES=""

function set_prompt() {
	local colors=(''${(@s:~:)PROMPT_COLORS})
	local prefixes=(''${(@s:~:)PROMPT_PREFIXES})

	local prefix=""
	for i in $(seq 1 "''${#prefixes[@]}"); do
		prefix+="%F{''${colors[$i]:-255}}''${prefixes[$i]}%F{255} "
	done
	
	PROMPT="[''${prefix}%n@%m %1~]%(#.#.$) "
}

typeset -a precmd_functions
precmd_functions+=(set_prompt)


# Initialize direnv if it exists
if command -v direnv &> /dev/null; then
	eval "$(direnv hook zsh)"
fi


if command -v lf &> /dev/null; then
    lfcd() {
        cd "$(command lf -print-last-dir "$@")"
    }

    bindkey -s '^o' 'lfcd\n'
fi


if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh='kitty +kitten ssh'
    alias clear='printf "\033c"'
fi
    '';

    shellAliases = {
      grep = "grep --color=auto";
      ls = "ls --color=auto";

      nv = "nvim";
      nvd = "nvim .";
      nvc = "nvim -c \"edit \\$MYVIMRC\"";
      nvp = "nvim ${config.home.homeDirectory}/projects";

      c = "clear";
      e = "echo";
      pf = "printf";
      nf = "neofetch";

      x = "exit";
      ":q" = "exit";
      ":wq" = "exit";
    };


    profileExtra = ''
[[ -f ~/.profile ]] && . ~/.profile
[[ -f $ZDOTDIR/.zshrc ]] && . $ZDOTDIR/.zshrc

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi
    '';
  };
}
