PrawnCharts generates line graphs in Prawn.  There are no other
dependencies other than Prawn, so this library is perfect for generating
vector images with small file sizes.

Todo:
Allow horizontal lines to be drawn at the y label points
 - Call the log_y_pdf_data_collector or linear_y_pdf_data_collector
 - Draw line from [0, y] to [graph_width, y]


2. Make functions extend from Prawn, so you can write pdf.draw_chart,
etc.
3. Review has everything is connected and see if any code can be reused
or simplified.
4. What inputs are mandatory and what are optional?
