module ApplicationHelper
    def full_title(page_title = '')
        title = "Social networking app"
        if page_title.empty?
            title
        else
            "#{page_title} | #{title}"
        end
    end
    
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url,alt: user.name,class: gravatar)
    end
end
