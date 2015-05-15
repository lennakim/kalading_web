# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

Rails.application.config.assets.precompile += %w( orders.js home.js admin/admin.js admin/admin.css activity/activity.js activity/activity.css activity/activity99.js activity/activity99.css admin/posts.js ckeditor/* baidu_map.js activity/papago.css activity/papago.js activity/yd_3_by_tc.css activity/yd_3_by_tc.js activity/rice_dumpling.css activity/rice_dumpling.js activity/baojia.css activity/thousand_special_right.css activity/tiantian.css new.js new.css)

Rails.application.config.assets.precompile += %w(api.js api.css)

Rails.application.config.assets.precompile += %w(mobile.js mobile.css mobile/*)

Rails.application.config.assets.precompile += %w(activity/515.css activity/515.js)

