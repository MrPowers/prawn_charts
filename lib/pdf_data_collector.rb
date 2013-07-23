class PdfDataCollector
  attr_reader :input_data, :graph_width_pdf, :graph_height_pdf
  def initialize(input_data, graph_width_pdf, graph_height_pdf)
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
  end

  def x_pdf_data
    XPdfDataCollector.new(@input_data, @graph_width_pdf).collect
  end

  def y_pdf_data
    LinearYPdfDataCollector.new(@input_data, @graph_height_pdf).collect
  end

  def collect
    x_pdf_data.zip(y_pdf_data)
  end
end
