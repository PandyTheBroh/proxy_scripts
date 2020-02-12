# Proxy Scripts
Generic Bash scripts to connect/disconnect my job's proxy.
# Summary
A couple scripts to make easier connect/disconnect my job's proxy. This bash scripts have been wrotten to be used via *Script your Proxies* Gnome Shell Extension, but must work themself.

After to execute the proxy.sh with your proxy access configuration, your environment will has been configured the next services to use that proxy:
* System-wide
* Bash environment
* Gnome Shell
* git
* Docker
* Apt

In other hand, you could use this scripts to configure other proxies and change between them without conflicts.

# Compatibility
This scripts only have been tested under a Ubuntu 18.04 LTS. Maybe it could works on other versions/distros, but I can't guarantee it.

For macOS's environment I think that them could work with a few tweaks (at the end is a unix system). Feel free to investigate it, create forks, ask for a new branch or send a pull request to colaborate.

# Prerequisites
To use this scripts I will take for granted the next requisites:
- Several configuration files in the local home that will be symlinked with them system file's counterpart. Inside them, you must to add the regular proxy configurations for the corresponding services (Look in the *References* paragraph for more information about this configurations):
  - Bash environment: ln -s ~/.local/share/proxy/environment /etc/environment
  - Docker: ln -s ~/.local/share/docker/docker.service /etc/systemd/system/docker.service.d/http-proxy.conf
  - Apt: ln -s ~/.local/share/apt/02proxy /etc/apt/apt.conf.d/02proxy
- For the software that isn't preinstalled by default in Ubuntu, you would install and configure previously (Docker & Git). In any case you will find in the *References* paragraph some interesting informations about it.
- Like optional, but recommended, the perfect complement for this scripts is the Gnome Shell Extension *Script your Proxies*. To use it, would be necessary that you have configured your enviroment to use the Gnome Shell Extensions in your Ubuntu and install this plugin. Like before, You can find more information below in the *References* paragraph.

# References
- Gnome Shell Extensions: https://extensions.gnome.org
  - Easy tutorial to install & configure Gnome Shell Extensions: https://itsfoss.com/gnome-shell-extensions
  - Script your Proxies Plugin: 
    - https://extensions.gnome.org/extension/1069/script-your-proxies
    - https://github.com/Eimji/gnome-shell-extension-scriptproxies
- Configuration files for usual services:
  - System-wide: 
    - https://kifarunix.com/how-to-set-system-wide-proxy-in-ubuntu-18-04
    - https://www.golinuxcloud.com/set-up-proxy-http-proxy-environment-variable
    - https://unix.stackexchange.com/a/152292
  - Apt:
    - https://kifarunix.com/how-to-set-system-wide-proxy-in-ubuntu-18-04
    - https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-set-the-proxy-for-apt-for-ubuntu-18-04
    - https://unix.stackexchange.com/a/152292
  - Docker:
    - https://docs.docker.com/config/daemon/#httphttps-proxy
- Additional information to install correctly usual services:
  - Docker: https://docs.docker.com/install/linux/linux-postinstall
