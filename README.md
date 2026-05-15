# Simple.nvim

Minimal Neovim config with LSP.

### Installation

Requirements:

- [Neovim 0.12+](https://github.com/neovim/neovim/releases/)
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`), `ripgrep`
- Needed for LSP setup: [nodejs](https://nodejs.org/en), [golang](https://go.dev/)
- If you use custom Linux setup you'll need a clipboard tool (ie. wl-clipboard/xclip/xsel)
- [Nerd Fonts](https://www.nerdfonts.com/): Provides various symbols/icons
- Language Setup:
  - [clangd](https://clangd.llvm.org/installation.html)
  - [gopls](https://go.dev/gopls/#installation)
  - html: `npm i -g vscode-langservers-extracted`
  - intelephense (php): `npm install -g intelephense`
  - [lua_ls](https://luals.github.io/)
  - [marksman](https://github.com/artempyanykh/marksman)

Backup your current nvim folders (if any):

```bash
# Linux/Mac
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Windows
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
```

Clone the repository:

```bash
# Linux/Mac
git clone https://github.com/moonbrooke/simple.nvim.git ~/.config/nvim

# Windows
git clone https://github.com/moonbrooke/simple.nvim.git $env:LOCALAPPDATA\nvim
```

(Optional) Remove the .git folder:

```bash
# Linux/Mac
rm -rf ~/.config/nvim/.git

# Windows
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
```

Start Neovim:

```bash
nvim
```
