require_relative "./../prawn_charts"

##################################
#Graph Data Collectors
##################################
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

x_label_width = 50
x_label_height = 35
x_label_text_box_options = { overflow: :shrink_to_fit, align: :center, rotate: 45 }

y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
y_label_height = 30
y_label_width = 65
y_label_offset = 10
y_label_text_box_options = { align: :right, valign: :center }

graph_title_text = "Cool Prawn Graph"
graph_title_height = 40

y_title_width = 30
y_title_text = "HCV Viral Load"

x_title_height = 40
x_title_text = "Month"

pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
x_label_data = XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_height, x_label_width).collect
y_label_data = YLabelsDataCollector.new(y_labels, graph_height_pdf, y_label_width, y_label_height, y_label_offset).collect
horizontal_lines_data = HorizontalLinesDataCollector.new(graph_height_pdf, graph_width_pdf, y_labels).collect

##################################
#Container Data Collectors
##################################

container_inputs = {
  container_left_padding: 0,
  y_label_offset: y_label_offset,
  y_label_width: y_label_width,
  y_title_width: y_title_width,
  container_right_padding: 20,
  container_top_padding: 20,
  graph_title_height: graph_title_height,
  container_bottom_padding: 0,
  x_label_height: x_label_height,
  x_title_height: x_title_height,
  graph_height: graph_height_pdf,
  graph_width: graph_width_pdf
}

container_data_collector = ContainerDataCollector.new(container_inputs)

graph_title_position = container_data_collector.graph_title_top_left
graph_title_options = { align: :center, valign: :center}
graph_title_data = GraphTitleDataCollector.new(graph_title_text, graph_title_position, graph_title_height, graph_width_pdf).collect

y_title_position = container_data_collector.y_title_top_left
# specifying width is a temp hack solution because of a Prawn bug: https://github.com/prawnpdf/prawn/pull/505
y_title_options = { align: :center, valign: :center, rotate: 90, rotate_around: :center, width: 65 }
y_title_data = GraphTitleDataCollector.new(y_title_text, y_title_position, graph_height_pdf, y_title_width).collect

x_title_position = container_data_collector.x_title_top_left
x_title_options = { align: :center, valign: :center }
x_title_data = GraphTitleDataCollector.new(x_title_text, x_title_position, x_title_height, graph_width_pdf).collect

graph_top_left = container_data_collector.graph_top_left

##################################
#Colors
##################################

orange = "D95D2E"
green = "62C545"
light_blue = "EDF1F7"
white = "FFFFFF"
black = "000000"

##################################
#Create PDF
##################################

Prawn::Document.extensions << PrawnChartRenderer

pdf = Prawn::Document.new
pdf.bounding_box([0, pdf.cursor], :width => container_data_collector.width, :height => container_data_collector.height) do
  pdf.stroke_bounds
  pdf.fill_color = light_blue
  pdf.fill_rectangle([0, pdf.cursor], container_data_collector.width, container_data_collector.height)
  pdf.fill_color = black

  pdf.draw_title(graph_title_data, graph_title_options)
  pdf.draw_title(y_title_data, y_title_options)
  pdf.draw_title(x_title_data, x_title_options)

  pdf.bounding_box(container_data_collector.graph_top_left, :width => graph_width_pdf, :height => graph_height_pdf) do
    pdf.stroke_bounds
    pdf.fill_color = white
    pdf.fill_rectangle([0, pdf.cursor], graph_width_pdf, graph_height_pdf)

    pdf.stroke_color = green
    pdf.draw_chart(pdf_data)
    pdf.fill_color = orange
    pdf.draw_dots(pdf_data, dot_radius)

    pdf.fill_color = black
    pdf.draw_labels(x_label_data, x_label_width, x_label_height, x_label_text_box_options)

    pdf.draw_labels(y_label_data, y_label_width, y_label_height, y_label_text_box_options)

    pdf.stroke_color = black
    pdf.draw_horizontal_lines(horizontal_lines_data)
  end
end
pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
