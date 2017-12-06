#!/usr/bin/osascript
use AppleScript version "2.4" # Yosemite or later
use scripting additions
use framework "Foundation"

tell application "Finder"
    set theWindows to every Finder window
    # display dialog theWindows
    repeat with i from 1 to number of items in theWindows
        set the position of item i of theWindows to {(i - 1) * 100, (i - 1) * 100}
    end repeat
end tell

