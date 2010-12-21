SUMMARY
=======

This extension provides a "Print Invoice" button on the Admin Orders view screen which generates a PDF of the order details.

 
INSTALLATION
------------

1. The gem relies only on the prawn gem, to install you need to add the following lines to your Gemfile

    gem 'spree_print_invoice' , :git => 'git://github.com/BDQ/spree-print-invoice.git'

2. run bundler

    bundle install
  
3. Set the logo path preference to include your store / company logo (in your seeds.rb / site extension).

    Spree::Config.set(:print_invoice_logo_path => "/path/to/public/images/company-logo.png")

4. Optional: add your own translation to config/locales, even for english users. You can change the footer text that way.

5. Enjoy!

