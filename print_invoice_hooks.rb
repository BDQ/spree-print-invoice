class PrintInvoiceHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_order_show_buttons do
    %( <%= button_link_to("Print Invoice", formatted_admin_order_url(@order, :pdf)) %>)
  end

  insert_after :admin_order_edit_buttons do
    %( <%= button_link_to("Print Invoice", formatted_admin_order_url(@order, :pdf)) %>)
  end

end
