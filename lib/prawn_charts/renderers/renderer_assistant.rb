class RendererAssistant
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def collector
    @collector ||= SingleFileDataCollector.new(input.fetch(:graph))
  end

  # graph_title
  def graph_title_translate
    [0, collector.height + offset(:graph_title, default_graph_title_offset)]
  end

  def graph_title
    title = input[:graph_title][:title]
    raise "Graph must have title" unless title
    title
  end

  def graph_title_options
    default_graph_title_options.merge(input[:graph_title][:text_box_options]) || default_graph_title_options
  end

  # x_title
  def x_title_translate
    [0, offset(:x_title, default_x_title_offset)]
  end

  def x_title
    title = input[:x_title][:title]
    raise "Graph must have title" unless title
    title
  end

  def x_title_options
    default_x_title_options.merge(input[:x_title][:text_box_options]) || default_x_title_options
  end

  # y_title
  def y_title_translate
    [offset(:y_title, default_y_title_offset), 0]
  end

  def y_title
    title = input[:y_title][:title]
    raise "Graph must have title" unless title
    title
  end

  def y_title_options
    default_y_title_options.merge(input[:y_title][:text_box_options]) || default_y_title_options
  end

  private

  def offset(title_type, default_offset)
    return input[title_type][:offset] if input[title_type][:offset]
    default_offset
  end

  # graph title
  def default_graph_title_options
    {at: [0, -20], width: collector.width, height: 20, align: :center}
  end

  def default_graph_title_offset
    50
  end

  # x title
  def default_x_title_options
    {at: [0, 20], width: collector.width, height: 20, align: :center}
  end

  def default_x_title_offset
    -60
  end

  # y title
  def default_y_title_options
    {at: [0, 0], width: collector.height, height: 20, align: :center, valign: :center, rotate: 90}
  end

  def default_y_title_offset
    -50
  end

end
