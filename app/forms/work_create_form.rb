class WorkCreateForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :current_user_id, :integer
  attribute :title, :string
  attribute :concept, :string
  attribute :description, :string
  attribute :image, :binary
  attribute :illustration_name, :string
  attribute :illustration_description, :string
  attribute :illustration_photo, :binary

  def save
    # return false if invalid?
    user = User.find(current_user_id)
    work = user.works.new(title: title, concept: concept, description: description)
    work.image.attach(image)
    work.save

    illustration = work.illustrations.build(name: illustration_name, description: illustration_description)
    illustration.photo.attach(illustration_photo)
    illustration.save
    if illustration.persisted? && work.persisted?
      return true
    else
      return false
    end
  end
end
