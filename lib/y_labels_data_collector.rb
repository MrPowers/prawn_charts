class YLabelsDataCollector
  attr_reader :y_labels, :graph_height_pdf, :horizontal_offset, :label_height
  def initialize(y_labels, graph_height_pdf, horizontal_offset, label_height)
    @y_labels = y_labels
    @graph_height_pdf = graph_height_pdf
    @horizontal_offset = horizontal_offset
    @label_height = label_height
  end

  def vertical_offset
    label_height / 2
  end

  def y_label_increment
    graph_height_pdf.to_f / (y_labels.count - 1)
  end

  def collect
    y_labels.map.with_index do |y_label, index|
      y_label = y_label.to_s
      x_pdf = -horizontal_offset
      y_pdf = index * y_label_increment + vertical_offset
      [y_label, [x_pdf, y_pdf]]
    end
  end
end
