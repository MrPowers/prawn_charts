class ChartRenderer
  attr_reader :pdf_data
  def initialize(pdf_data)
    @pdf_data = pdf_data
  end

  def draw(pdf)
    pdf_data.each_index do |i|
      pdf.stroke_line(pdf_data[i], pdf_data[i + 1]) unless pdf_data[i + 1].nil?
    end
  end
end
