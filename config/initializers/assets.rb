# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w[users.js users.css
                                                 logo.png profile-avatar.png
                                                 favicon.ico .svg
                                                 .png logo_without_name.png
                                                 no_login.css no_login.js
                                                 rifle.png smg.png
                                                 knife.png gloves.png
                                                 pistol.png shotgun.png
                                                 sticker.png music_kit.png
                                                 agent.png graffiti.png]
