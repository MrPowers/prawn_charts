require "spec_helper"

module PrawnCharts
  describe LogVerticalDataCollector do
    context "#convert_to_pdf" do
      it "converts a y_units data point to a y_pdf_points data point" do
        collector = LogVerticalDataCollector.new(400, [0, 10, 100, 1_000])
        expect(collector.convert_to_pdf(17)).to be_within(0.1).of 164.0
      end
    end
  end
end
