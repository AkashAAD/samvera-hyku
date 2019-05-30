# accepts_nested_attributes_for can not be called until all the properties are declared
# because it calls resource_class, which finalizes the propery declarations
# See https://github.com/projecthydra/active_fedora/issues/847
module DatasetNestedAttributes
  extend ActiveSupport::Concern

  included do
    # accepts_nested_attributes_for :work_review_process, reject_if: :work_review_process_blank, allow_destroy: true
    accepts_nested_attributes_for :reviewers, reject_if: :reviewers_blank, allow_destroy: true
    accepts_nested_attributes_for :other_title, reject_if: :other_title_blank, allow_destroy: true
    accepts_nested_attributes_for :identifier_nested, reject_if: :identifier_blank, allow_destroy: true
    accepts_nested_attributes_for :creator_nested, reject_if: :creator_blank, allow_destroy: true
    accepts_nested_attributes_for :subject_nested, reject_if: :subject_blank, allow_destroy: true
    # accepts_nested_attributes_for :contributor_nested, reject_if: :contributor_blank, allow_destroy: true
    # accepts_nested_attributes_for :date_nested, reject_if: :date_blank, allow_destroy: true
    # accepts_nested_attributes_for :alt_identifier_nested, reject_if: :alt_identifier_blank, allow_destroy: true
    accepts_nested_attributes_for :related_identifier_nested, reject_if: :related_identifier_blank, allow_destroy: true    
    # accepts_nested_attributes_for :rights_nested, reject_if: :rights_blank, allow_destroy: true
    accepts_nested_attributes_for :description_nested, reject_if: :description_blank, allow_destroy: true
    accepts_nested_attributes_for :funding_nested, reject_if: :funding_blank, allow_destroy: true
    accepts_nested_attributes_for :geolocation_nested, reject_if: :geolocation_blank, allow_destroy: true

    # relation_blank
    # Need label, url / identifier, relationship name / relationship role
    # resource_class.send(:define_method, :relation_blank) do |attributes|
    #   (Array(attributes[:label]).all?(&:blank?) ||
    #   (Array(attributes[:url]).all?(&:blank?) &&
    #   Array(attributes[:identifier]).all?(&:blank?))) ||
    #   (Array(attributes[:relationship_role]).all?(&:blank?) &&
    #   Array(attributes[:relationship_name]).all?(&:blank?))
    # end

    # subject_blank
    resource_class.send(:define_method, :subject_blank) do |attributes|
      Array(attributes[:subject]).all?(&:blank?)
    end

    # date_blank
    # resource_class.send(:define_method, :date_blank) do |attributes|
    #   Array(attributes[:date]).all(&:blank?) ||
    #   Array(attributes[:date_type]).all(&:blank?) ||
    #   Array(attributes[:date_information]).all(&:blank?)
    # end

    # work_review_process_blank
    # resource_class.send(:define_method, :work_review_process_blank) do |attributes|
    #   Array(attributes[:status]).all?(&:blank?)
    # end

    # reviewers
    resource_class.send(:define_method, :reviewers_blank) do |attributes|
      Array(attributes[:reviewer]).all?(&:blank?)
    end

    # gelocation_blank
    resource_class.send(:define_method, :geolocation_blank) do |attributes|
      Array(attributes[:geolocation]).all?(&:blank?)
    end

    # funding_blank
    resource_class.send(:define_method, :funding_blank) do |attributes|
      Array(attributes[:funding_reference]).all?(&:blank?) ||
      Array(attributes[:funder_name]).all?(&:blank?)
    end

    # description_blank
    resource_class.send(:define_method, :description_blank) do |attributes|
      Array(attributes[:description]).all?(&:blank?)
    end

    # rights_blank
    resource_class.send(:define_method, :rights_blank) do |attributes|
      Array(attributes[:rights]).all?(&:blank?)
    end

    # # alt_identifier_blank
    # resource_class.send(:define_method, :alt_identifier_blank) do |attributes|
    #   Array(attributes[:alt_identifier]).all?(&:blank?) ||
    #   Array(attributes[:alternate_identifier_type]).all?(&:blank?)
    # end

    # related_identifier_blank
    resource_class.send(:define_method, :related_identifier_blank) do |attributes|
      Array(attributes[:related_identifier]).all?(&:blank?) ||
      Array(attributes[:related_identifier_type]).all?(&:blank?)
    end

    # contributor_blank
    # resource_class.send(:define_method, :contributor_blank) do |attributes|
    #   Array(attributes[:contributor_type]).all?(&:blank?) ||
    #   Array(attributes[:full_name]).all?(&:blank?) ||
    #   Array(attributes[:name_type]).all?(&:blank?) ||
    #   Array(attributes[:contributor_first_name]).all?(&:blank?) ||
    #   Array(attributes[:contributor_last_name]).all?(&:blank?) ||
    #   Array(attributes[:contributor_affiliation]).all?(&:blank?) ||
    #   Array(attributes[:contributor_scheme_uri]).all?(&:blank?) ||
    #   Array(attributes[:name_identifier_scheme]).all?(&:blank?) ||
    #   Array(attributes[:contributor_name_identifier]).all?(&:blank?)
    # end

    # admin_metadata_blank
    resource_class.send(:define_method, :admin_metadata_blank) do |attributes|
      Array(attributes[:question]).all?(&:blank?)
    end
    # other_title_blank
    resource_class.send(:define_method, :other_title_blank) do |attributes|
      Array(attributes[:title]).all?(&:blank?)
    end

    # creator_blank
    resource_class.send(:define_method, :creator_blank) do |attributes|
      # (Array(attributes[:creator_first_name]).all?(&:blank?) ||
      # (Array(attributes[:creator_last_name]).all?(&:blank?)) ||
      Array(attributes[:role]).all?(&:blank?) ||
      Array(attributes[:orcid]).all?(&:blank?) ||
      Array(attributes[:name]).all?(&:blank?) ||
      # Array(attributes[:creator_scheme_uri]).all?(&:blank?) ||
      # Array(attributes[:creator_name_identifier]).all?(&:blank?) ||
      Array(attributes[:creator_affiliation]).all?(&:blank?)
    end

    # identifier_blank - need identifier and scheme attributes
    resource_class.send(:define_method, :identifier_blank) do |attributes|
      (Array(attributes[:obj_id]).all?(&:blank?) ||
       Array(attributes[:obj_id_scheme]).all?(&:blank?))
    end



  end
end
