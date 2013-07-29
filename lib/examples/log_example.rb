require_relative "./../prawn_charts"

# log example
input_data = [["Apr-11", 5_000_000],
              ["May-11", nil],
              ["Jun-11", nil],
              ["Jul-11", nil],
              ["Aug-11", 1_000_000],
              ["Sep-11", nil],
              ["Oct-11", nil],
              ["Dec-11", 10_000],
              ["Jan-12", nil],
              ["Feb-12", nil],
              ["Mar-12", 150_000],
              ["Apr-12", nil],
              ["May-12", nil],
              ["Jun-12", 7_500_000]]
scale = :log
graph_height_pdf = 200
graph_width_pdf = graph_height_pdf * 1.7
dot_radius = 4

bounding_top_left = [50, 700]
bounding_width = 500
bounding_height = 300

x_label_vertical_offset = 35
x_label_width = 50
x_label_height = 30
x_label_text_box_options = { overflow: :shrink_to_fit, align: :center, rotate: 45 }

y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
y_label_height = 30
y_label_width = 70
y_label_text_box_options = { align: :right, valign: :center }
y_label_horizontal_offset = 80

orange = "D95D2E"
green = "62C545"
light_blue = "EDF1F7"
white = "FFFFFF"

Prawn::Document.extensions << PrawnChartRenderer

pdf = Prawn::Document.new
pdf.bounding_box(bounding_top_left, :width => bounding_width, :height => bounding_height) do
  pdf.stroke_bounds
  pdf.fill_color = light_blue
  pdf.fill_rectangle([0, pdf.cursor], bounding_width, bounding_height)

  pdf.bounding_box([100, pdf.cursor - 50], :width => graph_width_pdf, :height => graph_height_pdf) do
    pdf.stroke_bounds
    pdf.fill_color = white
    pdf.fill_rectangle([0, pdf.cursor], graph_width_pdf, graph_height_pdf)

    pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
    pdf.draw_chart(pdf_data, green)
    pdf.draw_dots(pdf_data, dot_radius, orange)

    x_label_data = XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_vertical_offset, x_label_width).collect
    pdf.draw_labels(x_label_data, x_label_width, x_label_height, x_label_text_box_options)

    y_label_data = YLabelsDataCollector.new(y_labels, graph_height_pdf, y_label_horizontal_offset, y_label_height).collect
    pdf.draw_labels(y_label_data, y_label_width, y_label_height, y_label_text_box_options)

    horizontal_lines_data = HorizontalLinesDataCollector.new(graph_height_pdf, graph_width_pdf, y_labels).collect
    pdf.draw_horizontal_lines(horizontal_lines_data)
  end
end
pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
