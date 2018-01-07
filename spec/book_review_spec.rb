require 'rails_helper'

feature "Trabajo: Asociación de modelos e identificación de usuarios" do

  before :all do
    $continue = true
  end

  around :each do |example|
    if $continue
      $continue = false 
      example.run 
      $continue = true unless example.exception
    else
      example.skip
    end
  end

  #helper method to determine if Ruby class exists as a class
  def class_exists?(class_name)
    eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
  end

  #helper method to determine if two files are the same
  def files_same?(file1, file2) 
    if (File.size(file1) != File.size(file2)) then
      return false
    end
    f1 = IO.readlines(file1)
    f2 = IO.readlines(file2)
    if ((f1 - f2).size == 0) then
      return true
    else
      return false
    end
  end

  context "Req01" do
    
    context "Genera aplicación Rails" do
      it "debe tener la estructura adecuada" do
        expect(File.exists?("Gemfile")).to be(true)
        expect(Dir.entries(".")).to include("app", "bin", "config", "db", "lib", "public", "log", "test", "vendor")
        expect(Dir.entries("./app")).to include("assets", "controllers", "helpers", "mailers", "models", "views")        
      end
    end
    
  end

  context "Req02" do
    
    context "El Scaffold generado" do
      it "debe tener un controlador books y la vista index" do 
        expect(Dir.entries("./app/controllers")).to include("books_controller.rb")
        expect(Dir.entries("./app/views/")).to include("books")
        expect(Dir.entries("./app/views/books")).to include("index.html.erb")
      end
    end
    
    context "El modelo Book" do
      it "es implementado en la clase Book" do
        expect(class_exists?("Book"))
        expect(Book < ActiveRecord::Base).to eq(true)
      end
    end
    
    context "La clase Book contiene las propiedades establecidas" do
      subject(:books) { Book.new }
      it { is_expected.to respond_to(:name) } 
      it { is_expected.to respond_to(:author) }
      it { is_expected.to respond_to(:reviewer) } 
      it { is_expected.to respond_to(:image) }
      it { is_expected.to respond_to(:created_at) } 
      it { is_expected.to respond_to(:updated_at) } 
    end
    
    context "La tabla 'book'" do 
      it "contiene la estructura adecuada" do
        expect(Book.column_names).to include "name", "author"
        expect(Book.attribute_types["name"].type).to eq :string
        expect(Book.attribute_types["author"].type).to eq :string  
        expect(Book.attribute_types["reviewer_id"].type).to eq :integer 
        expect(Book.attribute_types["created_at"].type).to eq :datetime
        expect(Book.attribute_types["updated_at"].type).to eq :datetime
        expect(Book.attribute_types["image_file_name"].type).to eq :string
        expect(Book.attribute_types["image_content_type"].type).to eq :string
        expect(Book.attribute_types["image_file_size"].type).to eq :integer
        expect(Book.attribute_types["image_updated_at"].type).to eq :datetime
      end  
    end   
  end

  context "Req03" do 
    before :each do    
      visit '/' 
    end

    scenario "La raíz de la aplicación debe ser una ruta válida" do 
      expect(page.status_code).to eq(200)
      expect(page).to have_content "Login"
    end

    scenario "La página principal contiene una barra de navegación con un botón de Home, Sign Up y Books" do
      expect(page).to have_content "Home"
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Books"
    end

    scenario "Desde la página principal podemos crear nuevos revisores" do 
      expect(page).to have_link("Sign Up")
      click_link("Sign Up")
      expect(page).to have_content "New Reviewer"
      reviewer = Reviewer.new(name:'prueba', password:'prueba')
      fill_in 'reviewer[name]', with: reviewer.name
      fill_in 'reviewer[password]', with: reviewer.password
      fill_in 'reviewer[password_confirmation]', with: reviewer.password
      click_button 'Create Reviewer'
      expect(page).to have_content "Reviewer was successfully created."
    end
  end 
end