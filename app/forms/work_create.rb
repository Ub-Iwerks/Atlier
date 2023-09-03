class WorkCreate
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  # TODO: validation
  attr_accessor :illustrations
  attr_accessor :tags
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

    # Work
    @work = Work.new(
      title:       title,
      user_id:     user_id,
      category_id: category_id,
      concept:     concept,
      description: description
    )
    @work.image.attach(image)
    @valid = @work.valid?

    # Tag
    @tags = tags.map do |tag|
      if !tag[:title].empty?
        tag = @work.tags.find_or_initialize_by(
          title: tag[:title]
        )

        @valid = @valid && tag.valid?
        tag
      end
    end
    Rails.logger.debug @tags

    # Illustration
    @illustrations = illustrations.map do |illustration|
      if (
        !illustration[:name].empty? \
        || !illustration[:description].empty? \
        || !illustration[:photo].nil?
      )
        illustration = @work.illustrations.new(
          name:        illustration['name'],
          description: illustration['description'],
        )
        illustration.photo.attach(illustration['photo'])

        @valid = @valid && illustration.valid?
        illustration
      end
    end
    Rails.logger.debug @illustrations
    # /Validation

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

      Tag.transaction do
        @tags.map do |tag|
          tag.save! if !tag.nil?
        end
      end

      Illustration.transaction do
        @illustrations.map do |illustration|
          illustration.save! if !illustration.nil?
        end
      end
    end
    # /Transactions end

    return [
      true,
      @work,
    ]
  end
end
