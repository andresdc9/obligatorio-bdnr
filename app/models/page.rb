class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :wiki
  belongs_to :admin_user
  has_many :revisions, dependent: :destroy

  field :title, type: String
  field :content, type: String

  validates :title,  presence: true

  attr_accessor :edit_message

  def create_revision
    if self.edit_message.present?
      Revision.create(page: self, edit_message: self.edit_message, admin_user: self.admin_user)
    else
      Revision.create(page: self, edit_message: "Created #{self.title} (markdown)", admin_user: self.admin_user)
    end
  end

  def create_edit_revision
    if self.edit_message.present?
      Revision.create(page: self, edit_message: self.edit_message, admin_user: self.admin_user)
    else
      Revision.create(page: self, edit_message: "Updated #{self.title} (markdown)", admin_user: self.admin_user)
    end
  end
end
