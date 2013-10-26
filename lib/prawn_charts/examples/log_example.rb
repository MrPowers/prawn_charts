require_relative "./../../prawn_charts"

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer
pdf = Prawn::Document.new

data = [
  {x_label: "Apr-11", y: 1_000},
  {x_label: "May-11", y: nil},
  {x_label: "Jun-11", y: nil},
  {x_label: "Jul-11", y: nil},
  {x_label: "Aug-11", y: 300_000},
  {x_label: "Sep-11", y: nil},
  {x_label: "Oct-11", y: nil},
  {x_label: "Dec-11", y: 17},
  {x_label: "Jan-12", y: nil},
  {x_label: "Feb-12", y: nil},
  {x_label: "Mar-12", y: 10},
  {x_label: "Apr-12", y: nil},
  {x_label: "May-12", y: nil},
  {x_label: "Jun-12", y: 1_000_000}
]

orange = "D95D2E"
green = "62C545"
white = "FFFFFF"

colors = {
  :rectangle_fill => white,
  :line => green,
  :dots => orange
}

input = {
  :graph => {
    :starting_point => [100, 400],
    :width => 300,
    :height => 200,
    :data => data,
    :y_labels => ["1", "10", "100", "1,000", "10,000", "100,000", "1,000,000"],
    :scale => :log
  },
  :dots => {},
  :y_labels => {
    :offset => -62,
    :text_box_options => {:width => 55, :align => :right}
  },
  :x_labels => {},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph" },
  :x_title => { :title => "x title" },
  :y_title => { :title => "y title", :offset => -60 },
}

pdf.draw_graph(input, colors)

pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
