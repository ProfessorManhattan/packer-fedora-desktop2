# Workstation installation script for Fedora 33 server edition
# This is needed because auto unattend installation with kickstarter file is not supported

# Install the Workstation group
sudo yum groupinstall "Fedora Workstation" --skip-broken -y

# Change systemd to start graphical mode
sudo systemctl set-default graphical.target

# Reboot system for changes to take effect
sudo systemctl reboot
