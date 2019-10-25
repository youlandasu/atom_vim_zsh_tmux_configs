#!/bin/bash
ROOTHPATH=~
CURRENTDIC=$PWD
echo $CURRENTDIC

while true; do
    read -p "Do you wish to setup tmux? [Y/n]" yn
    case $yn in
        [Y]* )
            if [ -d "$ROOTHPATH/.tmux" ]
            then
                while true; do
                    read -p "$ROOTHPATH/.tmux exists. Continue? [Y/n]" yn2
                    case $yn2 in
                        [Y]* ) break;;
                        [n]* ) break;;
                        * ) echo "Please answer Y or n.";;
                    esac
                done
                if [ $yn2 == n ]
                then
                    break
                fi
            fi
            cd $ROOTHPATH
            git clone https://github.com/gpakosz/.tmux.git
            ln -s -f .tmux/.tmux.conf
            cp .tmux/.tmux.conf.local .
            cd $CURRENTDIC
            echo "Done!"; break;;
        [n]* ) echo "Pass tmux setting"; break;;
        * ) echo "Please answer Y or n.";;
    esac
done


while true; do
    read -p "Do you wish to setup vim? [Y/n]" yn
    case $yn in
        [Y]* )
            if [ -d "$ROOTHPATH/.vim_runtime" ]
            then
                while true; do
                    read -p "$ROOTHPATH/.vim_runtime exists. Continue? [Y/n]" yn2
                    case $yn2 in
                        [Y]* ) break;;
                        [n]* ) break;;
                        * ) echo "Please answer Y or n.";;
                    esac
                done
                if [ $yn2 == n ]
                then
                    break
                fi
            fi
            git clone --depth=1 https://github.com/amix/vimrc.git $ROOTHPATH/.vim_runtime
            sh $ROOTHPATH/.vim_runtime/install_awesome_vimrc.sh
            git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim_runtime/my_plugins/nerdtree-git-plugin
            cp my_configs.vim $ROOTHPATH/.vim_runtime/my_configs.vim
            echo "Done!"; break;;
        [n]* ) echo "Pass vim setting"; break;;
        * ) echo "Please answer Y or n.";;
    esac
done

while true; do
    read -p "Do you wish to install anaconda? [Y/n]" yn
    case $yn in
        [Y]* )

            condaweb=$(curl -s https://www.anaconda.com/distribution/)
            filename=$(echo $condaweb | sed "s/.*\(Anaconda3-[0-9]*.[0-9]*-Linux-x86_64\).*/\1/")
            filename="$filename.sh"
            echo "Download from https://repo.anaconda.com/archive/$filename"
            wget https://repo.anaconda.com/archive/$filename -P "$ROOTHPATH"/software
            sh "$ROOTHPATH"/software/$filename
            echo "Done!"; break;;
        [n]* ) echo "Pass anaconda setting"; break;;
        * ) echo "Please answer Y or n.";;
    esac
done

while true; do
    read -p "Do you wish to install oh my zsh (if you change zsh to default, enter exit to get back to installation)? [Y/n]" yn
    case $yn in
        [Y]* )
            sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
            cp $CURRENTDIC/.zshrc $ROOTHPATH/.zshrc
            while true; do
                read -p "Do you wish to copy cond config to zsh? [Y/n]" yn
                case $yn in
                    [Y]* )
                        cat $ROOTHPATH/.bashrc| grep "# >>> conda init" -A 13 >> $ROOTHPATH/.zshrc
                        echo "Done!"; break;;
                    [n]* ) break;;
                    * ) echo "Please answer Y or n.";;
                esac
            done
            echo "Done!"; break;;
        [n]* ) echo "Pass oh my zsh setting"; break;;
        * ) echo "Please answer Y or n.";;
    esac
done
