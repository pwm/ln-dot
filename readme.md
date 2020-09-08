# ln-dot

Small util to dump the lightning network graph into a graphviz dot file.

#### Install [stack](https://docs.haskellstack.org/en/stable/README/) and then build the code:

    # git clone git@github.com:pwm/ln-dot.git
    # cd ln-dot
    # stack build

#### Get the graph from your LN node, eg. a [raspiblitz](https://github.com/rootzoll/raspiblitz):

    # ssh raspiblitz 'lncli describegraph' > ln-graph.json

#### Turn it into a dot file:

    # stack exec ln-dot "ln-graph.json" > ln-graph.dot

#### Install [graphviz](https://graphviz.org/) and make the dot file into a pretty png or svg:

    # sfdp -Tpng ln-graph.dot > ln-graph.png
    # sfdp -Tsvg ln-graph.dot > ln-graph.svg

![](https://cdn.rawgit.com/pwm/ln-dot/master/pics/ln-graph-neato-small.png)

