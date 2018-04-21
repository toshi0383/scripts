# scripts
Handy scripts for iOS/tvOS/Mac developers!

# Install
## Use cmdshelf

```bash
cmdshelf add remote toshi0383 git@github.com:toshi0383/scripts.git
cmdshelf run xcode/open-device-support-dir.sh tvos
```

https://github.com/toshi0383/cmdshelf

# Contents

# bitrise
## download-recent-error-logs.sh
TBD

# carthage
## carthage/checkout
TBD

## carthage/search-bcsymbolmap
TBD

## carthage/update
TBD

## carthage/update-with-hack.sh
TBD

# git
## git/brset
Set upstream remote branch to `origin/$current_branch`.

## git/git-branch-by-author
TBD

## git/replaceOriginWith.sh
Change `origin` to `upstream` and add `$1` as `origin`.
Useful when you cloned somebody's repo, and later forked and want to push to your fork repo.

## git/take-ours
Resolve merge conflict by removing everything from their change.

## git/take-theirs
Resolve merge conflict by removing everything from our change.

# github

## github/pr-approve
Approve a pull-request number `$1`.

## github/pr-check-milestone
TBD

## github/pr-ready-for-review
List pull-requests which you haven't approved and not WIP.

## github/pro
Open PR like `hub pull-request`, but also supports milestone and labels.

## github/update-comment
Add or update PR/issue comment (like Danger).

# image
## image/pixelSize.sh
TBD

## image/sips-assets.sh
Generate given size of @1x,@2x,@3x variants using `sips` utility.

# ios
## ios/resize-appicon.sh
Resizing image for App Icon image assets.

# media/hls
## media/hls/extract-master-playlist
TBD

# net
## net/url_encode
TBD

# snippet/gen
## snippet/gen/color-printf
TBD

# swiftpm
## swiftpm/install.sh
TBD

## swiftpm/release.sh
TBD

# twitter
## twitter/bearer
TBD

# xcode
## xcode/build-time.sh
TBD

## xcode/latest-build-time.sh
TBD

## xcode/check-build-time.sh
TBD

## xcode/find-error.sh
TBD

## xcode/fix-framework-version.sh
TBD

## xcode/open-device-support-dir.sh
TBD

## xcode/printUUIDofMobileprovision.sh
TBD

## xcode/sort-Xcode-project-file
TBD

## xcode/sort-xcpretty-by-time
TBD

## xcode/sync-device-support-dir.sh
TBD

## xcode/total-test-duration
TBD

# xcode/plugins

## xcode/plugins/xcode_toggleFlux_backword.scpt
TBD

## xcode/plugins/xcode_toggleFlux_forward.scpt
TBD

