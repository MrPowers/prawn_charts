class LogPdfDataCollector
  attr_reader :input_data, :graph_width_pdf, :graph_height_pdf
  def initialize(input_data, graph_width_pdf, graph_height_pdf, y_labels)
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def x_pdf_data
    XPdfDataCollector.new(@input_data, @graph_width_pdf).collect
  end

  def y_pdf_data
    LogYPdfDataCollector.new(@input_data, @graph_height_pdf, @y_labels).collect
  end

  def collect
    x_pdf_data.zip(y_pdf_data)
  end
end
