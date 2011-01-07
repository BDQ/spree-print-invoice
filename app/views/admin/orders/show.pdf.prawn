require 'prawn/layout'

font "Helvetica"
im = Spree::Config[:print_invoice_logo_path]
im = "#{RAILS_ROOT}/public/images/admin/bg/spree_50.png" unless im

image im , :at => [0,720], :scale => 0.35

render :partial => "invoice"

move_down 4

font "Helvetica",  :size => 9,  :style => :bold
text "#{I18n.t(:order_number)} #{@order.number}", :align => :right

move_down 2
font "Helvetica", :size => 9
text "#{I18n.l @order.created_at.to_date}", :align => :right

render :partial => "address"

move_down 30

render :partial => "line_items_box"

move_down 5
# Footer
repeat :all do
  footer_message = I18n.t :footer_message
#  text_box footer_message, :at => [margin_box.left -10, margin_box.bottom + 40], :size => 8 , :position => :left
  table [[Prawn::Table::Cell.new( :text => I18n.t(:footer_left), :font_style => :bold ),
                Prawn::Table::Cell.new( :text =>I18n.t(:footer_left2)),
                Prawn::Table::Cell.new( :text =>I18n.t(:footer_right), :font_style => :bold ),
                Prawn::Table::Cell.new( :text =>I18n.t(:footer_right2))]],
    :border_width => 0,
    :vertical_padding   => 2,
    :font_size => 9,
    :column_widths => { 0 => 80, 1 => 190, 2 => 75, 3 => 190 }
end
