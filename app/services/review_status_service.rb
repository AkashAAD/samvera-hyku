class ReviewStatusService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('review_status_types')

  def self.select_all_options
    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.label(id)
    authority.find(id).fetch('term')
  end  
end
