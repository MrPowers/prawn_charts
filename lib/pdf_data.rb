module PrawnCharts
  class PdfData
    attr_reader :scale, :input_data, :graph_height, :graph_width
    def initialize(scale, input_data, graph_height, graph_width)
      @input_data = input_data
      @graph_height = graph_height
      @graph_width = graph_width
    end

    def x_pdf_data
      XPdfData.new(input_data, graph_width)
    end

    def y_pdf_data
      LinearYPdfData.new(input_data, graph_height)
    end

    def collect
      result = []
      input_data.each_with_index do |(x, y), index|
        unless y.nil?
          result << [(index * x_pdf_data.x_increment), (y * y_pdf_data.y_increment)]
        end
      end
      result
    end
  end
end
