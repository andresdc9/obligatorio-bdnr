ActiveAdmin.register AdminUser do
  menu priority: 3
  permit_params :email, :password, :password_confirmation

  index do
    column :email

    actions
  end

  show do
    attributes_table do
      row :email
    end
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
