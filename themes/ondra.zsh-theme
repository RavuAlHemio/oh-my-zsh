typeset -A hashtocolor
typeset -A hashtocolornored
hashtocolor=("0" "red" "1" "green" "2" "yellow" "3" "blue" "4" "magenta" "5" "cyan" "6" "white" "7" "red" "8" "green" "9" "yellow" "a" "blue" "b" "magenta" "c" "cyan" "d" "white" "e" "red" "f" "green")
hashtocolornored=("0" "green" "1" "yellow" "2" "blue" "3" "magenta" "4" "cyan" "5" "white" "6" "green" "7" "yellow" "8" "blue" "9" "magenta" "a" "cyan" "b" "white" "c" "green" "d" "yellow" "e" "blue" "f" "magenta")

mymd5sum()
{
	if which md5sum &>/dev/null
	then
		md5sum "$@"
	elif which md5 &>/dev/null
	then
		md5 "$@"
	else
		echo "0"
	fi
}

if [ "$UID" -eq 0 ]
then
	NCOLOR="red"
else
	local namelast="$(echo $USER | mymd5sum | cut -c 32)"
	NCOLOR="$hashtocolornored[$namelast]"
fi

local hostfqdn="$(hostname)"
local shorthost="${hostfqdn/.${hostfqdn#*.}/}"
local hostlast="$(echo ${shorthost} | mymd5sum | cut -c 32)"
local hostclr="${fg[$hashtocolor[$hostlast]]}"

local return_code="%(?..%{$fg[red]%}[%?]%{$reset_color%})"

PROMPT='
%{$fg[$NCOLOR]%}%B%n%{$fg[green]%}@%{$hostclr%}%m%b%{$reset_color%} %{$fg[white]%}%B${PWD/#$HOME/~}%b%{$reset_color%}
$(git_prompt_info)%(!.#.$) '
RPROMPT="${return_code} [%*]"

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.flac=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

# vim: set ft=zsh:
