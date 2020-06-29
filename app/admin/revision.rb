ActiveAdmin.register Revision do
  config.clear_action_items!
  config.filters = false

  belongs_to :page

  permit_params :edit_message, :page_id, :admin_user_id

  breadcrumb do
    crumbs = [
        link_to('Admin', admin_root_path),
        link_to(page.wiki.name, admin_wikis_path(wiki_id: page.wiki.id)),
        link_to('Pages', admin_wiki_pages_path(wiki_id: page.wiki.id)),
        link_to(page.title, admin_wiki_page_path(wiki_id: page.wiki.id, id: page.id))
    ]
  end

  index do
    column "Edit Message", :edit_message
    column "User", :admin_user
    column "Date", :created_at
  end

end
