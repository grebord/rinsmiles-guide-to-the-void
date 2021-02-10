#!/bin/sh
# Screen backlight handler script - part of: rinsmiles guide to the Void.
#
# Look for an interface
bl_dev='/sys/class/backlight/acpi_video0'
[ ! -d $bl_dev ] && bl_dev='/sys/class/backlight/intel_backlight'
# Get max and current values, and derive increment/decrement
bl=$(cat $bl_dev/max_brightness) || exit
bl_cur=$(cat $bl_dev/brightness)
bl_mod=$(($bl / 15))
#
case $1 in
	up)		bl=$(( $bl_cur + $bl_mod )) ;;
	down)	bl_clamp=$(($bl / 3))
			bl=$(( $bl_cur - $bl_mod ))
			[ $bl -lt $bl_clamp ] && bl=$bl_clamp ;;
	max)		;;
	dim)		bl=$(( $bl / 2 )) ;;
esac
echo $bl > $bl_dev/brightness
