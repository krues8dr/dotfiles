# Serve a local static website
# Requires jq for node package info! https://stedolan.github.io/jq/
typeset -A KJOBSLIST

KSERVE_ICON_DEFAULT="\uf013"
KSERVE_ICON_SERVE="\uf233"
KSERVE_ICON_BUILD="\uf021"

# Serve the current directory as a website at port 8000
function kserve() {
  if [ -f "Gemfile" ]; then
    &>/dev/null jekyll serve --port 8000 --host 0.0.0.0 --incremental &
  elif [ -f "package.json" ]; then
    pkginfo=($(cat ./package.json | jq -r '[.name, .version, .scripts.watch ] | .[]'))

    # TODO add watch handler
    if [[ pkginfo[3] ]]; then
      &>/dev/null npm run watch &
      KJOBSLIST[$!]="$pkginfo[1]:$KSERVE_ICON_BUILD"
    fi

    &>/dev/null npm start &
  else
    &>/dev/null python -m SimpleHTTPServer &
  fi

  if [[ -z $pkginfo && -f ".git/config" ]]; then
    pkginfo=($(basename -s .git `git config --get remote.origin.url`))
  fi

  # We save our metadata here, attached to the PID ($!).
  KJOBSLIST[$!]="$pkginfo[1]:$KSERVE_ICON_SERVE"
}

function krefresh() {
  for i in "$jobstates"; do
    echo $i;
    # Refresh the list here
  done;
}

function kend() {
  # Kill the process specified
  if [[ $1 ]]; then
    kill $1
  elif [[ $! ]]; then
    kill $!
  fi
}

# TODO Add hook to remove any running processes before exit.
function kend_remaining() {

}
# add-zsh-hook zshexit kend_remaining

# Drop-in replacement for Powerlevel9K/10K background_jobs

kprompt_background_jobs() {
  icons=''
  list=$(jobs -p)

  jobs -p | while read line; do
    [[ $line =~ '\[[0-9]+\][ +]+([0-9]+)' ]] && pid=$match[1]
    icon="$KSERVE_ICON_DEFAULT"
    info=${KJOBSLIST[$pid]}

    if [[ $info ]]; then

      icontmp=$(echo $info | cut -d':' -f2)
      if [[ $icontmp ]]; then
        icon="$icontmp"
      fi
    fi

    icons+="$icon "
  done;

  echo -n $icons[0,-2]
}
# Add this to your .p10k.zsh file AFTER the "unset -m 'POWERLEVEL9K_*'" line.
# POWERLEVEL9K_CUSTOM_BACKGROUND_JOBS="kprompt_background_jobs"