# Homepage (Root path)
get '/' do
  erb :index
end

get '/contacts' do
  Contact.all.to_json
end

post '/contacts/create' do
  response = Hash.new
  response[:result] = false
  contact = Contact.new(firstname: params[:firstname], lastname: params[:lastname], email: params[:email])

  if contact.save
    response[:result] = true
    response[:id] = contact.id
  end

  response.to_json
end

get '/contacts/search' do
  search_term = params[:search_term];
  contacts = Contact.where("firstname LIKE ? OR lastname LIKE ? OR email LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  contacts.to_json
end

get '/contacts/:contact_id' do
  contact = Contact.find(params[:contact_id])
  contact.to_json
end

delete '/contacts/:contact_id' do
  response = Hash.new
  response[:result] = false
  if contact = Contact.find(params[:contact_id])
    response[:id] = contact.id
    contact.destroy
    response[:result] =true
  end

  response.to_json
end