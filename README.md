# sfdx-dh-decompose

A script that shows you how to decompose the famous dreamhouseapp/dreamhouse-sfdx into multiple package directories.

Here's what the final package directory structure will look like:
```
dreamhouse-sfdx/
├── src/schema
├── src/bl
├── src/ui
└── src/perms
```

## Dependencies

Install my handy plugin: `sfdx plugins:install sfdx-waw-plugin`

## Try it

```
chmod +x decomp.sh
./decomp.sh
```
