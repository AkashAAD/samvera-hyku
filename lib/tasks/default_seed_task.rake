namespace :ebsco do
  require 'importers/dataset_importer'
  desc 'Seeds default data, It will read from specified file usage: bundle exec rake ebsco:default_seed_data["default_seed_data.json"]'
  task 'default_seed_data', [:seedfile] => :environment do |task, args|
    default_data_file = args.seedfile
    unless default_data_file.nil?
      seed_file = Rails.root.join("seed", default_data_file)
    else
      abort("***ERROR: missing default data seed file.***")
    end

    root_dir = File.dirname(seed_file)
    
    unless !File.exists?(seed_file)
      puts "Running seed_file: #{}"
    else
      abort("***ERROR: missing default data seed file into directory.***")
    end

    seed_data = JSON.parse(File.read(seed_file))

    ## Create the default requested users ##
    user_role = Role.where(name: 'user').first_or_create!
    admin_role = Role.where(name: 'admin').first_or_create!
    superadmin_role = Role.where(name: 'superadmin').first_or_create!    
    seed_data['users'].each do |user|
      new_user = { display_name: user['display_name'], email: user['email'], password: user['password'] }
      if user['role'].eql?('admin')
        user_role.users.create(new_user)
      elsif user['role'].eql?('superadmin')
        superadmin_role.users.create(new_user)
      elsif user['role'].eql?('user')
        admin_role.users.create(new_user)
      end
    end

    # Select superadmin
    superadmin = User.second

    # Create Tenent
    seed_data['tenent_repositories'].each do |tenent_repository|
      account = Account.new(name: tenent_repository['repository'])
      create_account = CreateAccount.new(account).save
    end

    tenants = Account.all.pluck(:tenant)

    # Create tenant users.
    tenants.each_with_index do |tenent, index|
      ActiveRecord::Base.connection.schema_search_path = "'" + tenent.to_s + "'"
      user_role = Role.where(name: 'user').first_or_create!
      admin_role = Role.where(name: 'admin').first_or_create!
      reviewer_role = Role.where(name: 'reviewer').first_or_create!      
      seed_data["tenent_users"][index.to_s].each_with_index do |ten_usr, index|
        if ten_usr['role'].eql?('user')
          user_role.users.create({ display_name: ten_usr['display_name'], email: ten_usr['email'], password: ten_usr['password'] })
        elsif ten_usr['role'].eql?('admin')
          admin_role.users.create({ display_name: ten_usr['display_name'], email: ten_usr['email'], password: ten_usr['password'] })
        elsif ten_usr['role'].eql?('reviewer')
          reviewer_role.users.create({ display_name: ten_usr['display_name'], email: ten_usr['email'], password: ten_usr['password'] })            
        end
      end
    end

    ## Create the default site text ##

    seed_data["site_text"].each do |key, array|
      html = array.join("")
      if key == "marketing"
        marketing_text = ContentBlock.where(name: "marketing_text").first_or_create!
        marketing_text.value=html
        marketing_text.save!
      elsif key == "about"
        about_page = ContentBlock.where(name: "about_page").first_or_create!
        about_page.value=html
        about_page.save!
      end
    end

    Hyrax::Workflow::WorkflowImporter.load_workflows
    ## Create Administrative Sets ##
    # administrative_sets = {}
    # if seed.has_key?("administrative_sets")
    #   seed["administrative_sets"].each do |administrative_set|
    #     arguments = {}
    #     administrative_set["metadata"].each do |key, val|
    #       arguments[key.to_sym] = val
    #     end

    #     as = AdminSet.where(id: administrative_set["id"]).first || AdminSet.create!(
    #       id: administrative_set["id"],
    #       **arguments)

    #     if administrative_set.has_key?("permission_template")
    #       pt = Hyrax::PermissionTemplate
    #                .where(admin_set_id: administrative_set["id"])
    #                .first_or_create!

    #       if administrative_set["permission_template"].has_key?("permission_template_access")
    #         administrative_set["permission_template"]["permission_template_access"].each do |pta|
    #           Hyrax::PermissionTemplateAccess
    #               .where(permission_template: pt,
    #                      agent_type: pta["agent_type"],
    #                      agent_id: pta["agent_id"],
    #                      access: pta["access"])
    #               .first_or_create!
    #         end
    #       end
    #     end

    #     administrative_sets[administrative_set["id"]] = as
    #   end
    # end
    ## Create default collections
    depositors = ['first_user_tenant@ebsco.com', 'second_user_tenant@ebsco.com']
    cols = {}
    tenants.each_with_index do |tenent, index|
      ActiveRecord::Base.connection.schema_search_path = "'" + tenent.to_s + "'"
      
      #Create collection type for each tenent
      default = Hyrax::CollectionType.find_or_create_default_collection_type
      default_collection_type = Hyrax::CollectionType.all.first
      #End
      depositor = User.find_by_email(depositors[index])

      if seed_data.has_key?('collections')
        seed_data["collections"].each do |collection|
          arguments = {}
          collection["metadata"].each do |key, val|
            arguments[key.to_sym] = val
          end
          # col = Collection.where(id: collection["id"]).first || Collection.create!(
          #     id: collection["id"],
          #     edit_users: [depositor],
          #     depositor: depositor.email,
          #     visibility: 'public',
          #     collection_type_gid: default_collection_type.gid,
          #     **arguments
          # )
          @collection = ::Collection.new
          @collection.collection_type_gid = default_collection_type.gid
          @collection.attributes = arguments
          @collection.apply_depositor_metadata(depositor.email)
          @collection.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE unless @collection.discoverable?
          @collection.save
          @collection.update_index
          cols[collection["id"]] = @collection
        end
      end
    end
    ## End default collections

    ## Create default works
    if seed_data.has_key?("works")
      tenants.each_with_index do |tenent, index|  
        ActiveRecord::Base.connection.schema_search_path = "'" + tenent.to_s + "'"
        depositor = User.find_by_email(depositors[index])
        seed_data["works"].each do |work|
          arguments = {}
          work["metadata"].each do |key, val|
            arguments[key.to_sym] = val
          end

          # first create the work
          new_work = Dataset.where(id: work["id"]).first || Dataset.create!(
            id: work["id"],
            edit_users: [depositor],
            depositor: depositor.email,
            **arguments
          )

          # then add any files
          if work.has_key?("files")
            work["files"].each do |file|
              fargs = {}
              file["metadata"].each do |key, val|
                fargs[key.to_sym] = val
              end

              fileset_id = "#{new_work.id}-#{file['id']}"
              label = File.basename(file["path"])
              fileset = FileSet.where(id: fileset_id).first || FileSet.create!(
                  id: fileset_id,
                  label: label,
                  title: ["Fileset #{fileset_id} - #{label}"],
                  edit_users: [depositor],
                  depositor: depositor.email,
                  **fargs
              )

              unless new_work.members.include?(fileset)
                # NB ordered_members is important here; members will not appear in blacklight!
                new_work.ordered_members << fileset
                fileset.save!
              end
              # unless fileset.files.any?
              #   Hydra::Works::UploadFileToFileSet.call(fileset, open(File.join(root_dir, file["path"])))
              #   CharacterizeJob.perform_now(fileset, fileset.files.first.id)
              # end

              # unless new_work.representative_id.present?
              #   new_work.representative_id = fileset.id
              #   new_work.thumbnail_id = fileset.thumbnail_id
              #   new_work.save!
              # end
            end
          end
          
          # then add to any collections
          if work.has_key?("collections")
            work["collections"].each do |collection_id|
              collection = cols[collection_id]
              unless collection.members.include?(new_work)
                collection.ordered_members << new_work
                collection.save!
              end
            end
          end

          # feature the work if requested
          if work.has_key?("featured") && work["featured"] == true
            FeaturedWork.where(work_id: work["id"]).first_or_create!
          end
          new_work.save!
          dataset_importer = Importers::DatasetImporter.new(root_dir)
          # dataset_importer.perform_create
        end
      end
    end
    ## finished creating works
  end
end
