class RelatedUrlLinksAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
  private
  def li_value(value)
    youtube_regex = /^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$/
    html = ''
    if youtube_regex.match?(value)
      html+= '<a href="'+value+'" onclick="return false;" class="open_youtube_modal" data-toggle="modal" data-target="#youtube_modal"> '+ value +'</a>'
    else
      html += '<a href="'+ value +'" rel="noopener" target="_blank">'+ value +'</a>'
    end
    %(#{html})
  end
end
