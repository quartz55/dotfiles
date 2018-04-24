# Status update interval
set -g status-interval 1

# Basic status bar colors
set -g status-bg black
set -g status-fg cyan

# Left side of status bar
set -g status-left-bg black
set -g status-left-fg black
set -g status-left-length 40
set -g status-left "#[bg=green] #S ● #[bg=yellow]#[fg=green]#[fg=default] #I #[bg=cyan]#[fg=yellow] #[fg=default]#P "

# Right side of status bar
set -g status-right-bg black
set -g status-right-fg cyan
set -g status-right-length 60
set -g status-right "#{prefix_highlight} #H #[fg=white]« #[fg=yellow]%H:%M:%S #[fg=green]%d/%b/%y "

# Window status
set -g window-status-format " #I:#W#F "
set -g window-status-current-format " #I:#W#F "
set -g window-status-bg white
set -g window-status-fg black

# Current window status
set -g window-status-current-bg red
set -g window-status-current-fg black

# Window with activity status
set -g window-status-activity-bg yellow # fg and bg are flipped here due to a
set -g window-status-activity-fg black  # bug in tmux

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify left

# Pane border
set -g pane-border-bg default
set -g pane-border-fg default

# Active pane border
set -g pane-active-border-bg default
set -g pane-active-border-fg green

# Pane number indicator
set -g display-panes-colour yellow
set -g display-panes-active-colour red

# Clock mode
set -g clock-mode-colour red
set -g clock-mode-style 24

# Message
set -g message-bg default
set -g message-fg default

# Command message
set -g message-command-bg default
set -g message-command-fg default

# Mode
set -g mode-bg red
set -g mode-fg default
