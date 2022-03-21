# README

# daisy watt T2A2 - plate to plate 
-----------------------

## problem
It takes 25 years for a head of lettuce to decompose.

we know that in australia alone one in six adults last year didn't have enough food to eat, we also know that if we globally re-distributed just a ¼ of our food waste that ends up in landfill to those who didn't have access to food - we would be able to reduce food waste and reduce barriers to food access. Given that food waste in landfill contributes methane into our planet that is 28% stronger than carbon dioxide, smarter waste and food distribution can help with the fact that food is the 3rd leading cause of our current global climate crisis.

------------------

## why
Like may others, in my previous industry my income was suddenly impacted after the impacts of covid19 putting pressure on my ability to keep a roof over my head and food on my table. Fortunately the privilege that comes with living in a socially conscious area, our community rallied around those in need setting up local public (free) community pantries and fridges for those who needed instant food and support. Noticing community-led pages appearing more and more on various social media platforms - but with no functionality….. And requiring users to use particular platforms. 

We trade/donate/sell our old furniture, clothing and other belongings for a myriad of reasons - why not our unused food to.

---------------------------------

## Github repo [link](https://github.com/daisy-watt/rails_marketplace/tree/dev)

-------------------------------

## heroku deployed [link](https://plate-to-plate.herokuapp.com/listings)

----------------------------------------

## overview/description...
### *purpose*
To provide an accessible platform and resources for the public to help take the pressure off already strained community services with food distribution, whilst also providing opportunity to folks to generate small income from unneeded food.

### *functionality / features*
- Registration for new users
- Sign in for current users
- View all listed items
- View/Purchase individual items
- Create/Post a new food listing (with image uploading capabilities)
- Edit a food listing (only for current users listings)

### *sitemap*
![daisy sitemap](/app/assets/images/sitemap.jpeg "sitemap")


### *screenshots*
![screenshot home](/app/assets/images/home_landing.jpg "screenshot home")
![create listing](/app/assets/images/create_listing.jpg "create listing")
![listing](/app/assets/images/listing_made.jpg "listing")
![all food listings](/app/assets/images/all_listings.jpg "all food listings")
![stripe payment](/app/assets/images/payment_stripe.jpg "stripe payment")


### *target audience* 
Low income folks, No income folks, individuals/groups who cook to much than they need.

----------------------------

## tech stack
- Ruby
- Ruby on Rails 
- HTML
- CSS + SCSS
- JavaScript
- AWS S3
- Heroku

---------------------------------

## user stories
*As a low income/precarious income person, I want to be able to have access to buy cheap food/meals in my area*

*As a single person, I cook too much food for myself which ends up being thrown out. I want to be able to sell my leftovers so it doesn't go to waste*

*As a household, we have to throw out the contents of our fridge when we go away even if it still is suitable for eating - i want to be able to hand over or sell the perishable items*

---------------------------------------

## wireframes
![wireframes landing page](/app/assets/images/4.png "wireframes landing page")
![wireframes main page](/app/assets/images/3.png "wireframes main page")
![wireframes create listing page](/app/assets/images/2.png "create listing page")
![wireframes listing page](/app/assets/images/1.png "listing page")

------------------------------------

## ERD
![Daisy's ERD](/app/assets/images/ERD.jpeg "entity relationship diagram")

----------------------------------------

## high-level components (abstractions)
The development of this app followed the typical MVC architecture of Models, Views and Controllers. The benefit of using MVC for this project is its main ability to split up the application into smaller parts which allow us to have more control over how the logic is applied. 

Models in MVC structure allow my application to interact with the database tables to pull the data that is needed for the application logic (through the use of active record). Models I used in this application are; Application record (speaks to active record), Category, Dietary, Listing, Listings_Dietary(through a join table), Order and a User.

My Controllers do the job of helping map my HTTP requests to my methods that also interact with the information from my database, allowing my Models to put the right type of data into my views. Controllers made within this app are: application_controller, listings_controller(which helps bring in the right data and also updating and editing information), orders_controller, pages_controller and payments_controllers(which is where my checkout session are created, where i also utilize a webhook for connecting the dots with Stripe payment functionality).

Views within this application produce and display the outcome from the controller, I have also utilized the ability to use “partials” in my views (specifically in my _navbar) - which allow for more overall dynamic use of code and overall less dry code. 

------------------------------------------------------

## third party services
- **STRIPE** - Allows for external handling(stripe takes care of) and is a payment processing software/application (which was utilized im my project for its external payment handling, so that i'm not having to account for any payment details)
- **AWS S3** - Amazon's web services simple storage service, a cloud based storage service that allows users to stores files as objects internally. (I used S3 to store my users uploaded images associated with their listings as it is scalable, as heroku is limited with its size capabilities)
- **HEROKU** - is a cloud based service for deployment, specifically for developers to have the ability to deploy and host their projects (I have set up a pipeline environment that is looped in with my GitHub. As i make pushes to my repo, it triggers an auto build in my pipeline which allows me to deploy through a staging environment, then once the staging is checked it is “promoted to production”)

---------------------------

## projects models relationship with active reccord associations
The User model has a one to many relationship with the Listing model, because a User can create many different food listings to sell - but a listing will only ever be associated with one User.

The Listing model has a Many to Many relationship with the Lisitngs_diatary Model, as a Listing could have many different bits of dietary information it can be associated with. The Listings_dietary model is a join table that has a Many to Many relationship with the Dietary Model - allowing the Listing Model to connect to the various Dietary information it needs. The Category Model has a One to Many relationship with the Listing Model as a listing will only ever be in one category.

The Order Model has a One to Many relationship with the User Model, as an order will only ever have a relationship with a single User - because the User may have/make many orders.

--------------------------------------

## database relations implimented 
A Many to Many(has_many) relation is implemented in the database in Listing with Dietries. Listing will hold a Foreign Key for Listings_dietary, this tells us a join table called Listings_dietary will hold a Foreign Key for Dietary_id and for Listing_id, which also means Dietary holds a Foreign Key to Listings_dietary. Listing also holds a Foreign Key for both the Category_id and User_id.

A One to Many(belongs_to) relation is implemented in the database in Order, because an order will hold a Foreign Key for the food Listing_ids it is associated with. It also has a One to Many relation with User and holds a Foreign Key for User_ids

A Primary Key is the Id or Key for the table it is, a Foreign Key is a referenced Primary Key(from another table).

----------------------------------------------

## database schema

```
ActiveRecord::Schema.define(version: 2022_03_20_050729) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dietries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "cooked_on"
    t.bigint "category_id", null: false
    t.text "description"
    t.integer "price"
    t.boolean "sold", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_listings_on_category_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "listings_dietries", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "dietry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dietry_id"], name: "index_listings_dietries_on_dietry_id"
    t.index ["listing_id"], name: "index_listings_dietries_on_listing_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.string "payment_id"
    t.string "receipt_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["listing_id"], name: "index_orders_on_listing_id"
    t.index ["seller_id"], name: "index_orders_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "listings", "categories"
  add_foreign_key "listings", "users"
  add_foreign_key "listings_dietries", "dietries"
  add_foreign_key "listings_dietries", "listings"
  add_foreign_key "orders", "listings"
  add_foreign_key "orders", "users", column: "buyer_id"
  add_foreign_key "orders", "users", column: "seller_id"
end
```
--------------------------------------------------

## task allocation and tracking 
You can find the link to my public Trello board [here](https://trello.com/b/dud5ujEE/t2a2)

I utilized the project management tool Trello, which is a web based application following the kanban style suited for an agile workflow method approach.

I used five different “streams” of tasks; tasks to do(the initial list of tasks), features (app specific, to track notes/research), blocks (for things needing resolving), doing (what i was currently working on) and done (purely for the satisfaction of moving a completed task into the done pile).

This approach allowed me to be able to see an overview of how i was progressing, as well as highlighting outstanding tasks still remaining. 


![trello board item](/app/assets/images/trello_detail.jpg)
![trello board overview](/app/assets/images/trello_progress.jpg)