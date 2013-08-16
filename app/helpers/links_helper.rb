module LinksHelper
  def new_link(link, index)
    html = "<label for= 'link_#{index}_title'>Title:</label>"
    html += "<input type='text' name='link[#{index}][title]' value='#{link.title}' id= 'link_#{index}_title'>"
    html += "<br>"
    html += "<label for= 'link_#{index}_url'>URL:</label>"
    html += "<input type='text' name='link[#{index}][url]' value='#{link.url}' id= 'link_#{index}_url'>"
    html += "<br>"
    html += "<label for='link_#{index}_desc'>Description:</label>"
    html += "<textarea id='link_#{index}_desc' name='link[#{index}][desc]' id= 'link_#{index}_desc' >#{link.desc}</textarea>"
    html += "<br><br>"
    html.html_safe
  end

  def make_comment(parent_comment_id, link_id)
    html = "<form action='#{comments_url}' method='post'>"
    html += "<input type='hidden' name='authenticity_token' value= '#{form_authenticity_token}'>"
    html += "<input type='hidden' name='comment[parent_comment_id]' value= '#{parent_comment_id}'>"
    html += "<input type='hidden' name='comment[link_id]' value= '#{link_id}'>"
    html += "<input type='text' name='comment[body]'>"
    html += "<input type='submit' value='Comment'>"
    html += "</form>"
    html.html_safe
  end
end
