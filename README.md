# Neovim configuration

Personal [LazyVim](https://www.lazyvim.org/) configuration backed up from
`~/.config/nvim`.

## Restore

```sh
git clone git@github.com:dincorvaia-nc/neovim.git ~/.config/nvim
nvim
```

LazyVim installs plugins on first launch. External tools used by individual
language integrations may also need to be installed through Mason.

## Apex language server (manual)

The Salesforce Apex language-server JAR and the Salesforce VS Code extension
source are intentionally not tracked in this repository. Obtain the Apex
extension from Salesforce's official VS Code Marketplace distribution, then
place its `apex-jorje-lsp.jar` at:

```text
~/.config/nvim/lsps/salesforcedx-vscode/packages/salesforcedx-vscode-apex/jars/apex-jorje-lsp.jar
```

The expected path is configured in `lua/plugins/apex.lua`. Apex formatting
also expects `prettier-plugin-apex` in Mason's Prettier installation, and Apex
linting expects PMD; install those locally if Mason has not already done so.

Do not commit the downloaded extension, JARs, generated files, or other
language-server binaries. The entire `lsps/` directory is ignored.
