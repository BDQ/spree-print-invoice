# Line Items
bounding_box [0,cursor], :width => 540, :height => 430 do
  move_down 2
  data =  [[Prawn::Table::Cell.new( :text => I18n.t(:sku), :font_style => :bold),
                Prawn::Table::Cell.new( :text =>I18n.t(:item_description), :font_style => :bold ),
               Prawn::Table::Cell.new( :text =>I18n.t(:price), :font_style => :bold ),
               Prawn::Table::Cell.new( :text =>I18n.t(:qty), :font_style => :bold, :align => 1 ),
               Prawn::Table::Cell.new( :text =>I18n.t(:total), :font_style => :bold )]]

  table data,
    :position           => :center,
    :border_width => 0,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :column_widths => { 0 => 75, 1 => 265, 2 => 75, 3 => 50, 4 => 75 } ,
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
      :column_widths => { 0 => 75, 1 => 265, 2 => 75, 3 => 50, 4 => 75 } ,
      :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }
  end

  font "Helvetica", :size => 9

  render :partial => "totals"
  
  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end
