# A Coding Anecdote
Once upon a time, you are working intensely on a coding project on a tight timeline, unbothered and locked in to meet the goals. Suddenly your cat, whom you have forgotten to feed for several hours, jumped in and spilled your coffee over your machine. Screen went black and the keys won't work, indeed a very bad disaster!

Being the rich developer that you are, you walked into a store and in just few minutes you have a new coding laptop. But you know the problem, it would take hours to get it ready for coding again...

# The Solution  
Voila!  a docker image definition that is pre-loaded with tools to help you become a productive coder. It is designed for neovim users who only want simple but useful plugins. Of course, you can always load your own configurations but firing up the default container would already set you on the go in no more than 5 minutes.   

## Simple Steps  
1. Ensure that you have ```docker``` and ```docker-compose``` installed. Look for your OS/distro documentation on the how-to.
2. Clone the repo. ```git clone https://github.com/jayson-nacional/docker-zone.git```
3.  The current config utilizes the environment variable ```DOCKER_USER``` to setup the container user. To set a temporary value, run ```export DOCKER_USER={name of your choice}```.  To make this variable value permanent, simply add it on your shell config (i.e. ~/.bashrc or ~/.zshrc).
4.  The script also assumes that you have a *projects* folder on your home directory. If none, add as needed. This is mounted and routed to the *development* folder of the container.
5.  Navigate to the cloned directory and fire up ```docker compose up -d```. The argument ```-d``` ensures that the container is running in detached mode.
6.  Once the container is created, you can simply connect to the container's terminal using the command ```docker run -it {container id} zsh```. To know the container id, just simply run ```docker ps```. You don't have to type the whole id, just the first few characters would be enough as long as it doesn't conflict with other existing running containers, if there is any.

## Rationale  
--- 
Why *Arch* distro? So you can proudly say, *"I use arch by the way"*.  

Arch, though not the smallest in size in terms of images, ensures that you get the latest packages which is critical for software development. Ubuntu for example (at the time of writing), ships a lower version of neovim that doesn't support the *lazy* package manager. Other candidates such as *Alpine* is also available but it has been known to have some issues especially with debugging capabilities. This image is to be built as a container for development and not production deployment.  

---
Why even use *tmux* inside the container? Yes, containers are temporary, and if you shutdown or reboot your computer, all your sessions are gone. I used to hibernate my machine a lot and only reboot my machine about once a week (maybe you should too) so having my tmux sessions alive for 7 days without reloading everytime is still a BIG win. Besides, there's no easier way to navigate through your container's coding projects without multiplexing. 

--- 
Do you really  need to setup *ssh*? This is the part where I would not heavily defend. This approach is not very secure as the current config also mounts the host's ```~/.ssh``` directory thereby posing the risk that if the container is compromised then so is the host's credentials. But as long as you take extra precautions and know what you are doing then this would still be fine. I encourage you to read further on ssh security practices.   

Why not use SSH-forwarding? Yes, you are totally right, it is the recommended way but normally this is done by mounting the hosts ```ssh.socket``` to the container. At the time of writing, *Arch* has already deprecated the socket for security reasons so the only remaining option which is recommended is to use ```docker secrets``` to pass in the ssh keys. This is a major improvement that the project is eyeing towards to but if you have the time to write the solution, well-written PRs will be reviewed and approved.  

## Dependencies  
```ncurses``` - This is important as it manages the ```terminfo``` inside the container. The importance is heavily noticed when using ```tmux```. By default, tmux reads the terminal definitions from the host using the TERM environment variable. This is typically mapped to ```xterm``` upon provisioning the container. It is an older terminal emulator with limited support for colors, so using themes for neovim would not reflect the ideal colors. Using ```ENV={modern terminal emulator}``` ensures that you get the latest support for colors and fonts. As an alternative, you can always copy the hosts terminal info towards the container but having this package makes the process very simple and easy. 

```node, npm, unzip, ripgrep``` - These are all must have as neovim package management (*mason* in particular) heavily relies on these utilities to handle the installation of several language-servers and debuggers. Removing one of these would cause one or more packages to fail during installation.  

## Important Note  
It is highly recommended that you use specific version of images and packages for distro, SDKs and package managers to ensure consistency especially when your projects are to be shipped to production. ```archlinux:latest``` for example does not guarantee the same version when the build is executed with months of gap, so adding a more specific tag is ideal. Another example would be ```nodejs```. For frontend/javascript developers, having a consistent node/npm version from development to production is critical to ensure that all dependencies that rely on npm are all aligned. This is mainly resolved by using ```nvm``` (node version manager). These are also changes that will be implemented sooner on the image definition.
