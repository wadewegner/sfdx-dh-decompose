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

## What is this showing?

- It shows how we can logically split the Dreamhouse application into four package directories
- It demonstrates that there are relationships between the package directories
  - `schema` is logically contained
  - `bl` depends on `schema`
  - `ui` depends on a combination of `schema` and `bl`
  - `perms` depends on the rest
- It shows we can compose the tiers such that dependencies are properly encapsulated
- It shows we can push our source successfully as each tier is added to the project
- It shows that we can also push the entire project (with all four package directories) at the same time

## Dependencies

Install my handy plugin: `sfdx plugins:install sfdx-waw-plugin`

## Try it

```
chmod +x decomp.sh
./decomp.sh
```
