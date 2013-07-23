class XPdfDataCollector
  def initialize(input_data, graph_width_pdf)
    @input_data = input_data
    @graph_width_pdf = graph_width_pdf
  end

  def x_label_increment_pdf
    @graph_width_pdf.to_f / (@input_data.length - 1)
  end

  def collect
    0.step(@graph_width_pdf, x_label_increment_pdf).to_a
  end
end
