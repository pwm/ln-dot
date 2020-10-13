# ln-dot

Small util to dump the lightning network graph into a graphviz dot file.

#### Install [stack](https://docs.haskellstack.org/en/stable/README/) and then build the code:

    $ git clone git@github.com:pwm/ln-dot.git
    $ cd ln-dot
    $ nix-build nix/release.nix

or with cabal

    $ nix-shell
    $ cabal build

#### Get the graph from your LN node, eg. a [raspiblitz](https://github.com/rootzoll/raspiblitz):

    $ ssh my-raspiblitz 'lncli describegraph' > ln-graph.json

#### Turn it into a dot file:

    $ ./result/bin/ln-dot "ln-graph.json" > ln-graph.dot

or with cabal

    $ cabal exec -- ln-dot "ln-graph.json" > ln-graph.dot

#### Make the dot file into a pretty png or svg:

    $ sfdp -Tpng ln-graph.dot > ln-graph.png
    $ sfdp -Tsvg ln-graph.dot > ln-graph.svg

![](https://cdn.rawgit.com/pwm/ln-dot/master/pics/ln-graph-neato-small.png)

