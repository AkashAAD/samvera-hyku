# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  # Generated form for Dataset
  class DatasetForm < Hyrax::Forms::WorkForm
    self.model_class = ::Dataset
    self.terms += [:reviewers, :work_review_process, :geolocation_nested, :funding_nested, :description_nested, :dataset_version, :dataset_format, :dataset_size, :related_identifier_nested, :date_nested, :publication_year, :resource_type, :identifier_nested, :creator_nested, :other_title, :subject_nested]
    self.terms -= [:contributor, :creator, :description, :subject, :identifier, :based_near]
    self.required_fields += [:creator_nested]
    NESTED_ASSOCIATIONS = [:work_review_process, :geolocation_nested, :funding_nested, :description_nested, :related_identifier_nested, :other_title, :creator_nested, :identifier_nested, :subject_nested, :date_nested].freeze
    
    def self.permitted_other_params
      [
        :id,
        :_destroy,
        {
          title: [],
          title_type: []
        },
      ]
    end

    def self.permitted_creator_params
      [
        :id,
        :_destroy,
        {
          name: [],
          # creator_first_name: [],
          # creator_last_name: [],
          orcid: [],
          role: [],
          creator_affiliation: []
          # creator_scheme_uri: []
          # creator_name_identifier: []
        },
      ]
    end

    def self.permitted_identifier_params
      [
        :id,
        :_destroy,
        {
          obj_id_scheme: [],
          obj_id: []
        },
      ]
    end

    def self.permitted_subject_params
      [
        :id,
        :_destroy,
        {
          subject: []
          # subject_scheme: [],
          # scheme_uri: [],
          # value_uri: []
        },
      ]
    end

    # def self.permitted_contributer_params
    #   [
    #     :id,
    #     :_destroy,
    #     {
    #       contributor_type: [],
    #       full_name: [],
    #       name_type: [],
    #       contributor_first_name: [],
    #       contributor_last_name: [],
    #       contributor_affiliation: [],
    #       contributor_scheme_uri: [],
    #       name_identifier_scheme: [],
    #       contributor_name_identifier: []
    #     }
    #   ]
    # end

    def self.permitted_date_params
      [
        :id,
        :_destroy,
        {
          date: [],
          date_type: [],
          date_information: []
        }
      ]
    end

    def self.permitted_alt_identifier_params
      [
        :id,
        :_destroy,
        {
          alt_identifier: [],
          alternate_identifier_type: []
        }
      ]
    end

    def self.permitted_related_identifier_params
      [
        :id,
        :_destroy,
        {
          related_identifier: [],
          related_identifier_type: [],
          relation_type: []
          # related_metadata_scheme: [],
          # scheme_uri: [],
          # scheme_type: []
        }
      ]
    end

    def self.permitted_rights_params
      [
        :id,
        :_destroy,
        {
          rights: [],
          rights_uri: []
        }
      ]
    end

    def self.permitted_description_params
      [
        :id,
        :_destroy,
        {
          description: [],
          description_type: []
        }
      ]
    end

    def self.permitted_funding_params
      [
        :id,
        :_destroy,
        {
          funding_reference: [],
          funder_name: [],
          funder_identifier: [],
          funder_identifier_type: [],
          award_number: [],
          award_uri: [],
          award_title: []
        }
      ]
    end

    def self.permitted_gelocation_params
      [
        :id,
        :_destroy,
        {
          geolocation: []
          # geolocation_point: [],
          # point_longitude: [],
          # point_latitude: [],
          # geo_location_box: [],
          # west_bound_longitude: [],
          # east_bound_longitude: [],
          # south_bound_latitude: [],
          # north_bound_latitude: [],
          # geolocation_place: [],
          # geolocation_polygon: [],
          # polygon_point: [],
          # in_polygon_point: []
        }
      ]
    end

    def self.permitted_work_review_process_params
      [
        :id,
        :_destroy,
        {
          reviewers: [],
          status: [],
          comment: [],
          upload_user_report: [],
          upload_admin_report: [],
          outcome: [],
          reviewer_acceptance_due_date: [],
          reviewer_completing_due_date: []
        }
      ]
    end

    def self.reviewers_params
      [
        :id,
        :_destroy,
        {
          reviewer: []
        }
      ]
    end

    def self.build_permitted_params
      permitted = super
      permitted << { subject_nested_attributes: permitted_subject_params }
      permitted << { other_title_attributes: permitted_other_params }
      permitted << { creator_nested_attributes: permitted_creator_params }
      permitted << { identifier_nested_attributes: permitted_identifier_params }
      # permitted << { contributor_nested_attributes: permitted_contributer_params }
      permitted << { date_nested_attributes: permitted_date_params }
      # permitted << { alt_identifier_nested_attributes: permitted_alt_identifier_params }
      permitted << { related_identifier_nested_attributes: permitted_related_identifier_params }
      # permitted << { rights_nested_attributes: permitted_rights_params }
      permitted << { description_nested_attributes: permitted_description_params }
      permitted << { funding_nested_attributes: permitted_funding_params }
      permitted << { geolocation_nested_attributes: permitted_gelocation_params }
      permitted << { work_review_process_attributes: permitted_work_review_process_params }
      permitted << { reviewers_attributes: reviewers_params }
      permitted
    end
  end
end
