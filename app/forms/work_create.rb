class WorkCreate
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  # TODO: validation
  attr_accessor :illustrations
  attribute :user_id, :integer
  attribute :category_id, :integer
  attribute :title, :string
  attribute :concept
  attribute :description
  attribute :image, :binary

  def initialize(attributes = {})
    super attributes
  end

  def save
    # Validation
    @valid = true

    @work = Work.new(
      title:       title,
      user_id:     user_id,
      category_id: category_id,
      concept:     concept,
      description: description
    )
    @work.image.attach(image)
    @valid = @work.valid?

    @illustrations = illustrations.map do |illustration|
      if (
        !illustration['name'].empty? \
        || !illustration['description'].empty? \
        || !illustration['photo'].nil?
      )
        @illustration = @work.illustrations.new(
          name:        illustration['name'],
          description: illustration['description'],
        )
        @illustration.photo.attach(illustration['photo'])

        @valid = @valid && @illustration.valid?
      end
    end

    if @valid === false
      return [
        false,
        @work,
      ]
    end

    # Transactions start
    ActiveRecord::Base.transaction(joinable: false, requires_new: true) do
      Work.transaction do
        @work.save!
      end

      Illustration.transaction do
        @illustrations.map do |illustration|
          @illustration.save!
        end
      end
    end

    return [
      true,
      @work,
    ]
  end
end
