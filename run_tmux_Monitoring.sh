#! /bin/bash

#Create tmux windows with usefull utilities
tmux new-session -n Monitoring \; \
	split-window -h \; \
	select-pane -t 0 \; \
	split-window -v \; \
	split-window -v \; \
	select-pane -t 0 \; \
	send-keys 'top' C-m \; \
	select-pane -t 1 \; \
	send-keys 'watch -d sensors k10temp-pci-00c3' C-m \; \
	select-pane -t 2 \; \
	send-keys 'background_changer.py' C-m \; \
	select-pane -t 3 \;
