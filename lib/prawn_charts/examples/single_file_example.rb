require_relative "./../../prawn_charts"

Prawn::Document.extensions << PrawnCharts::PrawnChartRenderer

pdf = Prawn::Document.new

data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
input = {
  :graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
  :horizontal_lines => true,
  :graph_title => { :title => "cool graph", :vertical_offset => 50, :text_box_options => {}},
  :x_title => { :title => "x title", :vertical_offset => -60, :text_box_options => {}},
  :y_title => { :title => "y title", :horizontal_offset => -50, :text_box_options => {}}
}


#y_labels = [0, 5, 10, 15, 20]
#data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
pdf.draw_graph([100, 200], 300, 200, data, y_labels)

pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
