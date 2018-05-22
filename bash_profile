# ------------------------------------
# PATH
# ------------------------------------
# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
PATH=/usr/local/bin:$PATH
PATH=$HOME/bin:$PATH
export PATH

# ------------------------------------
# History 
# ------------------------------------
export HISTCONTROL="ignoredups:ignorespace"
export HISTFILESIZE="5000"
export PROMPT_COMMAND="history -a"
export HISTTIMEFORMAT="%F %T - "
export HISTFILE=~/.bash_eternal_history

# ------------------------------------
# Autocompleters 
# ------------------------------------
# AWS
complete -C aws_completer aws
# git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
# Kubernetes kubectl autocompleter
# source <(kubectl completion bash)

# Terraform autocompleter
_terraform()
{
   local cmds cur colonprefixes
   cmds="apply console destroy env fmt get graph import init \
      output plan providers push refresh show state taint \
      untaint validate version state workspace"

   COMPREPLY=()
   cur=${COMP_WORDS[COMP_CWORD]}
   colonprefixes=${cur%"${cur##*:}"}
   COMPREPLY=( $(compgen -W '$cmds'  -- $cur))
   local i=${#COMPREPLY[*]}
   while [ $((--i)) -ge 0 ]; do
      COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
   done

        return 0
} &&

complete -F _terraform terraform

# Serverless autocompleter
_serverless()
{
   local cmds cur colonprefixes
   cmds="config create deploy info install invoque logs metrics \
      package plugin print remove rollback slstats emit run"

   COMPREPLY=()
   cur=${COMP_WORDS[COMP_CWORD]}
   colonprefixes=${cur%"${cur##*:}"}
   COMPREPLY=( $(compgen -W '$cmds'  -- $cur))
   local i=${#COMPREPLY[*]}
   while [ $((--i)) -ge 0 ]; do
      COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
   done

        return 0
} &&

complete -F _serverless serverless

# Chef autocompleter
_chef()
{
   local cmds cur colonprefixes
   cmds="exec env gem generate shell-init install update \
      push push-archive show-policy diff provision export \
      clean-policy-revisions clean-policy-cookbooks \
      delete-policy-group delete-policy undelete verify"

   COMPREPLY=()
   cur=${COMP_WORDS[COMP_CWORD]}
   colonprefixes=${cur%"${cur##*:}"}
   COMPREPLY=( $(compgen -W '$cmds'  -- $cur))
   local i=${#COMPREPLY[*]}
   while [ $((--i)) -ge 0 ]; do
      COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
   done

        return 0
} &&

complete -F _chef chef

# Chef - knife autocompleter
_knife()
{
   local cmds cur colonprefixes
   cmds="opc bootstrap client configure cookbook 'data bag' \
      decrypt encrypt environment exec help index job node \
      null osc_user delete deps diff download edit list show upload xargs \
      raw 'recipe list' rehash role search serve spork ssh ssl status \
      supermarket tag user vault windows winrmwsman"

   COMPREPLY=()
   cur=${COMP_WORDS[COMP_CWORD]}
   colonprefixes=${cur%"${cur##*:}"}
   COMPREPLY=( $(compgen -W '$cmds'  -- $cur))
   local i=${#COMPREPLY[*]}
   while [ $((--i)) -ge 0 ]; do
      COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
   done

        return 0
} &&

complete -F _knife knife



# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file
