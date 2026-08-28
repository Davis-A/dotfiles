Additional steps on new machines:

# MacOS: 

### touchid sudo, and in tmux in tmux

First install pam-reattach with `brew install pam-reattach`
Then to configure it you need to create/edit `/etc/pam.d/sudo_local`
```
# pam reattach for tmux
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
# uncomment following line to enable Touch ID for sudo
auth       sufficient     pam_tid.so
```

### Chromium middle click scroll 
Run chromium with `--enable-blink-features=MiddleClickAutoscroll` ie `open -a "Google Chrome" --args --enable-blink-features=MiddleClickAutoscroll`  
Some chromium based browsers (not chrome) have it as a feature flag with `chrome://flags/#middle-button-autoscroll`
