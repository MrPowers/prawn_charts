require "spec_helper"

module PrawnCharts
  describe LinearVerticalDataCollector do
    context "#convert_to_pdf" do
      it "converts a y_unit point to a y_pdf point" do
        collector = LinearVerticalDataCollector.new(200, [0, 10, 20, 30, 40, 50])
        expect(collector.convert_to_pdf(15)).to eq 60
      end

      it "accounts for linear scales that don't start at 0" do
        collector = LinearVerticalDataCollector.new(200, [30, 40, 50])
        expect(collector.convert_to_pdf(15)).to eq 150
      end
    end
  end
end
