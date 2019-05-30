module ApplicationHelper
  include ::HyraxHelper
  include GroupNavigationHelper

  def hyku_colection_type(collection_type, user)
    if collection_type.eql?("translation missing: en.hyrax.collection_type.default_title") && user.roles.pluck(:name).include?("admin")
      I18n.t("hyrax.collection_type.default_title")
    elsif collection_type.eql?("translation missing: en.hyrax.collection_type.default_title") && user.roles.pluck(:name).include?("user")
      I18n.t("hyrax.collection_type.default_title")
    elsif collection_type.eql?("translation missing: en.hyrax.collection_type.admin_set_title") && user.roles.pluck(:name).include?("admin")
      I18n.t("hyrax.collection_type.admin_set_title")
    else
      I18n.t("hyrax.collection_type.default_title")
    end
  end

  def get_reviews(reviewer_email, review_dataset_id)
    WorkReview.where(reviewer_email: reviewer_email, review_dataset_id: review_dataset_id)
  end

  def user_roles(user, role)
    user.roles.pluck(:name).include?(role) if !user.nil?
  end
end
