require 'prawn/layout'
require 'prawn/format'

bill_address = @order.bill_address
ship_address = @order.ship_address

font "Helvetica"

image Spree::PrintInvoice::Config[:print_invoice_logo_path], :at => [0,720], :scale => 0.65

fill_color "005D99"
text "Customer Invoice", :at => [200,698], :style => :bold, :size => 22
fill_color "000000"

move_down 55

font "Helvetica", :style => :bold, :size => 14
text "Order Number: #{@order.number}"

font "Helvetica", :size => 8
text @order.created_at.to_s(:long)

# Address Stuff
bounding_box [0,600], :width => 540 do
  move_down 2
  data = [[Prawn::Table::Cell.new( :text => "Billing Address", :font_style => :bold ),
                Prawn::Table::Cell.new( :text =>"Shipping Address", :font_style => :bold )]]

  table data,
    :position           => :center,
    :border_width => 0.5,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :border_style => :underline_header,
    :column_widths => { 0 => 270, 1 => 270 }

  move_down 2
  horizontal_rule

  bounding_box [0,0], :width => 540 do
    move_down 2
    data2 = [["#{bill_address.firstname} #{bill_address.lastname}", "#{ship_address.firstname} #{ship_address.lastname}"],
            [bill_address.address1, ship_address.address1]]
    data2 << [bill_address.address2, ship_address.address2] unless bill_address.address2.blank? and ship_address.address2.blank?
    data2 << ["#{@order.bill_address.city}, #{(@order.bill_address.state ? @order.bill_address.state.abbr : "")} #{@order.bill_address.zipcode}",
              "#{@order.ship_address.city}, #{(@order.ship_address.state ? @order.ship_address.state.abbr : "")} #{@order.ship_address.zipcode}"]
    data2 << [bill_address.country.name, ship_address.country.name]
    data2 << [bill_address.phone, ship_address.phone]

    table data2,
      :position           => :center,
      :border_width => 0.0,
      :vertical_padding   => 0,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 270, 1 => 270 }
  end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

move_down 30

# Line Items
bounding_box [0,cursor], :width => 540, :height => 450 do
  move_down 2
  data =  [[Prawn::Table::Cell.new( :text => "SKU", :font_style => :bold),
                Prawn::Table::Cell.new( :text =>"Item Description", :font_style => :bold ),
               Prawn::Table::Cell.new( :text =>"Price", :font_style => :bold ),
               Prawn::Table::Cell.new( :text =>"Qty", :font_style => :bold, :align => 1 ),
               Prawn::Table::Cell.new( :text =>"Total", :font_style => :bold )]]

  table data,
    :position           => :center,
    :border_width => 0,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :column_widths => { 0 => 75, 1 => 290, 2 => 75, 3 => 50, 4 => 50 } ,
    :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }

  move_down 4
  horizontal_rule
  move_down 2

  bounding_box [0,cursor], :width => 540 do
    move_down 2
    data2 = []
    @order.line_items.each do |item|
      data2 << [item.variant.product.sku,
                item.variant.product.name,
                number_to_currency(item.price),
                item.quantity,
                number_to_currency(item.price * item.quantity)]
    end


    table data2,
      :position           => :center,
      :border_width => 0,
      :vertical_padding   => 5,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 75, 1 => 290, 2 => 75, 3 => 50, 4 => 50 },
      :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }
  end

  font "Helvetica", :size => 9

  totals = []

  totals << [Prawn::Table::Cell.new( :text => "Subtotal:", :font_style => :bold), number_to_currency(@order.item_total)]

  @order.charges.each do |charge|
    totals << [Prawn::Table::Cell.new( :text => charge.description + ":", :font_style => :bold), number_to_currency(charge.amount)]
  end
  @order.credits.each do |credit|
    totals << [Prawn::Table::Cell.new( :text => credit.description + ":", :font_style => :bold), number_to_currency(credit.amount)]
  end

  totals << [Prawn::Table::Cell.new( :text => "Order Total:", :font_style => :bold), number_to_currency(@order.total)]

  bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 15)], :width => 500 do
    table totals,
      :position => :right,
      :border_width => 0,
      :vertical_padding   => 2,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 425, 1 => 75 } ,
      :align => { 0 => :right, 1 => :right }

  end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

footer [margin_box.left, margin_box.bottom + 30] do
  font "Helvetica", :size => 8

  text "Shipping is not refundable. | Special orders are non-refundable."
  text "In order to return a product prior authorization with a RMA number is mandatory"
  text "All returned items must be in original un-opened packaging with seal intact."
end
