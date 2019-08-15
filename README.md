## Installing... On Arch
---
```
# Installs needed packages for Ruby and gosu
sudo pacman -S openal pango sdl2 sdl2_ttf libsndfile pkg-config mpg123

# Installs Ruby programming language
sudo pacman -S ruby

# Installs Gosu graphic library
gem install gosu
```

##Installing... On other distros
---
```
while OS != ArchLinux
	OS.uninstall
	OS.install("ARCH")
end
```

## Starting the game
---
In the game main directory, run `ruby app.rb`

Welcome to my world!

## Playing
---
You can move your charcter with `i, j, k, l`

## Known bugs
---
* Player can't move on top of top-left corner of house.

## TO-DO list
---

* Add (basic) map of local zone
* Add (basic) map of world zone
* Add enemies
* Add combat system
* Add better local maps
* Add better world map
* Add storyline

## Program language
---
This game is written in Ruby

## Credits
---
* Thanks to Gosu for his awesome graphic library.
* Thanks to Gallantyl U-Seigel for all houses tiles.
