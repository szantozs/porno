source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


eval "$(starship init zsh)"
export DOCKER_HOST="unix:///run/user/$(id -u)/podman/podman.sock"
export PATH=/home/zsombor/.local/bin:$PATH
