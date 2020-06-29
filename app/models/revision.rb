class Revision
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :page
  belongs_to :admin_user

  field :edit_message, type: String
end
