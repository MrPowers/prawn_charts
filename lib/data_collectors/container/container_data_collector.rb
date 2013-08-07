class ContainerDataCollector
  attr_reader :inputs
  def initialize(inputs)
    @inputs = inputs
  end

  def height
    bottom_gap +
    inputs[:graph_height] +
    top_gap
  end

  def width
    left_gap + right_gap + inputs[:graph_width]
  end

  def graph_top_left
    [left_gap, (height - top_gap)]
  end

  def graph_title_top_left
    [left_gap, (bottom_gap + inputs[:graph_height] + inputs[:graph_title_height])]
  end

  def y_title_top_left
    [inputs[:container_left_padding], (bottom_gap + inputs[:graph_height])]
  end

  def x_title_top_left
    [left_gap, (inputs[:container_bottom_padding] + inputs[:x_title_height])]
  end

  private

  # gap is area between container edge and graph
  def left_gap
    inputs[:container_left_padding] +
    inputs[:y_label_width] +
    inputs[:y_label_offset] +
    inputs[:y_title_width]
  end

  def right_gap
    inputs[:container_right_padding]
  end

  def top_gap
    inputs[:container_top_padding] +
    inputs[:graph_title_height]
  end

  def bottom_gap
    inputs[:container_bottom_padding] +
    inputs[:x_label_height] +
    inputs[:x_title_height]
  end
end
