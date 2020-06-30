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
		jekyll serve --port 8000 --host 0.0.0.0 --incremental
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
