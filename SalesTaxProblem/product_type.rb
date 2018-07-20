module ProductType
  NON_TAX_ITEMS = ['book', 'chocolate', 'pill']

  def imported_item?(order_item)
    order_item.include?('imported')
  end

  def non_tax_item?(order_item)
    NON_TAX_ITEMS.each do |item|
      if order_item.include?(item) || order_item.include?(item.pluralize)
        return true
      end
    end
    false
  end

  def imported_and_non_tax_item?(order_item)
    imported_item?(order_item) && non_tax_item?(order_item)
  end
end
