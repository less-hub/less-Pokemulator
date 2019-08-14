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

## Program language
---
This game is written in Ruby

## Credits
---
Thanks to Gosu for his awesome graphic library.