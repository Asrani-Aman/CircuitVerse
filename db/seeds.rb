# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.logger.debug "Creating Users"

User.create(name: "Admin",
            email: "admin@circuitverse.org",
            password: "password",
            admin: true)
users = User.create([{ name: "user1", email: "user1@circuitverse.org", password: "password" },
                     { name: "user2", email: "user2@circuitverse.org", password: "password" }])

# private,public,limited access
Rails.logger.debug "Creating Projects"
projects = Project.create([{ name: "Private",
                             author_id: users.first.id,
                             project_access_type: "Private",
                             description: "description" },
                           { name: "Public",
                             author_id: users.first.id,
                             project_access_type: "Public",
                             description: "description" },
                           { name: "Limited access",
                             author_id: users.first.id,
                             project_access_type: "Limited access",
                             description: "description" }])

# examples
Rails.logger.debug "Creating Examples"
Project.create([{ name: "Full Adder",
                  author_id: users.first.id,
                  project_datum_attributes: { data: File.read("db/examples/fullAdder.json") },
                  project_access_type: "Public",
                  description: "description" },
                { name: "SAP",
                  author_id: users.first.id,
                  project_datum_attributes: { data: File.read("db/examples/SAP.json") },
                  project_access_type: "Public",
                  description: "SAP-1 short for simple as possible computer is a 8 Bit computer. It can perform simple operations like Addition and Subtraction." },
                { name: "ALU-74LS181",
                  author_id: users.first.id,
                  project_datum_attributes: { data: File.read("db/examples/ALU-74LS181.json") },
                  project_access_type: "Public",
                  description: "description" }])

#groups
puts "Creating Groups"
group = Group.create(name: 'group1',
  primary_mentor_id: users.first.id,
)
GroupMember.create(group_id: group.id,
                   user_id: users.second.id)

# tags
Rails.logger.debug "Creating Tags"
tag = Tag.create(name: "example")
Tagging.create([{ tag_id: tag.id,
                  project_id: projects.first.id },
                { tag_id: tag.id,
                  project_id: projects.second.id },
                { tag_id: tag.id,
                  project_id: projects.third.id }])

                  5.times do |i|
                    user = User.new(
                      email: "preexisting_user#{i+1}@example.com",
                      password: 'password',
                      name: "Pre-existing User #{i+1}",
                      created_at: (Rails.application.config.email_verification_cutoff_date - 10.days),
                      email_verification_deadline: Time.current + 30.days
                    )
                    # Don't call skip_confirmation_notification!
                    user.save(validate: false)
                    puts "Created user: #{user.email}, confirmed: #{user.confirmed?}, within grace period: #{user.within_grace_period?}"
                  end
                  # 5.times do |i|
                  #   user = User.find_by(email: "preexisting_user#{i+1}@example.com")
                  #   user.destroy if user
                  # end