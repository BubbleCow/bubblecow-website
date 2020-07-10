This is the bootstrap module for the ProActive brand. 

proactive_global.scss has all the scss for cross company styling. 

The company based styling is in either proactive_bubblecow_frontend.scss or proactive_writer.scss

NAVBAR 

The nav element need the class 'proactive-navbar' to be added. 

The logo looks like this...

    <%= link_to root_path, class: "navbar-brand proactive_logo" do %>
      <span class="proactive-logo-first-word ml-2">FIRST WORD</span><span class="proactive-logo-second-word">SECOND WORD</span>
    <% end %>


PAGES

Each page needs a main tag as follows:

    <main class="page about">
    ...
    </main>


