# Battlestation

0. iTerm2

0. Homebrew

    `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

0. oh-my-zsh 
    
    `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

0. zsh addons
    
    `brew install zsh-syntax-highlighting`

    `brew install zsh-autosuggestions`

0. Powerline fonts

    `g clone https://github.com/powerline/fonts`

    `cd fonts/`

    `./install.sh`

0. [Meslo Fonts](`https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k`)

0. powerlevel10k

    `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k`

    `srczsh`


0. VSCode Font ligatures

    `brew tap homebrew/cask-fonts`

    `brew cask install font-fira-code`

0. [Github SSH setup](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)