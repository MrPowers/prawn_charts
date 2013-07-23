require_relative "prawn_charts"

scale = :linear
input_data = [["Jan 11", 5], ["Feb 11", 77], ["Mar 11", nil], ["Apr 11", nil], ["May 11", nil], ["Jun 11", 1], ["Jul 11", 20]]
graph_height = 200
graph_width = 300
bounding_x = 100
bounding_y = 600

#p = PrawnCharts::Main.new(scale, input_data, graph_height, graph_width, bounding_x, bounding_y)
#p.draw_graph

chart = PrawnCharts::PdfData.new(scale, input_data, graph_height, graph_width)
p chart.y_pdf_data.y_increment

