require 'prawn/layout'

font "Helvetica"
im = Spree::Config[:print_invoice_logo_path]
im = "#{RAILS_ROOT}/public/images/admin/bg/spree_50.png" unless im

image im , :at => [0,720], :scale => 0.65

render :partial => "invoice"

move_down 55

font "Helvetica", :style => :bold, :size => 14
text "#{I18n.t(:order_number)} #{@order.number}"

font "Helvetica", :size => 8
text I18n.l @order.created_at

render :partial => "address"

move_down 30

render :partial => "line_items_box"
# Footer
repeat :all do
  footer_message = I18n.t :footer_message
  text_box footer_message, :at => [margin_box.left, margin_box.bottom + 30], :size => 8
end
