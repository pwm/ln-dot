# ln-dot

Dump out the lightning network graph into a graphviz dot file

### 0. Build

    # git clone git@github.com:pwm/ln-dot.git
    # cd ln-dot
    # stack build

### 1. Get the graph

    # ssh raspiblitz 'lncli describegraph' > ln-graph.json

### 2. Turn it into a dot file

    # stack exec ln-dot "ln-graph.json" > ln-graph.dot

### 3. Make it into a pretty png or svg

    # sfdp -Tpng ln-graph.dot > ln-graph.png
    # sfdp -Tsvg ln-graph.dot > ln-graph.svg
