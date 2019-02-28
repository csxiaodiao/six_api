require "six_api/version"
require 'rest-client'
require 'json'

module SixApi
  module Api
    class Configuration
      attr_accessor :site_id, :api_key, :post_url

      def initialize
        @site_id = ''
        @api_key = ''
        @post_url = ''
      end
    end

    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def create_art_payload(**opt)
        payload = {
          api_key: configuration.api_key,
          site_id: configuration.site_id,
          id: opt[:id],
          title: opt[:title],
          seo_title: opt[:seo_title],
          keywords: opt[:keywords],
          description: opt[:description],
          filename: opt[:filename],
          content: opt[:content],
          logo: opt[:logo],
          addtime: opt[:addtime],
          cat_id: opt[:cat_id],
          release: opt[:release],
          type: 'article'
        }.compact

        payload
      end

      # push article to six
      def push_six_art(content)
        payload =  create_art_payload(content)
        single_sender(payload)
      end

      def single_sender(payload)
        response = RestClient.post(configuration.post_url, payload)
      end


    end

  end
end
