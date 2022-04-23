# mixbus-utils
This is a collection of Custom Mixbus Scripts and Presets

## Midi Control Preset for Harley Benton MP 100

### Button Mapping

Button 1: Play
Button 2: Stop
Button 3: Jump To Previous Marker 
Button 4: Jump To Next Marker

### Setup

You need to Configure a Custom Setting on the MP100 as follows:
*MIDI.CH*
7 CUS1 CH   13
*CUS-1*
```
...
KEY 1 MOD   CC#
KEY 1 CC#   1
KEY 1 Tog   Off
KEY 2 MOD   CC#
KEY 2 CC#   2
KEY 2 Tog   Off
KEY 3 MOD   CC#
KEY 3 CC#   3
KEY 3 Tog   Off
KEY 4 MOD   CC#
KEY 4 CC#   4
KEY 4 Tog   Off
```
... or change at will in your config an the .map File

### Todo
* Would be cool to have the Play Button with feedback (on/off) incl. LED on/off i.E.
* * Push > Play (LED on)
* * Push > Pause (LED off)

## Session Script

