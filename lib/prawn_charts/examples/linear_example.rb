require_relative "./../../prawn_charts"

pdf = Prawn::Document.new

data = [
  {x_label: "Apr-11", y: 10},
  {x_label: "May-11", y: nil},
  {x_label: "Jun-11", y: nil},
  {x_label: "Jul-11", y: nil},
  {x_label: "Aug-11", y: 3},
  {x_label: "Sep-11", y: nil},
  {x_label: "Oct-11", y: nil},
  {x_label: "Dec-11", y: 17},
  {x_label: "Jan-12", y: nil},
  {x_label: "Feb-12", y: nil},
  {x_label: "Mar-12", y: 14},
  {x_label: "Apr-12", y: nil},
  {x_label: "May-12", y: nil},
  {x_label: "Jun-12", y: 16}
]

orange = "D95D2E"
green = "62C545"
light_blue = "EDF1F7"
white = "FFFFFF"
black = "000000"

colors = {
  :rectangle_border => black,
  :rectangle_fill => white,
  :line => green,
  :dots => orange,
  :x_labels => black,
  :y_labels => black,
  :horizontal_lines => black,
  :graph_title => black,
  :x_title => black,
  :y_title => black
}

input = {
  :graph => {:starting_point => [100, 400], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
  :dots => {},
  :y_labels => {},
  :x_labels => {},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph" },
  :x_title => { :title => "x title" },
  :y_title => { :title => "y title" },
}

pdf.draw_graph(input, colors)

pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
