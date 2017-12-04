module ApplicationHelper
  
  def tailing_javascript(t=nil, html_options={}, &block)
    @tailing_javascript ||= ""
    @tailing_javascript << javascript_include_tag(t, html_options) if t
    @tailing_javascript << capture_haml(&block) if block_given?
    @tailing_javascript.html_safe
  end
  
  def page_title(t=nil)
    return (@page_title.try(:html_safe)) || ENV["SITE_NAME"] if t.nil?
    @page_title = (@page_title.nil? ? t : @page_title + ' &mdash; '.html_safe + t).html_safe
  end
  
  def mdown(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @markdown.render(text).html_safe
  end
  
  def ga
    " <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-103028949-1', 'auto');
      ga('send', 'pageview');
      </script>".html_safe
  end
  
end
