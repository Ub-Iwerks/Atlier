module ApplicationHelper
  def base_meta_tags
    {
      site: 'Atlier',
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

  def current_user?(user)
    user == current_user
  end

  def text_url_to_link(text)
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\" rel=\"noopener\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    text
  end

  def display_avatar_for(user, size: Settings.avatar_size[:in_feed])
    default_avatar = Settings.default_image[:avatar]
    resize = "#{size}x#{size}^"
    crop = "#{size}x#{size}+0+0"
    if user.avatar.attached?
      avatar = user.avatar
      image_tag(avatar.variant(gravity: :center, resize: resize, crop: crop).processed, alt: "#{user.username}", class: "avatar")
    else
      image_tag(default_avatar, alt: "#{user.username}", class: "avatar", width: "#{size}px")
    end
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
