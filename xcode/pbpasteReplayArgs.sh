#!/bin/bash
pbpaste | awk '{print "let replayArgs = CheckerArguments(replay: (StdGen(" $1 ", " $2 "), " $5 "))"}'
