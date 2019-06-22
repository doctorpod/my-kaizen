RSpec.shared_examples 'redirect home' do
  it 'returns http 302' do
    expect(response).to have_http_status(302)
  end

  it 'redirects to home page' do
    expect(response).to redirect_to('/')
  end
end
