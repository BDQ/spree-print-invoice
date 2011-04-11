require 'print_invoice_hooks'
require 'prawn'
require 'prawn/layout'


module PrintInvoice
  class Engine < Rails::Engine
    
    def self.activate

      Admin::OrdersController.class_eval do
        
        show.success.wants.pdf do
          template = params[:template] || "invoice"
          render :template => "admin/orders/#{template}"  , :filename => "#{@order.number}.pdf", 
                  :layout => false      , :content_type => "application/pdf" , :type => :erb
        end #
        
        def method_missing(method, *args, &block)
          puts "missing #{method} has pdf=#{@pdf=!nil} args=#{args.length}"
          @pdf.respond_to?(method) ? @pdf.send(method, *args, &block) : super
        end      
      end
    end


    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

  end
end

Mime::Type.register 'application/pdf', :pdf
