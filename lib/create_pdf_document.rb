require_relative './x_labels_data_collector'
class CreatePdfDocument
  attr_reader :pdf, :scale, :input_data, :graph_width_pdf, :graph_height_pdf, :dot_radius, :y_labels
  def initialize(pdf, scale, input_data, graph_width_pdf, graph_height_pdf, dot_radius, y_labels, x_label_options)
    @pdf = pdf
    @scale = scale
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @dot_radius = dot_radius
    @y_labels = y_labels
    @x_label_options = x_label_options
  end

  def run
    pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
    DrawChart.new(pdf_data, dot_radius).draw_line_and_dots(pdf)
    x_label_vertical_offset = @x_label_options[:vertical_offset]
    x_label_width = @x_label_options[:label_width]
    x_label_data = XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_vertical_offset, x_label_width).collect
    DrawLabels.new(x_label_data, x_label_width).draw_x_labels(pdf)
  end
end
