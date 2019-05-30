# Generated via
#  `rails generate hyrax:work WorkReview`
module Hyrax
  # Generated controller for WorkReview
  class WorkReviewsController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::WorkReview

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::WorkReviewPresenter
  end
end
