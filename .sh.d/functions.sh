# Dotfiles alias
alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Turn Spotlight On/Off
alias sl_off='sudo mdutil -a -i off'
alias sl_on='sudo mdutil -a -i on'

# Clear Symfony's Console
alias sfcc='php app/console cache:clear --env=dev --no-debug ; php app/console cache:clear --env=prod --no-debug ; sudo chown -R krues8dr:_www app/cache/ app/logs/ ; sudo chmod -R g+rw ./app/cache ./app/logs/'

alias bob="php artisan bob::build"

clearsolr() {
  curl http://localhost:8983/solr/$1/update -H "Content-type: text/xml" --data-binary '<delete><query>*:*</query></delete>'
  curl http://localhost:8983/solr/$1/update -H "Content-type: text/xml" --data-binary '<commit />'
  curl http://localhost:8983/solr/$1/update -H "Content-type: text/xml" --data-binary '<optimize />'
  curl http://localhost:8983/solr/$1/update -H "Content-type: text/xml" --data-binary '<commit />'
}

alias solrstart="cd ~/Sites/solr.localhost/solr/example/ && java -Dsolr.solr.home=solr_home -jar start.jar"
alias startsolr=solrstart

alias solr4_10="cd ~/Sites/solr.localhost/solr-4.10.4/example/ && java8 -Dsolr.solr.home=solr_home -jar start.jar"

function vagrantlist() {
for i in vagrant box list
do
cd $i
vagrant status
cd -
done
}

function vault-update() {
for i in $(knife data bag list); do
    for j in $(knife data bag show $i|grep _keys$|sed s/_keys$//); do
        knife vault refresh $i $j &
    done
done
}

# better git diff
alias gitres="git diff --name-only --diff-filter=U | uniq | xargs open"

# Redo the last command with sudo
alias sbb='sudo "$BASH" -c "$(history -p !!)"'

# force 1Password login
function 1login() {
    eval $(op signin krues8dr)
    if [ $OP_SESSION_krues8dr ]; then
	echo "Logged in";
    else
        echo "Failed login";
    fi
}

# 1Passowrd helper
function 1pass() {
    op get item "$1" | jq '.details.fields[] | select(.designation=="password").value'
}

# Get info about the current git repo
function gitinfo() {

  pushd . >/dev/null

  # Find base of git directory
  while [ ! -d .git ] && [ ! `pwd` = "/" ]; do cd ..; done

  # Show various information about this git directory
  if [ -d .git ]; then
    echo "== Remote URL: `git remote -v`"

    echo "== Remote Branches: "
    git branch -r
    echo

    echo "== Local Branches:"
    git branch
    echo

    echo "== Configuration (.git/config)"
    cat .git/config
    echo

    echo "== Most Recent Commit"
    git log --max-count=1
    echo

    echo "Type 'git log' for more commits, or 'git show' for full commit details."
  else
    echo "Not a git repository."
  fi

  popd >/dev/null

}

# Serve the current directory as a website at port 8000
# See serve.sh for the more advanced version of this.
function serve() {
	if [ -f "Gemfile" ]; then
    if [ -f "bin/rails" ]; then
       bin/rails s -p 8000
    else
		  JEKYLL_ENV=production bundle exec jekyll serve --port 8000 --host 0.0.0.0 --incremental $1
    fi
	elif [ -f "package.json" ]; then
		npm start
	else
		python -m SimpleHTTPServer
	fi
}

# Save playlist files as videos
function sdl () {
  ffmpeg -i $1 -c copy -bsf:a aac_adtstoasc $2.mp4
}



# work on a given project
function wo() {
  if [ -d ~/Projects/$1 ]; then
    KWPATH=~/Projects/$1
  elif [ -d ~/Projects/RPGMakerMV/$1 ]; then
    KWPATH=~/Projects/RPGMakerMV/$1
  elif [ -d ~/Sites/$1/http ]; then
    KWPATH=~/Sites/$1/http
  elif [ -d ~/Sites/$1 ]; then
    KWPATH=~/Sites/$1
  else
    KWPATH=$(tac ~/.zsh_history | sed -n "/;cd *.*$1/{p;q}" | sed -re 's/.*;cd *(.*)/\1/')
    KWPATH="${KWPATH/#\~/$HOME}"

    if [ ! -d "$KWPATH" ]; then
      return 1
    fi
  fi

  echo "↳ $KWPATH"
  cd "$KWPATH"

  # If there's a project, let's use it
  KFILE=($KWPATH/*.sublime-project)
  if [ -f $KFILE ]; then
    subl $KFILE
  else
    subl $KWPATH
  fi

  open "$KWPATH"
}

function site() {
  site=$1
  shift

  echo "$@"

  opts=$@


  if [ ! -d ~/Sites/$site ]; then
    mkdir ~/Sites/$site
  fi

  cd ~/Sites/$site

  if [[ ${opts[(i)npm]} -le ${#opts} ]]; then
    echo "Init npm"
    npm init --yes
  fi

  if [[ ${opts[(i)express]} -le ${#opts} ]]; then
    echo "Adding Express"
    mkdir server client
    yarn add express express-session session-file-store dotenv uuid4 bootstrap jquery

    cp -R ~/.site-skel/* ./client/
  fi

  if [[ ${opts[(i)angular]} -le ${#opts} ]]; then
    echo "Adding Angular"
    yarn add @uirouter/angularjs angular angular-sanitize
  fi

  if [[ ${opts[(i)jekyll]} -le ${#opts} ]]; then
    echo "Setting up Jekyll"
    jekyll new ./
  fi

  open ./
  subl ./
}

function post() {
  fulltime=$(date +%Y-%m-%d-T%H:%M:%S%z)
  ymd=$(date +"%Y-%m-%d")
  ymdtoo=$(date +"%Y/%m/%d")
  name=$(echo $1 | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)
  filename=_posts/${ymd}-${name}.md
  url=/blog/${ymdtoo}/${name}/

  echo Writing $filename
  touch $filename

  cat > $filename << EOM
---
title: "$1"
author: Bill Hunt
type: post
date: $fulltime
permalink: $url
layout: post
excerpt:

---

EOM

  subl $filename

  echo "http://localhost:8000$url"

}

function recm() {
  ymd=$(date +"%Y-%m-%d")
  name=$(echo $1 | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)
  filename=_recommended/${ymd}-${name}.md

  echo Writing $filename
  touch $filename

  cat > $filename << EOM
---
title: "$1"
date: $ymd
link: $2
category: Recommended
---
$3
EOM

  subl $filename
}


alias lh='exa -l -s modified --no-permissions --icons --no-user'
