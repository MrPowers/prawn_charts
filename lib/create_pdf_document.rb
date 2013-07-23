class CreatePdfDocument
  attr_reader :pdf, :input_data, :graph_width_pdf, :graph_height_pdf, :dot_radius
  def initialize(pdf, input_data, graph_width_pdf, graph_height_pdf, dot_radius)
    @pdf = pdf
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @dot_radius = dot_radius
  end

  def run
    pdf_data = PdfDataCollector.new(input_data, graph_width_pdf, graph_height_pdf).collect
    DrawChart.new(pdf_data, dot_radius).draw_line_and_dots(pdf)
  end
end
