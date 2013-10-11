require_relative "./../../prawn_charts"

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer

pdf = Prawn::Document.new

data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
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

red = "FF0000"
orange = "CC4A14"
light_green = "E7FFD4"
bright_green = "40FF40"
light_brown = "99583D"
black = "000000"

colors = {
  :rectangle_border => red,
  :rectangle_fill => light_green,
  :line => orange,
  :dots => black,
  :x_labels => red
}

input = {
  :graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
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
