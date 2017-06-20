module SparkPostRails
  class DeliveryMethod
    def prepare_inline_content_from mail, sparkpost_data
      if mail.multipart?
        if mail.html_part
          @data[:content][:html] = cleanse_encoding(mail.html_part.body.to_s)
        end

        if mail.text_part
          @data[:content][:text] = cleanse_encoding(mail.text_part.body.to_s)
        end
      else
        # monkeypatch a safe navigator if html_content_only is not present
        if SparkPostRails.try(:configuration).try(:html_content_only) || sparkpost_data[:html_content_only]
          @data[:content][:html] = cleanse_encoding(mail.body.to_s)
        else
          @data[:content][:text] = cleanse_encoding(mail.body.to_s)
        end
      end
    end
  end
end
