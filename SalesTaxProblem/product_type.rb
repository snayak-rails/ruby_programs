module ProductType
  NON_TAX_ITEMS = ['book', 'chocolate', 'pill']

  def imported_item?
    @item_description.include?('imported')
  end

  def non_tax_item?
    NON_TAX_ITEMS.each do |item_type|
      return true if @item_description.include?(item_type)
      #return true if @item_description.include?(item_type.pluralize)
    end
    false
  end

  def imported_and_non_tax_item?
    imported_item? && non_tax_item?
  end
end
