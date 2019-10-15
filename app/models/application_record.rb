class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def create_slug
    loop do
      uuid = SecureRandom.uuid

      if self.class.where({ slug: uuid }).count == 0
        self.slug = uuid
        break
      end
    end
  end
end
