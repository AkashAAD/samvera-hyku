# Generated via
#  `rails generate hyrax:work WorkReview`
module Hyrax
  # Generated form for WorkReview
  class WorkReviewForm < Hyrax::Forms::WorkForm
    self.model_class = ::WorkReview
    self.terms += [:admin_comment, :user_comment, :outcome, :review_status, :review_dataset_id, :reviewer_email]
    self.terms -= [:description, :keyword, :license, :rights_statement, :publisher, :contributor, :date_created, :subject, :language, :identifier, :related_url, :source]
    self.required_fields += [:creator, :title]
  end
end
