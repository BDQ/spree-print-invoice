SUMMARY
=======

This extension provides a "Print Invoice" button on the Admin Orders view screen which generates a PDF of the order details.

 
INSTALLATION
------------

1. Install the prawn_hander plugin

      script/plugin install git://github.com/Roman2K/prawn-handler.git
      
2. Install this extension

      script/extension install git://github.com/BDQ/spree-print-invoice.git

3. Make sure you have the required gems

      sudo gem install prawn prawn-layout
      
4. Optional: Set the logo path preference to include your store / company logo (in your seeds.rb / site extension).

      Spree::PrintInvoice::Config.set(:print_invoice_logo_path => "/path/to/public/images/company-logo.png")

5. Enjoy!

