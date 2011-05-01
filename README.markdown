SUMMARY
=======

This extension provides a "Print Invoice" button on the Admin Orders view screen which generates a PDF of the order details.

Upon reflection
===============

Having done this I spent too much time to get it working. Part of that was tools on the move and my own 
learning, but there is also a flaw in the approach of the actual pdf generation. 
The generation is driven by code, which is a mistake. Pdf's are designed documents and should be created by a designer, not a coder. So the tool is wrong. Also this template code is really difficult to debug.

So I would suggest to create a simple html page without the admin layout in admin/order. Create a link to it and let your designer work with tools he knows. You can then create pdf on the client, and if you can't try PdfKit, which does the html->pdf conversion on the server.

I may get around to this, or if you do it, let me know. Whichever way, you have been warned.
 
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

2. Add your own own footer texts to the locale. The current footer works with :footer_left , :footer_left2 and :footer_right, :footer_right2 where the 1 version is on the left in bold, and the 2 version the "value" on the right.

3. Override any of the includes templates. they are address, footer, totals, header, bye , and the line_items. In bye the text :thanks is printed, and there is a hook :extra_note.

4. Set :suppress_anonymous_address option to get blank addresses for anonymous email addresses (as created by my spree_last_address extension for empty/unknown user info)

5. Enable packaging slips, by setting 

  Spree::Config.set(:print_buttons => "invoice,packaging_slip"  #comma separated list

 Use above feature for your own template if you want. For each button_name, define a subsection with header, print, and thanks, in your locale.

Note
-----
Unfortunately Romans nice missing_method approach, and the prawn own way, of having the pdf document implicit didn't work. So it's @pdf all over the place.

Now using erb templates, if you change, you must get the output right!

The good news is, it now works on PCs.

Plans
=====
Next receipts and then product related stuff with barcodes.


Contributions welcome

Torsten