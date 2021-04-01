class WorkCreate
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :illustrations
  attribute :user_id, :integer
  attribute :category_id, :integer
  attribute :title, :string
  attribute :concept
  attribute :description
  attribute :image, :binary

  def initialize(attributes = {})
    super attributes
    self.illustrations = Settings.attached_count[:maximum].times.map { Illustration.new } if illustrations.blank?
  end

  def illustrations_attributes=(attributes)
    self.illustrations = attributes.map { |_, v| Illustration.new(v) }
  end

  def save
    @work = Work.new(title: title, user_id: user_id, category_id: category_id, concept: concept, description: description)
    @work.image.attach(image)
    if @work.save
      Illustration.transaction do
        illustrations.map do |illustration|
          if illustration.photo.attached?
            illustration.work_id = @work.id
            unless illustration.save
              return false, illustration
            end
          end
        end
      end
      return true, @work
    else
      return false, @work
    end
  end
end
