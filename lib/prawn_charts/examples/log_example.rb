require_relative "./../../prawn_charts"

pdf = Prawn::Document.new

data = [
  {x_label: "Apr-11", y: 100},
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

#data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
#input = {
  #:graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
  #:dots => { :radius => 4 },
  #:horizontal_lines => true,
  #:graph_title => { :title => "cool graph", :offset => 50, :text_box_options => {} },
  #:x_title => { :title => "x title", :offset => -60, :text_box_options => {} },
  #:y_title => { :title => "y title", :offset => -50, :text_box_options => {} },
  #:x_labels => { :offset => -50, :text_box_options => { :width => 100, :height => 20, align: :center, rotate: 45 } },
  #:y_labels => { :offset => -40, :text_box_options => { :height => 40, valign: :center } }
#}

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
  :graph => {:starting_point => [100, 400], :width => 300, :height => 200, :data => data, :y_labels => [1, 10, 100, 1_000, 10_000, 100_000, 1_000_000], :scale => :log},
  :dots => {},
  :y_labels => {:offset => -80, :text_box_options => {:width => 50}},
  :x_labels => {},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph" },
  :x_title => { :title => "x title" },
  :y_title => { :title => "y title", :offset => -90 },
}

pdf.draw_graph(input, colors)

pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
