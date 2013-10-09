require_relative "./../../prawn_charts"

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer

pdf = Prawn::Document.new

data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
input = {
  :graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph", :offset => 50, :text_box_options => {} },
  :x_title => { :title => "x title", :offset => -60, :text_box_options => {} },
  :y_title => { :title => "y title", :offset => -50, :text_box_options => {} },
  :x_labels => { :offset => -70, :text_box_options => { :width => 100, align: :center, rotate: 45 } },
  :y_labels => { :offset => -40, :text_box_options => { :height => 40, valign: :center } }
}

pdf.draw_graph(input)

pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
