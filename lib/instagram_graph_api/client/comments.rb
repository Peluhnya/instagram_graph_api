module InstagramGraphApi
  class Client
    module Comments
      def get_comments(media_id)
        query = "comments"
        get_connections(media_id, query)
      end

      def get_comment(comment_id, fields = "hidden,id,like_count,media,text,timestamp,user,username,replies")
        get_object(comment_id, fields: fields)
      end

      def get_replies(comment_id)
        query = "replies"
        get_connections(comment_id, query)
      end

      def hide_comment(comment_id)
        query = "?hide=true"
        put_connections(comment_id, query)
      end

      def unhide_comment(comment_id)
        query = "?hide=false"
        put_connections(comment_id, query)
      end

      def recent_comment_count(business_account_id)
        comment_count = InstagramGraphApi::Client::Media::MEDIA_TYPES.sum do |media_type|
                          media = get_user_recent_media(business_account_id, type: media_type)
                          media.sum {|comment| comment["comments_count"]}
                        end
        
        comment_count
      end
    end
  end
end