
require 'print_invoice_hooks'
require 'prawn_handler'


module PrintInvoice
  class Engine < Rails::Engine
    
    def self.activate

      Admin::OrdersController.class_eval do
        show.success.wants.pdf { render :layout => false, :template => 'admin/orders/show.pdf.prawn' } #
      end


    end


    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end
