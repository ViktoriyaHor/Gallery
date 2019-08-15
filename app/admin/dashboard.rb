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
            column(:title) { |category| link_to("#{category.title}", admin_category_path(category))}
            column(:user_id) { |category| link_to("#{category.user_id}", admin_user_path(category.user_id))}
            column :subscriptions_count
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
            column(:user_id) { |comment| link_to("#{comment.user_id}", admin_user_path(comment.user_id))}
            column(:image_id) { |comment| link_to("#{comment.image_id}", admin_comment_path(comment))}
            column :created_at
          end
        end
        strong {link_to "View all comments", admin_comments_path}
      end
    end
    columns do
      column do
        panel "Recent Images" do
          table_for Image.order("created_at desc").limit(10) do
            column("Image") { |image| link_to image_tag("#{image.src.url(:thumbnail)}"), admin_image_path(image)}
            column(:user_id) { |image| link_to("#{image.user_id}", admin_user_path(image.user_id))}
            column(:category_id) { |image| link_to("#{image.category_id}", admin_category_path(image.category_id)) if image.src?}
            column :likes_count
            column :comments_count
            column :created_at
          end
        end
        strong {link_to "View all images", admin_images_path}
      end

      column do
        panel "User actions" do
          table_for LoggingUserAction.order("created_at desc").limit(10) do
            column("User email") { |action| link_to("#{User.find(action.user_id).email}", admin_user_path(action.user_id))}
            column(:action) { |action| link_to("#{Action.find(action.action_id).action_type}", admin_logging_user_action_path(action))}
            column("URL") {|action| action.action_path}
            column :created_at
          end
        end
        strong {link_to "View all actions", admin_logging_user_actions_path}
      end
    end
    columns do
      column do
        panel "Upload Images" do
          input 'URL', :body
        end
        # strong {link_to "View all images", admin_images_path}
      end
    end
  end # content
end
