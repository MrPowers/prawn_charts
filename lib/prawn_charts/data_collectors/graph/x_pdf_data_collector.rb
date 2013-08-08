module PrawnCharts
  class XPdfDataCollector
    def initialize(input_data, graph_width_pdf)
      @input_data = input_data
      @graph_width_pdf = graph_width_pdf
    end

    def pdf_points_per_unit
      @graph_width_pdf.to_f / (@input_data.length - 1)
    end

    def collect
      0.step(@graph_width_pdf, pdf_points_per_unit).to_a
    end
  end
end
