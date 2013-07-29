class YPdfDataCollector
  attr_reader :scale, :input_data, :graph_height_pdf, :y_labels
  def initialize(scale, input_data, graph_height_pdf, y_labels)
    @scale = scale
    @input_data = input_data
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def collect
    if scale == :linear
      LinearYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    elsif scale == :log
      LogYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    else
      raise("Scale must be :linear or :log")
    end
  end
end
