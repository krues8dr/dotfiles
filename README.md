# Krues8dr's dotfiles

This archive contains my system dotfiles.

![Screenshot](https://raw.githubusercontent.com/krues8dr/dotfiles/master/screenshot.jpg)

I use the following tools in my ZSH environment:

* [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
* [Powerlevel10K Prompt](https://github.com/romkatv/powerlevel10k)
  * I recently switched away from [Spaceship Prompt](https://github.com/denysdovhan/spaceship-prompt) as Powerlevel has better color support.
* [Autojump](https://github.com/wting/autojump) a.k.a. `j`
* [Color LS](https://github.com/athityakumar/colorls)

I have a couple of custom add-ons I've created:

* [MOTD](https://github.com/krues8dr/dotfiles/blob/master/.sh.d/motd.sh) - shows a message banner when a session is started.
* [kserve](https://github.com/krues8dr/dotfiles/blob/master/.sh.d/serve.sh) - a tiny package that that detects the type of project of a given directory and then runs the appropriate local webserver (Jekyll, NPM, or Python http-server) as a background process. This integrates with Powerlevel10K to show a custom segment (`kprompt_background_jobs`) with icons for the background processes that are running.