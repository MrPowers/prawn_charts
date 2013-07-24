class CreateLogPdfDocument
  attr_reader :pdf, :input_data, :graph_width_pdf, :graph_height_pdf, :dot_radius, :y_labels
  def initialize(pdf, input_data, graph_width_pdf, graph_height_pdf, dot_radius, y_labels)
    @pdf = pdf
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @dot_radius = dot_radius
    @y_labels = y_labels
  end

  def run
    pdf_data = LogPdfDataCollector.new(input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
    DrawChart.new(pdf_data, dot_radius).draw_line_and_dots(pdf)
  end
end
