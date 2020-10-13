# ln-dot

Small util to dump the lightning network graph into a graphviz dot file.

#### 1. Get the code:

    $ git clone git@github.com:pwm/ln-dot.git
    $ cd ln-dot

#### 2. Build the code:

with Nix:

    $ nix-build nix/release.nix --attr exe

with Cabal:

    $ nix-shell --run "cabal build"

#### 3. Get the graph from your LN node, eg. your [raspiblitz](https://github.com/rootzoll/raspiblitz):

    $ ssh my-raspiblitz 'lncli describegraph' > ln-graph.json

#### 4. Turn it into a dot file using `ln-dot`:

with Nix:

    $ ./result/bin/ln-dot "ln-graph.json" > ln-graph.dot

with Cabal:

    $ cabal exec -- ln-dot "ln-graph.json" > ln-graph.dot

#### 5. Turn the dot file into a pretty pic:

    $ sfdp -Tpng ln-graph.dot > ln-graph.png
    $ sfdp -Tsvg ln-graph.dot > ln-graph.svg

see an example in the `pics` directory.