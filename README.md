# personal-vimrc
The "safe" part of my vim configuration; the config does not load any external code.

## Instruction to append this configuration to use it in a standalone way:
### Vim
```bash
curl https://raw.githubusercontent.com/datMaffin/personal-vimrc/master/plugin/vimrc.vim >> ~/.vimrc
```

### Neovim
```bash
curl https://raw.githubusercontent.com/datMaffin/personal-vimrc/master/plugin/vimrc.vim >> ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim
```
