set -x CHRUBY_ROOT /usr/local

source $HOME/.config/fish/private.fish

set -x TERM 'screen-256color'
set -x EDITOR 'vim -f'
set -x PATH $PATH $HOME/bin

set fish_greeting

set fish_pager_color_prefix yellow
set fish_pager_color_progress yellow
set fish_pager_color_completion normal
set fish_pager_color_description $fish_color_comment

if status --is-login
	for p in /usr/bin /usr/local/bin /opt/local/bin /usr/local/mysql/bin /opt/local/lib/postgresql83/bin ~/bin ~/.config/fish/bin
		if test -d $p
			set PATH $p $PATH
		end
	end
end

function parse_git_branch
	sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | cut -c -30
end

function parse_git_tag
	git describe --tags --always ^/dev/null
end

function parse_git_tag_or_branch
	if [ (parse_git_branch) != "(no branch)" ]
    parse_git_branch
	else
    parse_git_tag
	end
end

function git_clean
  echo (git status) | grep 'nothing to commit' > /dev/null
end

function git_ahead
  echo (git status) | grep 'Your branch is ahead' > /dev/null
end

function git_diverged
  echo (git status) | grep 'have diverged' > /dev/null
end

function git_behind
  echo (git status) | grep 'Your branch is behind' > /dev/null
end

function git_parse_ahead_of_remote
  git status ^/dev/null | grep 'Your branch is ahead' | echo '^'
  git status ^/dev/null | grep 'Your branch is behind' | echo 'v'
end

function is_git
	git status >/dev/null ^&1
	return $status
end


function fish_prompt
    test $SSH_TTY; and printf (set_color red)(whoami)(set_color white)'@'(set_color yellow)(hostname)' '

    test $USER = 'root'; and echo (set_color red)"#"

    # Main
    echo -n (set_color cyan)(prompt_pwd) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end

function fish_right_prompt
	# last status
	test $status != 0; and printf (set_color red)"⏎ "

	if git rev-parse ^ /dev/null
			# Purple if branch detached else green
			git branch -qv | grep "\*" | grep -q detached
					and set_color purple --bold
					or set_color green --bold

			# Need optimization on this block (eliminate space)
			git name-rev --name-only HEAD

			# Merging state
			git merge -q ^ /dev/null; or printf ':'(set_color red)'merge'
			printf ' '

			# Symbols
			for i in (git branch -qv --no-color|grep \*|cut -d' ' -f4-|cut -d] -f1|tr , \n)\
					(git status --porcelain | cut -c 1-2 | uniq)
					switch $i
							case "*[ahead *"
									printf (set_color purple)⬆' '
							case "*behind *"
									printf (set_color purple)⬇' '
							case "."
									printf (set_color green)✚' '
							case " D"
									printf (set_color red)✖' '
							case "*M*"
									printf (set_color blue)✱' '
							case "*R*"
									printf (set_color purple)➜' '
							case "*U*"
									printf (set_color brown)═' '
							case "??"
									printf (set_color white)◼' '
					end
			end
	end
end

bind \cr "rake"

function ss -d "Run the script/server"
	script/server
end

function sc -d "Run the Rails console"
	script/console
end

if test -d "/opt/java"
   set -x JAVA_HOME "/opt/java"
end

# Load custom settings for current hostname
set HOST_SPECIFIC_FILE ~/.config/fish/(hostname).fish
if test -f $HOST_SPECIFIC_FILE
   . $HOST_SPECIFIC_FILE
else
   echo Creating host specific file: $HOST_SPECIFIC_FILE
   touch $HOST_SPECIFIC_FILE
end

# Load custom settings for current user
set USER_SPECIFIC_FILE ~/.config/fish/(whoami).fish
if test -f $USER_SPECIFIC_FILE
   . $USER_SPECIFIC_FILE
else
   echo Creating user specific file: $USER_SPECIFIC_FILE
   touch $USER_SPECIFIC_FILE
end

# Load custom settings for current OS
set PLATFORM_SPECIFIC_FILE ~/.config/fish/(uname -s).fish
if test -f $PLATFORM_SPECIFIC_FILE
   . $PLATFORM_SPECIFIC_FILE
else
   echo Creating platform specific file: $PLATFORM_SPECIFIC_FILE
   touch $PLATFORM_SPECIFIC_FILE
end

set PATH $HOME/.rbenv/bin $PATH
. (rbenv init -)
