# Cheatsheet

> NOTE: Refer to actual which-key menu inside config.nvim by pressing `<leader>`

## Global

_Note: `<C-h/j/k/l>` lazily overrides the default window movement to seamlessly integrate with tmux panes._

| Key           | Mode | Action                        | Source             |
| :------------ | :--- | :---------------------------- | :----------------- |
| `<Esc>`       | n    | Clear search highlight        | init.lua           |
| `<Esc><Esc>`  | t    | Exit terminal mode            | init.lua           |
| `<C-h/j/k/l>` | n    | Move focus left/down/up/right | tmux-navigator.lua |
| `<C-\>`       | n    | Previous pane/split           | tmux-navigator.lua |
| `<leader>q`   | n    | Diagnostic quickfix list      | init.lua           |

## Harpoon

| Key           | Mode | Action       | Source  |
| :------------ | :--- | :----------- | :------ |
| `<leader>a`   | n    | Add file     | Harpoon |
| `<leader>h`   | n    | Quick menu   | Harpoon |
| `<leader>1…9` | n    | Jump to file | Harpoon |
| `<M-1…9>`     | n    | Jump to file | Harpoon |

## Search / Telescope

| Key                | Mode | Action                        | Source    |
| :----------------- | :--- | :---------------------------- | :-------- |
| `<leader><leader>` | n    | Buffers                       | Telescope |
| `<leader>/`        | n    | Fuzzily search current buffer | Telescope |
| `<leader>sh`       | n    | Help                          | Telescope |
| `<leader>sk`       | n    | Keymaps                       | Telescope |
| `<leader>sf`       | n    | Files                         | Telescope |
| `<leader>ss`       | n    | Select Telescope              | Telescope |
| `<leader>sw`       | n    | Current word                  | Telescope |
| `<leader>sg`       | n    | Live grep                     | Telescope |
| `<leader>sd`       | n    | Diagnostics                   | Telescope |
| `<leader>sr`       | n    | Resume                        | Telescope |
| `<leader>s.`       | n    | Recent files                  | Telescope |
| `<leader>s/`       | n    | Live grep in open files       | Telescope |
| `<leader>sn`       | n    | Neovim config files           | Telescope |
| `<leader>H`        | n    | Harpoon files                 | Telescope |

## Silicon

_Note: Shares LHS mappings with Telescope, but isolated to Visual mode._

| Key          | Mode | Action                   | Source  |
| :----------- | :--- | :----------------------- | :------ |
| `<leader>sc` | v    | Copy render to clipboard | Silicon |
| `<leader>sf` | v    | Save render to file      | Silicon |
| `<leader>ss` | v    | Screenshot               | Silicon |

## LSP

_Note: These mappings are buffer-local and only activate when an LSP server attaches._

| Key          | Mode | Action             | Source |
| :----------- | :--- | :----------------- | :----- |
| `gd`         | n    | Definition         | LSP    |
| `gD`         | n    | Declaration        | LSP    |
| `gr`         | n    | References         | LSP    |
| `gI`         | n    | Implementation     | LSP    |
| `<leader>D`  | n    | Type definition    | LSP    |
| `<leader>ds` | n    | Document symbols   | LSP    |
| `<leader>ws` | n    | Workspace symbols  | LSP    |
| `<leader>rn` | n    | Rename             | LSP    |
| `<leader>ca` | n/x  | Code action        | LSP    |
| `<leader>th` | n    | Toggle inlay hints | LSP    |

## Code / Debug (DAP)

| Key          | Mode | Action            | Source |
| :----------- | :--- | :---------------- | :----- |
| `<leader>cu` | n    | Toggle DAP UI     | DAP    |
| `<leader>cb` | n    | Toggle breakpoint | DAP    |
| `<leader>ce` | n    | REPL              | DAP    |
| `<leader>cr` | n    | Run/continue      | DAP    |

## Format / Refactor / Document

| Key          | Mode | Action                                 | Source   |
| :----------- | :--- | :------------------------------------- | :------- |
| `<leader>f`  | n    | Format buffer (Conform, fires on save) | Conform  |
| `<leader>rr` | n/x  | Select refactor                        | Refactor |

## Explorers / Git

| Key         | Mode | Action                                 | Source   |
| :---------- | :--- | :------------------------------------- | :------- |
| `<leader>e` | n    | Neo-tree toggle                        | Neo-tree |
| `<leader>E` | n    | Aerial float toggle                    | Aerial   |
| `<leader>g` | n    | LazyGit                                | LazyGit  |
| `{` / `}`   | n    | Aerial prev/next symbol (buffer-local) | Aerial   |

## Comment

| Key   | Mode | Action                              | Source  |
| :---- | :--- | :---------------------------------- | :------ |
| `gc`  | n/v  | Toggle line comment region          | Comment |
| `gb`  | n/v  | Toggle block comment region         | Comment |
| `gcc` | n    | Toggle line comment (current line)  | Comment |
| `gbc` | n    | Toggle block comment (current line) | Comment |
| `gcO` | n    | Add comment above                   | Comment |
| `gco` | n    | Add comment below                   | Comment |
| `gcA` | n    | Add comment at end of line          | Comment |

## which-key groups

| Key         | Mode | Action                   | Source    |
| :---------- | :--- | :----------------------- | :-------- |
| `<leader>c` | n    | Code & Debuggers group   | which-key |
| `<leader>d` | n    | Document group           | which-key |
| `<leader>r` | n    | Rename or Refactor group | which-key |
| `<leader>s` | n    | Search group             | which-key |
| `<leader>s` | v    | Silicon group            | which-key |
| `<leader>w` | n    | Workspace group          | which-key |
| `<leader>t` | n    | Toggle group             | which-key |
