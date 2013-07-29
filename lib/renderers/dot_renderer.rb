class DotRenderer
  attr_reader :pdf_data, :dot_radius
  def initialize(pdf_data, dot_radius)
    @pdf_data = pdf_data
    @dot_radius = dot_radius
  end

  def draw(pdf)
    pdf_data.each do |point|
      pdf.fill_circle(point, dot_radius)
    end
  end
end
