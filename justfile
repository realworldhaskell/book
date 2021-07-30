set shell := ["bash", "-uc"]
set dotenv-load
set export
set positional-arguments


# List all
default:
  just --list


# Run ghcup
ghcup:
  docker run --rm -it --net host \
    --name rwh \
    -v {{justfile_directory()}}:/workdir \
    -v ~/.cabal:/root/.cabal \
    -w /workdir \
    ghcr.io/realworldhaskell/book:master bash

