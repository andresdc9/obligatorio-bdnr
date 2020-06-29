class Wiki
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :pages, dependent: :destroy

  field :name, type: String
  
  validates :name,  presence: true, uniqueness: true
end
