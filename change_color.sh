#!/bin/bash
echo 'List of the available colors in the database.'
echo 'Please choose one'

# Query/fetch data using the sql engine Apache Impala.
impala-shell \
	-i localhost:21000 \
	--quiet \
	-q 'SELECT color FROM wax.crayons' 2> /dev/null

# Read the user's input (wanted color)
read -p "color? - " color

# Query the hex code equivalent to the inputted color.
color=$(
  impala-shell \
	-i localhost:21000 \
	--quiet \
	--delimited \
	--var="col=${color}" \
	-q $'SELECT hex FROM wax.crayons WHERE color = \'${var:col}\'' 2> /dev/null
  )

# Change the system's wallpaper (Linux gnome only)
gconftool-2 \
	-t str \
	-s /desktop/gnome/background/primary_color "#$color"
