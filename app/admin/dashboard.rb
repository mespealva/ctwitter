ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t()
        small I18n.t()
      end
    end

    columns do
      column do
        panel "usuarios" do
          ul do
            User.all.each do |u|
              li link_to(u.name, admin_user_path(u))
            end
          end
        end
      end
    end

    columns do
      column do
        panel "tweets" do
          ul do
            Tweet.all.each do |t|
              li link_to(t.content, admin_tweet_path(t))
            end
          end
        end
      end


    end
  end # content
end

