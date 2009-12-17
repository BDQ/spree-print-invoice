class PrintInvoiceHooks < Spree::ThemeSupport::HookListener
  
  insert_after :admin_order_buttons do
    %( <%= button_link_to("Print Invoice", formatted_admin_order_url(@order, :pdf)) %>)
  end
  
end
