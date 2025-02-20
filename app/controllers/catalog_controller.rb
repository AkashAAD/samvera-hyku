class CatalogController < ApplicationController
  include Hydra::Catalog
  include Hydra::Controller::ControllerBehavior

  # These before_action filters apply the hydra access controls
  before_action :enforce_show_permissions, only: :show

  def self.uploaded_field
    solr_name('system_create', :stored_sortable, type: :date)
  end

  def self.modified_field
    solr_name('system_modified', :stored_sortable, type: :date)
  end

  configure_blacklight do |config|
    config.view.gallery.partials = %i[index_header index]
    config.view.masonry.partials = [:index]
    config.view.slideshow.partials = [:index]

    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
    config.show.partials.insert(1, :openseadragon)
    # default advanced config values
    config.advanced_search ||= Blacklight::OpenStructWithHashAccess.new
    # config.advanced_search[:qt] ||= 'advanced'
    config.advanced_search[:url_key] ||= 'advanced'
    config.advanced_search[:query_parser] ||= 'dismax'
    config.advanced_search[:form_solr_parameters] ||= {}

    config.search_builder_class = Hyrax::CatalogSearchBuilder

    # Show gallery view
    config.view.gallery.partials = %i[index_header index]
    config.view.slideshow.partials = [:index]

    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      qt: "search",
      rows: 10,
      qf: "title_tesim description_tesim creator_tesim keyword_tesim"
    }

    # Specify which field to use in the tag cloud on the homepage.
    # To disable the tag cloud, comment out this line.
    config.tag_cloud_field_name = Solrizer.solr_name("tag", :facetable)

    # solr field configuration for document/show views
    config.index.title_field = solr_name("title", :stored_searchable)
    config.index.display_type_field = solr_name("has_model", :symbol)
    config.index.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    config.add_facet_field solr_name("human_readable_type", :facetable), label: "Type", limit: 5
    config.add_facet_field solr_name("resource_type", :facetable), label: "Resource Type", limit: 5
    # config.add_facet_field solr_name("creator", :facetable), limit: 5
    # config.add_facet_field solr_name("contributor", :facetable), label: "Contributor", limit: 5
    config.add_facet_field solr_name("keyword", :facetable), limit: 5
    # config.add_facet_field solr_name("subject", :facetable), limit: 5
    config.add_facet_field solr_name("language", :facetable), limit: 5
    # config.add_facet_field solr_name("based_near_label", :facetable), limit: 5
    config.add_facet_field solr_name("publisher", :facetable), limit: 5
    config.add_facet_field solr_name("file_format", :facetable), limit: 5
    config.add_facet_field solr_name('member_of_collections', :symbol), limit: 5, label: 'Collections'
    config.add_facet_field solr_name('creator_nested', :facetable), label: "Creator", limit: 5
    config.add_facet_field solr_name("subject_nested", :facetable), label: I18n.t('ebsco.fields.subject_nested'), limit: 5
    # config.add_facet_field solr_name("contributor_nested", :facetable), label: I18n.t('ebsco.fields.contributor_nested'), limit: 5
    config.add_facet_field solr_name('publication_year', :facetable), label: I18n.t('ebsco.fields.publication_year')
    config.add_facet_field solr_name('date_nested', :facetable), label: I18n.t('ebsco.fields.date_nested')    

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name("title", :stored_searchable), label: "Title", itemprop: 'name', if: false
    # config.add_index_field solr_name("description", :stored_searchable), itemprop: 'description', helper_method: :iconify_auto_link
    config.add_index_field solr_name("keyword", :stored_searchable), itemprop: 'keywords', link_to_search: solr_name("keyword", :facetable)
    # config.add_index_field solr_name("subject", :stored_searchable), itemprop: 'about', link_to_search: solr_name("subject", :facetable)
    # config.add_index_field solr_name("creator", :stored_searchable), itemprop: 'creator', link_to_search: solr_name("creator", :facetable)
    # config.add_index_field solr_name("contributor", :stored_searchable), itemprop: 'contributor', link_to_search: solr_name("contributor", :facetable)
    config.add_index_field solr_name("proxy_depositor", :symbol), label: "Depositor", helper_method: :link_to_profile
    config.add_index_field solr_name("depositor"), label: "Owner", helper_method: :link_to_profile
    config.add_index_field solr_name("publisher", :stored_searchable), itemprop: 'publisher', link_to_search: solr_name("publisher", :facetable)
    # config.add_index_field solr_name("based_near_label", :stored_searchable), itemprop: 'contentLocation', link_to_search: solr_name("based_near_label", :facetable)
    config.add_index_field solr_name("language", :stored_searchable), itemprop: 'inLanguage', link_to_search: solr_name("language", :facetable)
    config.add_index_field solr_name("date_uploaded", :stored_sortable, type: :date), itemprop: 'datePublished', helper_method: :human_readable_date
    config.add_index_field solr_name("date_modified", :stored_sortable, type: :date), itemprop: 'dateModified', helper_method: :human_readable_date
    config.add_index_field solr_name("date_created", :stored_searchable), itemprop: 'dateCreated'
    config.add_index_field solr_name("rights_statement", :stored_searchable), helper_method: :rights_statement_links
    config.add_index_field solr_name("license", :stored_searchable), helper_method: :license_links
    config.add_index_field solr_name("resource_type", :stored_searchable), label: "Resource Type", link_to_search: solr_name("resource_type", :facetable)
    config.add_index_field solr_name("file_format", :stored_searchable), link_to_search: solr_name("file_format", :facetable)
    # config.add_index_field solr_name("identifier", :stored_searchable), helper_method: :index_field_link, field_name: 'identifier'
    config.add_index_field solr_name("embargo_release_date", :stored_sortable, type: :date), label: "Embargo release date", helper_method: :human_readable_date
    config.add_index_field solr_name("lease_expiration_date", :stored_sortable, type: :date), label: "Lease expiration date", helper_method: :human_readable_date
    config.add_index_field solr_name("identifier_nested", :symbol), label: I18n.t('ebsco.fields.identifier_nested')
    config.add_index_field solr_name("creator_nested", :stored_searchable), label: "Creator", itemprop: 'creator', link_to_search: solr_name("creator_nested", :facetable)
    # config.add_index_field solr_name("contributor_nested", :stored_searchable), label: I18n.t('ebsco.fields.contributor_nested'), itemprop: 'contributor', link_to_search: solr_name("contributor_nested", :facetable)
    # config.add_index_field solr_name("rights_nested", :stored_searchable), label: I18n.t('ebsco.fields.rights_nested'), itemprop: 'rights', link_to_search: solr_name("rights_nested", :facetable)
    config.add_index_field solr_name("subject_nested", :stored_searchable), label: I18n.t('ebsco.fields.subject_nested'), itemprop: 'about', link_to_search: solr_name("subject_nested", :facetable)
    config.add_index_field solr_name("date_nested", :stored_searchable), label: I18n.t('ebsco.fields.date_nested'), itemprop: 'date', link_to_search: solr_name("date_nested", :facetable)
    # config.add_index_field solr_name("alt_identifier_nested", :stored_searchable), label: I18n.t('ebsco.fields.alt_identifier_nested'), itemprop: 'alt_identifier', link_to_search: solr_name("alt_identifier_nested", :facetable)
    config.add_index_field solr_name("description_nested", :stored_searchable), label: I18n.t('ebsco.fields.description_nested'), itemprop: 'description', link_to_search: solr_name("description_nested", :facetable)    
    config.add_index_field solr_name("funding_nested", :stored_searchable), label: I18n.t('ebsco.fields.funding_nested'), itemprop: 'funding', link_to_search: solr_name("funding_nested", :facetable)    
    config.add_index_field solr_name("related_identifier_nested", :stored_searchable), label: I18n.t('ebsco.fields.related_identifier_nested'), itemprop: 'related_identifier', link_to_search: solr_name("related_identifier_nested", :facetable)
    config.add_index_field solr_name("other_title", :stored_searchable), label: I18n.t('ebsco.fields.other_title')
    config.add_index_field solr_name("publication_year", :stored_searchable), label: I18n.t('ebsco.fields.publication_year')
    config.add_index_field solr_name("dataset_size", :stored_searchable), label: I18n.t('ebsco.fields.dataset_size')
    config.add_index_field solr_name("dataset_format", :stored_searchable), label: I18n.t('ebsco.fields.dataset_format')
    config.add_index_field solr_name("dataset_version", :stored_searchable), label: I18n.t('ebsco.fields.dataset_version')
    config.add_index_field solr_name("work_status", :stored_searchable), label: I18n.t('ebsco.fields.work_status')
    config.add_index_field solr_name("work_review_process", :stored_searchable), label: I18n.t('ebsco.fields.work_review_process')
    config.add_index_field solr_name("reviewers", :stored_searchable), label: I18n.t('ebsco.fields.reviewers')

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field solr_name("title", :stored_searchable)
    # config.add_show_field solr_name("description", :stored_searchable)
    config.add_show_field solr_name("keyword", :stored_searchable)
    # config.add_show_field solr_name("subject", :stored_searchable)
    # config.add_show_field solr_name("creator", :stored_searchable)
    # config.add_show_field solr_name("contributor", :stored_searchable)
    config.add_show_field solr_name("publisher", :stored_searchable)
    # config.add_show_field solr_name("based_near_label", :stored_searchable)
    config.add_show_field solr_name("language", :stored_searchable)
    config.add_show_field solr_name("format", :stored_searchable)    
    config.add_show_field solr_name("date_uploaded", :stored_searchable)
    config.add_show_field solr_name("date_modified", :stored_searchable)
    config.add_show_field solr_name("date_created", :stored_searchable)
    config.add_show_field solr_name("rights_statement", :stored_searchable)
    config.add_show_field solr_name("license", :stored_searchable)
    config.add_show_field solr_name("resource_type", :stored_searchable), label: "Resource Type"        
    # config.add_show_field solr_name("identifier", :stored_searchable)
    config.add_show_field solr_name('extent', :stored_searchable)
    config.add_show_field solr_name("identifier_nested", :displayable), label: I18n.t('ebsco.fields.identifier_nested')
    config.add_show_field solr_name("creator_nested", :displayable), label: "Creator"
    # config.add_show_field solr_name("contributor_nested", :displayable), label: I18n.t('ebsco.fields.contributor_nested')    
    config.add_show_field solr_name("subject_nested", :displayable), label: I18n.t('ebsco.fields.subject_nested')
    config.add_show_field solr_name("date_nested", :displayable), label: I18n.t('ebsco.fields.date_nested')
    # config.add_show_field solr_name("alt_identifier_nested", :displayable), label: I18n.t('ebsco.fields.alt_identifier_nested')
    # config.add_show_field solr_name("rights_nested", :displayable), label: I18n.t('ebsco.fields.rights_nested')
    config.add_show_field solr_name("description_nested", :displayable), label: I18n.t('ebsco.fields.description_nested')
    config.add_show_field solr_name("funding_nested", :displayable), label: I18n.t('ebsco.fields.funding_nested')
    config.add_show_field solr_name("related_identifier_nested", :displayable), label: I18n.t('ebsco.fields.related_identifier_nested')
    config.add_show_field solr_name("other_title", :displayable), label: I18n.t('ebsco.fields.other_title')
    config.add_show_field solr_name("publication_year", :stored_searchable), label: I18n.t('ebsco.fields.publication_year')
    config.add_show_field solr_name("dataset_size", :stored_searchable), label: I18n.t('ebsco.fields.dataset_size')
    config.add_show_field solr_name("dataset_format", :stored_searchable), label: I18n.t('ebsco.fields.dataset_format')
    config.add_show_field solr_name("dataset_version", :stored_searchable), label: I18n.t('ebsco.fields.dataset_version')
    config.add_show_field solr_name("work_status", :stored_searchable), label: I18n.t('ebsco.fields.work_status')
    config.add_show_field solr_name("work_review_process", :stored_searchable), label: I18n.t('ebsco.fielded.work_review_process')
    config.add_show_field solr_name("reviewers", :stored_searchable), label: I18n.t('ebsco.fields.reviewers')

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.
    #
    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.
    config.add_search_field('all_fields', label: 'All Fields', include_in_advanced_search: false) do |field|
      all_names = config.show_fields.values.map(&:field).join(" ")
      title_name = solr_name("title", :stored_searchable)
      field.solr_parameters = {
        qf: "#{all_names} file_format_tesim all_text_timv publication_year_tesim",
        pf: title_name.to_s
      }
    end

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.
    # creator, title, description, publisher, date_created,
    # subject, language, resource_type, format, identifier, based_near,
    # config.add_search_field('contributor') do |field|
    #   # solr_parameters hash are sent to Solr as ordinary url query params.
    #   field.solr_parameters = { "spellcheck.dictionary": "contributor" }

    #   # :solr_local_parameters will be sent using Solr LocalParams
    #   # syntax, as eg {! qf=$title_qf }. This is neccesary to use
    #   # Solr parameter de-referencing like $title_qf.
    #   # See: http://wiki.apache.org/solr/LocalParams
    #   solr_name = solr_name("contributor", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    # config.add_search_field('creator') do |field|
    #   field.solr_parameters = { "spellcheck.dictionary": "creator" }
    #   solr_name = solr_name("creator", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('title') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "title"
      }
      solr_name = solr_name("title", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('description') do |field|
    #   field.label = "Abstract or Summary"
    #   field.solr_parameters = {
    #     "spellcheck.dictionary": "description"
    #   }
    #   solr_name = solr_name("description", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('publisher') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "publisher"
      }
      solr_name = solr_name("publisher", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('date_created') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "date_created"
      }
      solr_name = solr_name("created", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('subject') do |field|
    #   field.solr_parameters = {
    #     "spellcheck.dictionary": "subject"
    #   }
    #   solr_name = solr_name("subject", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('language') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "language"
      }
      solr_name = solr_name("language", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('resource_type') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "resource_type"
      }
      solr_name = solr_name("resource_type", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('format') do |field|
      field.include_in_advanced_search = false
      field.solr_parameters = {
        "spellcheck.dictionary": "format"
      }
      solr_name = solr_name("format", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('identifier') do |field|
    #   field.include_in_advanced_search = false
    #   field.solr_parameters = {
    #     "spellcheck.dictionary": "identifier"
    #   }
    #   solr_name = solr_name("id", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('based_near_label') do |field|
      field.label = "Location"
      field.solr_parameters = {
        "spellcheck.dictionary": "based_near_label"
      }
      solr_name = solr_name("based_near_label", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('keyword') do |field|
      field.solr_parameters = {
        "spellcheck.dictionary": "keyword"
      }
      solr_name = solr_name("keyword", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('depositor') do |field|
      solr_name = solr_name("depositor", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('rights_statement') do |field|
      solr_name = solr_name("rights_statement", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('license') do |field|
      solr_name = solr_name("license", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('extent') do |field|
      solr_name = solr_name("extent", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('identifier_nested') do |field|
      solr_name = solr_name("identifier_nested", :symbol)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('creator_nested') do |field|
      solr_name = solr_name("creator_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('other_title') do |field|
      solr_name = solr_name("other_title", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('publication_year') do |field|
      solr_name = solr_name("publication_year", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('dataset_size') do |field|
      solr_name = solr_name("dataset_size", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('dataset_format') do |field|
      solr_name = solr_name("dataset_format", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('work_status') do |field|
      solr_name = solr_name("work_status", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('work_review_process') do |field|
      solr_name = solr_name("work_review_process", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('dataset_version') do |field|
      solr_name = solr_name("dataset_version", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end    

    config.add_search_field('subject_nested') do |field|
      solr_name = solr_name("subject_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    config.add_search_field('reviewers') do |field|
      solr_name = solr_name("reviewers", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end    

    config.add_search_field('description_nested') do |field|
      solr_name = solr_name("description_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('contributor_nested') do |field|
    #   solr_name = solr_name("contributor_nested", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('date_nested') do |field|
      solr_name = solr_name("date_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('alt_identifier_nested') do |field|
    #   solr_name = solr_name("alt_identifier_nested", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('related_identifier_nested') do |field|
      solr_name = solr_name("related_identifier_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end

    # config.add_search_field('rights_nested') do |field|
    #   solr_name = solr_name("rights_nested", :stored_searchable)
    #   field.solr_local_parameters = {
    #     qf: solr_name,
    #     pf: solr_name
    #   }
    # end

    config.add_search_field('funding_nested') do |field|
      solr_name = solr_name("funding_nested", :stored_searchable)
      field.solr_local_parameters = {
        qf: solr_name,
        pf: solr_name
      }
    end    

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # label is key, solr field is value
    config.add_sort_field "score desc, #{uploaded_field} desc", label: "relevance"
    config.add_sort_field "#{uploaded_field} desc", label: "date uploaded \u25BC"
    config.add_sort_field "#{uploaded_field} asc", label: "date uploaded \u25B2"
    config.add_sort_field "#{modified_field} desc", label: "date modified \u25BC"
    config.add_sort_field "#{modified_field} asc", label: "date modified \u25B2"

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  # This is overridden just to give us a JSON response for debugging.
  def show
    _, @document = fetch params[:id]
    render json: @document.to_h
  end
end
