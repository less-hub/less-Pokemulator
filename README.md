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
You can move your charcter with `i, j, k, l`.

## Known bugs
---
* Player can't move on top of top-left corner of house.

## TO-DO list
---
* Add Player spawn point at player House
* Add enemy NPC
* Add combat system
* Add (basic) map of world zone
* Add villages, routes etc to world zone
* Add better world map
* Add storyline

## Program language
---
This game is written in Ruby

## Adding maps
---
Create a `.txt` file, place it in `media/maps/MAP_NUMBER.txt`. The spawn path is
```
POSX OBJ POSY
```
Where `OBJ` stands for


* `H` for HOUSE
* `T` for TREE
* `S` for STONE

Hence, for instance, in file `/media/maps/0.txt`
```
600 T 400
500 S 800
1100 H 400
```
To create a `Tree` in `600, 400`, a `Stone` in `500, 800` and `House` in `1100, 400`

## Credits
---
* Thanks to Gosu for his awesome graphic library.
* Thanks to Gallantyl U-Seigel for all houses tiles.
* Thanks to https://www.dragonflycave.com/resources/ for sprites.
* Thanks to Chae for trees and mountains
