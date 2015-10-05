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

get '/contacts/search/:search_term' do
  contacts = Contact.where("firstname LIKE ? OR lastname LIKE ? OR email LIKE ?", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%")
  contacts.to_json
end

get '/contacts/:id' do
  contact = Contact.find(params[:id])
  contact.to_json
end

delete '/contacts/:id' do
  response = Hash.new
  response[:result] = false
  if contact = Contact.find(params[:id])
    contact.destroy
    response[:result] =true
    response[:id] = contact.id
  end
end