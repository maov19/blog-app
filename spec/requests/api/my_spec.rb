require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
  after do |example|
    content = example.metadata[:response][:content] || {}
    example_spec = {
      "application/json" => {
        examples: {
          test_example: {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
    example.metadata[:response][:content] = content.deep_merge(example_spec)
  end

  path '/api/users/{user_id}/posts' do
    get 'List all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true

      response '200', 'OK' do
        schema type: :array,
          items: { '$ref' => '#/components/schemas/Post' }


        run_test!
      end
    end
  end

  path '/api/users/{user_id}/posts/{post_id}/comments' do
    get 'List all comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true
      parameter name: :post_id, in: :path, type: :integer, required: true

      response '200', 'OK' do
        schema type: :array,
          items: { '$ref' => '#/components/schemas/Comment' }


        run_test!
      end
    end
  end

  path '/api/users/{user_id}/posts/{post_id}/comments' do
    post 'Add a comment to a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true
      parameter name: :post_id, in: :path, type: :integer, required: true
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Created' do

        run_test!
      end
    end
  end
end
