SUMMARY
=======

This extension provides a "Print Invoice" button on the Admin Orders view screen which generates a PDF of the order details.

 
INSTALLATION
============

1. The gem relies only on the prawn gem, to install you need to add the following lines to your Gemfile

    gem 'spree_print_invoice' , :git => 'git://github.com/dancinglightning/spree-print-invoice.git'

2. run bundler

    bundle install
  
3. Enjoy!

Configuration
==============

1. Set the logo path preference to include your store / company logo.

    Spree::Config.set(:print_invoice_logo_path => "/path/to/public/images/company-logo.png")

2. Add your own own footer texts to the locale. The current footer works with :footer_left1 , :footer_left2 and :footer_right1, :footer_right2 where the 1 version is on the left in bold, and the 2 version the "value" on the right.

3. Override any of the partial templates. they are address, footer, totals, header , and the line_items.

Plans
=====
Next will come

- packaging list
- extra texts 

Contributions welcome

Torsten