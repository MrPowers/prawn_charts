class PdfDataCollector
  attr_reader :scale, :input_data, :graph_width_pdf, :graph_height_pdf, :y_labels
  def initialize(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels)
    @scale = scale
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def x_pdf_data
    XPdfDataCollector.new(input_data, graph_width_pdf).collect
  end

  def y_pdf_data
    if scale == :linear
      LinearYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    else
      LogYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    end
  end

  def collect
    x_pdf_data.zip(y_pdf_data)
  end
end
