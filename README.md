<p align="center"><img src="https://i.imgur.com/kyxhcwg.png" width="128" height="128"></p>

# node-prune.sh

`node-prune.sh` is a small tool to prune unnecessary files from `./node_modules`, such as markdown, typescript source files, and so on.

## Usage

```bash
wget -qO- raw.githubusercontent.com/jeromedecoster/node-prune.sh/master/node-prune.sh | bash
```

### Silent Mode

```bash
wget -qO- raw.githubusercontent.com/jeromedecoster/node-prune.sh/master/node-prune.sh | PRUNE_SILENTLY=1 bash
```

or

```bash
export PRUNE_SILENTLY=1
wget -qO- raw.githubusercontent.com/jeromedecoster/node-prune.sh/master/node-prune.sh | bash
```

---

### Credits

This is a fork of the **excellent** [npmprune](https://github.com/xthezealot/npmprune) project

Who himself was inspired by the **excellent** [node-prune](https://github.com/tj/node-prune) project
