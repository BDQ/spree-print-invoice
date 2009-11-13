# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class PrintInvoiceExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/print_invoice"
 
	def self.require_gems(config)
		config.gem "prawn", :version => '0.6.1'
	end

  def activate

		Admin::OrdersHelper.module_eval do
		  def event_links
		    links = [button_link_to("Print Invoice", formatted_admin_order_url(@order, :pdf))]
		    @order_events.sort.each do |event|
		      if @order.send("can_#{event}?")
		        links << button_link_to(t(event), fire_admin_order_url(@order, :e => event),
		                                { :method => :put, :confirm => t("order_sure_want_to", :event => t(event)) })
		      end
		    end
		    links.join('&nbsp;')
		  end
		
		end
		
		Admin::OrdersController.class_eval do
			show.success.wants.pdf { render :layout => false} #, :template => 'admin/orders/show.pdf.prawn' 
		end
		
  end
end
