# Generated via
#  `rails generate hyrax:work Dataset`

RSpec.describe Dataset, :vcr do
  it 'has human readable type dataset' do
    @obj = build(:dataset)
    expect(@obj.human_readable_type).to eq('Dataset')
  end

  describe 'title' do
    it 'requires title' do
      @obj = build(:dataset, title: nil)
      expect{ @obj.save! }.to raise_error(ActiveFedora::RecordInvalid, 'Validation failed: Title Your dataset work must have a title.')
    end
    it 'has a multi valued title field' do
      @obj = build(:dataset, title: ['test work title'])
      expect(@obj.title).to eq ['test work title']
    end
  end

  describe 'publication_year' do
    it 'has a single valued publication_year' do
      @obj = build(:dataset, publication_year: '01/2018')
      expect(@obj.publication_year).to eq '01/2018'
    end
  end

  describe 'dataset_size' do
    it 'has a single valued dataset_size' do
      @obj = build(:dataset, dataset_size: "10KB")
      expect(@obj.dataset_size).to eq '10KB'
    end
  end

  describe 'dataset_version' do
    it 'has a single valued dataset_version' do
      @obj = build(:dataset, dataset_version: 'V1.0')
      expect(@obj.dataset_version).to eq 'V1.0'
    end
  end

  describe 'dataset_format' do
    it 'has a single valued dataset_format' do
      @obj = build(:dataset, dataset_format: 'jpg')
      expect(@obj.dataset_format).to eq 'jpg'
    end
  end

  describe 'nested attributes for other_title' do
    it 'accept other title attributes' do
      @obj = build(:dataset, other_title_attributes: [{
          title: 'Other title',
          title_type: 'Other title type'
        }]
      )
      expect(@obj.other_title.first.title).to eq ['Other title']
      expect(@obj.other_title.first.title_type).to eq ['Other title type']
    end
    it 'has the correct uri' do
      @obj = build(:dataset, other_title_attributes: [{
          title: 'Other title',
          title_type: 'Other title type'
        }]
      )
      expect(@obj.other_title.first.id).to include('#other_title')
    end
    it 'reject other title attributes if title is blank' do
      @obj = build(:dataset, other_title_attributes: [{
            title: 'Other title',
            title_type: 'Other title type'
          },
          { title: "A second title" },
          { title_type: 'A third title' }
        ]
      )
      expect(@obj.other_title.size).to eq(2)
    end

    it 'destroys other titles' do
      @obj = build(:dataset, other_title_attributes: [{
          title: 'Other title',
          title_type: 'Other title type'
        }]
      )
      expect(@obj.other_title.size).to eq(1)
      @obj.attributes = {
        other_title_attributes: [{
          id: @obj.other_title.first.id,
          title: 'Other title',
          title_type: 'Other title type',
          _destroy: "1"
        }]
      }
      expect(@obj.other_title.size).to eq(0)
    end

    it 'indexes the other title' do
      @obj =  build(:dataset, other_title_attributes: [{
          title: 'Other title',
          title_type: 'Other title type'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('other_title_tesim')
      expect(@doc['other_title_tesim']).to eq ['Other title']
    end
  end

  describe 'nested attributes for subject' do
    it 'accept subject attributes' do
      @obj = build(:dataset, subject_nested_attributes: [{
          subject: 'Computer Science'
          # subject_scheme: 'cs scheme',
          # scheme_uri: 'www.cs.com',
          # value_uri: 'www.cs-value.com'
        }]
      )
      expect(@obj.subject_nested.first.subject).to eq ['Computer Science']
      # expect(@obj.subject_nested.first.subject_scheme).to eq ['cs scheme']
      # expect(@obj.subject_nested.first.scheme_uri).to eq ['www.cs.com']
      # expect(@obj.subject_nested.first.value_uri).to eq ['www.cs-value.com']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, subject_nested_attributes: [{
          subject: 'Computer Science'
          # subject_scheme: 'cs scheme',
          # scheme_uri: 'www.cs.com',
          # value_uri: 'www.cs-value.com'          
        }]
      )
      expect(@obj.subject_nested.first.id).to include('#subject')
    end

    # it 'reject subject attributes if subject_scheme is blank' do
    #   @obj = build(:dataset, subject_nested_attributes: [{
    #       subject: 'Computer Science'
    #       # subject_scheme: 'cs scheme',
    #       # scheme_uri: 'www.cs.com',
    #       # value_uri: 'www.cs-value.com'
    #     },{
    #       subject: 'Computer Science'
    #       # subject_scheme: '',
    #       # scheme_uri: 'www.cs.com',
    #       # value_uri: 'www.cs-value.com'
    #     }]
    #   )
    #   expect(@obj.subject_nested.size).to eq(1)
    # end

    it 'destroy subject' do
      @obj = build(:dataset, subject_nested_attributes: [{
          subject: 'Computer Science'
          # subject_scheme: 'cs scheme',
          # scheme_uri: 'www.cs.com',
          # value_uri: 'www.cs-value.com'
        }]
      )
      expect(@obj.subject_nested.size).to eq(1)
      @obj.attributes = {
        subject_nested_attributes: [{
          id: @obj.subject_nested.first.id,
          subject: 'Computer Science',
          # subject_scheme: 'cs scheme',
          # scheme_uri: 'www.cs.com',
          # value_uri: 'www.cs-value.com',
          _destroy: "1"
        }]
      }
      expect(@obj.subject_nested.size).to eq(0)
    end

    it 'indexes the subject' do
      @obj = build(:dataset, subject_nested_attributes: [{
          subject: 'Computer Science'
          # subject_scheme: 'cs scheme',
          # scheme_uri: 'www.cs.com',
          # value_uri: 'www.cs-value.com'        
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('subject_nested_tesim')
      expect(@doc['subject_nested_tesim']).to eq ['Computer Science']
    end
  end

  describe 'nested attributes for identifiers' do
    it 'accept identifiers attributes' do
      @obj = build(:dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1'
        }]
      )
      expect(@obj.identifier_nested.first.obj_id_scheme).to eq ['Obj Scheme']
      expect(@obj.identifier_nested.first.obj_id).to eq ['Obj 1']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1'
        }]
      )
      expect(@obj.identifier_nested.first.id).to include('#identifier')
    end

    it 'rejects identifier attributes if obj_id or obj_id_scheme is blank' do
      @obj = build(:dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1'
        },{
          obj_id_scheme: 'second Obj Scheme',
          obj_id: ''
        },{
          obj_id_scheme: '',
          obj_id: 'Obj 3'
        }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
    end

    it 'destroy identifier nested' do
      @obj = build(:dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1'
        }]
      )
      expect(@obj.identifier_nested.size).to eq(1)
      @obj.attributes = {
        identifier_nested_attributes: [{
          id: @obj.identifier_nested.first.id,
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1',
          _destroy: '1'
        }]
      }
      expect(@obj.identifier_nested.size).to eq(0)
    end

    it 'indexes the identifier nested' do
      @obj = build(:dataset, identifier_nested_attributes: [{
          obj_id_scheme: 'Obj Scheme',
          obj_id: 'Obj 1',          
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('identifier_nested_ssm')
      expect(@doc['identifier_nested_ssim']).to eq ["Obj 1"]
    end
  end

  describe 'nested attributes for creators' do
    it 'accept creators attributes' do
      @obj = build(:dataset, creator_nested_attributes: [{
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }]
      )
      # expect(@obj.creator_nested.first.creator_first_name).to eq ['John']
      # expect(@obj.creator_nested.first.creator_last_name).to eq ['Doe']
      expect(@obj.creator_nested.first.name).to eq ['John Doe']
      expect(@obj.creator_nested.first.orcid).to eq ['ORC 1']
      expect(@obj.creator_nested.first.role).to eq ['administrator']
      expect(@obj.creator_nested.first.creator_affiliation).to eq ['Affiliation']
      # expect(@obj.creator_nested.first.creator_scheme_uri).to eq ['www.schemeuri.com']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, creator_nested_attributes: [{
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'          
        }]
      )
      expect(@obj.creator_nested.first.id).to include('#person')
    end
    it 'reject creator if name, role, orcid, creator_affiliation are blank' do
      @obj = build(:dataset, creator_nested_attributes: [{
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: '',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }, {
          # creator_first_name: '',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: '',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }, {
          # creator_first_name: 'John',
          # creator_last_name: '',
          name: '',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }, {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: '',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }, {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: '',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        }, {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: '',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        },  {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: ''
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'
        },   {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: '',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: '',
          # creator_name_identifier: 'John Doe'
        },  {
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: ''
        }]
      )
      expect(@obj.creator_nested.size).to eq(1)
    end

    it 'destroy creator nested attributes' do
      @obj = build(:dataset, creator_nested_attributes: [{
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'          
        }]
      )
      expect(@obj.creator_nested.size).to eq(1)
      @obj.attributes = {
        creator_nested_attributes: [{
          id: @obj.creator_nested.first.id,
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation',
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe',
          _destroy: '1'
        }]
      }
      expect(@obj.creator_nested.size).to eq(0)
    end

    it 'indexes the creator nested' do
      @obj = build(:dataset, creator_nested_attributes: [{
          # creator_first_name: 'John',
          # creator_last_name: 'Doe',
          name: 'John Doe',
          orcid: 'ORC 1',
          role: 'administrator',
          creator_affiliation: 'Affiliation'
          # creator_scheme_uri: 'www.schemeuri.com',
          # creator_name_identifier: 'John Doe'          
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('creator_nested_tesim')
      expect(@doc['creator_nested_tesim']).to eq ["John Doe ORC 1"]
    end
  end

  describe 'nested attributes for related identifiers' do
    it 'accept related identifiers attributes' do
      @obj = build(:dataset, related_identifier_nested_attributes: [{
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }]
      )
      expect(@obj.related_identifier_nested.first.related_identifier).to eq ['Alt id 1']
      expect(@obj.related_identifier_nested.first.related_identifier_type).to eq ['EAN13']
      expect(@obj.related_identifier_nested.first.relation_type).to eq ['HasVersion']
      # expect(@obj.related_identifier_nested.first.related_metadata_scheme).to eq ['meta_schema']
      # expect(@obj.related_identifier_nested.first.scheme_uri).to eq ['www.schemeuri.com']
      # expect(@obj.related_identifier_nested.first.scheme_type).to eq ['manager']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, related_identifier_nested_attributes: [{
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }]
      )
      expect(@obj.related_identifier_nested.first.id).to include('#rel_identifier')
    end

    it 'reject related identifier if related_identifier_type or related_identifier are blank' do
      @obj = build(:dataset, related_identifier_nested_attributes: [{
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }, {
          related_identifier: '',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }, {
          related_identifier: 'Alt id 1',
          related_identifier_type: '',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }]
      )
      expect(@obj.related_identifier_nested.size).to eq(1)
    end

    it 'destroy related identifier nested attributes' do
      @obj = build(:dataset, related_identifier_nested_attributes: [{
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }]
      )
      expect(@obj.related_identifier_nested.size).to eq(1)
      @obj.attributes = {
        related_identifier_nested_attributes: [{
          id: @obj.related_identifier_nested.first.id,
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion',
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager',
          _destroy: '1'
        }]
      }
      expect(@obj.related_identifier_nested.size).to eq(0)         
    end

    it 'indexes the related identifier nested' do
      @obj = build(:dataset, related_identifier_nested_attributes: [{
          related_identifier: 'Alt id 1',
          related_identifier_type: 'EAN13',
          relation_type: 'HasVersion'
          # related_metadata_scheme: 'meta_schema',
          # scheme_uri: 'www.schemeuri.com',
          # scheme_type: 'manager'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('related_identifier_nested_tesim')
      expect(@doc['related_identifier_nested_tesim']).to eq ["Alt id 1"]          
    end
  end

  describe 'nested attributes for description' do
    it 'accept description attributes' do
      @obj = build(:dataset, description_nested_attributes: [{
          description: 'The work is related to the matter.',
          description_type: 'Methods'
        }]
      )
      expect(@obj.description_nested.first.description).to eq ['The work is related to the matter.']
      expect(@obj.description_nested.first.description_type).to eq ['Methods']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, description_nested_attributes: [{
          description: 'The work is related to the matter.',
          description_type: 'Methods'
        }]
      )
      expect(@obj.description_nested.first.id).to include('#description')
    end

    it 'reject nested description if description is blank' do
      @obj = build(:dataset, description_nested_attributes: [{
          description: 'The work is related to the matter.',
          description_type: 'Methods'
        }, {
          description: '',
          description_type: 'Methods'
        }]
      )
      expect(@obj.description_nested.size).to eq(1)
    end

    it 'destroy nested description attributes' do
      @obj = build(:dataset, description_nested_attributes: [{
          description: 'The work is related to the matter.',
          description_type: 'Methods'
        }]
      )
      expect(@obj.description_nested.size).to eq(1)
      @obj.attributes = {
        description_nested_attributes: [{
          id: @obj.description_nested.first.id,
          description: 'The work is related to the matter.',
          description_type: 'Methods',
          _destroy: '1'
        }]
      }
      expect(@obj.description_nested.size).to eq(0)      
    end

    it 'indexes the description nested' do
      @obj = build(:dataset, description_nested_attributes: [{
          description: 'The work is related to the matter.',
          description_type: 'Methods'    
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('description_nested_tesim')
      expect(@doc['description_nested_tesim']).to eq ['The work is related to the matter.']
    end
  end

  describe 'nested attributes for funding' do
    it 'accept funding attributes' do
      @obj = build(:dataset, funding_nested_attributes: [{
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }]
      )
      expect(@obj.funding_nested.first.funding_reference).to eq ['A. J. Dev']
      expect(@obj.funding_nested.first.funder_name).to eq ['N. O. Poet']
      expect(@obj.funding_nested.first.funder_identifier).to eq ['id 12']
      expect(@obj.funding_nested.first.funder_identifier_type).to eq ['GRID']
      expect(@obj.funding_nested.first.award_number).to eq ['AWD 12']
      expect(@obj.funding_nested.first.award_uri).to eq ['www.awd.com']
      expect(@obj.funding_nested.first.award_title).to eq ['Representative Honor Award']
    end

    it 'has the correct uri' do
      @obj = build(:dataset, funding_nested_attributes: [{
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }]
      )
      expect(@obj.funding_nested.first.id).to include('#funding')
    end

    it 'reject nested funding if funding_reference or funder_name is blank' do
      @obj = build(:dataset, funding_nested_attributes: [{
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }, {
          funding_reference: '',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }, {
          funding_reference: 'A. J. Dev',
          funder_name: '',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }]
      )
      expect(@obj.funding_nested.size).to eq(1)
    end

    it 'destroy nested funding attributes' do
      @obj = build(:dataset, funding_nested_attributes: [{
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award'
        }]
      )
      expect(@obj.funding_nested.size).to eq(1)
      @obj.attributes = {
        funding_nested_attributes: [{
          id: @obj.funding_nested.first.id,
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award',
          _destroy: '1'
        }]
      }
      expect(@obj.funding_nested.size).to eq(0)      
    end

    it 'indexes the description nested' do
      @obj = build(:dataset, funding_nested_attributes: [{
          funding_reference: 'A. J. Dev',
          funder_name: 'N. O. Poet',
          funder_identifier: 'id 12',
          funder_identifier_type: 'GRID',
          award_number: 'AWD 12',
          award_uri: 'www.awd.com',
          award_title: 'Representative Honor Award' 
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('funding_nested_tesim')
      expect(@doc['funding_nested_tesim']).to eq ['A. J. Dev']
    end
  end

  describe 'nested attributes for geolocation' do
    it 'accept geolocation attributes' do
      @obj = build(:dataset, geolocation_nested_attributes: [{
          geolocation: 'NYK'
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }]
      )
      expect(@obj.geolocation_nested.first.geolocation).to eq ['NYK']
      # expect(@obj.geolocation_nested.first.geolocation_point).to eq ['302, NYK']
      # expect(@obj.geolocation_nested.first.point_longitude).to eq ['223.21']
      # expect(@obj.geolocation_nested.first.point_latitude).to eq ['128.12']
      # expect(@obj.geolocation_nested.first.geo_location_box).to eq ['Geo, NYK']
      # expect(@obj.geolocation_nested.first.west_bound_longitude).to eq ['219.08']
      # expect(@obj.geolocation_nested.first.east_bound_longitude).to eq ['129.07']
      # expect(@obj.geolocation_nested.first.south_bound_latitude).to eq ['321.29']
      # expect(@obj.geolocation_nested.first.north_bound_latitude).to eq ['111.67']
      # expect(@obj.geolocation_nested.first.geolocation_place).to eq ['Geo place']
      # expect(@obj.geolocation_nested.first.geolocation_polygon).to eq ['Poly place']
      # expect(@obj.geolocation_nested.first.polygon_point).to eq ['Poly Point']
      # expect(@obj.geolocation_nested.first.in_polygon_point).to eq ['23.12']      
    end

    it 'has the correct uri' do
      @obj = build(:dataset, geolocation_nested_attributes: [{
          geolocation: 'NYK'
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }]
      )
      expect(@obj.geolocation_nested.first.id).to include('#geolocation')
    end

    it 'reject nested geolocation if geolocation is blank' do
      @obj = build(:dataset, geolocation_nested_attributes: [{
          geolocation: 'NYK'
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }, {
          geolocation: ''
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }]
      )
      expect(@obj.geolocation_nested.size).to eq(1)
    end

    it 'destroy nested description attributes' do
      @obj = build(:dataset, geolocation_nested_attributes: [{
          geolocation: 'NYK'
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }]
      )
      expect(@obj.geolocation_nested.size).to eq(1)
      @obj.attributes = {
        geolocation_nested_attributes: [{
          id: @obj.geolocation_nested.first.id,
          geolocation: 'NYK',
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12',
          _destroy: '1'
        }]
      }
      expect(@obj.geolocation_nested.size).to eq(0)      
    end

    it 'indexes the description nested' do
      @obj = build(:dataset, geolocation_nested_attributes: [{
          geolocation: 'NYK'
          # geolocation_point: '302, NYK',
          # point_longitude: '223.21',
          # point_latitude: '128.12',
          # geo_location_box: 'Geo, NYK',
          # west_bound_longitude: '219.08',
          # east_bound_longitude: '129.07',
          # south_bound_latitude: '321.29',
          # north_bound_latitude: '111.67',
          # geolocation_place: 'Geo place',
          # geolocation_polygon: 'Poly place',
          # polygon_point: 'Poly Point',
          # in_polygon_point: '23.12'
        }]
      )
      @doc = @obj.to_solr
      expect(@doc).to include('geolocation_nested_tesim')
      expect(@doc['geolocation_nested_tesim']).to eq ['NYK']
    end
  end

end
