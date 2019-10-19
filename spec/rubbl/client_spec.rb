RSpec.describe Rubbl::Client do
  describe '#auth_params' do
    context 'when an api key is provided' do
      let(:client) { Rubbl::Client.new('foobar') }

      it 'includes it' do
        expect(client.auth_params).to eq({ user: 'foobar', pass: 'api_token' })
      end
    end

    context 'when an api key is not provided' do
      let(:client) { Rubbl::Client.new('') }

      it 'excludes it' do
        expect(client.auth_params).to eq({ user: '', pass: 'api_token' })
      end
    end
  end

  describe '#get' do
    let(:client) { Rubbl::Client.new('foobar') }

    context 'valid request' do
      it 'has a success response code' do
        VCR.use_cassette("client_get_valid") do
          response = client.get('https://www.example.org/')
          expect(response.code).to eq(200)
        end
      end
    end

    context 'invalid request' do
      it 'has a non-success response code' do
        VCR.use_cassette('client_get_invalid') do
          response = client.get('https://www.example.org/notfound')
          expect(response.code).to eq(404)
        end
      end
    end

    context 'with query params' do
      it 'includes them in the URI' do
        VCR.use_cassette('client_get_with_query') do
          response = client.get('https://www.example.org/', foo: 'bar')
          expect(response.uri.to_s).to eq('https://www.example.org/?foo=bar')
        end
      end
    end

    context 'without query params' do
      it 'does not include them in the URI' do
        VCR.use_cassette('client_get_no_query') do
          response = client.get('https://www.example.org/')
          expect(response.uri.to_s).to eq('https://www.example.org/')
        end
      end
    end
  end

  describe '#post' do
    let(:client) { Rubbl::Client.new('foobar') }
    context 'valid request' do
      it 'has a success response code' do
        VCR.use_cassette('client_post_success') do
          response = client.post(
            'https://jsonplaceholder.typicode.com/posts/',
            { title: 'hello world', body: 'hello world', userId: 1 }
          )
          expect(response.code).to eq(201)
        end
      end
    end

    context 'invalid request' do
      it 'has a non-success response code' do
        VCR.use_cassette('client_post_no_success') do
          response = client.post(
            'https://jsonplaceholder.typicode.com/notfounds/',
            { title: 'hello world', body: 'hello world', userId: 1 }
          )
          expect(response.code).to eq(404)
        end
      end
    end
  end
end
