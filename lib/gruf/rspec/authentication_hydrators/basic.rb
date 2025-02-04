# Copyright (c) 2018-present, BigCommerce Pty. Ltd. All rights reserved
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'base64'

module Gruf
  module Rspec
    module AuthenticationHydrators
      ##
      # Automatically hydrate request metadata with basic authentication options
      #
      class Basic < ::Gruf::Rspec::AuthenticationHydrators::Base
        ##
        # @param [Hash] metadata The incoming request metadata
        # @return [Hash] The hydrated metadata
        #
        def hydrate(metadata)
          username = auth_opts.fetch(:username, '')
          password = auth_opts.fetch(:password, '')
          auth_string = username.to_s.empty? ? password : "#{username}:#{password}"
          metadata[auth_opts.fetch(:header_key, 'authorization').to_s] = "Basic #{::Base64.encode64(auth_string)}" unless auth_string.empty?
          metadata
        end

        private

        def auth_opts
          @auth_opts ||= @options.fetch(:authentication_options, {})
        end
      end
    end
  end
end
