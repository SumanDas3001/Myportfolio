module BlogsHelper
	def gravatar_helper user
		image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
	end

	class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)

    options = {
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
      lax_spacing: true
    }

    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

  def blog_status_color blog
    'color: red;' if blog.draft?
  end

  def blog_favorite_color blog, user
    user_favorite_blog = UserFavoriteBlog.find_by(user_id: user.id, blog_id: blog.id) rescue nil
    if user_favorite_blog.present?
      'color: red;' if user_favorite_blog.is_favorited
    else
      'color: blue;' 
    end
  end

  def blog_default_color
    'color: blue;'
  end

  def total_favorite_count(blog)
    UserFavoriteBlog.where(blog_id: blog.id, is_favorited: true).count rescue 0
  end

  def total_blog_of_topic(topic)
    Blog.where(topic_id: topic.id, status: 'published').count rescue 0
  end
end
