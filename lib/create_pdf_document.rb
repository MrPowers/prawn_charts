class CreatePdfDocument
  attr_reader :pdf, :scale, :input_data, :graph_width_pdf, :graph_height_pdf, :dot_radius, :y_labels
  def initialize(pdf, scale, input_data, graph_width_pdf, graph_height_pdf, dot_radius, y_labels)
    @pdf = pdf
    @scale = scale
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @dot_radius = dot_radius
    @y_labels = y_labels
  end

  def run
    pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
    DrawChart.new(pdf_data, dot_radius).draw_line_and_dots(pdf)
  end
end
