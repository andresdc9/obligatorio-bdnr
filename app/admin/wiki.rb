ActiveAdmin.register Wiki do
  menu priority: 2

  permit_params :name

  filter :name

  index do
    column :name

    actions do |resource|
      item 'Pages',  admin_wiki_pages_path(wiki_id: resource.id), class: 'action-button member_link'
    end
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end
end
