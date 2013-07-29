require_relative "prawn_charts"

# linear example
#input_data = [["Jan 11", 5], ["Feb 11", 77], ["Mar 11", 99], ["Apr 11", 105], ["May 11", 32], ["Jun 11", 1], ["Jul 11", 20]]
#graph_height_pdf = 200
#graph_width_pdf = 300
#dot_radius = 4

#pdf = ::Prawn::Document.new
#pdf.bounding_box([0, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
  #pdf.stroke_bounds
  #CreatePdfDocument.new(pdf, input_data, graph_width_pdf, graph_height_pdf, dot_radius).run
#end
#pdf.render_file(Dir.home + "/desktop/linear_prawn_graph.pdf")



# log example
input_data = [["Feb 11", 900], ["Mar 11", 800_000], ["Apr 11", nil], ["May 11", 9_000_000], ["June 11", 40]]
scale = :log
graph_height_pdf = 400
graph_width_pdf = 400
dot_radius = 4
x_label_vertical_offset = 25
x_label_width = 40
x_label_height = 30
x_label_text_box_options = { width: 50, height: x_label_height, overflow: :shrink_to_fit, align: :center }

y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
y_label_height = 30
y_label_text_box_options = { width: 70, height: y_label_height, align: :right, valign: :center }
y_label_horizontal_offset = 90


pdf = Prawn::Document.new
pdf.bounding_box([50, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
  pdf.stroke_bounds

  pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
  ChartRenderer.new(pdf_data).draw(pdf)
  DotRenderer.new(pdf_data, dot_radius).draw(pdf)

  x_label_data = XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_vertical_offset, x_label_width).collect
  LabelRenderer.new(x_label_data, x_label_text_box_options).draw(pdf)

  y_label_data = YLabelsDataCollector.new(y_labels, graph_height_pdf, y_label_horizontal_offset, y_label_height).collect
  LabelRenderer.new(y_label_data, y_label_text_box_options).draw(pdf)

  horizontal_lines_data = HorizontalLinesDataCollector.new(graph_height_pdf, y_labels).collect
  HorizontalLinesRenderer.new(horizontal_lines_data).draw(pdf)
end
pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
