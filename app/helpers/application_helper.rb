module ApplicationHelper
  def base_meta_tags
    {
      site: 'Egg',
      reverse: true,
      charset: 'utf-8',
      description: "Create an account or log in to Egg - Let's refer other ideas to observe their works and
                    understand the production intention to chat with creators , observe the trajectory of
                    your thoughts by registering your own works.",
      canonical: request.original_url,
      separator: ' - ',
      # icon: image_url("favicon.ico"),
      og: base_og,
    }
  end

  private

  def base_og
    {
      title: :full_title,
      description: :description,
      url: request.original_url,
      # image: image_url('https://example.com/hoge.png')
    }
  end
end
