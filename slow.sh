#!/bin/bash
# Sometimes its hard to debug information flickering on the screen. This will slow down that flow.
while true; do
VBoxManage controlvm "arch1 1" pause && sleep 2 || VBoxManage controlvm "arch1 1" resume && sleep 0.5
done

