class ManuscriptContentTypeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      valid_content_types = [
        'application/msword', 
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'application/vnd.apple.pages',
        'application/vnd.oasis.opendocument.text',
        'text/rtf',
        'text/plain'
      ]
  
      user_friendly_content_types = [
        'Word (.doc)', 
        'Word (.docx)', 
        'Pages', 
        'OpenDocument Text', 
        'Rich Text Format', 
        'Plain Text'
      ]
  
      if record.send(attribute).attached? && !valid_content_types.include?(record.send(attribute).blob.content_type)
        record.errors.add(attribute, :invalid_file_type, message: "It seems that you have attached the wrong file format. In most cases, this is because a writer has tried to upload a PDF file. We are unable to edit PDF format. We accept the following formats: #{user_friendly_content_types.join(', ')}.")
      end
    end
  end
  