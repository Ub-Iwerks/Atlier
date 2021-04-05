class WorkSearch
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attribute :keyword, :string
  attribute :category_id, :integer
  attribute :parent_category_id, :integer

  def search
    if category_id.present?
      serarch_category = category_id
    elsif parent_category_id.present?
      serarch_category = Category.where(ancestry: parent_category_id).map { |i| i.id }
    else
      serarch_category = nil
    end
    if keyword.present?
      if serarch_category.present?
        Work.where('title like ?', "%#{keyword}%").where(category_id: serarch_category)
      else
        Work.where('title like ?', "%#{keyword}%")
      end
    else
      Work.where(category_id: serarch_category)
    end
  end
end
