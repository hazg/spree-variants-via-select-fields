Deface::Override.new(:virtual_path => 'spree/products/_cart_form',
                     :replace => "#product-variants",
                     :partial => "spree/products/variant_selects",
                     :name => "variant_select")
