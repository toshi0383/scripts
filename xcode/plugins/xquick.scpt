#!/usr/bin/osascript

use AppleScript version "2.4" # Yosemite or later
use scripting additions
use framework "Foundation"

on run
    tell application "Xcode"
        set projectPath to path of active workspace document
        set projectFolder to characters 1 thru -((offset of "/" in (reverse of items of projectPath as string)) + 1) of projectPath as string
        set sourceName to (get name of window 1)
        do shell script "hackscode xquick " & sourceName
    end tell
end run

