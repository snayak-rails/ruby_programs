# module ProductType : identifies the type of product for
# an item object of class: SalesTax
module ProductType
  NON_TAX_ITEMS = %w[book chocolate pill]

  def imported_item?(item_description)
    item_description.include?('imported')
  end

  def non_tax_item?(item_description)
    NON_TAX_ITEMS.each do |item_type|
      return true if item_description.include?(item_type)
      return true if item_description.include?(item_type + 's')
    end
    false
  end

  def imported_and_non_tax_item?(item_description)
    imported_item?(item_description) && non_tax_item?(item_description)
  end
end
