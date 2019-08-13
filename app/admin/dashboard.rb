ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    columns do
      column do
        panel "Recent Categories" do
          table_for Category.order("created_at desc").limit(5) do
            column("Title") { |category| link_to("#{category.title}", admin_category_path(category))}
            column :created_at
          end
        end
        strong {link_to "View all categories", admin_categories_path}
      end

      column do
        panel "Recent Comments" do
          table_for Comment.order("created_at desc").limit(5) do
            column :commenter
            column :body
            column :created_at
            # column("Link To User") { |comment| link_to("#{comment.user_id}", admin_comment_path(comment))}
            column("Link To Image") { |comment| link_to("#{comment.image_id}", admin_comment_path(comment))}
          end
        end
        strong {link_to "View all comments", admin_comments_path}
      end
    end
  end # content
end
