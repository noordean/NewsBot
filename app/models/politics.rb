class Politics < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :link, presence: true, uniqueness: true

  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  # settings do
  #   mappings dynamic: false do
  #     indexes :title, type: :text
  #     indexes :description, type: :text
  #   end
  # end
  def self.search(query)
    where("title ILIKE :query OR description ILIKE :query", query: "%#{query}%")
  end
end
