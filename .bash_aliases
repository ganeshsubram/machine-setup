#
# System
#
alias refresh='source ~/.bashrc'
alias cue='code ~/.bash_aliases'
alias machine='cd ~/machine-setup'
alias code_machine='code ~/machine-setup'

alias exp='xdg-open .'
alias ll='ls -alhF'
alias la='ls -A'
alias lf='ls -CF'
alias ld='du -sh *'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../..'
alias .....='cd ../../../../..'
alias ......='cd ../../../../../..'
alias .......='cd ../../../../../../..'

#
# Git
#
function git_branch {
  git branch --show-current
}
alias gb='git branch'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias gpf='git push -f'
alias gco='git checkout master'
alias gcom='git checkout main'
alias gpom='git pull origin main'
alias gal='git add --all'
alias grbi='git rebase -i main'
alias gcr='git rebase --continue'
alias gcm='git commit -m'
alias cane='git commit --amend --no-edit'
alias gpfu='git push -f -u origin $(git_branch)'
alias grs='git reset --soft HEAD~1 && git restore --staged . && git status'
alias gsr='git restore --staged . && git status'

#
# Tmux
#
alias tmux_refresh='tmux source-file ~/.tmux.conf'

#
# Docker
#
alias docker_enable='systemctl --user enable docker-desktop'
alias docker_start='systemctl --user start docker-desktop'
alias docker_stop='systemctl --user stop docker-desktop'

############################
# Glydways                 #
############################

#
# SSH
#
alias keygenr='ssh-keygen -f "$HOME/.ssh/known_hosts" -R "192.168.200.12" &&  ssh-keygen -f "$HOME/.ssh/known_hosts" -R "192.168.100.11"'

alias 301='ssh_env glydways@agdf-ops-b2-301'
alias 302='ssh_env glydways@agdf-ops-b2-302'
alias 303='ssh_env glydways@agdf-ops-b2-303'
alias 304='ssh_env glydways@agdf-ops-b2-304'
alias 305='ssh_env glydways@agdf-ops-b2-305'

alias 301gui='ssh_env -L 8080:192.168.100.22:8080 glydways@agdf-ops-b2-301'
alias 302gui='ssh_env -L 8080:192.168.100.22:8080 glydways@agdf-ops-b2-302'
alias 303gui='ssh_env -L 8080:192.168.100.22:8080 glydways@agdf-ops-b2-303'
alias 304gui='ssh_env -L 8080:192.168.100.22:8080 glydways@agdf-ops-b2-304'
alias 305gui='ssh_env -L 8080:192.168.100.22:8080 glydways@agdf-ops-b2-305'

#
# Repo
#

alias auth='bazel run @ark//:auth -- -u ganesh'
alias compile='bazel run //:compile_commands'
alias gui='bazel run //glyd/onboard/gui:onboard-gui --'
alias play='bazel run //glyd/onboard/pipelines/playback --'
alias downloadlog='bazel run @ark//:download-log -- -o ~/glyd_logs/'

alias ark='cd $HOME/glyd/third_party/ark'
alias at128='cd $HOME/glyd/glyd/onboard/lidar/hesai/at128'
alias at128='cd $HOME/glyd/glyd/onboard/lidar/hesai/jt128'
alias at128test='bazel test //glyd/onboard/lidar/hesai/at128/...'
alias at128test='bazel test //glyd/onboard/lidar/hesai/jt128/...'
alias atptest='bazel test //glyd/onboard/atp/...'
alias basetest='bazel test //glyd/base/...'
alias conti='cd $HOME/glyd/glyd/onboard/radar/continental/ars540'
alias contitest='bazel test //glyd/onboard/radar/continental/ars540/...'
alias door='cd glyd/onboard/doors'
alias doorgui='bazel run //glyd/onboard/doors/gui --'
alias doortest='bazel test //glyd/onboard/doors/...'
alias estoptest='bazel test //glyd/onboard/estop/...'
alias gld='cd $HOME/glyd'
alias gldcode='code $HOME/glyd'
alias hesai='cd $HOME/glyd/glyd/onboard/lidar/hesai'
alias hesaitest='bazel test //glyd/onboard/lidar/hesai/...'
alias imu='cd $HOME/glyd/glyd/onboard/imu'
alias imutest='bazel test //glyd/onboard/imu/...'
alias lidar='cd $HOME/glyd/glyd/onboard/lidar'
alias lidartest='bazel test //glyd/onboard/lidar/...'
alias lint='cd $HOME/glyd && ./lint.sh && cd -'
alias linttidy='cd $HOME/glyd && ./lint.sh --lint-tidy && cd -'
alias logtool='bazel test //ark-logtool --'
alias ncom='cd $HOME/glyd/third_party/oxts_ncom_sdk'
alias onboardtest='bazel test //glyd/onboard/...'
alias oxts='cd $HOME/glyd/glyd/onboard/imu/oxts/ncom'
alias oxtstest='bazel test //glyd/onboard/imu/oxts/ncom/...'
alias radartest='bazel test //glyd/onboard/radar/...'
alias vcutest='bazel test //glyd/onboard/vcu/...'
alias velodyne='cd $HOME/glyd/glyd/onboard/lidar/velodyne_v2'
alias velodynetest='bazel test //glyd/onboard/lidar/velodyne_v2/...'
alias xsens='cd $HOME/glyd/glyd/onboard/imu/xsens/mti'
alias xsenstest='bazel test //glyd/onboard/imu/xsens/mti/...'

#
# B2
#
alias hla_release='bazel build --stamp --enable_cuda //glyd/onboard/pipelines/b2:autonomy_release-linux-aarch64'
alias hla_deploy='ark-supervisor-tool --host hla:8081 --deploy-archive bazel-bin/glyd/onboard/pipelines/b2/autonomy_release-linux-aarch64.tar.zst'
alias hla_release_and_deploy='hla_release && hla_deploy'

#
# ATP/VCU/ESTOP ELF and IMG build commands
#
alias atpelf='bazel build --stamp //glyd/onboard/atp/pipelines/b2:atp_pipeline.elf'
alias estopelf='bazel build --stamp //glyd/onboard/estop/pipelines:estop_pipeline.elf'
alias vcuelf='bazel build --stamp //glyd/onboard/vcu/pipelines:vcu_pipeline.elf'

alias atpelfcopy='scp bazel-out/k8-opt-ST-3b22708a4922/bin/glyd/onboard/atp/pipelines/b2/atp_pipeline.elf_/atp_pipeline.elf glydways@agdf-tb-mule-dell-r360:.'
alias estopelfcopy='scp bazel-out/k8-opt-ST-3b22708a4922/bin/glyd/onboard/estop/pipelines/estop_pipeline.elf_/estop_pipeline.elf glydways@agdf-tb-mule-dell-r360:.'
alias vcuelfcopy='scp bazel-out/k8-opt-ST-3b22708a4922/bin/glyd/onboard/vcu/pipelines/vcu_pipeline.elf_/vcu_pipeline.elf glydways@agdf-tb-mule-dell-r360:.'

alias build_elves='atpelf && estopelf && vcuelf'
alias copy_elves='atpelfcopy && estopelfcopy && vcuelfcopy'
alias deploy_elves='build_elves && copy_elves'

alias atpimg='bazel build --stamp //glyd/onboard/atp/pipelines/b2:atp_pipeline.img'
alias estopimg='bazel build --stamp //glyd/onboard/estop/pipelines:estop_pipeline.img'
alias vcuimg='bazel build --stamp //glyd/onboard/vcu/pipelines:vcu_pipeline.img'

alias atpcopy='scp bazel-bin/glyd/onboard/atp/pipelines/b2/atp_pipeline.img glydways@gdf-debug-cart:~/workspace/eetools/etf/devices/ganesh/.'
alias estopcopy='scp bazel-bin/glyd/onboard/estop/pipelines/estop_pipeline.img glydways@gdf-debug-cart:~/workspace/eetools/etf/devices/ganesh/.'
alias vcucopy='scp bazel-bin/glyd/onboard/vcu/pipelines/vcu_pipeline.img glydways@gdf-debug-cart:~/workspace/eetools/etf/devices/ganesh/.'

alias build_images='atpimg && estopimg && vcuimg'
alias copy_images='atpcopy && estopcopy && vcucopy'
alias deploy_images='build_images && copy_images'
