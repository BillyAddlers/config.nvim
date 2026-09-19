# config.nvim

<p align="center">
  <img src="lua.png" alt="Lua" width="600">
</p>

> An opinionated but robust Neovim configuration used across most of my project.

[![Skillicons](https://skillicons.dev/icons?i=typescript,tailwind,python,go)](https://skillicons.dev)

## Introduction

A customizable personal Neovim config that is:

- Robust
- Modular
- Completely Documented

<p align="center">
  <img src="screenshot.png" alt="Screenshot">
</p>

> Project in display is [go-relaychat](https://github.com/BillyAddlers/go-relaychat).

## Installation

### Install Neovim

This project is based off [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), which as you may know _only_ targets the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

Basic Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
  - Needed to build native plugins (LuaSnip regexp support, `telescope-fzf-native`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) — for Telescope's live grep (`<leader>sg`)
- Clipboard tool (xclip/xsel/win32yank or other depending on platform) — for `clipboard = 'unnamedplus'`
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true

Language Setup:

- If you want to write Typescript, you need `npm` (`ts_ls`, `eslint`, `tailwindcss`, `prettier`, `mdx_analyzer`, …)
- If you want to write Golang, you will need `go` (`gopls`, `gofumpt`, `goimports`, `gofmt`)
- If you want to write Python, you will need `python` (`pyright`)
- etc.

Optional / Feature-gated:

- [ImageMagick](https://imagemagick.org) (`magick` CLI) — image/PDF/SVG preview in Markdown via `snacks.image`. Without it only PNGs are displayed. LaTeX math additionally needs `tectonic` or `pdflatex`; Mermaid diagrams need `mmdc`.
  - Ubuntu: `sudo apt install imagemagick`
  - Fedora: `sudo dnf install ImageMagick`
  - Arch: `sudo pacman -S imagemagick`
  - macOS: `brew install imagemagick`
- [Silicon](https://github.com/Aloxaf/silicon) — beautiful code screenshots
  - `cargo install silicon`
    > **NOTE** > For Arch/Cachy, just install from pacman with `sudo pacman -S silicon`
  - It contains my personal font and watermark (see `lua/plugins/silicon.lua`), so don't forget to change them!
- [lazygit](https://github.com/jesseduffield/lazygit) — visual Git UI (`<leader>g`)
- `tmux` — seamless tmux pane / Neovim split navigation
- [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) + C compiler — building parsers for nvim-treesitter (`:TSUpdate`)
- `hexokinase` binary — color previews next to hex codes (`make hexokinase` in the plugin directory)

Installed automatically by [Mason](https://github.com/williamboman/mason.nvim) — no manual step:

- LSP servers: `clangd`, `gopls`, `rust_analyzer`, `pyright`, `ts_ls`, `eslint`, `tailwindcss`, `html`, `angularls`, `vue_ls`, `svelte`, `mdx_analyzer`, `marksman`, `dockerls`, `docker_compose_language_service`, `arduino_language_server`, `roslyn_ls`, `lua_ls` — plus `stylua`
- Debug adapters: `codelldb` (C/C++/Rust/Zig) and `delve` (Go), via `mason-nvim-dap`
- Conform / none-ls formatters (`gofumpt`, `goimports`, `gofmt`, `clang-format`, `prettier`, `markdownlint-cli2`, `markdown-toc`) are **not** managed by Mason — they must be on your `PATH`

### Pinned / Patched Plugins

Some plugins are pinned to an exact commit so that a local fix is not reverted by
`:Lazy update` — or by `:Lazy install`, which runs a `git checkout` and would
otherwise discard the patch. Adding `pin = true` makes lazy.nvim skip its
`git.checkout` step for that plugin, so the working-tree patch survives.

| Plugin                                                        | Pinned revision                                                 | Reason                                                                                                                                         | Unpin      |
| :------------------------------------------------------------ | :-------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------- | :--------- |
| [nvim-silicon](https://github.com/michaelrommel/nvim-silicon) | `7f66bda8f60c97a5bf4b37e5b8acb0e829ae3c32` (`main`, 2025-01-09) | Local fix for a deprecated `vim.validate` call (the table form is removed in Neovim 1.0). Without the pin, `:Lazy update` checks the fix away. | See below. |

The pin lives in [`lua/plugins/silicon.lua`](lua/plugins/silicon.lua):

```lua
commit = '7f66bda8f60c97a5bf4b37e5b8acb0e829ae3c32',
pin = true,
```

#### Unpinning a plugin

Do this once upstream ships the fix (or the deprecation warning is no longer needed):

1. Remove the `commit` and `pin` lines from `lua/plugins/silicon.lua`.
2. Discard the local patch so the next checkout is clean:
   ```sh
   git -C ~/.local/share/nvim/lazy/nvim-silicon checkout .
   ```
3. Update the plugin:
   ```
   :Lazy update nvim-silicon
   ```

#### The local patch

Applied in `~/.local/share/nvim/lazy/nvim-silicon/lua/nvim-silicon/init.lua`
(working-tree only — reapply if the plugin is ever re-cloned):

```diff
-	vim.validate({
-		opts = { opts, "table" }
-	})
+	vim.validate("opts", opts, "table")
```

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install config.nvim

> **NOTE** > [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`                    |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                 |

#### \*Extra Step

If you're planning to build your own Neovim config, either [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
or the repo this project based off, which is [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> **NOTE**
> Your fork's url will be something like this:
> `https://github.com/<your_github_username>/config.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in this repo to make maintenance easier, but it's
[recommmended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone config.nvim

> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> the username with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/billyaddlers/config.nvim "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/billyaddlers/config.nvim "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/billyaddlers/config.nvim "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

Also, feel free to check half-heartedly documented Cheatsheet [here.](./doc/cheatsheet.md)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install config.nvim](#install-config.nvim) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
   either follow the instructions on the page or use winget,
   run in cmd as **admin**:

```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
   open a new one so that choco path is set, and run in cmd as **admin**:

```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

</details>

#### Linux Install

<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```

</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```

</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```

</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

</details>
