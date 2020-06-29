ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :add_feed, method: :post do
    Feed.create(message: "Generated Feed")
    redirect_to admin_dashboard_path, notice: "Feed was added"
  end

  action_item :add do
    link_to "Generate Feed", admin_dashboard_add_feed_path, method: :post
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
      end
    end

        panel "Actions feed" do
          ul do
            feed = Rails.cache.fetch("actions_feed")
            if feed.nil?
              feed = Feed.order('created_at DESC')
              Rails.cache.write("actions_feed", feed)
            end
            feed.map do |f|
              para "#{f.message} - Date: #{f.created_at.strftime("%-d/%-m/%y - %H:%M:%S")}"
            end
            para "There is no feed" if feed.empty?
          end
        end
      end
    end
