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
        Work.
          select("works.*, SUM(footprints.counts) AS total_footprint_counts").
          joins(:footprints).
          includes(
            [
              :comments,
              :likes,
              image_attachment: :blob,
              user: { avatar_attachment: :blob },
              illustrations: { photo_attachment: :blob },
            ]
          ).where(
            'title like ? OR concept like ?',
            "%#{keyword}%",
            "%#{keyword}%",
          ).where(category_id: serarch_category).
          group("works.id")
      else
        Work.
          select("works.*, SUM(footprints.counts) AS total_footprint_counts").
          joins(:footprints).
          includes(
            [
              :comments,
              :likes,
              image_attachment: :blob,
              user: { avatar_attachment: :blob },
              illustrations: { photo_attachment: :blob },
            ]
          ).where(
            'title like ? OR concept like ?',
            "%#{keyword}%",
            "%#{keyword}%",
          ).group("works.id")
      end
    else
      Work.
        select("works.*, SUM(footprints.counts) AS total_footprint_counts").
        joins(:footprints).
        includes(
          [
            :comments,
            :likes,
            image_attachment: :blob,
            user: { avatar_attachment: :blob },
            illustrations: { photo_attachment: :blob },
          ]
        ).where(category_id: serarch_category).
        group("works.id")
    end
  end
end
