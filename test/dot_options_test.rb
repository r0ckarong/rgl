require 'test_helper'

require 'rgl/dot'
require 'rgl/adjacency'

class TestDotOptions < Test::Unit::TestCase
  def test_vertex_options
    graph = RGL::DirectedAdjacencyGraph.new
    graph.add_vertex('NODE_OPTS')
    RGL::DOT::NODE_OPTS.each do |opt|
      # Omitting shapefile for now because I don't have a proper file to test this with
      next if opt == 'shapefile'

      graph.add_vertex(opt)
      graph.add_edge('NODE_OPTS', opt)
      graph.set_edge_options('NODE_OPTS', opt)
    end

    graph.add_vertex('polygon')
    graph.set_vertex_options('polygon' , shape: 'point', style: 'invis')
    graph.add_edge('shape', 'polygon')
    graph.set_edge_options('shape','polygon', label: "shape = polygon")

    ['distortion', 'regular', 'sides', 'skew'].each do |opt|
      graph.remove_edge('NODE_OPTS', opt)
      graph.add_edge('polygon', opt)
    end

    graph.set_vertex_options('color', label: "color: green", color: "green")
    graph.set_vertex_options('colorscheme', colorscheme: "accent8", color: 6, label: "colorscheme:\naccent8\/6")
    graph.set_vertex_options('comment', label: "comment:\nMy Comment (SVG source)", comment: "My Comment")
    graph.set_vertex_options('distortion', label: "distortion: 0.6", shape: "polygon", distortion: "0.6")
    graph.set_vertex_options('fillcolor', label: "fillcolor: lightblue", fillcolor: "lightblue", style: "filled")
    graph.set_vertex_options('fixedsize', label: "fixedsize\nheight: 4.0\nwidth: 2.5", fixedsize: "true", width: 4.0, height: 2.5)
    graph.set_vertex_options('fontcolor', label: "fontcolor: red", fontcolor: "red")
    graph.set_vertex_options('fontname', label: "fontname: Courier", fontname: "Courier")
    graph.set_vertex_options('fontsize', label: "fontsize: 34", fontsize: "34")
    graph.set_vertex_options('group', group: "opts")
    graph.set_vertex_options('height', label: "height: 1.5", height: "1.5")
    graph.set_vertex_options('id', label: "id\n(SVG ID)", id: "MyID")
    graph.set_vertex_options('label', label: "label")
    graph.set_vertex_options('labelloc', label: "labelloc b", labelloc: "b")
    graph.set_vertex_options('layer', layer: "overlay range")
    graph.set_vertex_options('margin', label: "margin: 0.25,0.25", margin: "0.25,0.25")
    graph.set_vertex_options('nojustify', label: "The first line is longer\nnojustify=false\\l", nojustify: 'false', shape: "box", width: 3)
    graph.set_vertex_options('orientation', label: "orientation: 71", shape: "polygon", orientation: "71")
    graph.set_vertex_options('penwidth', label: "penwidth: 5.0", penwidth: "5.0")
    graph.set_vertex_options('peripheries', label: "peripheries: 4", peripheries: "4")
    graph.set_vertex_options('regular', shape: "hexagon", regular: "true")
    graph.set_vertex_options('samplepoints', label: "samplepoints: 16", samplepoints: 16)
    graph.set_vertex_options('shape', label: "shape: box3d", shape: "box3d")
    # graph.set_vertex_options('shapefile', shapefile: example_shapefile)
    graph.set_vertex_options('sides', label: "sides: 8",shape: "polygon", sides: "8")
    graph.set_vertex_options('skew', label: "skew 0.5", shape: "polygon", sides: "8", skew: "0.5")
    graph.set_vertex_options('style', label: "style: dashed", style: "dashed")
    graph.set_vertex_options('target', label: "target: _blank", URL: "https://graphviz.org/docs/attrs/target/", target: "_blank")
    graph.set_vertex_options('tooltip', label: "tooltip: FOO", tooltip: "FOO")
    graph.set_vertex_options('URL', label: "URL: http://www.example.org", URL: "http://www.example.org")
    graph.set_vertex_options('width', label: "width: 4.25", width: "4.25")

    graph_options = { 'rankdir' => 'LR' }

    dot = graph.to_dot_graph(graph_options).to_s

    assert_match(dot, /color \[\n\s*color = green,\n\s*fontsize = 8,\n\s*label = "color: green"*/)
    assert_match(dot, /colorscheme \[\n\s*color = 6,\n\s*colorscheme = accent8,\n\s*fontsize = 8,\n\s*label = "colorscheme:\\naccent8\/6"*/)
    assert_match(dot, /comment \[\n\s*comment = "My Comment",\n\s*fontsize = 8,\n\s*label = "comment:\\nMy Comment \(SVG source\)"*/)
    assert_match(dot, /distortion \[\n\s*distortion = 0.6,\n\s*fontsize = 8,\n\s*shape = polygon,\n\s*label = "distortion: 0.6"*/)
    assert_match(dot, /fillcolor \[\n\s*fillcolor = lightblue,\n\s*fontsize = 8,\n\s*style = filled,\n\s*label = "fillcolor: lightblue"*/)
    assert_match(dot, /fixedsize \[\n\s*fixedsize = true,\n\s*fontsize = 8,\n\s*height = 2.5,\n\s*width = 4.0,\n\s*label = "fixedsize\\nheight: 4.0\\nwidth: 2.5"*/)
    assert_match(dot, /fontcolor \[\n\s*fontcolor = red,\n\s*fontsize = 8,\n\s*label = "fontcolor: red"*/)
    assert_match(dot, /fontname \[\n\s*fontname = Courier,\n\s*fontsize = 8,\n\s*label = "fontname: Courier"*/)
    assert_match(dot, /fontsize \[\n\s*fontsize = 34,\n\s*label = "fontsize: 34"*/)
    assert_match(dot, /group \[\n\s*fontsize = 8,\n\s*group = opts*/)
    assert_match(dot, /height \[\n\s*fontsize = 8,\n\s*height = 1.5,\n\s*label = "height: 1.5"*/)
    assert_match(dot, /id \[\n\s*fontsize = 8,\n\s*id = MyID,\n\s*label = "id\\n\(SVG ID\)"*/)
    assert_match(dot, /label \[\n\s*fontsize = 8,\n\s*label = label*/)
    assert_match(dot, /labelloc \[\n\s*fontsize = 8,\n\s*labelloc = b,\n\s*label = "labelloc b"*/)
    assert_match(dot, /layer \[\n\s*fontsize = 8,\n\s*layer = "overlay range"*/)
    assert_match(dot, /margin \[\n\s*fontsize = 8,\n\s*margin = "0.25,0.25",\n\s*label = "margin: 0.25,0.25"*/)
    assert_match(dot, /nojustify \[\n\s*fontsize = 8,\n\s*nojustify = false,\n\s*shape = box,\n\s*width = 3,\n\s*label = "The first line is longer\\nnojustify=false\\l"*/)
    assert_match(dot, /orientation \[\n\s*fontsize = 8,\n\s*orientation = 71,\n\s*shape = polygon,\n\s*label = "orientation: 71"*/)
    assert_match(dot, /penwidth \[\n\s*fontsize = 8,\n\s*penwidth = 5.0,\n\s*label = "penwidth: 5.0"*/)
    assert_match(dot, /peripheries \[\n\s*fontsize = 8,\n\s*peripheries = 4,\n\s*label = "peripheries: 4"*/)
    assert_match(dot, /regular \[\n\s*fontsize = 8,\n\s*regular = true,\n\s*shape = hexagon*/)
    assert_match(dot, /samplepoints \[\n\s*fontsize = 8,\n\s*samplepoints = 16,\n\s*label = "samplepoints: 16"*/)
    assert_match(dot, /shape \[\n\s*fontsize = 8,\n\s*shape = box3d,\n\s*label = "shape: box3d"*/)
    # assert_match(dot, /shapefile \[\n\s*fontsize = 8,\n\s*shapefile = example_shapefile*/)
    assert_match(dot, /sides \[\n\s*fontsize = 8,\n\s*shape = polygon,\n\s*sides = 8,\n\s*label = "sides: 8"*/)
    assert_match(dot, /skew \[\n\s*fontsize = 8,\n\s*shape = polygon,\n\s*sides = 8,\n\s*skew = 0.5,\n\s*label = "skew 0.5"*/)
    assert_match(dot, /style \[\n\s*fontsize = 8,\n\s*style = dashed,\n\s*label = "style: dashed"*/)
    assert_match(dot, /target \[\n\s*fontsize = 8,\n\s*target = _blank,\n\s*URL = "https:\/\/graphviz.org\/docs\/attrs\/target\/",\n\s*label = "target: _blank"*/)
    assert_match(dot, /tooltip \[\n\s*fontsize = 8,\n\s*tooltip = FOO,\n\s*label = "tooltip: FOO"*/)
    assert_match(dot, /URL \[\n\s*fontsize = 8,\n\s*URL = "http:\/\/www.example.org",\n\s*label = "URL: http:\/\/www.example.org"*/)
    assert_match(dot, /width \[\n\s*fontsize = 8,\n\s*width = 4.25,\n\s*label = "width: 4.25"*/)

    graph.vertices.each do |v|
      v == 'NODE_OPTS' ? graph.set_vertex_options(v, label: "Node\nOptions", URL: 'https://graphviz.org/docs/nodes/', target: '_blank') : graph.set_vertex_options(v, URL: "https://graphviz.org/docs/attrs/#{v}/", target: '_blank')
    end

    graph.write_to_graphic_file('svg', 'node-opts-graph', graph_options)
  end

  def test_edge_options
    graph = RGL::DirectedAdjacencyGraph.new
    graph.add_vertex('EDGE_OPTS')
    RGL::DOT::EDGE_OPTS.each do |opt|
      graph.add_edge('EDGE_OPTS', opt)
    end

    # Divide the options into the HTL subgroups (Head/Tail Label)

    # Create subgroup for edge label attributes
    graph.add_vertex('labelgroup')
    graph.set_vertex_options('labelgroup', shape: 'house', orientation: "90", label: 'edge label')
    graph.add_edge('EDGE_OPTS', 'labelgroup')
    graph.set_edge_options('EDGE_OPTS', 'labelgroup', headport: 'w', constraint: 'false')
    [ 'label',
      'labelfloat',
      'labelhref',
      'labelURL',
      'labeltarget',
      'labeltooltip'].each do |entry|
      graph.remove_edge('EDGE_OPTS', entry)
      graph.add_edge('labelgroup', entry)
      graph.set_vertex_options(entry, group: 'labelgroup')
    end

    graph.add_edge('href','target')
    graph.remove_edge('EDGE_OPTS', 'target')

    graph.add_edge('edgeURL','edgetarget')
    graph.add_edge('edgehref','edgetarget')
    graph.remove_edge('EDGE_OPTS', 'edgetarget')

    graph.add_edge('labelURL','labeltarget')
    graph.add_edge('labelhref','labeltarget')
    graph.remove_edge('labelgroup', 'labeltarget')

    # Create subgroup for head label attributes
    graph.add_vertex('headgroup')
    graph.set_vertex_options('headgroup', shape: 'house', orientation: "90", label: 'head label')
    graph.add_edge('EDGE_OPTS', 'headgroup')
    graph.set_edge_options('EDGE_OPTS', 'headgroup', headport: 'w', constraint: 'false')
    ['headclip', 'headhref', 'headlabel', 'headport', 'headtarget', 'headtooltip', 'headURL'].each do |entry|
      graph.remove_edge('EDGE_OPTS', entry)
      graph.add_edge('headgroup', entry)
      graph.set_vertex_options(entry, group: 'headgroup')
    end
    graph.set_vertex_options('headclip', labelloc: 't')
    graph.add_edge('headURL', 'headtarget')
    graph.add_edge('headhref', 'headtarget')
    graph.remove_edge('headgroup', 'headtarget')

    # Create subgroup for tail label attributes
    graph.add_vertex('tailgroup')
    graph.set_vertex_options('tailgroup', shape: 'house', orientation: "90", label: 'tail label', labelloc: 'b')
    graph.add_edge('EDGE_OPTS', 'tailgroup')
    graph.set_edge_options('EDGE_OPTS', 'tailgroup', headport: 'w', constraint: 'false')
    %w[tailclip tailhref taillabel tailport tailtarget tailtooltip tailURL].each do |entry|
      graph.remove_edge('EDGE_OPTS', entry)
      graph.add_edge('tailgroup', entry)
      graph.set_vertex_options(entry, group: 'tailgroup')
    end

    graph.add_edge('tailURL', 'tailtarget')
    graph.add_edge('tailhref', 'tailtarget')
    graph.remove_edge('tailgroup', 'tailtarget')

    # Add the edges to the subgroups
    ['labelangle','labeldistance','labelfontcolor','labelfontname', 'labelfontsize'].each do |opt|
      graph.add_edge('htlattribs', opt)
      graph.remove_edge('EDGE_OPTS', opt)
    end
    graph.set_edge_options('headlabel', 'htlattribs', arrowhead: 'none')
    graph.set_edge_options('taillabel', 'htlattribs', arrowhead: 'none')
    graph.add_edge('headlabel', 'htlattribs')
    graph.add_edge('taillabel', 'htlattribs')
    graph.set_vertex_options('htlattribs', style: 'invis', shape: 'point')

    # Set edge options
    graph.set_edge_options('EDGE_OPTS', 'arrowhead', tailport: 'n', arrowhead: "empty", label: "arrowhead: empty")
    graph.set_edge_options('EDGE_OPTS', 'arrowsize', tailport: 'n', arrowsize: 3, label: "arrowsize: 3")
    graph.set_edge_options('EDGE_OPTS', 'arrowtail', tailport: 'ne', dir: "back", arrowtail: "odot", label: "arrowtail: odot")
    graph.set_edge_options('EDGE_OPTS', 'color', tailport: 'n', color: "magenta", label: "color: magenta")
    graph.set_edge_options('EDGE_OPTS', 'colorscheme', tailport: 'n', colorscheme: "accent8", color: 6, label: "colorscheme:\naccent8\/6")
    graph.set_edge_options('EDGE_OPTS', 'comment', tailport: 'n', label: "comment\n(SVG source)", comment: "My Comment")
    graph.set_edge_options('EDGE_OPTS', 'constraint', nodeport: 'nw', constraint: 'false', label: "constraint: false")
    graph.set_edge_options('EDGE_OPTS', 'decorate', tailport: 'n', decorate: 'true', label: "decorate: true")
    graph.set_edge_options('EDGE_OPTS', 'dir', tailport: 'n', dir: 'both', label: "dir: both")
    graph.set_edge_options('EDGE_OPTS', 'edgeURL', edgeURL: "https://www.example.org", label: "edgeURL: https://www.example.org")
    graph.set_edge_options('EDGE_OPTS', 'edgehref', edgehref: "https://www.example.org", label: "edgehref: https://www.example.org")
    graph.set_edge_options('edgeURL', 'edgetarget', edgeURL: "https://www.example.org", label: "optional")
    graph.set_edge_options('edgehref', 'edgetarget', edgehref: "https://www.example.org", label: "optional")
    graph.set_edge_options('EDGE_OPTS', 'edgetooltip', edgetooltip: 'FOOLTIP', label: "edgetooltip: FOOLTIP")
    graph.set_edge_options('EDGE_OPTS', 'fontcolor', label: "fontcolor: red", fontcolor: "red")
    graph.set_edge_options('EDGE_OPTS', 'fontname', label: "fontname: Courier", fontname: "Courier")
    graph.set_edge_options('EDGE_OPTS', 'fontsize', label: "fontsize: 34", fontsize: "34")
    graph.set_edge_options('headgroup', 'headclip', headclip: 'false', label: "headclip: false")
    graph.set_edge_options('headgroup', 'headhref', headlabel: 'headlabel', headtarget: '_blank', headhref:"https://www.example.org", label: "headhref:\nhttps://www.example.org")
    graph.set_edge_options('headgroup', 'headlabel', headlabel: "headlabel", label: "headlabel: headlabel", labeldistance: 2.2)
    graph.set_edge_options('headgroup', 'headport', headport: 'n', label: "headport: n")
    graph.set_edge_options('headgroup', 'headtarget', headlabel: 'headlabel', headtarget: '_blank', label: "headtarget: _blank")
    graph.set_edge_options('headgroup', 'headtooltip', headtooltip: 'HOOLTIP', label: "headtooltip: HOOLTIP", headlabel: 'headlabel')
    graph.set_edge_options('headgroup', 'headURL', headlabel: 'headlabel', headtarget: '_blank', headURL: "https://www.example.org", label: "headURL:\nhttps://www.example.org")
    graph.set_edge_options('EDGE_OPTS', 'href', href: "https://www.example.org", label: "href: https://www.example.org")
    graph.set_edge_options('EDGE_OPTS', 'id', label: "id\n(SVG ID)", id: "MyID")
    graph.set_edge_options('labelgroup', 'label', label: "label: My label")
    graph.set_edge_options('htlattribs', 'labelangle', headlabel: "headlabel", labelangle: -45, label: "labelangle: -45")
    graph.set_edge_options('htlattribs', 'labelangle', headlabel: "headlabel", labelangle: -45, label: "labelangle: -45")
    graph.set_edge_options('htlattribs', 'labeldistance', headlabel: "headlabel", labeldistance: 2.5, label: "labeldistance: 2.5")
    graph.set_edge_options('labelgroup', 'labelfloat', labelfloat: 'false', label: "labelfloat: false")
    graph.set_edge_options('htlattribs', 'labelfontcolor', labelfontcolor: 'aquamarine3', headlabel: 'headlabel', label: "labelfontcolor:\naquamarine3")
    graph.set_edge_options('htlattribs', 'labelfontname', labelfontname: 'Courier', headlabel: "headlabel", label: "labelfontname: Courier")
    graph.set_edge_options('htlattribs', 'labelfontsize', labelfontsize: 24, headlabel: "headlabel", label: "labelfontsize: 24")
    # graph.set_edge_options('labelgroup', 'labelhref', labelhref:, label: "labelhref:") # synonym for labelURL
    # graph.set_edge_options('labelgroup', 'labelURL', labelURL:, label: "labelURL:") # URL for label, overrides edge URL
    # graph.set_edge_options('labelgroup', 'labeltarget', labeltarget:, label: "labeltarget:") # if URL or labelURL is set, determines browser window for URL
    graph.set_edge_options('labelgroup', 'labeltooltip', labeltooltip: "FOO", label: "labeltooltip: FOO")
    graph.set_edge_options('EDGE_OPTS', 'layer', layer: "overlay range")
    # graph.set_edge_options('EDGE_OPTS', 'lhead', lhead:, label: "lhead:") # name of cluster to use as head of edge
    # graph.set_edge_options('EDGE_OPTS', 'ltail', ltail:, label: "ltail:") # name of cluster to use as tail of edge
    # graph.set_edge_options('EDGE_OPTS', 'minlen', minlen:, label: "minlen:") # default: 1 minimum rank distance between head and tail
    graph.set_edge_options('EDGE_OPTS', 'penwidth', penwidth: "4.0")
    # graph.set_edge_options('EDGE_OPTS', 'samehead', samehead:, label: "samehead:") # tag for head node; edge heads with the same tag are merged onto the same port
    # graph.set_edge_options('EDGE_OPTS', 'sametail', sametail:, label: "sametail:") # tag for tail node; edge tails with the same tag are merged onto the same port
    graph.set_edge_options('EDGE_OPTS', 'style', label: "style: dashed", style: "dashed")
    # graph.set_edge_options('EDGE_OPTS', 'weight', weight:, label: "weight:") # default: 1; integer cost of stretching an edge
    graph.set_edge_options('tailgroup', 'tailclip', tailclip: 'false', label: "tailclip: false")
    graph.set_edge_options('tailgroup', 'tailhref', taillabel: 'taillabel', tailhref: "https://www.example.org", label: "tailhref:\nhttps://www.example.org")
    graph.set_edge_options('tailgroup', 'taillabel', taillabel: 'taillabel', label: "taillabel: taillabel")
    graph.set_edge_options('tailgroup', 'tailport', tailport: 'sw', label: "tailport: sw")
    graph.set_edge_options('tailgroup', 'tailtarget', tailtarget: '_blank', label: "tailtarget: _blank")
    graph.set_edge_options('tailgroup', 'tailtooltip', tailtooltip: 'LOOLTIP', label: "tailtooltip: LOOLTIP", taillabel: 'taillabel')
    graph.set_edge_options('tailgroup', 'tailURL', taillabel: 'taillabel', tailURL: "https://www.example.org", label: "tailURL:\nhttps://www.example.org")
    graph.set_edge_options('href', 'target', label: "optional", tailURL: "https://www.example.org", target: "_blank")
    graph.set_edge_options('EDGE_OPTS', 'tooltip', label: "tooltip: FOO", tooltip: "FOO")

    graph_options = { 'rankdir' => 'LR' , 'overlap' => 'scale'}
    dot = graph.to_dot_graph(graph_options).to_s

    assert_match(dot, /arrowhead \[\n\s*arrowhead = empty,\n\s*fontsize = 8,\n\s*label = "arrowhead: empty"*/)
    assert_match(dot, /arrowsize \[\n\s*arrowsize = 3,\n\s*fontsize = 8,\n\s*label = "arrowsize: 3"*/)
    assert_match(dot, /arrowtail \[\n\s*arrowtail = odot,\n\s*dir = back,\n\s*fontsize = 8,\n\s*label = "arrowtail: odot",\n\s*tailport = w*/)
    assert_match(dot, /color \[\n\s*color = magenta,\n\s*fontsize = 8,\n\s*label = "color: magenta"*/)
    assert_match(dot, /colorscheme \[\n\s*color = 6,\n\s*colorscheme = accent8,\n\s*fontsize = 8,\n\s*label = "colorscheme:\naccent8\/6"*/)
    assert_match(dot, /constraint \[\n\s*constraint = false,\n\s*fontsize = 8,\n\s*label = "constraint: false"*/)
    assert_match(dot, /comment \[\n\s*comment = "My Comment",\n\s*fontsize = 8,\n\s*label = "comment\n\(SVG source\)"*/)
    assert_match(dot, /decorate \[\n\s*decorate = true,\n\s*fontsize = 8,\n\s*label = "decorate: true"*/)
    assert_match(dot, /dir \[\n\s*dir = both,\n\s*fontsize = 8,\n\s*label = "dir: both"*/)
    assert_match(dot, /edgetooltip \[\n\s*edgetooltip = FOOLTIP,\n\s*fontsize = 8,\n\s*label = "edgetooltip: FOOLTIP/)
    assert_match(dot, /fontcolor \[\n\s*fontcolor = red,\n\s*fontsize = 8,\n\s*label = "fontcolor: red"*/)
    assert_match(dot, /fontname \[\n\s*fontname = Courier,\n\s*fontsize = 8,\n\s*label = "fontname: Courier"*/)
    assert_match(dot, /fontsize \[\n\s*fontsize = 34,\n\s*label = "fontsize: 34"*/)
    assert_match(dot, /headgroup -> headclip \[\n\s*fontsize = 8,\n\s*headclip = false,\n\s*label = "headclip: false"*/)
    assert_match(dot, /headgroup -> headport \[\n\s*fontsize = 8,\n\s*headport = n,\n\s*label = "headport: n"*/)
    assert_match(dot, /headgroup -> headlabel \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*label = "headlabel: headlabel",\n\s*labeldistance = 2.2*/)
    assert_match(dot, /headgroup -> headtooltip \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*headtooltip = HOOLTIP,\n\s*label = "headtooltip: HOOLTIP"*/)
    assert_match(dot, /id \[\n\s*fontsize = 8,\n\s*id = MyID,\n\s*label = "id\n\(SVG ID\)"*/)
    assert_match(dot, /labelgroup -> label \[\n\s*fontsize = 8,\n\s*label = "label: My label"*/)
    assert_match(dot, /labelgroup -> labelfloat \[\n\s*fontsize = 8,\n\s*label = "labelfloat: false",\n\s*labelfloat = false*/)
    assert_match(dot, /htlattribs -> labelangle \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*label = "labelangle: -45",\n\s*labelangle = -45*/)
    assert_match(dot, /htlattribs -> labelfontcolor \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*label = "labelfontcolor:\naquamarine3",\n\s*labelfontcolor = aquamarine3*/)
    assert_match(dot, /htlattribs -> labelfontname \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*label = "labelfontname: Courier",\n\s*labelfontname = Courier*/)
    assert_match(dot, /htlattribs -> labelfontsize \[\n\s*fontsize = 8,\n\s*headlabel = headlabel,\n\s*label = "labelfontsize: 24",\n\s*labelfontsize = 24*/)
    assert_match(dot, /layer \[\n\s*fontsize = 8,\n\s*layer = "overlay range"*/)
    assert_match(dot, /penwidth \[\n\s*fontsize = 8,\n\s*penwidth = 4.0*/)
    assert_match(dot, /style \[\n\s*fontsize = 8,\n\s*label = "style: dashed",\n\s*style = dashed*/)
    assert_match(dot, /tailgroup -> tailclip \[\n\s*fontsize = 8,\n\s*label = "tailclip: false",\n\s*tailclip = false*/)
    assert_match(dot, /tailgroup -> taillabel \[\n\s*fontsize = 8,\n\s*label = "taillabel: taillabel",\n\s*taillabel = taillabel*/)
    assert_match(dot, /tailgroup -> tailtooltip \[\n\s*fontsize = 8,\n\s*label = "tailtooltip: LOOLTIP",\n\s*taillabel = taillabel,\n\s*tailtooltip = LOOLTIP*/)
    assert_match(dot, /tailgroup -> tailport \[\n\s*fontsize = 8,\n\s*label = "tailport: sw",\n\s*tailport = sw*/)
    assert_match(dot, /href -> target \[\n\s*fontsize = 8,\n\s*label = optional,\n\s*tailURL = "https:\/\/www.example.org",\n\s*target = _blank*/)
    assert_match(dot, /tooltip \[\n\s*fontsize = 8,\n\s*label = "tooltip: FOO",\n\s*tooltip = FOO*/)

    graph.vertices.each do |v|
      next if v == 'headgroup' || v == 'tailgroup' || v == 'labelgroup'

      v == 'EDGE_OPTS' ? graph.set_vertex_options(v, label: "Edge\nOptions", URL: 'https://graphviz.org/docs/edges/', target: '_blank') : graph.set_vertex_options(v, URL: "https://graphviz.org/docs/attrs/#{v}/", target: '_blank')
    end
    graph.write_to_graphic_file('svg', 'edge-opts-graph', graph_options)
  end
end