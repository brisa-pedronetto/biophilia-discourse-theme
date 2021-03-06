# name: biophilia-discourse-theme
# about: Biophilia Educationak Forum Theme
# authors: Jude Aakjaer, James Hunter, Kelle-Lee Connolly

after_initialize do

  module SitepointDesign
      
    class Engine < ::Rails::Engine
      engine_name "sitepoint_design"
      isolate_namespace SitepointDesign
    end

    Rails.application.config.assets.paths.unshift File.expand_path('../assets', __FILE__)
      
  end

  # app/models/topic_posters_summary.rb
  TopicPostersSummary.class_eval do
      
    def user_ids_with_descriptions
      user_ids.zip([
        :original_poster,
        :most_recent_poster
      ].map { |description| I18n.t(description) })
    end

    def top_posters
      user_ids.map { |id| avatar_lookup[id] }.compact.uniq.take(2)
    end
      
  end

  # SP customisation: add SiteCustomization to add in crawler links
  #  header = <<-EOS.strip_heredoc.chomp
  #    <noscript>
  #      <a class="header-link" href="https://shop.sitepoint.com" tabindex="2">Shop</a>
  #      <a class="header-link" href="http://www.sitepoint.com/versioning" tabindex="3">Versioning</a>
  #      <a class="header-link" href="http://www.sitepoint.com/reference" tabindex="4">Reference</a>
  #      <a class="header-link" href="http://www.sitepoint.com" tabindex="5">Articles</a>
  #      <a class="header-link u-button" target="_blank" href="https://www.sitepoint.com/premium/topics/all?utm_source=sitepoint&utm_medium=link&utm_content=top-nav" tabindex="6">Premium</a>
  #    </noscript>
  #
  #    <!-- Start Alexa Certify Javascript -->
  #    <script type="text/javascript">
  #    _atrk_opts = { atrk_acct:"3/2Rk1ao6C526C", domain:"sitepoint.com",dynamic: true};
  #    (function() { var as = document.createElement('script'); as.type = 'text/javascript'; as.async = true; as.src = "https://d31qbv1cthcecs.cloudfront.net/atrk.js"; var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(as, s); })();
  #    </script>
  #    <noscript><img src="https://d5nxst8fruw4z.cloudfront.net/atrk.gif?account=3/2Rk1ao6C526C" style="display:none" height="1" width="1" alt="" /></noscript>
  #    <!-- End Alexa Certify Javascript -->
  #    EOS

  #  begin
  #    if User.exists?
  #      sitepoint_site_customization = SiteCustomization.find_or_create_by({
  #        name: "SitePoint Crawler links",
  #        header: header,
  #        mobile_header: header,
  #        enabled: true,
  #        user_id: User.first.id,
  #        head_tag: ''
  #      })
  #      # cleanup old customizations
  #      SiteCustomization.where(name: sitepoint_site_customization.name).
  #        where.not(id: sitepoint_site_customization.id).
  #        delete_all
  #    end
  #  rescue ActiveRecord::StatementInvalid
  #    # This happens when you run db:migrate on a database that doesn't have any tables yet.
  #  end
    
end

## Adding To Discourse
#register_asset "javascripts/pm_button.js.es6", :client_side
register_asset "stylesheets/common/foundation/variables.scss", :variables # other things need these variables

## General Changes
register_asset "stylesheets/common/components/banner.css.scss" # Make the banner grey
register_asset "stylesheets/common/components/badges.css.scss" # category dropdown badges
register_asset "stylesheets/common/components/navs.scss"       # Navigation at top of list pages and to the side of profile pages
register_asset "stylesheets/common/components/buttons.scss"    # Button Colors and radius
register_asset "stylesheets/common/base/header.scss"           # Custom Header
register_asset "stylesheets/common/base/topic-list.scss"       # Category Page Table
register_asset "stylesheets/common/base/discourse.scss"        # Blockquote styles
register_asset "stylesheets/common/base/topic-post.scss"       # Coloring usernames based on role

## Desktop Only
register_asset "stylesheets/desktop/header.scss", :desktop     # Links in navbar
register_asset "stylesheets/desktop/topic-post.scss", :desktop # General Post styles
register_asset "stylesheets/desktop/topic.scss", :desktop      # Post Progress meter styles
register_asset "stylesheets/common/base/topic-admin-menu.scss" # yeah i dunno why this is needed but...

## Mobile Only
register_asset "stylesheets/mobile/header.scss", :mobile   # Hide Header links on Mobile
register_asset "stylesheets/mobile/topic-list.scss", :mobile   # Hide Tags from Topic List
