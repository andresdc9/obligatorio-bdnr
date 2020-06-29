ActiveAdmin.register Page do
  config.filters = false

  belongs_to :wiki


  permit_params :title, :creator, :content, :edit_message, :wiki_id, :admin_user_id

  breadcrumb do
    crumbs = [
        link_to('Admin', admin_root_path),
        link_to(wiki.name, admin_wikis_path(wiki_id: wiki.id)),
        link_to('Pages', admin_wiki_pages_path(wiki_id: wiki.id))
    ]
  end

  index do
    column "Title", :title
    column "Creator", :admin_user
    column "Last Updated", :updated_at

    actions do |resource|
      item  "#{resource.revisions.count} Revisions",  admin_page_revisions_path(page_id: resource.id), class: 'action-button member_link'
    end
  end

  show do
    attributes_table do
      row :title
      row "Creator" do
        resource.admin_user
      end
      row :content, :class => 'fr-view' do |page|
        raw(page.content)
      end
      row "Last Updated" do
        resource.updated_at
      end
      row "Revisions" do
         link_to("#{resource.revisions.count}", admin_page_revisions_path(page_id: resource.id))
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Page' do
      f.input :title
      f.input :content, as: :froala_editor
      f.input :edit_message
      f.input :wiki_id, as: :hidden
      f.input :admin_user_id, input_html: {value: "#{current_admin_user.id}"}, as: :hidden
    end
    f.actions do
      f.action :submit, wiki_id: params[:wiki_id]
      f.cancel_link(admin_wiki_pages_path(wiki_id: params[:wiki_id]))
    end
  end

  after_create do
    resource.create_revision
  end

  after_update do
    resource.create_edit_revision
  end
end
