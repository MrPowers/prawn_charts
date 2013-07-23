require_relative "prawn_charts"

input_data = [["Jan 11", 5], ["Feb 11", 77], ["Mar 11", 99], ["Apr 11", 105], ["May 11", 32], ["Jun 11", 1], ["Jul 11", 20]]
graph_height_pdf = 200
graph_width_pdf = 300
dot_radius = 4

pdf = ::Prawn::Document.new
pdf.bounding_box([0, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
  pdf.stroke_bounds
  CreatePdfDocument.new(pdf, input_data, graph_width_pdf, graph_height_pdf, dot_radius).run
end
pdf.render_file(Dir.home + "/desktop/prawn_graph.pdf")

