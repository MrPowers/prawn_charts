class SingleFileDataCollector
  attr_reader :height, :width, :data
  # data is in this format = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}]
  def initialize(height, width, data)
    @height = height
    @width = width
    @data = data
  end

  def x_units
    data.length - 1
  end

  def pdf_points_per_x_unit
    width / x_units.to_f
  end

  def y_units
    data.map {|h| h[:y]}.max
  end

  def pdf_points_per_y_unit
    height / y_units.to_f
  end

  def x_pdf_data_points
    result = [0]
    (data.length - 1).times do
      result << (result[-1] + pdf_points_per_x_unit)
    end
    result
  end

  def y_pdf_data_points
    data.map {|h| h[:y] * pdf_points_per_y_unit}
  end

  def graph_data_points
    x_pdf_data_points.zip(y_pdf_data_points)
  end
end
